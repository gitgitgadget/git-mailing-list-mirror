From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Thu, 15 Jan 2009 20:25:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151940170.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch> <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
 <8763khtbfc.fsf@iki.fi> <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de> <7vmydstoys.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 20:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNXrP-00042X-PQ
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 20:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310AbZAOTZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 14:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbZAOTZL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 14:25:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:39337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752842AbZAOTZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 14:25:09 -0500
Received: (qmail invoked by alias); 15 Jan 2009 19:25:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 15 Jan 2009 20:25:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mInYMZLumHpm87N6tetsx0eZ9+OvRVU2G6HRZdk
	+4UmiaIBBQioX3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vmydstoys.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105868>

Hi,

On Thu, 15 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> I didn't see the semantics of color-words documented in the original
> either,

Yeah, my bad.  Will try to fix it with this round of patches.

Actually, I'll give a quick outline right here:

Idea: the idea of word diff is to show the differences on a word level 
instead of line level.  To make it easier for humans (albeit we studiously 
exclude color blinds with our defaults), we do not show "+" and "-" as the 
standard diff does, but use colors to designate if the words were removed 
or added.

Now, the thing is that the inter-word parts _can_ differ.  The idea here 
is to show the part of the postimage and drop the preimage under the 
table.

Method: We use libxdiff as the real workhorse.  First, we let it generate 
a line diff.

Then we reconstruct the preimage and postimage for each hunk, process both 
into new images that have at most one word (in the new code exactly one 
word) per line, and feed the new preimage/postimage pair to libxdiff.

>From the output of libxdiff, we reconstruct which words were actually 
removed and which were added.  Then -- like the line based diff -- we 
combine the runs of common words, removed words and added words, and show 
them.

The algorithm I implemented in the new patch series is actually much 
cleaner than the old one:

- it feeds images to libxdiff which contain _exactly_ one word per line, 
  decoupling the word offsets in the original image from the offsets in 
  the processed image,

- this decoupling allows for arbitrary word boundaries, even 0-character 
  ones,

- it parses the hunk headers of the libxdiff output instead of the "-", 
  "+" and " " lines, and therefore does not have to play tricks with the 
  newline character in the middle of a run of removed words.

> What happens if a portion of background is only in the preimage?

If it is in a run of words that were removed, i.e. that are only in the 
preimage, then it is shown in that part.  Otherwise, the background of the 
preimage is never shown.

> E.g. when these two are compared:
> 
>   bbb aaa bb aa b
>   ccc aaa cc
> 
> what should happen?  We would want to say "aa" was removed by showing it
> in red, but on what background should it be displayed?  cc <red>aa</red>
> b?

If we are only ever interested in the 'a's, I'd say that the output should 
only reflect that.  In other words, what the current code does (ccc 
aaa<red>aa</red> cc) is okay IMHO.  After all, we said we're interested in 
the 'a's, so we should not complain that it did not show us the removal of 
'b's.

Ciao,
Dscho
