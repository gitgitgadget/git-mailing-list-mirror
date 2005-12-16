From: Don Zickus <dzickus@gmail.com>
Subject: Re: git merge questions
Date: Fri, 16 Dec 2005 16:35:41 -0500
Message-ID: <68948ca0512161335k50a3ec64lee6f73ea4f8ae23f@mail.gmail.com>
References: <68948ca0512161205x3d5921bfm3bfcaa64f988eb99@mail.gmail.com>
	 <7vacf0g4ga.fsf@assigned-by-dhcp.cox.net>
	 <7vy82keo8p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 22:37:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnNF1-0001v1-Fd
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 22:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVLPVfn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 16:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVLPVfn
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 16:35:43 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:41169 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932476AbVLPVfm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 16:35:42 -0500
Received: by wproxy.gmail.com with SMTP id i3so991561wra
        for <git@vger.kernel.org>; Fri, 16 Dec 2005 13:35:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GLxPaquGjGrk7INIJ+/zMZuyHcC9vhmT4YfJDtHGCNY7WoI5EsdyNADMyuqIlQPU4rypP9ffF+3vk7cs3Km9u82z5b3mz870XP/hW6/OIXnJaPmKzeFf6zYVQSWsK9vXmBcikCE5KDJkC0tcLskf5W1qlSE4aJeQc/eevQGeyuw=
Received: by 10.65.110.8 with SMTP id n8mr222516qbm;
        Fri, 16 Dec 2005 13:35:41 -0800 (PST)
Received: by 10.65.240.20 with HTTP; Fri, 16 Dec 2005 13:35:41 -0800 (PST)
In-Reply-To: <7vy82keo8p.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13755>

> and then, the digging I suggested yields these:
>
> $ ls -l arch/{ppc64,powerpc}/Kconfig
> -rw-rw-r--  1 junio src 24279 Dec 16 12:55 arch/powerpc/Kconfig
> -rw-rw-r--  1 junio src 11027 Dec 16 12:58 arch/ppc64/Kconfig
> $ git ls-files -s arch/ppc64/Kconfig arch/powerpc/Kconfig
> 100644 bb2efdd566a9d590d64184b10b097e4b7ed17e95 0       arch/powerpc/Kconfig
> 100644 c658650af429672267409508b02b38754c11a40f 1       arch/ppc64/Kconfig
> 100644 8abf1118ebbd59954d098d87679114ffda0e75cb 3       arch/ppc64/Kconfig
> $ ls arch/{powerpc,ppc64}/Kconfig~*
> ls: arch/powerpc/Kconfig~*: No such file or directory
> ls: arch/ppc64/Kconfig~*: No such file or directory
> $ git diff --theirs arch/ppc64/Kconfig
> * Unmerged path arch/ppc64/Kconfig
> diff --git a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
>
> The merge algorithm thought your branch (that is, test2 which is
> v2.6.15-rc4) removed the old ppc64/Kconfig path, but the other
> branch (test1 which has diff between v2.6.14 and v2.6.14.4) made
> updates to that file.  For the other path, it simply thought
> your branch added a new file arch/powerpc/Kconfig while the
> other branch did not do anything to that path between v2.6.14
> and v2.6.14.4, so it merged it already.
>
> The result you want in this case is to merge changes between
> c65865 (stage1 of old path) and 8abf11 (stage3 of old path) into
> bb2efd (the latest contents of the new path) and register it as
> the result of merge for arch/powerpc/Kconfig, and remove
> arch/ppc64/Kconfig.  So the sequence would be:
>
> $ orig=$(git unpack-file c65865)
> $ from_test=$(git unpack-file 8abf11)
> $ merge $from_test $orig arch/powerpc/Kconfig
> merge: warning: conflicts during merge
>
> After resolving the conflict in $from_test file, and other conflicts:
>
> $ ed $from_test
> $ cat $from_tset >arch/ppc64/Kconfig
> $ rm arch/powerpc/Kconfig
> $ rm $orig $from_test
> $ git update-index --add --remove arch/ppc64/Kconfig arch/powerpc/Kconfig
> # also mark paths you hand-resolved such as Makefile, drivers/pcmcia/i82365.c
> # etc. with "git update-index" here.
> $ git commit
>
> would commit the result of the merge.
>

Wow. That makes sense then.  All your digging techniques seem to be
fairly straightforward.   Now say I didn't know the name of the rename
and I had to dig that up.  Would the following be the right way or is
there something easier?

%git log <renamed file>  #grab the last commit id from here
%git-diff-tree -p <last commit id>  # search for the new file

Thanks again,
Don
