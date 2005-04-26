From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] cg-export to tarball
Date: Wed, 27 Apr 2005 00:24:14 +0200
Message-ID: <426EBF8E.5000906@lsrfire.ath.cx>
References: <200504260312.46320.jcorbin@wunjo.org> <20050426202014.GJ13224@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 00:20:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYP4-0002YX-U0
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVDZWYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 18:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVDZWY2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 18:24:28 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:12944 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261820AbVDZWYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 18:24:18 -0400
Received: from [10.0.1.3] (p508E5FF1.dip.t-dialin.net [80.142.95.241])
	by neapel230.server4you.de (Postfix) with ESMTP id CEA1A11C;
	Wed, 27 Apr 2005 00:24:15 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: "Joshua T. Corbin" <jcorbin@wunjo.org>
In-Reply-To: <20050426202014.GJ13224@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis schrieb:
> Dear diary, on Tue, Apr 26, 2005 at 09:12:46AM CEST, I got a letter 
> where "Joshua T. Corbin" <jcorbin@wunjo.org> told me that...
> 
>> The following patch to cg-export will simlpy create a tarball if 
>> the argument ends in .tar.gz, .tar.bz2, or .tar.
>> 
>> Signed-off-by; Joshua T. Corbin <jcorbin@wunjo.org>
> 
> 
> What about cooperating with Rene Scharfe and using his tar-tree? I 
> didn't actually try it yet (not even look at the code so far), it'd 
> be cool if someone would give it some review and testing.

Yes, this looks like a job for tar-tree.  You could do something like this:

   destbasename=${destdir##*/}
   case "$destdir" in
   *.tar)
       tar-tree $id "${destbasename%.tar}" > "$destdir"
       ;;
   *.tgz)
       tar-tree $id "${destbasename%.tgz}" | gzip -9 > "$destdir"
       ;;
   # *.tar.gz, *.tar.bz2, ...
   *)
       mkdir -p "$destdir" || die "cannot create $destdir"
       export GIT_INDEX_FILE="$destdir/.git-index"
       read-tree $id
       checkout-cache "--prefix=$destdir/" -a
       rm "$GIT_INDEX_FILE"
       ;;
   esac

The second parameter to tar-tree is an optional prefix for all paths
inside the archive (official kernel tarballs always have linux-2.x.xx as
a prefix).  It makes some sense to set this value to the archive
filename, "cg-export linux-2.6.12-rc3.tar.bz2" would than work as expected.

What do you think?  If you like it I'll cook up a patch later unless you
beat me to it.

Thanks,
Rene
