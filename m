From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Bug: segfault during git-prune
Date: Fri, 29 Jun 2007 13:39:58 +0100
Message-ID: <200706291340.00429.andyparkins@gmail.com>
References: <200706281134.58453.andyparkins@gmail.com> <200706282321.44244.andyparkins@gmail.com> <alpine.LFD.0.98.0706281525460.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 14:40:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Flk-0006k4-Mm
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 14:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbXF2MkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 08:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbXF2MkJ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 08:40:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:9546 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbXF2MkH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 08:40:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so798463ugf
        for <git@vger.kernel.org>; Fri, 29 Jun 2007 05:40:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rOyLhsKYW1qVH7S5NoFT5A3l1ijlDvztqqbpWEGjt0QlcAJBte6QUWm69E1M20RjUmUGLy/kKpmdownjNRouIkqe6N5TbCUAoj5iudQugjgNtSng5f5AEVDPnAz+oQsGioIfU3pCBFQz33rAU2nBN6x0UfmWfr+Oj21LJ4eVBPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gFD6hx19YVBHxkgdDr77+Uzp81HRHEcYQ+p9YWBSyNyQ5zUJ+TS+rjpm2WQq5bMDL8KBmeqmLspWGKSdj3rPHFa5uGQN2BC2cjbFCnifkyXnY/ES4KEDhvjeFozVCJGCvWNDsJp3KMF/846Lly69YJBui4d6fzttJA6YR/OnnK8=
Received: by 10.78.185.15 with SMTP id i15mr1570534huf.1183120805212;
        Fri, 29 Jun 2007 05:40:05 -0700 (PDT)
Received: from grissom.local ( [82.0.29.65])
        by mx.google.com with ESMTP id k10sm7195481nfh.2007.06.29.05.40.04
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jun 2007 05:40:04 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.0.98.0706281525460.8675@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51173>

On Thursday 2007, June 28, Linus Torvalds wrote:
> On Thu, 28 Jun 2007, Andy Parkins wrote:
> > I had hoped that git-prune wouldn't be a risk because I have:
> >
> >  * -- * -- * -- * -- * (ffmpeg-svn)
> >
> >       * -- * -- * -- * (libswscale-svn)
>
> Ok. If all subproject branches are also visible in the superproject as
> refs, then "git prune" should work fine, and you can apply my patch and
> it should just work very naturally: the reachability analysis will find
> the subprojects not through the superproject link, but simply through the
> direct refs to the subproject.

Excellent.  That's what I'd hoped.

I'm actually really impressed that git is robust enough that my symbolic 
linking of all the .git subdirectories works so well.  It's actually turned 
out to be a really natural way of using a repository for strongly connected 
submodules.

> This is not unlike just having two different repositories sharing the
> same object directory: as long as the two different repositories both
> have the appropriate refs, pruning is fine. In other words, you can see
> them as just independent branches in the same repo.

Absolutely.  With my poor-mans submodule script that I was using before git 
had it's own submodule support, I had the script make a refs/superrefs 
directory, and every time I committed to the supermodule the script would 
write $subhash to $submodule/.git/refs/heads/superrefs/$subhash.  The it 
was safe to git-prune the submodules as well.

> And in fact, subprojects are obviously very much *designed* to work that
> way: a subproject is basically a "different repository". So the basic
> rule is that if it would work with totally independent repos, it works
> with subprojects.

I certainly agree, it's an extremely elegant way of working.  I can't 
imagine that any other VCS is capable of this sort of manipulation.

> Anyway, if that patch works for you, I'd suggest you just pass it on to
> Junio (and feel free to add my "Signed-off-by:" on it - but conditional
> on you having actually tested it).

Will do.  I'll certainly test it, and am happy to forward it on if that test 
is successful.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
