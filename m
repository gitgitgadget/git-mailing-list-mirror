From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 03:22:07 +0200
Message-ID: <20090723012207.GA9368@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 03:23:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTn22-0007zv-Km
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 03:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbZGWBXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 21:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZGWBX3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 21:23:29 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:2636 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbZGWBX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 21:23:29 -0400
Received: by ey-out-2122.google.com with SMTP id 9so213026eyd.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 18:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dqSBBIp3BGfKiWBowh3fBJX1SMbaoHpzgIMgoZaFHkI=;
        b=eW0BGBYm3+CcfALT8zIcKaxXijDsYSuEOOZ+woc/dj7EDFMMw+BrsEfiGvhqC5lsU5
         PDOoKYK6UxebJTQwc52H5PLUXQmrvRbicUuYp0W272Z/jq2QdO+CCsCciU+2VqplpOD+
         eRlx9qJBIR2P6KLycvkMceJlQLccgt+ElIDA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OYw1/o+AuhocmMo+KAgPdGOmqUpcECBcOFRj2NU4/j2gXFfV/o7szj/CuA7bipHENQ
         hs7lBBf3cLirzVxuD9hYyoPEbqF46X6MHJatwRwzVd7BnTVXsQToEocICDrV6I43o2V1
         0hflf2jr+ocZFVBesOiOJR2QMvfARLfrhU/Kg=
Received: by 10.211.201.8 with SMTP id d8mr1896509ebq.7.1248312206650;
        Wed, 22 Jul 2009 18:23:26 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.106.15])
        by mx.google.com with ESMTPS id 10sm2820155eyz.41.2009.07.22.18.23.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 18:23:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123818>

On Wed 22.Jul'09 at 17:21:48 -0700, Linus Torvalds wrote:
> 
> When have you last repacked the repository?

Last week or so, with 'git repack -d -a'


> > [mafra@Pilar:linux-2.6]$ ls .git/refs/heads/
> > dev-private  master  sparse
> > 
> > which, apart from "master", are the last branches that I created.
> 
> Ok, this actually means that you _have_ repacked the repo, and the rest of 
> the branches are all nicely packed in .git/packed-refs.

Yes, now I saw the other branches inside packed-refs.

> But that four _second_ lstat() is really disgusting.
> 
> Let me guess: if you do a "ls -ld .git/refs/heads" you get a very big 
> directory, despite it only having three entries in it. 

[mafra@Pilar:linux-2.6]$ ls -ld .git/refs/heads
drwxr-xr-x 2 mafra mafra 4096 2009-07-22 23:01 .git/refs/heads/

> And your filesystem 
> doesn't have name hashing enabled, so searching for a non-existent file 
> involves looking through _all_ of the empty slots.

I use ext3 without changing any defaults that I know of (I simply compile
and boot the kernel of the day), and I have no idea if name hashing
is enabled here.

> Try this:
> 
> 	git pack-refs --all
> 
> 	rmdir .git/refs/heads
> 	rmdir .git/refs/tags
> 
> 	mkdir .git/refs/heads
> 	mkdir .git/refs/tags
> 
> and see if it magically speeds up.

It didn't change things, unfortunately.

After 'echo 3 > /proc/sys/vm/drop_caches' it still takes too long,

1248310449.693085 munmap(0x7f50bcd11000, 164) = 0
1248310449.693187 lstat(".git/refs/heads/sparse", 0x7fff618c0960) = -1 ENOENT (No such file or directory)
1248310449.719112 lstat(".git/refs/heads/stern", 0x7fff618c0960) = -1 ENOENT (No such file or directory)
1248310453.014041 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 3), ...}) = 0
1248310453.014183 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f50bcd11000

Perhaps I should delete the "stern" branch, but I would like to learn why
it is slowing things, because it also happened before (in fact it is always
like this, afaicr)

Do you have another theory? (now .git/refs/heads is empty)

Thanks,
Carlos
