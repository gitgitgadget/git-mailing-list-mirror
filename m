Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA096C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3B22078E
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbgKET3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:29:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:49128 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgKET3C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 14:29:02 -0500
Received: (qmail 17313 invoked by uid 109); 5 Nov 2020 19:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Nov 2020 19:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25830 invoked by uid 111); 5 Nov 2020 19:29:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Nov 2020 14:29:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Nov 2020 14:29:01 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] update-ref: Allow creation of multiple transactions
Message-ID: <20201105192901.GA121650@coredump.intra.peff.net>
References: <cover.1604501265.git.ps@pks.im>
 <eec7c2e8ec3e49b34066190d59fc45276bed637f.1604501265.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eec7c2e8ec3e49b34066190d59fc45276bed637f.1604501265.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 04, 2020 at 03:57:17PM +0100, Patrick Steinhardt wrote:

> While git-update-ref has recently grown commands which allow interactive
> control of transactions in e48cf33b61 (update-ref: implement interactive
> transaction handling, 2020-04-02), it is not yet possible to create
> multiple transactions in a single session. To do so, one currently still
> needs to invoke the executable multiple times.
> 
> This commit addresses this shortcoming by allowing the "start" command
> to create a new transaction if the current transaction has already been
> either committed or aborted.

Thanks for working on this. The amount of change needed is indeed quite
pleasant.

> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index d401234b03..48b6683071 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -125,7 +125,8 @@ option::
>  start::
>  	Start a transaction. In contrast to a non-transactional session, a
>  	transaction will automatically abort if the session ends without an
> -	explicit commit.
> +	explicit commit. This command may create a new empty transaction when
> +	the current one has been committed or aborted already.

Reading this made me wonder what would happen if we send a "start" when
the current one _hasn't_ been committed or aborted. I.e., what does:

  git update-ref --stdin <<EOF
  start
  create refs/heads/foo ...
  start
  commit
  EOF

do? It turns out that the second start is ignored totally (and the
commit does indeed update foo). I wonder if we ought to complain about
it. But that is completely orthogonal to your patch. The behavior is the
same before and after.

> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -446,7 +446,18 @@ static void update_refs_stdin(void)
>  			state = cmd->state;
>  			break;
>  		case UPDATE_REFS_CLOSED:
> -			die("transaction is closed");
> +			if (cmd->state != UPDATE_REFS_STARTED)
> +				die("transaction is closed");
> +
> +			/*
> +			 * Open a new transaction if we're currently closed and
> +			 * get a "start".
> +			 */
> +			state = cmd->state;
> +			transaction = ref_transaction_begin(&err);
> +			if (!transaction)
> +				die("%s", err.buf);
> +

Very nice. This duplicates the state and transaction setup at the start
of the function, which made me wonder if we could do this:

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index bb65129012..140f0d30e9 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -385,14 +385,10 @@ static const struct parse_cmd {
 static void update_refs_stdin(void)
 {
 	struct strbuf input = STRBUF_INIT, err = STRBUF_INIT;
-	enum update_refs_state state = UPDATE_REFS_OPEN;
+	enum update_refs_state state = UPDATE_REFS_CLOSED;
 	struct ref_transaction *transaction;
 	int i, j;
 
-	transaction = ref_transaction_begin(&err);
-	if (!transaction)
-		die("%s", err.buf);
-
 	/* Read each line dispatch its command */
 	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
 		const struct parse_cmd *cmd = NULL;

and just have it auto-open. But of course that doesn't work because we
might not see an "open" command at all. Traditional callers will start
with create/update/etc, and our "auto-open" would complain.

> +test_expect_success 'transaction can create and delete' '
> +	cat >stdin <<-EOF &&
> +	start
> +	create refs/heads/create-and-delete $A
> +	commit
> +	start
> +	delete refs/heads/create-and-delete $A
> +	commit
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" start commit start commit >expect &&
> +	test_path_is_missing .git/refs/heads/create-and-delete
> +'

The tests all look quite reasonable to me. Touching .git/refs like this
is a bit gross (and something we may have to deal with if we introduce
reftables, etc). But it's pretty pervasive in this file, so matching
the existing style is the best option for now.

-Peff
