Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBDF62018A
	for <e@80x24.org>; Tue, 28 Jun 2016 20:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbcF1Uw5 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 16:52:57 -0400
Received: from alt22.smtp-out.videotron.ca ([70.80.0.73]:55450 "EHLO
	alt22.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752165AbcF1Uw5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 16:52:57 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id HzkZbdwxAPTiyHzkabciq0; Tue, 28 Jun 2016 16:36:53 -0400
X-Authority-Analysis: v=2.1 cv=L469O7n8 c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=dg4UtMH5AAAA:8 a=dgnKuqusInU55A-5q-AA:9 a=CjuIK1q_8ugA:10
 a=byNfn09xH3PuSfgbYLsR:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 43C6C2DA0200;
	Tue, 28 Jun 2016 16:36:51 -0400 (EDT)
Date:	Tue, 28 Jun 2016 16:36:51 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
In-Reply-To: <xmqq60st853d.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160628043526.19403-1-lfleischer@lfos.de> <xmqqa8i59rph.fsf@gitster.mtv.corp.google.com> <xmqq60st9qg5.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
 <xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr> <xmqq60st853d.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfNN2H/f+POBYMUjFZusCre11N0VsVTGxkCgE2IAAAf84hLNeOJ8gHULLJmu9QTq6fsxgi2kh6TWPRABJSIDdlSxZEBGT4tbVg8aPid84M5KMkSOBpyeK
 ctkgEJV1N1gZYq05ar358S1zDFZdbd2dOu8turJ1VOmpLzEe0bO8B4Z5d+trJ/qewx+Uih416R7E17Zq4smRN/ziKsCEZXGs3JYREvAMmrSLWnjj7OJ+VlZQ
 BvbuQDTj9f6kqwed18fNn75KPTxtWcmyonFS1nemnOI=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 28 Jun 2016, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Without this, the error and remaining buffer would be reversed as 
> > mentioned previously.  With this, the order is restored, but a newline 
> > is added to unterminated lines whereas the error was simply appended to 
> > the output before Lukas' patch.
> >
> > In any case the new behavior is probably better and I'd simply adjust 
> > the test expectations.
> 
> There is something else going on.  I cannot quite explain why I am
> getting this failure from t5401-update-hooks.sh, for example:
> 
>     --- expect      2016-06-28 19:46:24.564937075 +0000
>     +++ actual      2016-06-28 19:46:24.564937075 +0000
>     @@ -9,3 +9,4 @@
>      remote: STDERR post-receive
>      remote: STDOUT post-update
>      remote: STDERR post-update
>     +remote: To ./victim.git
>     not ok 12 - send-pack stderr contains hook messages
> 
> ... goes and looks what v2.9.0 produces, which ends like this:
> 
>     ...
>     remote: STDERR post-receive        
>     remote: STDOUT post-update        
>     remote: STDERR post-update        
>     To ./victim.git
>        e4822ab..2b65bd1  master -> master
>      ! [remote rejected] tofail -> tofail (hook declined)
> 
> The test checks if lines prefixed with "remote: " match the expected
> output, and the difference is an indication that the new code is
> showing an extra incomplete-line "remote: " before other parts of
> the code says "To ./victim.git" to report where the push is going.

Ah...  I think I know what's going on.

The leftover data in the strbuf is normally (when there is no errors) an 
unterminated line. So instead of doing:

-                       fprintf(stderr, "%s: protocol error: no band designator\n", me);
+                       strbuf_addf(&outbuf,
+                                   "\n%s: protocol error: no band designator\n",
+                                   me);

you could omit the final \n in the format string and:

-       if (outbuf.len > 0)
-               fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
+       if (outbuf.len)
+               fwrite(outbuf.buf, 1, outbuf.len, stderr);
        strbuf_release(&outbuf);

and here a \n could be added before writing out the buffer.


Nicolas
