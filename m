From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Fri, 22 Jun 2007 11:39:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706221122200.4059@racer.site>
References: <20070621030622.GD8477@spearce.org> 
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net>
 <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 12:40:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1gYZ-0004C2-Qj
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 12:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbXFVKjy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 06:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXFVKjy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 06:39:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:49662 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751489AbXFVKjx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 06:39:53 -0400
Received: (qmail invoked by alias); 22 Jun 2007 10:39:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 22 Jun 2007 12:39:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18n0l81N1Un0i0SOWP+h0KJlzEZTTo4vNGd7Pm98U
	sMgKX7iCQwxCVV
X-X-Sender: gene099@racer.site
In-Reply-To: <467B777D.C47BFE0E@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50687>

Hi,

On Fri, 22 Jun 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> >         The dangerous thing is that the score can get negative now.
> >  ...
> > +               score = (int)(src_copied * MAX_SCORE / max_size)
> > +                       - levenshtein(src->path, dst->path);
> 
> Does that also mean that you can't ever have a rename with a score of
> 100%?
> 
> (I haven't studied the algorithms and assume that levenshtein(a,b) == 0
> only if a==b, and that without the -levenshtein(...) the score can grow
> to 100%.)

There is a different code path for identical contents. So yes, you can 
still hit 100%, but it is now much, much harder to hit a score close to 
100% [*1*].

The obviously correct way to do this is to have a subscore, and use it 
_strictly_ only when the score is identical.

I see two ways to do this properly:

- introduce a name_distance struct member, just below the score. This 
  means that estimate_similarity has to "return" two values instead of 
  one, and score_compare gets a bit more complex, too. Or

- change the score to unsigned long, and shift the score to higher bits, 
  adding a constant minus the Levenshtein distance. It is safe to assume 
  that the filenames are shorter than 16384 bytes (PATH_MAX is actually 
  much smaller than that), and even if two filenames of that length are 
  completely different, the distance can not be larger than twice that 
  number, i.e. 16384 deletions + 16384 insertions. Therefore, you could 
  pick 32768 as that constant.

However, I find both solutions ugly. Besides, I am not interested in the 
feature myself, only the implementation of Levenshtein was interesting, 
and I thought I just post the code here. So I did only the minimal stuff 
on top of the interesting one to make it sort of work.

If somebody wants to pick up the ball, be my guest, because I am out of 
that game.

Ciao,
Dscho

Footnote:

*1* Actually, it is not _that_ bad. The score is not a value between 0 and 
    100, IOW it is _not_ what you see in the output of "diff -M". It is an 
    unsigned short between 0 and MAX_SCORE, which is defined in 
    diffcore.h as 60000.0.

    The Levenshtein distance between two filenames cannot be larger than 
    the sum of their lengths, so it should be relatively safe. That is, if 
    you don't have such insanely long paths as e.g. egit. But even there, 
    the paths share most of their directories, and therefore the distances 
    should be much, much smaller in real life.
