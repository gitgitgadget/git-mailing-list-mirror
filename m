Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F181F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 03:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfDWDzk (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 23:55:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:37698 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727397AbfDWDzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 23:55:40 -0400
Received: (qmail 17166 invoked by uid 109); 23 Apr 2019 03:55:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 03:55:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5661 invoked by uid 111); 23 Apr 2019 03:56:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 23:56:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 23:55:38 -0400
Date:   Mon, 22 Apr 2019 23:55:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shawn Landden <shawn@git.icu>, git@vger.kernel.org
Subject: Re: allow a differn't diff.context config for git format-patch
Message-ID: <20190423035537.GB7753@sigill.intra.peff.net>
References: <CA+49okrda1=dV=rN23oFg7LQmRp+idkDDDxFQ9R5jhGJFHKpEg@mail.gmail.com>
 <20190423030648.GA6344@sigill.intra.peff.net>
 <xmqqftq95qr6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftq95qr6.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 12:45:17PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... I don't think it would be
> > too big a problem for format-patch to learn some options to configure
> > its diffs. We already have some options in format.* for various things.
> 
> I am not sure; diff.context is rather special in that the variable
> behind it belongs to the diff layer and is set via diff_config that
> is called by diff_ui_config that in turn is called by log_config
> which is called by format_config.
> 
> If we want to say "format.context" trumps "diff.config", then a new
> internal variable to receive the value of the variable must be
> invented and after the config gets read, cmd_format_patch() needs to
> do something silly like this:
> 
>                 git_config(git_format_config, NULL);
>         +	if (format_context != -1)
>         +		diff_default_context = format_context;
>                 repo_init_revisions(the_repository, &rev, prefix);
> 
> committing layering violation by exposing diff_default_context
> variable.

After init_revisions(), we'll have called diff_setup(), which puts
diff_context_default into revs->diffopt. So we still have to do the "if
we have a format-specific value, then override..." conditional. But we
can do it without touching the hidden variable:

diff --git a/builtin/log.c b/builtin/log.c
index 57869267d8..0de2ee0905 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1613,14 +1613,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
 	rev.diff = 1;
 	rev.max_parents = 1;
 	rev.diffopt.flags.recursive = 1;
+	if (format_context != -1)
+		rev.diffopt.context = format_context;
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
 
 	if (default_attach) {
 		rev.mime_boundary = default_attach;

-Peff
