Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825741FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 18:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbcFWS7m (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 14:59:42 -0400
Received: from alt32.smtp-out.videotron.ca ([24.53.0.21]:9347 "EHLO
	alt32.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863AbcFWS7m (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 14:59:42 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id G9qlb8r7BYOXTG9qmbWBYX; Thu, 23 Jun 2016 14:59:40 -0400
X-Authority-Analysis: v=2.1 cv=Gfm35VjL c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=GHbuC2Uv-WSV5FR99nYA:9 a=CjuIK1q_8ugA:10
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 05A6A2DA017F;
	Thu, 23 Jun 2016 14:59:39 -0400 (EDT)
Date:	Thu, 23 Jun 2016 14:59:38 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Lukas Fleischer <lfleischer@lfos.de>
cc:	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3] Refactor recv_sideband()
In-Reply-To: <146670333753.555.4852543207010532908@typhoon.lan>
Message-ID: <alpine.LFD.2.20.1606231453400.2550@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160622052951.8402-1-lfleischer@lfos.de> <alpine.LFD.2.20.1606221053150.2550@knanqh.ubzr> <alpine.LFD.2.20.1606221831100.2550@knanqh.ubzr> <146670333753.555.4852543207010532908@typhoon.lan>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfOFPmxMjnTDJz626AVxyGanDRzyEKWNL/qLR+vV2DlSHjWy2vS/8NBwc/Ahe9OwTQEI85NAtr8pLmm2UcZBNg505uGcrmrJ/+b/bCHQ8mqsM2kN5iAir
 Sb5JvDs1SyuWprjCzr9T/uKnA1YbwvdG9+OTPl+7X+bylZKLDJuiCMl0h4IpcTXe4CJTFSHvXFYNRp6cjzv73zeilZl2cwKWg0Y=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 23 Jun 2016, Lukas Fleischer wrote:

> On Thu, 23 Jun 2016 at 00:47:39, Nicolas Pitre wrote:
> > On Wed, 22 Jun 2016, Nicolas Pitre wrote:
> > [...]
> > >                 if (*b) {
> > >                         xwrite(STDERR_FILENO, outbuf.buf, outbuf.len);
> > >                         /* Incomplete line, skip the next prefix. */
> > >                         strbuf_reset(&outbuf);
> > >                 }
> > >                 continue;
> > > 
> > > You are probably missing a strbuf_addf() before the last xwrite().
> > 
> > In fact, you could simply append the partial line to the strbuf and make 
> > it the prefix for the next packet rather than writing a partial line.  
> > You'd only have to write a partial line before leaving the function if 
> > the strbuf is not empty at that point.
> 
> True. And I like that solution.
> 
> Thinking about your last sentence, do we care about printing an
> incomplete line at the end of the communication at all?

I'd think so. This is very unlikely to happen in practice, but that 
might be useful to diagnose potential problems.

> If so, do we need to print such a line on every return path (i.e. on 
> protocol and remote errors as well)? If we do, and if we want to 
> implement partial line handling the way you suggested, we should 
> probably print that final line from a common return path. And if we 
> add such a path, we could reconsider using a non-static strbuf as 
> well, since we could simply strbuf_release() the output buffer in that 
> common code block. Opinions?

That makes sense to me.


Nicolas
