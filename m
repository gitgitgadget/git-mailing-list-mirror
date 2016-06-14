From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 13:55:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1606141347310.1714@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr> <alpine.LFD.2.20.1606141245490.1714@knanqh.ubzr> <CsLdb3qLMBok7CsLebwX38@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Tue Jun 14 19:55:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCsYW-0002G5-4T
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 19:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbcFNRzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 13:55:10 -0400
Received: from alt32.smtp-out.videotron.ca ([24.53.0.21]:63604 "EHLO
	alt32.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752455AbcFNRzJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 13:55:09 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id CsYMbczki7gE8CsYNbSliW; Tue, 14 Jun 2016 13:55:07 -0400
X-Authority-Analysis: v=2.1 cv=B94ZqLZM c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=ssDU8-XTtA8lLubsY9EA:9 a=CjuIK1q_8ugA:10
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 961122DA01A5;
	Tue, 14 Jun 2016 13:55:06 -0400 (EDT)
In-Reply-To: <CsLdb3qLMBok7CsLebwX38@videotron.ca>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
X-CMAE-Envelope: MS4wfPINhmQzQTiPO0JE6VFVzGKUVihrdEhswOsAqw1r3qqXKo5w8yRRO/Ae0znPWt1aPNEMIZvgLKqG7/SR6Ved13hZPBhZjvHGOGYNNfFztWCIgMcv5qJB
 WqHdGmR+coYxwvQc6NH7yBcNljG1D3a8A9jBcg4TWYHN+jQXJVS3V+PsivqpRBgoAD/OM21K2xhgWZR0nalFaeajINoU/bE5TZ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297314>

On Tue, 14 Jun 2016, Lukas Fleischer wrote:

> Hi Nicolas,
> 
> On Tue, 14 Jun 2016 at 19:09:15, Nicolas Pitre wrote:
> > I just looked again at all the contraptions _I_ wrote (not Junio's) for 
> > a reason why I went to such extremes in making this code co complicated.
> > 
> > One aspect that is now lost with your patch is the atomic nature of the 
> > write.  See commit ed1902ef5c for the explanation.  You could probably 
> > use sprintf() into a temporary buffer and write it in one go to avoid 
> > segmented writes from the C library. It's probably not worth having that 
> > complex code just to avoid a string copy.
> 
> The old code calls fprintf() once per line and so does the new code. The
> only difference is that in the old code, the single parts were
> concatenated manually while the new code tells fprintf() to do the
> concatenation itself while printing. Also note that fprintf() is
> buffered -- so even if the new code would call it more often, it would
> not really matter.

It is not buffered as it writes to stderr. And some C libs do separate 
calls to write() for every string format specifier. So "%s%s%c" may end 
up calling write() 3 times depending on the implementation.  The example 
I gave in commit ed1902ef5c is real and I even observed it with strace 
back then.


Nicolas
