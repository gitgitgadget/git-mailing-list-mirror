From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] multi item packed files
Date: Thu, 21 Apr 2005 16:22:46 -0400
Message-ID: <200504211622.48065.mason@suse.com>
References: <200504211113.13630.mason@suse.com> <Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org> <m3u0m0q69a.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 22:19:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOi85-0006Pz-VI
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 22:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVDUUWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 16:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVDUUWz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 16:22:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30863 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261855AbVDUUWw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 16:22:52 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 077A991AD;
	Thu, 21 Apr 2005 22:22:52 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id AF7E614BDE0; Thu, 21 Apr 2005 22:22:51 +0200 (CEST)
To: Krzysztof Halasa <khc@pm.waw.pl>
User-Agent: KMail/1.8
In-Reply-To: <m3u0m0q69a.fsf@defiant.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 21 April 2005 15:28, Krzysztof Halasa wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > Wrong. You most definitely _can_ lose: you end up having to optimize for
> > one particular filesystem blocking size, and you'll lose on any other
> > filesystem. And you'll lose on the special filesystem of "network
> > traffic", which is byte-granular.
>
> If someone needs better on-disk ratio, (s)he can go with 1 KB filesystem
> or something like that, without all the added complexity of packing.
>
> If we want to optimize that further, I would try doing it at the
> underlying filesystem level. For example, loop-mounted one.

Shrug, we shouldn't need help from the kernel for something like this.  git as 
a database hits worst case scenarios for almost every FS.

We've got:

1) subdirectories with lots of files
2) wasted space for tiny files
3) files that are likely to be accessed together spread across the whole disk

One compromise for SCM use would be one packed file per commit, with an index 
that lets us quickly figure out which commit has a particular version of a 
given file.  My hack gets something close to that (broken into 32k chunks for 
no good reason), and the index to find a given file is just the git directory 
tree.

But my code does hide the fact that we're packing things from most of the git 
interfaces.  So I can almost keep a straight face while claiming to be true 
to the original git design...almost.  The whole setup is far from perfect, 
but it is one option for addressing points 2 & 3 above.

-chris
