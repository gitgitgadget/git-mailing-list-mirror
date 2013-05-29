From: =?ISO-8859-1?Q?Nicolas_Despr=E8s?= <nicolas.despres@gmail.com>
Subject: git ignore regression in 1.8.3
Date: Wed, 29 May 2013 14:31:46 +0200
Message-ID: <CAPqtr1KjmqRZZuVwput6=rKJrivb7siYePqT5QEOLJApg+phEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 29 14:32:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhfY7-0007M6-17
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966004Ab3E2McK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 08:32:10 -0400
Received: from mail-vb0-f47.google.com ([209.85.212.47]:65235 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965855Ab3E2McJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 08:32:09 -0400
Received: by mail-vb0-f47.google.com with SMTP id x13so6198712vbb.34
        for <git@vger.kernel.org>; Wed, 29 May 2013 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=QGJchar60O2GtTXOoWGH/Vj5ATyPVfsMAr87ped5Urc=;
        b=oD6edAnKEYGUp0HCcOVXngl4Egd1zP6ad+Jr59DSMsa/K9SbZz+jm1DZ6zRdwJeC+w
         KCIsEqgoUaZWgJRAJyFhf637KM6zk2K8aq5Ay1L/49G0X6yLXZ/wRo2yYNGSf7FzTRUd
         4AYdvwFZA2ZnEEh7JcoN0r/nygQ4Uc2M3IwwBlg0YotDn97TWiq8tfdx8P2N5fiYfr+M
         u4AddN9i6RF3Pr+q17CqFVN8mN20BESDVfNAXqR2yr87nQJYJ/wB7iK5MtLfThdSwkfW
         8nTq/ri0sZbcDRG8Zi2r63rplt1JScs/NNnB+De6ve/g25cE0QfG4dlqvjudq/zxecnS
         7q1Q==
X-Received: by 10.220.138.13 with SMTP id y13mr1331351vct.59.1369830726649;
 Wed, 29 May 2013 05:32:06 -0700 (PDT)
Received: by 10.221.10.7 with HTTP; Wed, 29 May 2013 05:31:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225801>

Hi all,

=46irst of all I would like to thank you all for the great tool that is
git. I love it and it makes my days way better.
This is my first post on this mailing list so please apology if there
is something wrong.

I have noticed a regression in the behavior of ignore rules in 1.8.3.
I have read the release notes and it might be related to all the great
optimization you guys have done.
My use case is quite uncommon but may happens to people who are
tracking their "dot files" like I do.
Basically I have a whitelist of non-ignored files at the top of my
repository and a blacklist of ignored file in some of the direct
sub-directories.

Example:
$ cd /tmp
$ mkdir repo
$ cd repo
$ git init
$ mkdir d
$ touch tracked d/tracked
$ git add tracked d/tracked
$ git commit -m "Initial commit"
$ touch untracked d/untracked
$ touch ignored d/ignored
$ echo '/*' >> .gitignore
$ echo '!/d/' >> .gitignore
$ echo '!/*' >> d/.gitignore
$ echo 'ignored' >> d/.gitignore
$ cat .gitignore
/*
!/d/
$ cat d/.gitignore
!/*
ignored
$ git --version
git version 1.8.3
$ git status -sb
## master
?? d/.gitignore
?? d/ignored
?? d/untracked
$ /usr/local/Cellar/git/1.8.2.3/bin/git --version
git version 1.8.2.3
$ /usr/local/Cellar/git/1.8.2.3/bin/git status -sb
## master
?? d/.gitignore
?? d/untracked
$ git config status.showUntrackedFiles
$ git check-ignore -v d/ignored
=2Egitignore:2:!/d/ d/ignored
$ /usr/local/Cellar/git/1.8.2.3/bin/git check-ignore -v d/ignored
=2Egitignore:2:!/d/ d/ignored

Although I am confused by the fact that both version of check-ignore
print the same result, my understanding of this behavior is that the
"local" d/.gitignore file is not taken into account and that once a
negate rule is set I can not include other sub-pattern any longer. I
have tried to only use the root .gitignore file like this

/*
!/d/
/d/ignored

but I have the same result. Removing the trailing slash in the
negative pattern (like this !/d) does not change anything. If I use
!/d/*, both version of git-status no longer report d/untracked.

I was happy with the 1.8.2.3 behavior. Maybe I misunderstand the new
behavior of 1.8.3. If yes please tell me how I could achieve the same
tricks in 1.8.3 because I did not find out how.
I have the same result with the next branch (version 1.8.3.430.gc6abf3f=
).

I have never hacked into git code base but I am willing to help if
someone can guide me a bit.

Regards,

--
Nicolas Despr=E8s
