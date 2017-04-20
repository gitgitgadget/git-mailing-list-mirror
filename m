Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4354A1FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 15:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970698AbdDTPfT (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 11:35:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:36866 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970607AbdDTPfR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 11:35:17 -0400
Received: (qmail 14171 invoked by uid 109); 20 Apr 2017 15:35:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 15:35:15 +0000
Received: (qmail 4269 invoked by uid 111); 20 Apr 2017 15:35:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 11:35:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 11:35:13 -0400
Date:   Thu, 20 Apr 2017 11:35:13 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
Message-ID: <20170420153512.kc57z7cyxdzq74sg@sigill.intra.peff.net>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
 <20170420095921.GA23873@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420095921.GA23873@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 04:59:21PM +0700, Duy Nguyen wrote:

> On Wed, Apr 19, 2017 at 10:37:21PM -0700, Junio C Hamano wrote:
> > * nd/worktree-add-lock (2017-04-16) 2 commits
> >  - SQUASH???
> >  - worktree add: add --lock option
> > 
> >  Allow to lock a worktree immediately after it's created. This helps
> >  prevent a race between "git worktree add; git worktree lock" and
> >  "git worktree prune".
> > 
> >  Waiting for a response to SQUASH???
> 
> Looking good. I would add some comment, lest ';' feel lonely. But it's
> really personal taste.
> 
> -- 8< --
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 5ebdcce793..bc75676bf3 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -310,7 +310,7 @@ static int add_worktree(const char *path, const char *refname,
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
>  	if (!ret && opts->keep_locked)
> -		;
> +		;	      /* --lock wants to keep "locked" file */
>  	else
>  		unlink_or_warn(sb.buf);

I know this is just a drive-by comment, but given that the "else" is the
only thing that does anything, would it be simpler to flip the
conditional? The strbuf manipulation above also could go inside it.
E.g.:

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5ebdcce79..05ade547c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -307,12 +307,11 @@ static int add_worktree(const char *path, const char *refname,
 	junk_git_dir = NULL;
 
 done:
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	if (!ret && opts->keep_locked)
-		;
-	else
+	if (ret || !opts->keep_locked) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 		unlink_or_warn(sb.buf);
+	}
 	argv_array_clear(&child_env);
 	strbuf_release(&sb);
 	strbuf_release(&symref);

(Since it's in its own block I'd also consider just introducing a new
variable for the path, but I guess reusing "sb" for each path is already
a pattern in the function).

-Peff
