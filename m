From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] mmap(win32): avoid copy-on-write when it is
 unnecessary
Date: Thu, 28 Apr 2016 10:03:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604281001220.2896@virtualbox>
References: <cover.1461335463.git.johannes.schindelin@gmx.de> <3e2a45e60e2905f52f962604cf19a0e5e39b9b1b.1461335463.git.johannes.schindelin@gmx.de> <571FB923.9040808@kdbg.org> <alpine.DEB.2.20.1604270834440.2896@virtualbox> <57210A38.4080203@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sven Strickroth <email@cs-ware.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 10:03:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avgvB-0004qu-QD
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 10:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbcD1IDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 04:03:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:63200 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbcD1IDb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 04:03:31 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M81vR-1bqQCw3Im1-00vgDw; Thu, 28 Apr 2016 10:03:23
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <57210A38.4080203@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:bsHXLAE2UzLhtADkwMipW+91XxE3lwZDI5x4KbgIV3GCbUSyEZ7
 sEcqJhwn8uMTQEEyOMZjphQQT9ti4nHInw9jb6dmxiC1oim7+JsPBpoUMY7KITY9qHv+ITG
 WaHgTvCx9gVQL4heIFQOjOoEiBbam4zrmlvz9N0usX9aSV6JdT+VgK2+cgEfoRLD4vozgnQ
 SgfGtmTYsn70I1GrrVcYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GqtI3I07uVg=:gYfqQAWSryOM15YfdqKRME
 vTHacjAJev05y9CjgX/Z4DSpinGW/sg+1SGUuiiOqWrKKMOKyCe4pz2e4NgCSKmSvkZQEtmzN
 igJZijTH2/KK6gYD2V8FycTA3Rej0HcexHJRMkdYOzFgYdUwThL770boduP3PQEOv8jl69dFu
 yu3CT8GxLvgk7NjDlS8EmNcFPsml4frfnD2SGwhQh9vBSl2yxfd5KzL0rVRhKfRI0q6Wa7EgI
 4UAnYicncTJaObciqmeY2Vqv/vBGE5Z6LTLlF5NrILP7/c90/QMZeLkKnATZ7hlAOoNWUIpJU
 RqS+HdXgGJF1fIigwdYhORMrPBsP0CbuNKDwYkEeOp2h3kw7MLGdZTauDyh77jRAvB7ygcwnS
 iq9R4WU4gArMIgVxK0Mp68qKQYIrjvJWjcxII9DmAXAdOG+L0I4UX7bv/OsJzQr4gegyg4ydN
 qwdU/rLtXfio5NO5Bx6Ax6aeuRVH2mwuiMuPRfsB95u2L1L9sA3xux1itFLZHXfN86WWcrPMD
 NFH8jCn8xF1GY/7XDkdUq+qqocBXhtOv22eZJ0agwt7YeiPs6QNq1XtdMSHLO8gK9n7+XT0Sz
 jOakyx8mQ63b15d5R7+ITmZfHGs9ALlMe/MEcab9H6mFTuGgJUWGDLqU4rBNyE9eBv8FEMVdr
 YIpdWkoPNrnO9Kbm3RjhN06KK/QNsDGJ7lUZXMBNz5/Xqc0UOQDmcXQ+DOrsbViNSjGLEdgGN
 u8sFic+Uvsvopr8VJZnyBlBg2H+ghCApgQ5sLb8M/7zZZBMZoGL97j2StjfdJQus1M6+1Rtr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292857>

Hi Hannes,

On Wed, 27 Apr 2016, Johannes Sixt wrote:

> Am 27.04.2016 um 08:43 schrieb Johannes Schindelin:
> > On Tue, 26 Apr 2016, Johannes Sixt wrote:
> > > Should we insert a check for MAP_PRIVATE to catch
> > > unexpected use-cases (think of the index-helper daemon effort)?
> >
> > I agree, we should have such a check. The line above the `die("Invalid
> > usage ...")` that you can read as first line in above-quoted hunk reads:
> >
> >  if (!(flags & MAP_PRIVATE))
> >
> > So I think we're fine :-)
> 
> Oh, well... I thought I had checked the code before I wrote my question, but
> it seems I was blind... ;)

Don't worry! I really appreciate your review!

Ciao,
Johannes
