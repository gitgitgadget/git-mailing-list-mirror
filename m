Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B263820970
	for <e@80x24.org>; Fri, 14 Apr 2017 21:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbdDNVfi (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 17:35:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43546 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752277AbdDNVfh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 17:35:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C678720970;
        Fri, 14 Apr 2017 21:35:36 +0000 (UTC)
Date:   Fri, 14 Apr 2017 21:35:36 +0000
From:   Eric Wong <e@80x24.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v3 10/10] run-command: block signals between fork and
 execve
Message-ID: <20170414213536.GA2390@whir>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
 <20170414165902.174167-11-bmwill@google.com>
 <20170414202447.GC54940@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170414202447.GC54940@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> wrote:
> On 04/14, Brandon Williams wrote:
> >  		/*
> > +		 * restore default signal handlers here, in case
> > +		 * we catch a signal right before execve below
> > +		 */
> > +		for (sig = 1; sig < NSIG; sig++) {
> > +			sighandler_t old = signal(sig, SIG_DFL);
> 
> So sighandler_t doesn't work on macOS.  Is there a more portable lib
> that needs to be included for this to work?

Oops, maybe this works (only tested on GNU/Linux):

--- a/run-command.c
+++ b/run-command.c
@@ -675,7 +675,7 @@ int start_command(struct child_process *cmd)
 		 * we catch a signal right before execve below
 		 */
 		for (sig = 1; sig < NSIG; sig++) {
-			sighandler_t old = signal(sig, SIG_DFL);
+			void (*old)(int) = signal(sig, SIG_DFL);
 
 			/* ignored signals get reset to SIG_DFL on execve */
 			if (old == SIG_IGN)

Otherwise, maybe just casting to 'void *' is OK:

			void *old = (void *)signal(sig, SIG_DFL);

			if (old == (void *)SIG_IGN)
				...



void *old = signal(sig, SIG_DFL);
