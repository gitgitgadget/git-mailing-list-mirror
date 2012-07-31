From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: rename detection
Date: Tue, 31 Jul 2012 10:39:43 +0200
Message-ID: <501799CF.1080100@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 10:50:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw8AE-0006CM-LW
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 10:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab2GaIuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 04:50:46 -0400
Received: from mail.ch.keymile.com ([193.17.201.103]:30615 "HELO
	mail.ch.keymile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755849Ab2GaIup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 04:50:45 -0400
X-Greylist: delayed 658 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2012 04:50:44 EDT
Received: from SRVCHBER1212.ch.keymile.net ([172.31.32.9]) by eSafe SMTP Relay 1342657264; Tue, 31 Jul 2012 10:39:43 +0200
Received: from chber1-10555x.ch.keymile.net ([172.31.40.82]) by SRVCHBER1212.ch.keymile.net with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 31 Jul 2012 10:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.6esrpre) Gecko/20120717 Thunderbird/10.0.6
X-OriginalArrivalTime: 31 Jul 2012 08:39:43.0449 (UTC) FILETIME=[08573490:01CD6EF8]
X-ESAFE-STATUS: [srvchber1306.keymile.net] Mail allowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202638>

Hi everyone,

I have some questions about rename detection.
The way I understand it, renames are not tracked in any way by GIT, at 
least not in the repository. Instead some detection algorithm is 
executed when data is extracted from the repository, prior to being 
presented to the user (i.e., git format-patch, git log, git show 
etc...), therefore depending on the command line and client used.

Some of those mechanisms are also in place when stuff gets commited. For 
instance, I get some rename indications when editing the commit message, 
and as the output of git commit itself.
I would assume the mechanisms would be exactly the same.

Things get a bit more complicated when you actually "merge" files (not 
in the git-tish sense, I mean physically move the content of one file 
into the other). Here is a test which includes a bigger file within a 
smaller file.

=================== SCRIPT BEGIN ========================
git --version
git init
hexdump -C -n 5120 /dev/urandom > file2
hexdump -C -n 2560 /dev/urandom > file1
echo "--------------------------"
git add file1 file2
git commit -m "first commit"
git log --summary -M10% -C -1
echo "--------------------------"
(head -n 40 file1; cat file2; tail -n+40 file1) > file3
git rm file1 file2
git add file3
git commit -m "including file2 within file1 as file3"
git log --summary -M10% -C -1
echo "--------------------------"
git mv file3 file1
git commit --amend -m "including file2 within file1 as file1"
git log --summary -M10% -C -1
echo "--------------------------"
git mv file1 file2
git commit --amend -m "including file2 within file1 as file2"
git log --summary -M10% -C -1
echo "--------------------------"

=================== SCRIPT END ========================

=================== OUTPUT BEGIN ========================
git version 1.7.10.4
Initialized empty Git repository in /home/chfalag1/tmp/gittest/.git/
--------------------------
[master (root-commit) 6d997f5] first commit
  2 files changed, 482 insertions(+)
  create mode 100644 file1
  create mode 100644 file2
commit 6d997f5bbed2e9452317991ca024a5a0e1715027
Author: Gerlando Falauto <gerlando.falauto@keymile.com>
Date:   Tue Jul 31 10:27:42 2012 +0200

     first commit

  create mode 100644 file1
  create mode 100644 file2
--------------------------
rm 'file1'
rm 'file2'
[master 424edab] including file2 within file1 as file3
  2 files changed, 162 insertions(+), 161 deletions(-)
  delete mode 100644 file1
  rename file2 => file3 (66%)
commit 424edab771495fc3a1b4c172b9fcef9418501266
Author: Gerlando Falauto <gerlando.falauto@keymile.com>
Date:   Tue Jul 31 10:27:42 2012 +0200

     including file2 within file1 as file3

  delete mode 100644 file1
  rename file2 => file3 (66%)
--------------------------
[master ca70367] including file2 within file1 as file1
  1 file changed, 162 insertions(+)
  rename file2 => file1 (66%)
commit ca7036705063adbbd3c8cd0b5bccd5fbf44075bf
Author: Gerlando Falauto <gerlando.falauto@keymile.com>
Date:   Tue Jul 31 10:27:42 2012 +0200

     including file2 within file1 as file1

  delete mode 100644 file2
--------------------------
[master d7fdea4] including file2 within file1 as file2
  2 files changed, 162 insertions(+), 161 deletions(-)
  delete mode 100644 file1
commit d7fdea4855efe8401562a53ec7093c80390ee274
Author: Gerlando Falauto <gerlando.falauto@keymile.com>
Date:   Tue Jul 31 10:27:42 2012 +0200

     including file2 within file1 as file2

  delete mode 100644 file1
--------------------------
=================== OUTPUT END ========================

So including file2 (bigger) within file1 (smaller):
a) gets always (commit+extraction) detected as a rename file2=>file1 if 
the merged file is file3 (new file).
b) gets detected as a rename ONLY during commit (but not while 
extracting) if the merged file is file1 (existing file)
c) doesn't ever get detected as a rename if the merged file is file2 
(which makes sense, being file2 more similar to itself than to file1)

So now my two questions:

1) Is the behavior in b) correct? Shouldn't it at least be made consistent?

2) Would it make any sense to track (or detect) such "inclusion" cases? 
Is there any recommended or standard practice for performing such 
operations as file merge/split (i.e. when refactoring code or something)?

Thanks!
Gerlando
