Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE7AB2023C
	for <e@80x24.org>; Fri,  8 Jul 2016 10:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbcGHKfX (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 06:35:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:41931 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754377AbcGHKfV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 06:35:21 -0400
Received: (qmail 8806 invoked by uid 102); 8 Jul 2016 10:35:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 06:35:20 -0400
Received: (qmail 12993 invoked by uid 107); 8 Jul 2016 10:35:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 06:35:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 06:35:15 -0400
Date:	Fri, 8 Jul 2016 06:35:15 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] avoid using sha1_to_hex output as printf format
Message-ID: <20160708103515.GA19705@sigill.intra.peff.net>
References: <20160708092510.GB17072@sigill.intra.peff.net>
 <20160708092526.GB18263@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708092526.GB18263@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 05:25:26AM -0400, Jeff King wrote:

> diff --git a/commit.c b/commit.c
> index 3f4f371..9603379 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1623,7 +1623,7 @@ void print_commit_list(struct commit_list *list,
>  {
>  	for ( ; list; list = list->next) {
>  		const char *format = list->next ? format_cur : format_last;
> -		printf(format, oid_to_hex(&list->item->object.oid));
> +		printf(format, "%s", oid_to_hex(&list->item->object.oid));

Urgh, this second hunk is clearly bogus. This is a -Wformat-nonliteral
problem, but not because of oid_to_hex(), but rather because of
"format". :-/

Here's a corrected patch. But as this has demonstrated the dangers of
churn, and as it doesn't really get us meaningfully closer to being able
to use -Wformat-nonliteral, perhaps the best course of action is to just
drop it (I do think the "walker_say" patch has more inherent value as a
cleanup, though).

-- >8 --
Subject: [PATCH] avoid using sha1_to_hex output as printf format

We know that it should not contain any percent-signs, but
it's a good habit not to feed non-literals to printf
formatters.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e866844..cce555c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -262,7 +262,7 @@ static int add_worktree(const char *path, const char *refname,
 	 */
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, sha1_to_hex(null_sha1));
+	write_file(sb.buf, "%s", sha1_to_hex(null_sha1));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
-- 
2.9.0.393.g704e522

