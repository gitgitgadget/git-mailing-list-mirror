From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 09:09:17 -0500
Message-ID: <20060118140917.GA15438@mythryan2.michonline.com>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <20060118125158.GN28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mathias Waack <Mathias.Waack@rantzau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 15:09:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzE0B-0000Dn-3x
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 15:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWAROJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 09:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbWAROJ2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 09:09:28 -0500
Received: from mail.autoweb.net ([198.172.237.26]:51926 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1030311AbWAROJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 09:09:27 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EzDzz-0006mP-IG; Wed, 18 Jan 2006 09:09:20 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1EzDzy-0007zN-7h; Wed, 18 Jan 2006 09:09:19 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1EzDzx-0004yb-IG; Wed, 18 Jan 2006 09:09:17 -0500
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060118125158.GN28365@pasky.or.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14827>

On Wed, Jan 18, 2006 at 01:51:58PM +0100, Petr Baudis wrote:
>   Hello,
> 
> Dear diary, on Wed, Jan 18, 2006 at 01:25:59PM CET, I got a letter
> where Mathias Waack <Mathias.Waack@rantzau.de> said that...
> > we're using git with cogito as a frontend. For some reasons I forgot we have 
> > some repositories which belong to the same project. To simplify the whole 
> > thing I would like to join these repositories. It mainly means to move some 
> > directories. So lets say I have: 
> > 
> > 	/r1/.git
> > 	/r2/.git
> > 
> > and what I would like to have is
> > 
> > 	/r/.git
> > 	   r1
> >            r2
> > 
> > Of course the history should remain (otherwise it would be to easy). 
> > 
> > How should I do this?
> 
>   The crucial question is what the joined repository's directory
> structure should be. If from r1/a, r2/b you want r/a, r/b then it's
> easy:
> 
> 	cd r1
> 	cg-branch-add r2 ../r2/.git
> 	cg-fetch r2
> 	cg-merge -j r2
> 
>   But if you want r1/a, r2/b to turn to r/r1/a, r/r2/b, you will have
> to rewrite the history of each (and then do the above). One rough
> and untested sketch...

... Why would that be the optimal method?

Assuming both repositories are clean, no extraneous files, and without
testing, of course:

In r1:
	mkdir r1
	# move everything into the subdirectory called r1.
	git mv $(ls -a | grep -v -e ^.git$ -e ^r1$) r1/
	git commit -a "Restructure directory"

In r2:
	mkdir r2
	# move all files into r2/
	git mv $(ls -a | grep -v -e ^.git$ -e ^r2$) r2/
	git commit -a "Restructure directory"

	git fetch ../r1/
	GIT_INDEX_FILE=.git/tmp-index git-read-tree FETCH_HEAD
	GIT_INDEX_FILE=.git/tmp-index git-checkout-cache -a -u
	git-update-cache --add -- $(GIT_INDEX_FILE=.git/tmp-index git-ls-files)
	cp .git/FETCH_HEAD .git/MERGE_HEAD
	git commit

No history rewritten, merging with the old repositories should, at least
theoretically, work, etc.

(This is just a restatement of Linus's "Coolest merge ever" / union
merge)

-- 

Ryan Anderson
  sometimes Pug Majere
