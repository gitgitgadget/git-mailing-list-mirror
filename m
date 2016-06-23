Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D081FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 17:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbcFWRfm (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:35:42 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:4358 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbcFWRfl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 13:35:41 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id fb6caf66
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Thu, 23 Jun 2016 19:35:38 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:	Nicolas Pitre <nico@fluxnic.net>
From:	Lukas Fleischer <lfleischer@lfos.de>
In-Reply-To: <alpine.LFD.2.20.1606221831100.2550@knanqh.ubzr>
Cc:	git@vger.kernel.org, "Johannes Sixt" <j6t@kdbg.org>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <20160622052951.8402-1-lfleischer@lfos.de>
 <alpine.LFD.2.20.1606221053150.2550@knanqh.ubzr>
 <alpine.LFD.2.20.1606221831100.2550@knanqh.ubzr>
Message-ID: <146670333753.555.4852543207010532908@typhoon.lan>
User-Agent: alot/0.3.7
Subject: Re: [PATCH v3] Refactor recv_sideband()
Date:	Thu, 23 Jun 2016 19:35:37 +0200
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 23 Jun 2016 at 00:47:39, Nicolas Pitre wrote:
> On Wed, 22 Jun 2016, Nicolas Pitre wrote:
> [...]
> >                 if (*b) {
> >                         xwrite(STDERR_FILENO, outbuf.buf, outbuf.len);
> >                         /* Incomplete line, skip the next prefix. */
> >                         strbuf_reset(&outbuf);
> >                 }
> >                 continue;
> > 
> > You are probably missing a strbuf_addf() before the last xwrite().
> 
> In fact, you could simply append the partial line to the strbuf and make 
> it the prefix for the next packet rather than writing a partial line.  
> You'd only have to write a partial line before leaving the function if 
> the strbuf is not empty at that point.

True. And I like that solution.

Thinking about your last sentence, do we care about printing an
incomplete line at the end of the communication at all? If so, do we
need to print such a line on every return path (i.e. on protocol and
remote errors as well)? If we do, and if we want to implement partial
line handling the way you suggested, we should probably print that final
line from a common return path. And if we add such a path, we could
reconsider using a non-static strbuf as well, since we could simply
strbuf_release() the output buffer in that common code block. Opinions?

I will wait for more comments and submit v4 in a couple of days.
