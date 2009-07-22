From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 01:59:14 +0200
Message-ID: <20090722235914.GA13150@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 02:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTljl-0000Us-1A
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 02:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbZGWAAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 20:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbZGWAAc
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 20:00:32 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:24642 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbZGWAAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 20:00:31 -0400
Received: by ey-out-2122.google.com with SMTP id 9so206456eyd.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=DPBg6JO5wqpL+/zIm96uK3ezfbnYP8uJflUc5xqX7U4=;
        b=DJrv+uoN1UPi6BhBrWUqYy236Rs6QOJTndr6D59rYC05zqAOf2b83Zv707StkdJzp3
         Dgh26Qh5yKsVMNEvS/FgEfk8dGFS6ZxaRb+GDToRnX+xahI6dMmBhziGG9UsXDIX4pqt
         HxO+dtsiZk85Aj9rqCTFixKWho6w1owForYrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=rAwyiB31lotyt74p3sVKCZRBO3nqso5T183tRhO76Wb9uES1/uWI6TUhSmAWp4PW2N
         iSJwVMtOAZWFOvkgJHogAkGFLwv7CSuMrxDXTyEqwto8GrhIdFz5tPL05Z2+R0+XQ/k9
         Kh2q9lODDhNrUunUJS9FolsvxTHnr5FlLHr74=
Received: by 10.210.118.13 with SMTP id q13mr1779677ebc.45.1248307231020;
        Wed, 22 Jul 2009 17:00:31 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.106.15])
        by mx.google.com with ESMTPS id 28sm2451224eye.30.2009.07.22.17.00.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 17:00:30 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123812>

Hi,

When I run 'git branch' in the linux-2.6 repo I think it takes
too long to finish (with cold cache):

[mafra@Pilar:linux-2.6]$ time git branch
  27-stable
  28-stable
  29-stable
  30-stable
  dev-private
* master
  option
  sparse
  stern
0.00user 0.05system 0:05.73elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (209major+1380minor)pagefaults 0swaps

This is with git 1.6.4.rc1.10.g2a67 and the kernel is 2.6.31-rc3+. The
machine is a 64bit Vaio laptop which is 1+ year old (so it is not "slow").

Repeating the command a second time takes basically zero seconds, but
this is more or less what I would expect in the first time too.

I use git to track linux-2.6 for 2 years now, and I remember that
'git branch' is slow for quite some time, so it is not a regression
or something. It is just now that I took the courage to report this
small issue.

I did a 'strace' and this is where it spent most of the time:

1248301060.654911 open(".git/refs/heads/sparse", O_RDONLY) = 6
1248301060.654985 read(6, "60afdf6a4065a170ad829b4d79a86ec0"..., 255) = 41
1248301060.655056 read(6, "", 214)      = 0
1248301060.655116 close(6)              = 0
1248301060.680754 lstat(".git/refs/heads/stern", 0x7fff80bfa8d0) = -1 ENOENT (No such file or directory)
1248301064.018491 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
1248301064.018641 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f409ffa7000
1248301064.018722 write(1, "  27-stable\33[m\n", 15) = 15

I don't know why .git/refs/heads/stern does not exist and why it takes
so long with it. That branch is functional ('git checkout stern' succeeds),
as well as all the others. But strangely .git/refs/heads/ contains only

[mafra@Pilar:linux-2.6]$ ls .git/refs/heads/
dev-private  master  sparse

which, apart from "master", are the last branches that I created.

I occasionally run 'git gc --aggressive --prune" to optimize the repo,
but other than that I don't do anything fancy, just 'pull' almost
every day and 'bisect' (which is becoming a rare event now :-)

So I would like to ask what should I do to recover the missing files
in .git/refs/heads/ (which apparently is the cause for my issue) and
how I can avoid losing them in the first place.

Also, is there a way to "fix" the 4-secs pause in that lstat() in
case the files in .git/refs/heads/ get lost again?

Thanks in advance,
Carlos
