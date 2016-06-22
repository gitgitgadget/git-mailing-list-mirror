Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0DB820189
	for <e@80x24.org>; Wed, 22 Jun 2016 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbcFVPDR (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:03:17 -0400
Received: from alt22.smtp-out.videotron.ca ([70.80.0.73]:55355 "EHLO
	alt22.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751726AbcFVPDC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2016 11:03:02 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id FjgAbbLt5zCgpFjgBbsDCg; Wed, 22 Jun 2016 11:03:01 -0400
X-Authority-Analysis: v=2.1 cv=QfzGxpvv c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=dg4UtMH5AAAA:8 a=gLDkJJiQLP1UIcxvOVIA:9 a=CjuIK1q_8ugA:10
 a=byNfn09xH3PuSfgbYLsR:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 55A032DA0492;
	Wed, 22 Jun 2016 11:02:58 -0400 (EDT)
Date:	Wed, 22 Jun 2016 11:02:56 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Lukas Fleischer <lfleischer@lfos.de>
cc:	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3] Refactor recv_sideband()
In-Reply-To: <20160622052951.8402-1-lfleischer@lfos.de>
Message-ID: <alpine.LFD.2.20.1606221053150.2550@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160622052951.8402-1-lfleischer@lfos.de>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfJrnqI5DZAo/uK2UEf5k4ll6mPDg8I8JBEgE2miI7RxsfzDgCzajgxhUMitVK1xQnvRPgUdUv4id0JsWxYkekbY32nWfv0QXHPG6+V4QKILFSJFGho0l
 gh8WVM6IHRhZOwaC6Mrx12IAzyY7TC7Ir0NUiNEsoPG7nvxKEGSoXAGhk4vTA0EDf3Pn4UPDYkCm1TMJU/TookOcoykMBKnorpo=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, 22 Jun 2016, Lukas Fleischer wrote:

> Before this patch, we used character buffer manipulations to split
> messages from the sideband at line breaks and insert "remote: " at the
> beginning of each line, using the packet size to determine the end of a
> message. However, since it is safe to assume that diagnostic messages
> from the sideband never contain NUL characters, we can also
> NUL-terminate the buffer, use strpbrk() for splitting lines and use
> format strings to insert the prefix.
> 
> A static strbuf is used for constructing the output which is then
> printed using a single write() call, such that the atomicity of the
> output is preserved. See 9ac13ec (atomic write for sideband remote
> messages, 2006-10-11) for details.
> 
> Helped-by: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>

The patch is buggy.

Once patched, the code looks like this:

        case 2:
                b = buf + 1;
                /*
                 * Append a suffix to each nonempty line to clear the
                 * end of the screen line.
                 */
                while ((brk = strpbrk(b, "\n\r"))) {
                        int linelen = brk - b;
                        if (linelen > 0) {
                                strbuf_addf(&outbuf, "%.*s%s%c",
                                            linelen, b, suffix, *brk);
                        } else {
                                strbuf_addf(&outbuf, "%c", *brk);
                        }
                        xwrite(STDERR_FILENO, outbuf.buf, outbuf.len);
                        strbuf_reset(&outbuf);
                        strbuf_addf(&outbuf, "%s", PREFIX);
                        b = brk + 1;
                }
                if (*b) {
                        xwrite(STDERR_FILENO, outbuf.buf, outbuf.len);
                        /* Incomplete line, skip the next prefix. */
                        strbuf_reset(&outbuf);
                }
                continue;

You are probably missing a strbuf_addf() before the last xwrite().


Nicolas
