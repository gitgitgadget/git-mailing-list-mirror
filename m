From: Sean <seanlkml@sympatico.ca>
Subject: Re: git reset --hard not removing some files
Date: Fri, 2 Jun 2006 06:08:20 -0400
Message-ID: <BAYC1-PASMTP11DBD87560470F1DA42426AE910@CEZ.ICE>
References: <20060601160052.GK14325@admingilde.org>
	<Pine.LNX.4.64.0606010918060.5498@g5.osdl.org>
	<20060602093736.GL14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 12:09:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm6ag-0001HB-CN
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 12:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWFBKI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 06:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWFBKI5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 06:08:57 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:44760 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751361AbWFBKI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 06:08:56 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Jun 2006 03:14:04 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 7D1E0644C28;
	Fri,  2 Jun 2006 06:08:54 -0400 (EDT)
To: Martin Waitz <tali@admingilde.org>
Message-Id: <20060602060820.8eebe391.seanlkml@sympatico.ca>
In-Reply-To: <20060602093736.GL14325@admingilde.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 02 Jun 2006 10:14:04.0421 (UTC) FILETIME=[46AFBB50:01C6862D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2 Jun 2006 11:37:36 +0200
Martin Waitz <tali@admingilde.org> wrote:

Hi Martin,

> GIT reset seems to have a problem when a file is tracked and ignored
> at the same time.

I tried to reproduce this problem, but couldn't.

> This fails:
> 
> diff --git a/t/t7101-reset.sh b/t/t7101-reset.sh
> index a919140..865e0f6 100755
> --- a/t/t7101-reset.sh
> +++ b/t/t7101-reset.sh
> @@ -21,10 +21,12 @@ test_expect_success \
>       cp ../../COPYING path1/COPYING &&
>       cp ../../COPYING COPYING &&
>       cp ../../COPYING path0/COPYING-TOO &&
> +     echo COPYING > .gitignore &&
>       git-add path1/path2/COPYING &&
>       git-add path1/COPYING &&
>       git-add COPYING &&
>       git-add path0/COPYING-TOO &&
> +     git-add .gitignore &&
>       git-commit -m change -a'
> 
>  test_expect_success \

This fails because git-add refuses to mark an ignored file as tracked.
So in your altered test above the COPYING file is never tracked.
git-reset then does the proper thing and refuses to remove it.  So it's
still not demonstrating the case you mention below.
 
> This hit me as the Linux kernel .gitignore includes ".*" which matches
> all the .gitignore files and so they are not removed when you go
> back to 2.6.13.  But with the new git checks regarding files in
> the working dir, git then refuses to pull in newer Linux versions
> because it would overwrite ".gitignore".

Strange.. this little test shows that tracked files that are ignored
do get removed when resetting --hard...

$ mkdir tryit ; cd tryit
$ git init-db
defaulting to local storage area

$ touch one ; git add one
$ git commit -a -m"Initial"
Committing initial tree 5fcffbd6e4c5c5b8d81f5e9314b20e338e3ffff5

$ touch .gitignore
$ git add .gitignore
$ git commit -a -m"now we have gitignore"

$ echo '.*' >> .gitignore
$ git commit -a -m'now git ignores all .* files'

$ ls -l .gitignore
-rw-r--r-- 1 sean sean 3 Jun  2 06:01 .gitignore

$ git reset --hard master~2
$ ls -l .gitignore
ls: .gitignore: No such file or directory


Sean
