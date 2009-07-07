From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Too many 'stat' calls by git-status on Windows
Date: Tue, 7 Jul 2009 04:05:01 +0400
Message-ID: <20090707000500.GA5594@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 02:06:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNyD1-0005sX-Sf
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 02:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbZGGAFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 20:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756011AbZGGAFb
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 20:05:31 -0400
Received: from ey-out-1920.google.com ([74.125.78.145]:33417 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459AbZGGAF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 20:05:29 -0400
Received: by ey-out-1920.google.com with SMTP id 3so942153eyh.36
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 17:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=MtU7nh3pvRQ1IBpaO8/F2UnVru8NY5+CP2S8beQSEkQ=;
        b=gs5Ws36IJn9zbystpVyV0/d+xiRDclM6o5N6h3PwJ0+jbXb59p+Qk+ZST5darI6jOE
         pPlz3iy6xphiI/1SpKlTx0C6l7Dy55d+dEARwVx3SrMa2ts3tT1x4M7z5tAzCdOEtlqQ
         ldMZ6R1I+KFCLAKPhpQKyfX2oKlvVKxwtWXN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=MxqVY5Sz7DAsBxilZJ1K/k/Zmui3FODIAj09uE1FZCP399EgeWJ5wuiRG7M5F43CDy
         ild8/2m3hoRDDWXx7ePh9uNPrbYKUJZwosR0Vkm1NjMZSMQSVb1Qp6XwHJ7KC8z16lgt
         PnA+sOIUWt5x0mmMwE//yeF8ztbtyGJIahnKI=
Received: by 10.210.52.15 with SMTP id z15mr4524649ebz.99.1246925131988;
        Mon, 06 Jul 2009 17:05:31 -0700 (PDT)
Received: from localhost (ppp91-77-224-188.pppoe.mtu-net.ru [91.77.224.188])
        by mx.google.com with ESMTPS id 10sm1363078eyz.41.2009.07.06.17.05.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Jul 2009 17:05:31 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122813>

I have used the Cygwin version of Git on one Windows computer and
noticed that git-status is sluggish. So, I have run the Process Monitor
to see what is going on.

The below, you can see the result of testing on Windows and Linux on the
same repository using the same version of Git. It is rather easy to
compare if you notice that the following match between syscalls:

Windows         Linux

QueryOpen       lstat or fstat
CreateFile      open
CloseFile       close
QueryDirectory  getdents

I have also tested git-diff to verify that the number of system calls
matches pretty well. (In fact, I got practical identical list for stat
syscalls for files inside of the working directory on Windows and Linux
when ran git-diff.) But something strange is going on with git-status.
The beginning of the log is identical on Windows and Linux, but then I
see more 'stat's in the Windows log that did not happen on Linux.  In
total, I see about 3 times increase of 'stat' calls, with all files
being stat twice and directories (which are numerous) being stat 3 and
more times (some of them as many 39 times...) It seems that every
directory is stat as many times as the number of subdirectories it has
plus 3.

It appears that the second 'stat' for files on Windows caused by lack
of d_type in dirent. When I recompiled the Linux version with
NO_D_TYPE_IN_DIRENT = YesPlease, I got the same result for files.
(Still I am not sure what caused those extra stat calls for
directory, maybe, it is Cygwin specific...)

The question is whether it is possible to avoid this redundant 'stat'
for files on system that do not have d_type in dirent or that would
require too much modification? Is it possible to use the cache where
d_stat is not available provided that the entry is marked as uptodate?


==== Git on Windows (CYGWIN) =====

$ wc -l git-diff.csv  git-status.csv
   5186 git-diff.csv
  21694 git-status.csv

$ csvtool col 5 git-diff.csv | sort | uniq -c | sort -nr | head -10
   4656 QueryOpen
    100 CreateFile
     94 CloseFile
     80 QuerySecurityFile
     61 ReadFile
     30 QueryInformationVolume
     28 QueryAllInformationFile
     26 RegOpenKey
     24 RegCloseKey
     20 QueryStandardInformationFile

$ csvtool col 5 git-status.csv | sort | uniq -c | sort -nr | head -10
  12984 QueryOpen
   3086 CreateFile
   2103 CloseFile
   1984 QueryDirectory
    988 QueryFileInternalInformationFile
    132 QuerySecurityFile
    100 ReadFile
     77 WriteFile
     55 QueryInformationVolume
     53 QueryAllInformationFile

Successful open:
$ csvtool col 5,7,8 git-diff.csv | grep CreateFile,SUCCESS, | wc -l
94
$ csvtool col 5,7,8 git-status.csv | grep CreateFile,SUCCESS, | wc -l
2103

Successful open for directories:
$ csvtool col 5,7,8 git-diff.csv | grep CreateFile,SUCCESS,.*Options:.*Directory | wc -l
37
$ csvtool col 5,7,8 git-status.csv | grep CreateFile,SUCCESS,.*Options:.*Directory | wc -l
1024

Not successful attempts to open
$ csvtool col 5,7,8 git-diff.csv | grep CreateFile | grep -v ,SUCCESS, | wc -l
6
$ csvtool col 5,7,8 git-status.csv | grep CreateFile | grep -v ,SUCCESS, | wc -l
983

Attempts to open .gitignore
$ csvtool col 5,6 git-diff.csv | grep 'CreateFile,.*\\\.gitignore' | wc -l
0
$ csvtool col 5,6 git-status.csv | grep 'CreateFile,.*\\\.gitignore' | wc -l
986

=== GIT on Linux ===

$ wc -l linux-git-*
   4674 linux-git-diff.log
   9807 linux-git-status.log

$ sed -e 's/(.*//' < linux-git-diff.log  | sort | uniq -c | sort -rn | head -10
   4237 lstat
     88 mmap
     56 open
     50 close
     50 access
     48 fstat
     45 mprotect
     43 read
     15 stat
     13 munmap

The number of lstat+fstat is equal 4285 for git-diff

$ sed -e 's/(.*//' < linux-git-status.log  | sort | uniq -c | sort -rn | head -10
   3279 lstat
   2048 open
   1976 getdents
   1062 close
   1058 fstat
     97 mmap
     67 read
     48 access
     45 mprotect
     40 write

The number of lstat+fstat is equal 4337 for git-status.

Successful open:
$ grep -c '^open(.*= [^-]' linux-*
linux-git-diff.log:50
linux-git-status.log:1064

Successful open for directories:
$ grep -c '^open(.*O_DIRECTORY.*= [^-]' linux-*
linux-git-diff.log:1
linux-git-status.log:989

Not successful attempts to open:
$ grep -c '^open(.*= -1' linux-*
linux-git-diff.log:6
linux-git-status.log:984

Attempts to open .gitignore:
$ grep -c '^open(.*.\.gitignore"' linux-*
linux-git-diff.log:0
linux-git-status.log:987

=== Linux with NO_D_TYPE_IN_DIRENT = YesPlease ===

$ wc -l linux-git-*no-dtype.log
   4674 linux-git-diff-no-dtype.log
  14040 linux-git-status-no-dtype.log

$ sed -e 's/(.*//' < linux-git-diff-no-dtype.log  | sort | uniq -c | sort -rn | head -10

   4237 lstat
     88 mmap
     56 open
     50 close
     50 access
     48 fstat
     45 mprotect
     43 read
     15 stat
     13 munmap

The number of lstat+fstat is equal 4285 for git-diff

$ sed -e 's/(.*//' < linux-git-status-no-dtype.log  | sort | uniq -c | sort -rn | head -10

   7512 lstat
   2048 open
   1976 getdents
   1062 close
   1058 fstat
     97 mmap
     67 read
     48 access
     45 mprotect
     40 write

The number of lstat+fstat is equal 8570 for git-status.

Successful open:
$ grep -c '^open(.*= [^-]' linux-*-no-dtype.log
linux-git-diff-no-dtype.log:50
linux-git-status-no-dtype.log:1064

Successful open for directories:
$ grep -c '^open(.*O_DIRECTORY.*= [^-]' linux-*-no-dtype.log
linux-git-diff-no-dtype.log:1
linux-git-status-no-dtype.log:989

Not successful attempts to open:
$ grep -c '^open(.*= -1' linux-*-no-dtype.log
linux-git-diff-no-dtype.log:6
linux-git-status-no-dtype.log:984

Attempts to open .gitignore:
$ grep -c '^open(.*.\.gitignore"' linux-*-no-dtype.log
linux-git-diff-no-dtype.log:0
linux-git-status-no-dtype.log:987

=======

Dmitry
