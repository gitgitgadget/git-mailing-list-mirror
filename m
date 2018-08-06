Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF44208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 16:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeHFSqb (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 14:46:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:44096 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728071AbeHFSqb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 14:46:31 -0400
Received: (qmail 15373 invoked by uid 109); 6 Aug 2018 16:36:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 16:36:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27648 invoked by uid 111); 6 Aug 2018 16:36:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 12:36:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 12:36:36 -0400
Date:   Mon, 6 Aug 2018 12:36:36 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [BUG] 'git ls-files --no-exclude' segfault & co
Message-ID: <20180806163636.GA19053@sigill.intra.peff.net>
References: <CAM0VKj=DDOPDxo_xDvhk2-HUPHfkUcLQTimqmY31yjq5eZiM2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=DDOPDxo_xDvhk2-HUPHfkUcLQTimqmY31yjq5eZiM2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 06:07:06PM +0200, SZEDER Gábor wrote:

> 'git ls-files' has the options '--exclude', '--exclude-from',
> '--exclude-per-directory', and '--exclude-standard', which all work
> fine.  However, it also allows the negated version of all these four
> options, and they definitely don't work very well:
> 
>   $ git ls-files --no-exclude
>   Segmentation fault
>   $ git ls-files --no-exclude-from
>   warning: unable to access '(null)': Bad address
>   fatal: cannot use (null) as an exclude file
> 
> And '--no-exclude-standard' has the same effect as
> '--exclude-standard', because its parseopt callback function
> option_parse_exclude_standard() doesn't bother to look at its 'unset'
> parameter.

I think --exclude-per-directory is fine, since it uses OPT_STRING().
Using "--no-exclude-per-directory" just means we'll cancel any
previously found option.

In an ideal world we'd perhaps do something useful with the negated
forms for the others, but I don't think the underlying code is set up to
do that (i.e., how do you undo "setup_standard_excludes()"). Possibly we
could switch to setting a flag (which could then be cleared), and
resolve the flags after parsing the whole command line. But often
options with callbacks list this have subtle user-visible timing effects
(e.g., that the command line options need to take effect in the order
they were found).

So unless somebody actually wants these negated forms to do something
useful, it's probably not worth the trouble and risk of regression.  But
we obviously should at least disallow them explicitly rather than
segfaulting.

I thought adding PARSE_OPT_NONEG like this would work:

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 88bb2019ad..9adee62358 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -547,15 +547,16 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			    N_("show resolve-undo information")),
 		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, N_("pattern"),
 			N_("skip files matching pattern"),
-			0, option_parse_exclude },
+			PARSE_OPT_NONEG, option_parse_exclude },
 		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, N_("file"),
 			N_("exclude patterns are read from <file>"),
-			0, option_parse_exclude_from },
+			PARSE_OPT_NONEG, option_parse_exclude_from },
 		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, N_("file"),
 			N_("read additional per-directory exclude patterns in <file>")),
 		{ OPTION_CALLBACK, 0, "exclude-standard", &dir, NULL,
 			N_("add the standard git exclusions"),
-			PARSE_OPT_NOARG, option_parse_exclude_standard },
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			option_parse_exclude_standard },
 		OPT_SET_INT_F(0, "full-name", &prefix_len,
 			      N_("make the output relative to the project top directory"),
 			      0, PARSE_OPT_NONEG),

But it actually does something quite interesting. Because of the NONEG
flag, we know that the user cannot mean "--no-exclude" itself. So our
liberal prefix-matching kicks in, and we treat it as
--no-exclude-per-directory. I.e., it becomes a silent noop and the user
gets no warning.

I think parse_options() may be overly liberal here, and we might want to
change that. But in the interim, it probably makes sense to just detect
the "unset" case in the callbacks, report an error, and return -1.

-Peff
