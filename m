Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14E001F404
	for <e@80x24.org>; Thu, 25 Jan 2018 03:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933498AbeAYDnI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 24 Jan 2018 22:43:08 -0500
Received: from elephants.elehost.com ([216.66.27.132]:15109 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933099AbeAYDnG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 22:43:06 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0P3h19b037930
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Jan 2018 22:43:01 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "=?UTF-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>,
        <git@vger.kernel.org>, "Bill Honaker" <bhonaker@xid.com>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>        <20180120111012.GA26459@tor.lan>        <xmqqshaxjzcc.fsf@gitster.mtv.corp.google.com>  <001401d393d2$73458ef0$59d0acd0$@nexbridge.com> <xmqqtvvcigui.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqtvvcigui.fsf@gitster.mtv.corp.google.com>
Subject: RE: [PATCH v2 0/6] Force pipes to flush immediately on NonStop platform
Date:   Wed, 24 Jan 2018 22:42:54 -0500
Message-ID: <006901d3958e$98ac26f0$ca0474d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH5ceUaUBDLnBuBgyHh9+OiHAZcgwKtGOTzAeA6Ju4CPrPWMwGFsPegovWpRHA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 23, 2018 1:13 PM, Junio C Hamano wrote:
> 
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> >> IOW, I do not see it explained clearly why this change is needed on
> >> any single platform---so "that issue may be shared by others, too"
> >> is a bit premature thing for me to listen to and understand, as "that
> >> issue" is quite unclear to me.
> >
> > v4 might be a little better. The issue seems to be specific to NonStop
> > that it's PIPE mechanism needs to have setbuf(pipe,NULL) called for
> > git to be happy.  The default behaviour appears to be different on
> > NonStop from other platforms from our testing. We get hung up waiting
> > on pipes unless this is done.
> 
> I am afraid that that is not a "diagnosis" enough to allow us moving forward.
> We get hung up because...?  When the process that has the other end of
> pipe open exits, NonStop does not close the pipe properly?  Or NonStop
> does not flush the data buffered in the pipe?
> Would it help if a compat wrapper that does setbuf(fd, NULL) immediately
> before closing the fd, or some other more targetted mechanism, is used only
> on NonStop, for example?  Potentially megabytes of data can pass thru a
> pipe, and if the platform bug affects only at the tail end of the transfer,
> marking the pipe not to buffer at all at the beginning is too big a hammer to
> work it around.  With the explanation given so far, this still smells more like
> "we have futzed around without understanding why, and this happens to
> work."  It may be good enough for your purpose of making progress (after
> all, I'd imagine that you'd need to work this around one way or another to
> hunt for and fix more issues on the platform), but it does not sound like "we
> know what the problem is, and this is the best workaround for that", which is
> what we want if it wants to become part of the official codebase.

As I feared, the test suite was unable to reproduce the issue without setbuf(NULL) - primary because the test structure ends up with both ends of the git dialogs on clone and fetch in the same CPU (even if different IPUs), which does not experience the issue and we can't loop-back through the platform's proprietary SSH. I am not comfortable releasing without it at this stage, but if you don't want to go forward with this fix, my team can run it for a few months internally in the hope that this works out for the better. The situation is timing related and is fine 99.98-ish% of the time. I really do want the setbuf present in any compiled versions that our community might get, primarily because I don't like sleepless nights chasing this down (again).

Cheers,
Randall

