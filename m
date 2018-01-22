Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 762CC1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 22:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbeAVWnp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 22 Jan 2018 17:43:45 -0500
Received: from elephants.elehost.com ([216.66.27.132]:59345 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeAVWno (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 17:43:44 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0MMhegJ032975
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 Jan 2018 17:43:41 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>
Cc:     <randall.s.becker@rogers.com>, <git@vger.kernel.org>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>        <20180120111012.GA26459@tor.lan> <xmqqshaxjzcc.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqshaxjzcc.fsf@gitster.mtv.corp.google.com>
Subject: RE: [PATCH v2 0/6] Force pipes to flush immediately on NonStop platform
Date:   Mon, 22 Jan 2018 17:43:34 -0500
Message-ID: <001401d393d2$73458ef0$59d0acd0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5ceUaUBDLnBuBgyHh9+OiHAZcgwKtGOTzAeA6Ju6jEFU8kA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 22, 2018 5:36 PM, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
> > On Fri, Jan 19, 2018 at 12:33:59PM -0500, randall.s.becker@rogers.com
> wrote:
> >> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >>
> >> * wrapper.c: called setbuf(stream,0) to force pipe flushes not enabled by
> >>   default on the NonStop platform.
> >>
> >> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> >> ---
> >>  wrapper.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/wrapper.c b/wrapper.c
> >> index d20356a77..671cbb4b4 100644
> >> --- a/wrapper.c
> >> +++ b/wrapper.c
> >> @@ -403,6 +403,9 @@ FILE *xfdopen(int fd, const char *mode)
> >>  	FILE *stream = fdopen(fd, mode);
> >>  	if (stream == NULL)
> >>  		die_errno("Out of memory? fdopen failed");
> >> +#ifdef __TANDEM
> >> +	setbuf(stream,0);
> >> +#endif
> >
> > Reading the commit message, I would have expected someting similar to
> >
> > #ifdef FORCE_PIPE_FLUSHES
> > 	setbuf(stream,0);
> > #endif
> >
> > (Because other systems may need the tweak as well, some day) Of course
> > you need to change that in the Makefile and config.mak.uname
> 
> I actually wouldn't have expected anything like that after reading the commit
> message.
> 
> First I thought it was describing only what it does (i.e. "let's use
> setbuf() to set the stream unbuffered on TANDEM"), which is a useless
> description that only says what it does which we can read from the diff, but
> "NonStop by default creates pipe that does not flush" is a potentially useful
> information the log message adds.
> But it is just "potentially"---we cannot read what exact problem the change is
> trying to address.  Making a pipe totally unbuffered is a heavy hammer that
> may not be an appropriate solution---it could be that we are missing calls to
> fflush() where we need and have been lucky because most of the systems
> we deal with do line-buffered by default, or something silly/implausible like
> that, and if that is the case, a more proper fix may be to add these missing
> fflush() to right places.
> 
> IOW, I do not see it explained clearly why this change is needed on any single
> platform---so "that issue may be shared by others, too"
> is a bit premature thing for me to listen to and understand, as "that issue" is
> quite unclear to me.

v4 might be a little better. The issue seems to be specific to NonStop that it's PIPE mechanism needs to have setbuf(pipe,NULL) called for git to be happy. The default behaviour appears to be different on NonStop from other platforms from our testing. We get hung up waiting on pipes unless this is done. At the moment, this is platform-specific. Other parts of the discussion led to the conclusion that we should make this available to any platform using a new configuration option, but my objective is to get the NonStop port integrated with the main git code base and when my $DAYJOB permits it, spend the time adding the option. Note: __TANDEM is #define automatically emitted by the NonStop compilers. 

Does that help?

Sincerely,
Randall

