Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CDC82018B
	for <e@80x24.org>; Wed, 22 Jun 2016 23:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbcFVXDk (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 19:03:40 -0400
Received: from alt13.smtp-out.videotron.ca ([135.19.0.26]:12878 "EHLO
	alt12.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751810AbcFVXDi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2016 19:03:38 -0400
X-Greylist: delayed 949 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jun 2016 19:03:37 EDT
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id FqvsbKAocq3HFFqvtbLvDi; Wed, 22 Jun 2016 18:47:42 -0400
X-Authority-Analysis: v=2.1 cv=Q9lym9Ca c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=dg4UtMH5AAAA:8 a=xD_RS4PtYRgHWBiv6XgA:9 a=CjuIK1q_8ugA:10
 a=byNfn09xH3PuSfgbYLsR:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 06C3F2DA0492;
	Wed, 22 Jun 2016 18:47:40 -0400 (EDT)
Date:	Wed, 22 Jun 2016 18:47:39 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Lukas Fleischer <lfleischer@lfos.de>
cc:	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3] Refactor recv_sideband()
In-Reply-To: <alpine.LFD.2.20.1606221053150.2550@knanqh.ubzr>
Message-ID: <alpine.LFD.2.20.1606221831100.2550@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160622052951.8402-1-lfleischer@lfos.de> <alpine.LFD.2.20.1606221053150.2550@knanqh.ubzr>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfDTAZQ9eEO/EHUOBe9OZZMcwnYNtL1r8f/spAMLD1Fg+IlO0RgOyanVwN77DGj13eWlN3QKohrbovd2/gHkW+EflQEIuatfh2VhPD2hi36+axCOCPxK2
 IgvM4LDFJ6kHwSPGDS61xaFYQa1YUqTUe/pvhDp3gVAtKwPegCNhTW5QxfBsLggJnVCYnpwUIxMyDR0GPbK1seWDIY7xrOZVUhA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, 22 Jun 2016, Nicolas Pitre wrote:

> On Wed, 22 Jun 2016, Lukas Fleischer wrote:
> 
> > Before this patch, we used character buffer manipulations to split
> > messages from the sideband at line breaks and insert "remote: " at the
> > beginning of each line, using the packet size to determine the end of a
> > message. However, since it is safe to assume that diagnostic messages
> > from the sideband never contain NUL characters, we can also
> > NUL-terminate the buffer, use strpbrk() for splitting lines and use
> > format strings to insert the prefix.
> > 
> > A static strbuf is used for constructing the output which is then
> > printed using a single write() call, such that the atomicity of the
> > output is preserved. See 9ac13ec (atomic write for sideband remote
> > messages, 2006-10-11) for details.
> > 
> > Helped-by: Nicolas Pitre <nico@fluxnic.net>
> > Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> 
> The patch is buggy.
> 
> Once patched, the code looks like this:
> 
>         case 2:
>                 b = buf + 1;
>                 /*
>                  * Append a suffix to each nonempty line to clear the
>                  * end of the screen line.
>                  */
>                 while ((brk = strpbrk(b, "\n\r"))) {
>                         int linelen = brk - b;
>                         if (linelen > 0) {
>                                 strbuf_addf(&outbuf, "%.*s%s%c",
>                                             linelen, b, suffix, *brk);
>                         } else {
>                                 strbuf_addf(&outbuf, "%c", *brk);
>                         }
>                         xwrite(STDERR_FILENO, outbuf.buf, outbuf.len);
>                         strbuf_reset(&outbuf);
>                         strbuf_addf(&outbuf, "%s", PREFIX);
>                         b = brk + 1;
>                 }
>                 if (*b) {
>                         xwrite(STDERR_FILENO, outbuf.buf, outbuf.len);
>                         /* Incomplete line, skip the next prefix. */
>                         strbuf_reset(&outbuf);
>                 }
>                 continue;
> 
> You are probably missing a strbuf_addf() before the last xwrite().

In fact, you could simply append the partial line to the strbuf and make 
it the prefix for the next packet rather than writing a partial line.  
You'd only have to write a partial line before leaving the function if 
the strbuf is not empty at that point.


Nicolas
