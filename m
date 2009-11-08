From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [BUG]
Date: Sun, 08 Nov 2009 21:36:19 +0100
Message-ID: <vpqeio8eou4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 21:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7EXu-0004iO-Ee
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 21:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332AbZKHUjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 15:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755330AbZKHUjZ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 15:39:25 -0500
Received: from imag.imag.fr ([129.88.30.1]:39316 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755311AbZKHUjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 15:39:24 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nA8KaJtE019160
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 8 Nov 2009 21:36:19 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N7EUl-000565-78; Sun, 08 Nov 2009 21:36:19 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 08 Nov 2009 21:36:19 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132414>

--=-=-=

Hi,

I'm hitting a bug when git-push-ing to a Linux PPC machine. In
general, pushing works well, but pushing some particular commits
breaks reproducibly with :

fatal: early EOF
error: unpack failed: unpack-objects abnormal exit
To ssh://localhost//home/perms/moy/prive/dest
 ! [remote rejected] master -> master (n/a (unpacker error))

I've put the guilty files on my website and wrote a reproduction
script:

#!/bin/sh

rm -fr source dest
git init source
git init --bare dest
dest=$PWD/dest
cd source
echo foo > bar.txt
git add .
git commit -m init
git push ssh://localhost/$dest master
wget 'http://www-verimag.imag.fr/~moy/tmp/git-bug/Conception Manual.docx'
wget 'http://www-verimag.imag.fr/~moy/tmp/git-bug/Extreme Programming.doc'
git add .
git commit -m "bug"
git push ssh://localhost/$dest master

The full output is attached (the error message for the last push is
given above). The machine on which I get this (let's call it "A")
says :

$ ssh -Version
OpenSSH_4.3p2, OpenSSL 0.9.8e-fips-rhel5 01 Jul 2008
$ uname -a
Linux A 2.6.18-128.7.1.el5 #1 SMP Wed Aug 19 04:08:13 EDT 2009 ppc64 ppc64 ppc64 GNU/Linux
$ cat /etc/redhat-release                                                                                                                                           
Red Hat Enterprise Linux Server release 5.4 (Tikanga)
(it's a 32-bit distribution although the machine is 64bits)
$ git --version
git version 1.6.5.2
(compiled myself, "make test" passes)

According to my experiments, the problem is on the receiver side. If I
do the same as above, with source/ and dest/ directories on two
different machines, then if source/ in on A and dest/ anywhere else,
it works, and if dest/ is on machine A, I get the same error.

If I push using "file://" instead of "ssh://", then everything works
well.

If instead of push-ing, I go to dest/ and do a fetch, then it works
well too.

Does anyone have any idea on what's going on?

If anyone has a machine similar to mine (ppc64), can he/she run my
reproduction script and tell me if the bug happens?

Thanks a lot,


--=-=-=
Content-Disposition: attachment; filename=git-bug-output.txt
Content-Transfer-Encoding: quoted-printable

Initialized empty Git repository in /perms/moy/prive/source/.git/
Initialized empty Git repository in /perms/moy/prive/dest/
[master (root-commit) e14141d] init
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 bar.txt
Counting objects: 3, done.
Writing objects:  33% (1/3)   =0DWriting objects:  66% (2/3)   =0DWriting o=
bjects: 100% (3/3)   =0DWriting objects: 100% (3/3), 209 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To ssh://localhost//home/perms/moy/prive/dest
 * [new branch]      master -> master
--2009-11-08 21:15:27--  http://www-verimag.imag.fr/~moy/tmp/git-bug/Concep=
tion%20Manual.docx
Resolving www-verimag.imag.fr... 129.88.43.46
Connecting to www-verimag.imag.fr|129.88.43.46|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1064912 (1.0M) [application/x-zip]
Saving to: `Conception Manual.docx'

     0K .......... .......... .......... .......... ..........  4% 42.9M 0s
    50K .......... .......... .......... .......... ..........  9% 38.1M 0s
   100K .......... .......... .......... .......... .......... 14% 51.4M 0s
   150K .......... .......... .......... .......... .......... 19% 47.1M 0s
   200K .......... .......... .......... .......... .......... 24% 54.5M 0s
   250K .......... .......... .......... .......... .......... 28% 58.4M 0s
   300K .......... .......... .......... .......... .......... 33% 53.5M 0s
   350K .......... .......... .......... .......... .......... 38% 64.5M 0s
   400K .......... .......... .......... .......... .......... 43% 42.0M 0s
   450K .......... .......... .......... .......... .......... 48% 55.7M 0s
   500K .......... .......... .......... .......... .......... 52% 61.9M 0s
   550K .......... .......... .......... .......... .......... 57% 54.4M 0s
   600K .......... .......... .......... .......... .......... 62% 56.3M 0s
   650K .......... .......... .......... .......... .......... 67% 58.8M 0s
   700K .......... .......... .......... .......... .......... 72% 61.6M 0s
   750K .......... .......... .......... .......... .......... 76% 53.5M 0s
   800K .......... .......... .......... .......... .......... 81% 44.3M 0s
   850K .......... .......... .......... .......... .......... 86% 54.4M 0s
   900K .......... .......... .......... .......... .......... 91% 63.9M 0s
   950K .......... .......... .......... .......... .......... 96% 75.0M 0s
  1000K .......... .......... .......... .........            100% 89.8M=3D=
0.02s

2009-11-08 21:15:27 (54.1 MB/s) - `Conception Manual.docx' saved [1064912/1=
064912]

--2009-11-08 21:15:27--  http://www-verimag.imag.fr/~moy/tmp/git-bug/Extrem=
e%20Programming.doc
Resolving www-verimag.imag.fr... 129.88.43.46
Connecting to www-verimag.imag.fr|129.88.43.46|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 521216 (509K) [application/msword]
Saving to: `Extreme Programming.doc'

     0K .......... .......... .......... .......... ..........  9% 42.7M 0s
    50K .......... .......... .......... .......... .......... 19% 38.3M 0s
   100K .......... .......... .......... .......... .......... 29% 51.4M 0s
   150K .......... .......... .......... .......... .......... 39% 48.9M 0s
   200K .......... .......... .......... .......... .......... 49% 51.9M 0s
   250K .......... .......... .......... .......... .......... 58% 57.0M 0s
   300K .......... .......... .......... .......... .......... 68% 54.6M 0s
   350K .......... .......... .......... .......... .......... 78% 56.1M 0s
   400K .......... .......... .......... .......... .......... 88% 52.5M 0s
   450K .......... .......... .......... .......... .......... 98% 75.4M 0s
   500K .........                                             100% 17.6M=3D=
0.01s

2009-11-08 21:15:27 (52.3 MB/s) - `Extreme Programming.doc' saved [521216/5=
21216]

[master c0fa75f] bug
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 Conception Manual.docx
 create mode 100644 Extreme Programming.doc
Counting objects: 5, done.
Delta compression using up to 16 threads.
Compressing objects:  25% (1/4)   =0DCompressing objects:  50% (2/4)   =0DC=
ompressing objects:  75% (3/4)   =0DCompressing objects: 100% (4/4)   =0DCo=
mpressing objects: 100% (4/4), done.
Writing objects:  25% (1/4)   =0DWriting objects:  50% (2/4)   =0DWriting o=
bjects:  75% (3/4)   =0DWriting objects: 100% (4/4)   =0DWriting objects: 1=
00% (4/4), 1.38 MiB, done.
Total 4 (delta 0), reused 0 (delta 0)
fatal: early EOF
error: unpack failed: unpack-objects abnormal exit
To ssh://localhost//home/perms/moy/prive/dest
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to 'ssh://localhost//home/perms/moy/prive/d=
est'

--=-=-=


--
Matthieu Moy
http://www-verimag.imag.fr/~moy/

--=-=-=--
