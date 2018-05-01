Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A2C21841
	for <e@80x24.org>; Tue,  1 May 2018 11:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753991AbeEALJI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 1 May 2018 07:09:08 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42878 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753072AbeEALJH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 07:09:07 -0400
X-IronPort-AV: E=Sophos;i="5.49,350,1520895600"; 
   d="scan'208";a="325237186"
Received: from zcs-store5.inria.fr ([128.93.142.32])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 May 2018 13:09:06 +0200
Date:   Tue, 1 May 2018 13:09:06 +0200 (CEST)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Eckhard =?iso-8859-1?Q?S=2E_Maa=DF?= 
        <eckhard.s.maass@googlemail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Eckhard =?iso-8859-1?Q?S=2E_Maa=DF?= <eckhard.s.maass@gmail.com>
Message-ID: <907020160.11403426.1525172946040.JavaMail.zimbra@inria.fr>
In-Reply-To: <50c60ddfeb9a44a99f556be2c2ca9a34@BPMBX2013-01.univ-lyon1.fr>
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com> <50c60ddfeb9a44a99f556be2c2ca9a34@BPMBX2013-01.univ-lyon1.fr>
Subject: Re: [PATCH v2] wt-status: use rename settings from
 init_diff_ui_defaults
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [77.192.142.118]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF59 (Linux)/8.7.11_GA_1854)
Thread-Topic: wt-status: use rename settings from init_diff_ui_defaults
Thread-Index: AQHT4THW6GOAw9NMfUGeiE2eIB+tESSfh/lV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eckhard S. Maaﬂ" <eckhard.s.maass@googlemail.com> wrote:

> Since the very beginning, git status behaved differently for rename
> detection than other rename aware commands like git log or git show as
> it has the use of rename hard coded into it.

My understanding is that the succession of events went stg like:

1) invent the rename detection, but consider it experimental
   hence don't activate it by default;

2) add commands using the rename detection, and since it works
   well, use it by default;

3) activate rename detection by default for diff.

The next logical step is what you patch does indeed.

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -161,9 +161,9 @@ static void determine_whence(struct wt_status *s)
> static void status_init_config(struct wt_status *s, config_fn_t fn)
> {
> 	wt_status_prepare(s);
> +	init_diff_ui_defaults();
> 	git_config(fn, s);
> 	determine_whence(s);
> -	init_diff_ui_defaults();
> 	s->hints = advice_status_hints; /* must come after git_config() */
> }

That init_diff_ui_defaults() should indeed have been before
git_config() from the beginning. My bad, I'm the one who
misplaced it apparently :-(.

> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -625,9 +625,6 @@ static void wt_status_collect_changes_index(struct wt_status
> *s)
> 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
> 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
> 	rev.diffopt.format_callback_data = s;
> -	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
> -	rev.diffopt.rename_limit = 200;
> -	rev.diffopt.break_opt = 0;

This "break_opt = 0" deserves a mention in the commit message
IMHO. I'm not 100% sure it's a good change actually.

break_opt is normally controlled by "-B/--break-rewrites".
I'm not sure why it was set to 0.

-- 
Matthieu Moy
https://matthieu-moy.fr/
