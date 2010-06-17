From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Subject: [BUG] git clean not working on FreeBSD/NFS
Date: Thu, 17 Jun 2010 17:26:43 +0300
Message-ID: <4C1A30A3.9080708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 16:27:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPG3Z-00082O-IG
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 16:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760157Ab0FQO0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 10:26:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59495 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136Ab0FQO0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 10:26:49 -0400
Received: by fxm10 with SMTP id 10so1643103fxm.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:openpgp
         :content-type:content-transfer-encoding;
        bh=J0bnGsY5FLkCdEpdAx8MtwZ3EWze9KUtPZQwloyKFCQ=;
        b=kNgFusohYPX4QBVOC3ErKg92s5DJSXV+xcCdko6MCnb6bpM34CCQcfP+zW3VsR0ftI
         x6KP/apXrj7x1vMcoYQsEK+Yc2YlUS0EbD4NZb96RhtVdan6FNOlp8mIX4rZaZKlU3RH
         Gj/Xf3XQ47l9EjMq3PJ27wgukYWqdhAwzVkWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=HYYM0WVHKFWBx1k8kZhkve1Kc8sNhP1W0rGNL1wPbyce/wIqYfh9srTQkGAUYukJ2x
         wld8BiqwFBFZc/VwDvcvBW0nkmCmBQP4nVqfUx8eSo2tj9JnUp3E5te0qXRusKfpa/De
         SWw1g4WTwoSbQdb91O0V/HG3i3igB+k2fAx68=
Received: by 10.223.92.152 with SMTP id r24mr10860312fam.74.1276784807272;
        Thu, 17 Jun 2010 07:26:47 -0700 (PDT)
Received: from debian ([79.114.80.106])
        by mx.google.com with ESMTPS id k14sm14955834fav.24.2010.06.17.07.26.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jun 2010 07:26:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by debian (Postfix) with ESMTP id 70E2657B05
	for <git@vger.kernel.org>; Thu, 17 Jun 2010 17:26:43 +0300 (EEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100515 Icedove/3.0.4
X-Enigmail-Version: 1.0.1
OpenPGP: id=5379965D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149310>

Hi,

I am running git 1.7.1 on a FreeBSD 8 box which has its home dir mounted
via NFS (I guess the NFS server is a Linux box).
When running 'git clean -x -f -d' it fails to remove some directories:
warning: failed to remove 'libclamav/.deps/'
warning: failed to remove 'libclamav/.libs/'
warning: failed to remove 'libclamav/c++/.deps/'
warning: failed to remove 'libclamav/c++/.libs/'
warning: failed to remove 'libclamav/c++/llvm/test/CodeGen/X86/Output/'

This causes buildbot managed builds to fail every 2nd time.

Steps to reproduce:
1. FreeBSD 8 with home mounted via NFS (NFS server probably Linux)
2. Checkout ClamAV, and ./configure it (some other autotooled program
would work too probably)
3. ./config.status
4. git clean -x -f -d -- libclamav
5. ls -l libclamav/.deps

Step 4. fails, step 5 shows remaining files.
You can repeat steps 3 and 4 to see the failure over and over again.
If instead of the 'git clean' you run 'rm -rf' that works!

Looking at the truss output I see that the error is that the directory
is not empty (see end of this mail for detailed truss output):
rmdir(0x8011e3080,0x5ff560,0x10,0x2000,0x626298,0x0) ERR#66 'Directory
not empty

Which is indeed true, if I run 'ls' on those directories they still have
some files in them: git made no attempt to stat/unlink them (it must
have missed them during directory listing?).
Here are the remaining files:
$ ls libclamav/.deps
libclamav_la-textnorm.Plo       libclamav_la-upx.Plo            unrar20.Plo
libclamav_la-tnef.Plo           libclamav_la-uuencode.Plo
unrar_iface.Plo
libclamav_la-unarj.Plo          libclamav_la-vba_extract.Plo    unrarcmd.Plo
libclamav_la-uniq.Plo           libclamav_la-version.Plo
unrarfilter.Plo
libclamav_la-unsp.Plo           libclamav_la-wwunpack.Plo       unrarhlp.Plo
libclamav_la-untar.Plo          libclamav_la-yc.Plo             unrarppm.Plo
libclamav_la-unzip.Plo          unrar.Plo                       unrarvm.Plo
libclamav_la-upack.Plo          unrar15.Plo

There is a second box attached to same NFS server, a Linux 2.6.26.
I can't reproduce this bug on that box, so I assume this a FreeBSD / or
FreeBSD + NFS specific bug.

However this bug reproduces almost always on the FreeBSD box (2 out of 3
tries approximatively).

uname -mrsp: FreeBSD 8.0-RELEASE amd64 amd64

gcc:
Using built-in specs.
Target: amd64-undermydesk-freebsd
Configured with: FreeBSD/amd64 system compiler
Thread model: posix
gcc version 4.2.1 20070719  [FreeBSD]

git --version: git version 1.7.1

There isn't anything relevant in dmesg on the NFS client, and I don't
have access to the NFS server.

FWIW running "rm -rf" DOES work!

Relevant part of 'truss git clean -x -f -d -- libclamav':
lstat("libclamav/c++/.deps",{ mode=drwx------
,inode=3222465128,size=20480,blksize=4096 }) = 0 (0x0)
getdirentries(0x5,0x8011e8000,0x1000,0x8011e5128,0xffff80080111e094,0x0)
= 0 (0x0)
lseek(5,0x0,SEEK_SET)				 = 0 (0x0)
close(5)					 = 0 (0x0)
lstat("libclamav/cab.c",{ mode=-rw-------
,inode=3535781250,size=18996,blksize=4096 }) = 0 (0x0)
lstat("libclamav/cab.h",{ mode=-rw-------
,inode=3535781252,size=1933,blksize=4096 }) = 0 (0x0)
lstat("libclamav/cache.c",{ mode=-rw-------
,inode=3535781253,size=19730,blksize=4096 }) = 0 (0x0)
lstat("libclamav/cache.h",{ mode=-rw-------
,inode=3535781283,size=1053,blksize=4096 }) = 0 (0x0)
lstat("libclamav/chmunpack.c",{ mode=-rw-------
,inode=3535781284,size=22473,blksize=4096 }) = 0 (0x0)
lstat("libclamav/chmunpack.h",{ mode=-rw-------
,inode=3535781285,size=3364,blksize=4096 }) = 0 (0x0)
lstat("libclamav/clamav.h",{ mode=-rw-------
,inode=3535781286,size=7166,blksize=4096 }) = 0 (0x0)
lstat("libclamav/clambc.h",{ mode=-rw-------
,inode=3535781287,size=2738,blksize=4096 }) = 0 (0x0)
lstat("libclamav/cltypes.h",{ mode=-rw-------
,inode=3535781288,size=1840,blksize=4096 }) = 0 (0x0)
lstat("libclamav/cpio.c",{ mode=-rw-------
,inode=3535781289,size=7978,blksize=4096 }) = 0 (0x0)
lstat("libclamav/cpio.h",{ mode=-rw-------
,inode=3535781290,size=971,blksize=4096 }) = 0 (0x0)
lstat("libclamav/cvd.c",{ mode=-rw-------
,inode=3535781291,size=16233,blksize=4096 }) = 0 (0x0)
lstat("libclamav/cvd.h",{ mode=-rw-------
,inode=3535781292,size=1246,blksize=4096 }) = 0 (0x0)
lstat("libclamav/dconf.c",{ mode=-rw-------
,inode=3535781293,size=11601,blksize=4096 }) = 0 (0x0)
lstat("libclamav/dconf.h",{ mode=-rw-------
,inode=3535781294,size=3481,blksize=4096 }) = 0 (0x0)
lstat("libclamav/default.h",{ mode=-rw-------
,inode=3535781295,size=1308,blksize=4096 }) = 0 (0x0)
lstat("libclamav/disasm-common.h",{ mode=-rw-------
,inode=3535781296,size=14271,blksize=4096 }) = 0 (0x0)
lstat("libclamav/disasm.c",{ mode=-rw-------
,inode=3535781297,size=78128,blksize=4096 }) = 0 (0x0)
lstat("libclamav/disasm.h",{ mode=-rw-------
,inode=3535781298,size=1014,blksize=4096 }) = 0 (0x0)
lstat("libclamav/disasmpriv.h",{ mode=-rw-------
,inode=3535781299,size=1678,blksize=4096 }) = 0 (0x0)
lstat("libclamav/dlp.c",{ mode=-rw-------
,inode=3535781300,size=13646,blksize=4096 }) = 0 (0x0)
lstat("libclamav/dlp.h",{ mode=-rw-------
,inode=3535781301,size=4678,blksize=4096 }) = 0 (0x0)
lstat("libclamav/dsig.c",{ mode=-rw-------
,inode=3535781302,size=5612,blksize=4096 }) = 0 (0x0)
lstat("libclamav/dsig.h",{ mode=-rw-------
,inode=3535781303,size=1004,blksize=4096 }) = 0 (0x0)
lstat("libclamav/elf.c",{ mode=-rw-------
,inode=3535781304,size=20341,blksize=4096 }) = 0 (0x0)
lstat("libclamav/elf.h",{ mode=-rw-------
,inode=3535781305,size=2645,blksize=4096 }) = 0 (0x0)
lstat("libclamav/encoding_aliases.h",{ mode=-rw-------
,inode=3535781306,size=2010,blksize=4096 }) = 0 (0x0)
lstat("libclamav/entconv.c",{ mode=-rw-------
,inode=3535781307,size=20631,blksize=4096 }) = 0 (0x0)
lstat("libclamav/entconv.h",{ mode=-rw-------
,inode=3535781308,size=1923,blksize=4096 }) = 0 (0x0)
lstat("libclamav/entitylist.h",{ mode=-rw-------
,inode=3535781309,size=32878,blksize=4096 }) = 0 (0x0)
lstat("libclamav/execs.h",{ mode=-rw-------
,inode=3535781310,size=1888,blksize=4096 }) = 0 (0x0)
lstat("libclamav/explode.c",{ mode=-rw-------
,inode=3535781311,size=7778,blksize=4096 }) = 0 (0x0)
lstat("libclamav/explode.h",{ mode=-rw-------
,inode=3533647648,size=1684,blksize=4096 }) = 0 (0x0)
lstat("libclamav/filetypes.c",{ mode=-rw-------
,inode=3533647649,size=8010,blksize=4096 }) = 0 (0x0)
lstat("libclamav/filetypes.h",{ mode=-rw-------
,inode=3533647650,size=2933,blksize=4096 }) = 0 (0x0)
lstat("libclamav/filetypes_int.h",{ mode=-rw-------
,inode=3533647651,size=8669,blksize=4096 }) = 0 (0x0)
lstat("libclamav/filtering.c",{ mode=-rw-------
,inode=3533647652,size=23994,blksize=4096 }) = 0 (0x0)
lstat("libclamav/filtering.h",{ mode=-rw-------
,inode=3533647653,size=1441,blksize=4096 }) = 0 (0x0)
lstat("libclamav/fmap.c",{ mode=-rw-------
,inode=3533647654,size=18843,blksize=4096 }) = 0 (0x0)
lstat("libclamav/fmap.h",{ mode=-rw-------
,inode=3533647655,size=1978,blksize=4096 }) = 0 (0x0)
lstat("libclamav/fsg.c",{ mode=-rw-------
,inode=3533647656,size=3455,blksize=4096 }) = 0 (0x0)
lstat("libclamav/fsg.h",{ mode=-rw-------
,inode=3533647657,size=1009,blksize=4096 }) = 0 (0x0)
lstat("libclamav/hashtab.c",{ mode=-rw-------
,inode=3533647658,size=20657,blksize=4096 }) = 0 (0x0)
lstat("libclamav/hashtab.h",{ mode=-rw-------
,inode=3533647659,size=4535,blksize=4096 }) = 0 (0x0)
lstat("libclamav/htmlnorm.c",{ mode=-rw-------
,inode=3533647660,size=53427,blksize=4096 }) = 0 (0x0)
lstat("libclamav/htmlnorm.h",{ mode=-rw-------
,inode=3533647661,size=1513,blksize=4096 }) = 0 (0x0)
lstat("libclamav/iana_cctld.h",{ mode=-rw-------
,inode=3533647662,size=11288,blksize=4096 }) = 0 (0x0)
lstat("libclamav/iana_tld.h",{ mode=-rw-------
,inode=3533647663,size=17214,blksize=4096 }) = 0 (0x0)
lstat("libclamav/inffixed64.h",{ mode=-rw-------
,inode=3533647664,size=8089,blksize=4096 }) = 0 (0x0)
lstat("libclamav/inflate64.c",{ mode=-rw-------
,inode=3533647665,size=42823,blksize=4096 }) = 0 (0x0)
lstat("libclamav/inflate64.h",{ mode=-rw-------
,inode=3533647666,size=3083,blksize=4096 }) = 0 (0x0)
lstat("libclamav/inflate64_priv.h",{ mode=-rw-------
,inode=3533647667,size=8156,blksize=4096 }) = 0 (0x0)
lstat("libclamav/is_tar.c",{ mode=-rw-------
,inode=3533647668,size=2212,blksize=4096 }) = 0 (0x0)
lstat("libclamav/is_tar.h",{ mode=-rw-------
,inode=3533647669,size=1102,blksize=4096 }) = 0 (0x0)
lstat("libclamav/ishield.c",{ mode=-rw-------
,inode=3533647670,size=23291,blksize=4096 }) = 0 (0x0)
lstat("libclamav/ishield.h",{ mode=-rw-------
,inode=3533647671,size=934,blksize=4096 }) = 0 (0x0)
lstat("libclamav/jsparse",{ mode=drwx------
,inode=671908298,size=4096,blksize=4096 }) = 0 (0x0)
stat("libclamav/jsparse/",{ mode=drwx------
,inode=671908298,size=4096,blksize=4096 }) = 0 (0x0)
open("libclamav/jsparse/",O_NONBLOCK,022)	 = 5 (0x5)
fstat(5,{ mode=drwx------ ,inode=671908298,size=4096,blksize=4096 }) = 0
(0x0)
fcntl(5,F_SETFD,FD_CLOEXEC)			 = 0 (0x0)
fstatfs(0x5,0x7fffffffcdd0,0x8011e5040,0x2,0x0,0x0) = 0 (0x0)
getdirentries(0x5,0x8011e8000,0x1000,0x8011e5128,0xfffffffffffffb90,0x0)
= 512 (0x200)
lstat("libclamav/jsparse/future_reserved_words.list",{ mode=-rw-------
,inode=671908299,size=227,blksize=4096 }) = 0 (0x0)
lstat("libclamav/jsparse/generated",{ mode=drwx------
,inode=805472893,size=41,blksize=4096 }) = 0 (0x0)
stat("libclamav/jsparse/generated/",{ mode=drwx------
,inode=805472893,size=41,blksize=4096 }) = 0 (0x0)
open("libclamav/jsparse/generated/",O_NONBLOCK,034) = 6 (0x6)
fstat(6,{ mode=drwx------ ,inode=805472893,size=41,blksize=4096 }) = 0 (0x0)
fcntl(6,F_SETFD,FD_CLOEXEC)			 = 0 (0x0)
fstatfs(0x6,0x7fffffffc960,0x8011e5040,0x3,0x0,0x0) = 0 (0x0)
getdirentries(0x6,0x8011e9000,0x1000,0x8011e5188,0xfffffffffffffb90,0x0)
= 512 (0x200)
lstat("libclamav/jsparse/generated/keywords.h",{ mode=-rw-------
,inode=805472894,size=7530,blksize=4096 }) = 0 (0x0)
lstat("libclamav/jsparse/generated/operators.h",{ mode=-rw-------
,inode=805472895,size=7473,blksize=4096 }) = 0 (0x0)
getdirentries(0x6,0x8011e9000,0x1000,0x8011e5188,0x27,0x27) = 0 (0x0)
lseek(6,0x0,SEEK_SET)				 = 0 (0x0)
close(6)					 = 0 (0x0)
lstat("libclamav/jsparse/js-norm.c",{ mode=-rw-------
,inode=671908300,size=42262,blksize=4096 }) = 0 (0x0)
lstat("libclamav/jsparse/js-norm.h",{ mode=-rw-------
,inode=671908301,size=1194,blksize=4096 }) = 0 (0x0)
lstat("libclamav/jsparse/keywords.list",{ mode=-rw-------
,inode=671908302,size=147,blksize=4096 }) = 0 (0x0)
lstat("libclamav/jsparse/lexglobal.h",{ mode=-rw-------
,inode=671908303,size=3087,blksize=4096 }) = 0 (0x0)
lstat("libclamav/jsparse/operators.gperf",{ mode=-rw-------
,inode=671908304,size=931,blksize=4096 }) = 0 (0x0)
lstat("libclamav/jsparse/special_keywords.list",{ mode=-rw-------
,inode=671908305,size=47,blksize=4096 }) = 0 (0x0)
lstat("libclamav/jsparse/textbuf.h",{ mode=-rw-------
,inode=671908306,size=1045,blksize=4096 }) = 0 (0x0)
getdirentries(0x5,0x8011e8000,0x1000,0x8011e5128,0x1b,0x1b) = 0 (0x0)
lseek(5,0x0,SEEK_SET)				 = 0 (0x0)
close(5)					 = 0 (0x0)
lstat("libclamav/libclamav.map",{ mode=-rw-------
,inode=3533647672,size=3455,blksize=4096 }) = 0 (0x0)
lstat("libclamav/line.c",{ mode=-rw-------
,inode=3533647673,size=2715,blksize=4096 }) = 0 (0x0)
lstat("libclamav/line.h",{ mode=-rw-------
,inode=3533647674,size=1484,blksize=4096 }) = 0 (0x0)
lstat("libclamav/lzma_iface.c",{ mode=-rw-------
,inode=3533647675,size=3180,blksize=4096 }) = 0 (0x0)
lstat("libclamav/lzma_iface.h",{ mode=-rw-------
,inode=3533647676,size=1679,blksize=4096 }) = 0 (0x0)
lstat("libclamav/macho.c",{ mode=-rw-------
,inode=3533647677,size=14817,blksize=4096 }) = 0 (0x0)
lstat("libclamav/macho.h",{ mode=-rw-------
,inode=3533647678,size=1037,blksize=4096 }) = 0 (0x0)
lstat("libclamav/matcher-ac.c",{ mode=-rw-------
,inode=3533647679,size=48723,blksize=4096 }) = 0 (0x0)
lstat("libclamav/matcher-ac.h",{ mode=-rw-------
,inode=3533647680,size=3570,blksize=4096 }) = 0 (0x0)
lstat("libclamav/matcher-bm.c",{ mode=-rw-------
,inode=3533647681,size=11727,blksize=4096 }) = 0 (0x0)
lstat("libclamav/matcher-bm.h",{ mode=-rw-------
,inode=3533647682,size=1787,blksize=4096 }) = 0 (0x0)
lstat("libclamav/matcher.c",{ mode=-rw-------
,inode=3533647683,size=19988,blksize=4096 }) = 0 (0x0)
lstat("libclamav/matcher.h",{ mode=-rw-------
,inode=3533647684,size=5610,blksize=4096 }) = 0 (0x0)
lstat("libclamav/mbox.c",{ mode=-rw-------
,inode=3533647685,size=93154,blksize=4096 }) = 0 (0x0)
lstat("libclamav/mbox.h",{ mode=-rw-------
,inode=3533647686,size=1481,blksize=4096 }) = 0 (0x0)
lstat("libclamav/md5.c",{ mode=-rw-------
,inode=3533647687,size=7560,blksize=4096 }) = 0 (0x0)
lstat("libclamav/md5.h",{ mode=-rw-------
,inode=3533647688,size=766,blksize=4096 }) = 0 (0x0)
lstat("libclamav/message.c",{ mode=-rw-------
,inode=3533647689,size=58761,blksize=4096 }) = 0 (0x0)
lstat("libclamav/message.h",{ mode=-rw-------
,inode=3533647690,size=3440,blksize=4096 }) = 0 (0x0)
lstat("libclamav/mew.c",{ mode=-rw-------
,inode=3533647691,size=22062,blksize=4096 }) = 0 (0x0)
lstat("libclamav/mew.h",{ mode=-rw-------
,inode=3533647692,size=1356,blksize=4096 }) = 0 (0x0)
lstat("libclamav/mpool.c",{ mode=-rw-------
,inode=3533647693,size=19987,blksize=4096 }) = 0 (0x0)
lstat("libclamav/mpool.h",{ mode=-rw-------
,inode=3533647694,size=2181,blksize=4096 }) = 0 (0x0)
lstat("libclamav/msexpand.c",{ mode=-rw-------
,inode=3533647695,size=3379,blksize=4096 }) = 0 (0x0)
lstat("libclamav/msexpand.h",{ mode=-rw-------
,inode=3533647696,size=872,blksize=4096 }) = 0 (0x0)
lstat("libclamav/mspack.c",{ mode=-rw-------
,inode=3533647697,size=70371,blksize=4096 }) = 0 (0x0)
lstat("libclamav/mspack.h",{ mode=-rw-------
,inode=3533647698,size=11179,blksize=4096 }) = 0 (0x0)
lstat("libclamav/nsis",{ mode=drwx------
,inode=945711766,size=4096,blksize=4096 }) = 0 (0x0)
stat("libclamav/nsis/",{ mode=drwx------
,inode=945711766,size=4096,blksize=4096 }) = 0 (0x0)
open("libclamav/nsis/",O_NONBLOCK,017)		 = 5 (0x5)
fstat(5,{ mode=drwx------ ,inode=945711766,size=4096,blksize=4096 }) = 0
(0x0)
fcntl(5,F_SETFD,FD_CLOEXEC)			 = 0 (0x0)
fstatfs(0x5,0x7fffffffcdd0,0x8011e5040,0x2,0x0,0x0) = 0 (0x0)
getdirentries(0x5,0x8011e8000,0x1000,0x8011e5128,0xfffffffffffffb90,0x0)
= 512 (0x200)
lstat("libclamav/nsis/bzlib.c",{ mode=-rw-------
,inode=947061420,size=38398,blksize=4096 }) = 0 (0x0)
lstat("libclamav/nsis/bzlib_private.h",{ mode=-rw-------
,inode=947061421,size=12997,blksize=4096 }) = 0 (0x0)
lstat("libclamav/nsis/infblock.c",{ mode=-rw-------
,inode=947061422,size=22142,blksize=4096 }) = 0 (0x0)
lstat("libclamav/nsis/nsis_bzlib.h",{ mode=-rw-------
,inode=947061423,size=5987,blksize=4096 }) = 0 (0x0)
lstat("libclamav/nsis/nsis_zconf.h",{ mode=-rw-------
,inode=947061424,size=74,blksize=4096 }) = 0 (0x0)
lstat("libclamav/nsis/nsis_zlib.h",{ mode=-rw-------
,inode=947061425,size=7753,blksize=4096 }) = 0 (0x0)
lstat("libclamav/nsis/nsis_zutil.h",{ mode=-rw-------
,inode=947061426,size=1864,blksize=4096 }) = 0 (0x0)
lstat("libclamav/nsis/nulsft.c",{ mode=-rw-------
,inode=947061427,size=13446,blksize=4096 }) = 0 (0x0)
lstat("libclamav/nsis/nulsft.h",{ mode=-rw-------
,inode=947061429,size=869,blksize=4096 }) = 0 (0x0)
getdirentries(0x5,0x8011e8000,0x1000,0x8011e5128,0x17,0x17) = 0 (0x0)
lseek(5,0x0,SEEK_SET)				 = 0 (0x0)
close(5)					 = 0 (0x0)
lstat("libclamav/ole2_extract.c",{ mode=-rw-------
,inode=3533647699,size=29069,blksize=4096 }) = 0 (0x0)
lstat("libclamav/ole2_extract.h",{ mode=-rw-------
,inode=3533647700,size=987,blksize=4096 }) = 0 (0x0)
lstat("libclamav/others.c",{ mode=-rw-------
,inode=3533647701,size=25145,blksize=4096 }) = 0 (0x0)
lstat("libclamav/others.h",{ mode=-rw-------
,inode=3533647702,size=17106,blksize=4096 }) = 0 (0x0)
lstat("libclamav/others_common.c",{ mode=-rw-------
,inode=3533647703,size=21064,blksize=4096 }) = 0 (0x0)
lstat("libclamav/packlibs.c",{ mode=-rw-------
,inode=3533647704,size=7863,blksize=4096 }) = 0 (0x0)
lstat("libclamav/packlibs.h",{ mode=-rw-------
,inode=3533647705,size=1039,blksize=4096 }) = 0 (0x0)
lstat("libclamav/pdf.c",{ mode=-rw-------
,inode=3533647707,size=41297,blksize=4096 }) = 0 (0x0)
lstat("libclamav/pdf.h",{ mode=-rw-------
,inode=3533647708,size=870,blksize=4096 }) = 0 (0x0)
lstat("libclamav/pe.c",{ mode=-rw-------
,inode=3533647709,size=87025,blksize=4096 }) = 0 (0x0)
lstat("libclamav/pe.h",{ mode=-rw-------
,inode=3533647710,size=6239,blksize=4096 }) = 0 (0x0)
lstat("libclamav/pe_icons.c",{ mode=-rw-------
,inode=3533647711,size=64573,blksize=4096 }) = 0 (0x0)
lstat("libclamav/pe_icons.h",{ mode=-rw-------
,inode=3523231968,size=1374,blksize=4096 }) = 0 (0x0)
lstat("libclamav/perflogging.c",{ mode=-rw-------
,inode=3523231969,size=3833,blksize=4096 }) = 0 (0x0)
lstat("libclamav/perflogging.h",{ mode=-rw-------
,inode=3523231970,size=2747,blksize=4096 }) = 0 (0x0)
lstat("libclamav/petite.c",{ mode=-rw-------
,inode=3523231971,size=14026,blksize=4096 }) = 0 (0x0)
lstat("libclamav/petite.h",{ mode=-rw-------
,inode=3523231972,size=1056,blksize=4096 }) = 0 (0x0)
lstat("libclamav/phish_domaincheck_db.c",{ mode=-rw-------
,inode=3523231973,size=2237,blksize=4096 }) = 0 (0x0)
lstat("libclamav/phish_domaincheck_db.h",{ mode=-rw-------
,inode=3523231974,size=1253,blksize=4096 }) = 0 (0x0)
lstat("libclamav/phish_whitelist.c",{ mode=-rw-------
,inode=3523231975,size=2329,blksize=4096 }) = 0 (0x0)
lstat("libclamav/phish_whitelist.h",{ mode=-rw-------
,inode=3523231976,size=1197,blksize=4096 }) = 0 (0x0)
lstat("libclamav/phishcheck.c",{ mode=-rw-------
,inode=3523231977,size=45951,blksize=4096 }) = 0 (0x0)
lstat("libclamav/phishcheck.h",{ mode=-rw-------
,inode=3523231978,size=2301,blksize=4096 }) = 0 (0x0)
lstat("libclamav/qsort.c",{ mode=-rw-------
,inode=3523231979,size=5112,blksize=4096 }) = 0 (0x0)
lstat("libclamav/readdb.c",{ mode=-rw-------
,inode=3523231980,size=85767,blksize=4096 }) = 0 (0x0)
lstat("libclamav/readdb.h",{ mode=-rw-------
,inode=3523231982,size=2401,blksize=4096 }) = 0 (0x0)
lstat("libclamav/rebuildpe.c",{ mode=-rw-------
,inode=3523231983,size=6510,blksize=4096 }) = 0 (0x0)
lstat("libclamav/rebuildpe.h",{ mode=-rw-------
,inode=3523231984,size=947,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex",{ mode=drwx------
,inode=1077739768,size=4096,blksize=4096 }) = 0 (0x0)
stat("libclamav/regex/",{ mode=drwx------
,inode=1077739768,size=4096,blksize=4096 }) = 0 (0x0)
open("libclamav/regex/",O_NONBLOCK,020)		 = 5 (0x5)
fstat(5,{ mode=drwx------ ,inode=1077739768,size=4096,blksize=4096 }) =
0 (0x0)
fcntl(5,F_SETFD,FD_CLOEXEC)			 = 0 (0x0)
fstatfs(0x5,0x7fffffffcdd0,0x8011e5040,0x2,0x0,0x0) = 0 (0x0)
getdirentries(0x5,0x8011e8000,0x1000,0x8011e5128,0xfffffffffffffb90,0x0)
= 512 (0x200)
lstat("libclamav/regex/cclass.h",{ mode=-rw-------
,inode=1077739769,size=2846,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex/cname.h",{ mode=-rw-------
,inode=1077739770,size=4263,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex/engine.c",{ mode=-rw-------
,inode=1077739771,size=26506,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex/regcomp.c",{ mode=-rw-------
,inode=1077739774,size=35560,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex/regerror.c",{ mode=-rw-------
,inode=1077739779,size=4460,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex/regex.h",{ mode=-rw-------
,inode=1077739780,size=3613,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex/regex2.h",{ mode=-rw-------
,inode=1077739781,size=6870,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex/regexec.c",{ mode=-rw-------
,inode=1077739783,size=5756,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex/regfree.c",{ mode=-rw-------
,inode=1077739784,size=2559,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex/strlcpy.c",{ mode=-rw-------
,inode=1077739785,size=1590,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex/utils.h",{ mode=-rw-------
,inode=1077739786,size=2401,blksize=4096 }) = 0 (0x0)
getdirentries(0x5,0x8011e8000,0x1000,0x8011e5128,0x17,0x17) = 0 (0x0)
lseek(5,0x0,SEEK_SET)				 = 0 (0x0)
close(5)					 = 0 (0x0)
lstat("libclamav/regex_list.c",{ mode=-rw-------
,inode=3523231985,size=20096,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex_list.h",{ mode=-rw-------
,inode=3523231986,size=2258,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex_suffix.c",{ mode=-rw-------
,inode=3523231987,size=10442,blksize=4096 }) = 0 (0x0)
lstat("libclamav/regex_suffix.h",{ mode=-rw-------
,inode=3523231988,size=1177,blksize=4096 }) = 0 (0x0)
lstat("libclamav/rtf.c",{ mode=-rw-------
,inode=3523231989,size=20004,blksize=4096 }) = 0 (0x0)
lstat("libclamav/rtf.h",{ mode=-rw-------
,inode=3523231990,size=854,blksize=4096 }) = 0 (0x0)
lstat("libclamav/scanners.c",{ mode=-rw-------
,inode=3523231991,size=63242,blksize=4096 }) = 0 (0x0)
lstat("libclamav/scanners.h",{ mode=-rw-------
,inode=3523231992,size=938,blksize=4096 }) = 0 (0x0)
lstat("libclamav/sha1.c",{ mode=-rw-------
,inode=3523231995,size=14998,blksize=4096 }) = 0 (0x0)
lstat("libclamav/sha1.h",{ mode=-rw-------
,inode=3523231996,size=2209,blksize=4096 }) = 0 (0x0)
lstat("libclamav/sha256.c",{ mode=-rw-------
,inode=3523231997,size=12499,blksize=4096 }) = 0 (0x0)
lstat("libclamav/sha256.h",{ mode=-rw-------
,inode=3523231998,size=2151,blksize=4096 }) = 0 (0x0)
lstat("libclamav/sis.c",{ mode=-rw-------
,inode=3523231999,size=37808,blksize=4096 }) = 0 (0x0)
lstat("libclamav/sis.h",{ mode=-rw-------
,inode=3523232000,size=853,blksize=4096 }) = 0 (0x0)
lstat("libclamav/special.c",{ mode=-rw-------
,inode=3523232001,size=11374,blksize=4096 }) = 0 (0x0)
lstat("libclamav/special.h",{ mode=-rw-------
,inode=3523232002,size=1285,blksize=4096 }) = 0 (0x0)
lstat("libclamav/spin.c",{ mode=-rw-------
,inode=3523232003,size=13171,blksize=4096 }) = 0 (0x0)
lstat("libclamav/spin.h",{ mode=-rw-------
,inode=3523232004,size=920,blksize=4096 }) = 0 (0x0)
lstat("libclamav/str.c",{ mode=-rw-------
,inode=3523232005,size=12521,blksize=4096 }) = 0 (0x0)
lstat("libclamav/str.h",{ mode=-rw-------
,inode=3523232006,size=2088,blksize=4096 }) = 0 (0x0)
lstat("libclamav/table.c",{ mode=-rw-------
,inode=3523232007,size=4834,blksize=4096 }) = 0 (0x0)
lstat("libclamav/table.h",{ mode=-rw-------
,inode=3523232008,size=1429,blksize=4096 }) = 0 (0x0)
lstat("libclamav/text.c",{ mode=-rw-------
,inode=3523232009,size=9233,blksize=4096 }) = 0 (0x0)
lstat("libclamav/text.h",{ mode=-rw-------
,inode=3523232010,size=1803,blksize=4096 }) = 0 (0x0)
lstat("libclamav/textdet.c",{ mode=-rw-------
,inode=3523232011,size=5981,blksize=4096 }) = 0 (0x0)
lstat("libclamav/textdet.h",{ mode=-rw-------
,inode=3523232012,size=860,blksize=4096 }) = 0 (0x0)
lstat("libclamav/textnorm.c",{ mode=-rw-------
,inode=3523232013,size=4154,blksize=4096 }) = 0 (0x0)
lstat("libclamav/textnorm.h",{ mode=-rw-------
,inode=3523232014,size=1143,blksize=4096 }) = 0 (0x0)
lstat("libclamav/tnef.c",{ mode=-rw-------
,inode=3523232015,size=9814,blksize=4096 }) = 0 (0x0)
lstat("libclamav/tnef.h",{ mode=-rw-------
,inode=3523232016,size=870,blksize=4096 }) = 0 (0x0)
lstat("libclamav/type_desc.h",{ mode=-rw-------
,inode=3523232017,size=3041,blksize=4096 }) = 0 (0x0)
lstat("libclamav/unarj.c",{ mode=-rw-------
,inode=3523232018,size=26039,blksize=4096 }) = 0 (0x0)
lstat("libclamav/unarj.h",{ mode=-rw-------
,inode=3523232019,size=1213,blksize=4096 }) = 0 (0x0)
lstat("libclamav/uniq.c",{ mode=-rw-------
,inode=3523232020,size=2800,blksize=4096 }) = 0 (0x0)
lstat("libclamav/uniq.h",{ mode=-rw-------
,inode=3523232021,size=1225,blksize=4096 }) = 0 (0x0)
lstat("libclamav/unsp.c",{ mode=-rw-------
,inode=3523232022,size=15170,blksize=4096 }) = 0 (0x0)
lstat("libclamav/unsp.h",{ mode=-rw-------
,inode=3523232023,size=1687,blksize=4096 }) = 0 (0x0)
lstat("libclamav/untar.c",{ mode=-rw-------
,inode=3523232024,size=5811,blksize=4096 }) = 0 (0x0)
lstat("libclamav/untar.h",{ mode=-rw-------
,inode=3523232025,size=1340,blksize=4096 }) = 0 (0x0)
lstat("libclamav/unzip.c",{ mode=-rw-------
,inode=3523232026,size=15846,blksize=4096 }) = 0 (0x0)
lstat("libclamav/unzip.h",{ mode=-rw-------
,inode=3523232027,size=4249,blksize=4096 }) = 0 (0x0)
lstat("libclamav/upack.c",{ mode=-rw-------
,inode=3523232028,size=22118,blksize=4096 }) = 0 (0x0)
lstat("libclamav/upack.h",{ mode=-rw-------
,inode=3523232029,size=972,blksize=4096 }) = 0 (0x0)
lstat("libclamav/upx.c",{ mode=-rw-------
,inode=3523232030,size=16871,blksize=4096 }) = 0 (0x0)
lstat("libclamav/upx.h",{ mode=-rw-------
,inode=3523232031,size=1163,blksize=4096 }) = 0 (0x0)
lstat("libclamav/uuencode.c",{ mode=-rw-------
,inode=3517287488,size=2945,blksize=4096 }) = 0 (0x0)
lstat("libclamav/uuencode.h",{ mode=-rw-------
,inode=3517287489,size=964,blksize=4096 }) = 0 (0x0)
lstat("libclamav/vba_extract.c",{ mode=-rw-------
,inode=3517287492,size=28078,blksize=4096 }) = 0 (0x0)
lstat("libclamav/vba_extract.h",{ mode=-rw-------
,inode=3517287494,size=1540,blksize=4096 }) = 0 (0x0)
lstat("libclamav/version.c",{ mode=-rw-------
,inode=3517287495,size=293,blksize=4096 }) = 0 (0x0)
lstat("libclamav/wwunpack.c",{ mode=-rw-------
,inode=3517287496,size=5492,blksize=4096 }) = 0 (0x0)
lstat("libclamav/wwunpack.h",{ mode=-rw-------
,inode=3517287497,size=933,blksize=4096 }) = 0 (0x0)
lstat("libclamav/yc.c",{ mode=-rw-------
,inode=3517287498,size=6140,blksize=4096 }) = 0 (0x0)
lstat("libclamav/yc.h",{ mode=-rw-------
,inode=3517287499,size=956,blksize=4096 }) = 0 (0x0)
lstat("libclamav/Makefile",{ mode=-rw-r--r--
,inode=270743026,size=165975,blksize=4096 }) = 0 (0x0)
lstat("libclamav/.deps",{ mode=drwxr-xr-x
,inode=404986341,size=8192,blksize=4096 }) = 0 (0x0)
getdirentries(0x4,0x8011e7000,0x1000,0x8011e50c8,0xffff80080111dc64,0x0)
= 0 (0x0)
lseek(4,0x0,SEEK_SET)				 = 0 (0x0)
close(4)					 = 0 (0x0)
lstat("libclamav.pc",{ mode=-rw-r--r--
,inode=270743009,size=236,blksize=4096 }) = 0 (0x0)
getdirentries(0x3,0x8011e6000,0x1000,0x8011e5068,0x8011df190,0x0) = 0 (0x0)
lseek(3,0x0,SEEK_SET)				 = 0 (0x0)
close(3)					 = 0 (0x0)
lstat("libclamav.pc",{ mode=-rw-r--r--
,inode=270743009,size=236,blksize=4096 }) = 0 (0x0)
lstat("libclamav/.deps/",{ mode=drwxr-xr-x
,inode=404986341,size=8192,blksize=4096 }) = 0 (0x0)
fstat(1,{ mode=crw--w---- ,inode=89,size=0,blksize=4096 }) = 0 (0x0)
ioctl(1,TIOCGETA,0xffffdce0)			 = 0 (0x0)
write(1,"Removing libclamav/.deps/\n",26)	 = 26 (0x1a)
stat("libclamav/.deps/.git",0x7fffffffe0a0)	 ERR#2 'No such file or
directory'
open("libclamav/.deps/.git/HEAD",O_RDONLY,00)	 ERR#2 'No such file or
directory'
open("libclamav/.deps/.git/packed-refs",O_RDONLY,0666) ERR#2 'No such
file or directory'
stat("libclamav/.deps/",{ mode=drwxr-xr-x
,inode=404986341,size=8192,blksize=4096 }) = 0 (0x0)
open("libclamav/.deps/",O_NONBLOCK,00)		 = 3 (0x3)
fstat(3,{ mode=drwxr-xr-x ,inode=404986341,size=8192,blksize=4096 }) = 0
(0x0)
fcntl(3,F_SETFD,FD_CLOEXEC)			 = 0 (0x0)
fstatfs(0x3,0x7fffffffdee0,0x8011e1040,0x0,0x0,0x1e008) = 0 (0x0)
getdirentries(0x3,0x8011e2000,0x1000,0x8011e1068,0x0,0x0) = 4096 (0x1000)
lstat("libclamav/.deps/bytecode_nojit.Plo",{ mode=-rw-r--r--
,inode=404986343,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/bytecode_nojit.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_la-md5.Plo",{
mode=-rw-r--r-- ,inode=404986344,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_la-md5.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_la-others_common.Plo",{
mode=-rw-r--r-- ,inode=404986345,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_la-others_common.Plo")
= 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_la-qsort.Plo",{
mode=-rw-r--r-- ,inode=404986346,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_la-qsort.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_la-regcomp.Plo",{
mode=-rw-r--r-- ,inode=404986347,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_la-regcomp.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_la-regerror.Plo",{
mode=-rw-r--r-- ,inode=404986348,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_la-regerror.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_la-regexec.Plo",{
mode=-rw-r--r-- ,inode=404986349,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_la-regexec.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_la-regfree.Plo",{
mode=-rw-r--r-- ,inode=404986350,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_la-regfree.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_la-str.Plo",{
mode=-rw-r--r-- ,inode=404986352,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_la-str.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_la-strlcpy.Plo",{
mode=-rw-r--r-- ,inode=404986353,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_la-strlcpy.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_nothreads_la-md5.Plo",{
mode=-rw-r--r-- ,inode=404986354,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_nothreads_la-md5.Plo")
= 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_nothreads_la-others_common.Plo",{
mode=-rw-r--r-- ,inode=404986355,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_nothreads_la-others_common.Plo")
= 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_nothreads_la-qsort.Plo",{ mode=-rw-r--r--
,inode=404986356,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_nothreads_la-qsort.Plo") =
0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_nothreads_la-regcomp.Plo",{
mode=-rw-r--r-- ,inode=404986363,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_nothreads_la-regcomp.Plo")
= 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_nothreads_la-regerror.Plo",{
mode=-rw-r--r-- ,inode=404986366,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_nothreads_la-regerror.Plo")
= 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_nothreads_la-regexec.Plo",{
mode=-rw-r--r-- ,inode=404986367,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_nothreads_la-regexec.Plo")
= 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_nothreads_la-regfree.Plo",{
mode=-rw-r--r-- ,inode=404986368,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_nothreads_la-regfree.Plo")
= 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_nothreads_la-str.Plo",{
mode=-rw-r--r-- ,inode=404986369,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_nothreads_la-str.Plo")
= 0 (0x0)
lstat("libclamav/.deps/libclamav_internal_utils_nothreads_la-strlcpy.Plo",{
mode=-rw-r--r-- ,inode=404986370,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_internal_utils_nothreads_la-strlcpy.Plo")
= 0 (0x0)
lstat("libclamav/.deps/libclamav_la-7z.Plo",{ mode=-rw-r--r--
,inode=404986371,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-7z.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-7zBuf.Plo",{ mode=-rw-r--r--
,inode=404986372,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-7zBuf.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-7zCrc.Plo",{ mode=-rw-r--r--
,inode=404986373,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-7zCrc.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-7zDecode.Plo",{ mode=-rw-r--r--
,inode=404986374,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-7zDecode.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-7zExtract.Plo",{ mode=-rw-r--r--
,inode=404986375,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-7zExtract.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-7zFile.Plo",{ mode=-rw-r--r--
,inode=404986376,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-7zFile.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-7zHeader.Plo",{ mode=-rw-r--r--
,inode=404986377,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-7zHeader.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-7zIn.Plo",{ mode=-rw-r--r--
,inode=404986378,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-7zIn.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-7zItem.Plo",{ mode=-rw-r--r--
,inode=404986379,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-7zItem.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-7zStream.Plo",{ mode=-rw-r--r--
,inode=404986380,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-7zStream.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-Bcj2.Plo",{ mode=-rw-r--r--
,inode=404986381,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-Bcj2.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-Bra.Plo",{ mode=-rw-r--r--
,inode=404986382,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-Bra.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-Bra86.Plo",{ mode=-rw-r--r--
,inode=404986384,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-Bra86.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-LzmaDec.Plo",{ mode=-rw-r--r--
,inode=404986385,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-LzmaDec.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-aspack.Plo",{ mode=-rw-r--r--
,inode=404986386,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-aspack.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-autoit.Plo",{ mode=-rw-r--r--
,inode=404986387,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-autoit.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-bignum.Plo",{ mode=-rw-r--r--
,inode=404986390,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-bignum.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-binhex.Plo",{ mode=-rw-r--r--
,inode=404986391,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-binhex.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-blob.Plo",{ mode=-rw-r--r--
,inode=404986392,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-blob.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-bytecode.Plo",{ mode=-rw-r--r--
,inode=404986393,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-bytecode.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-bytecode_api.Plo",{ mode=-rw-r--r--
,inode=404986394,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-bytecode_api.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-bytecode_api_decl.Plo",{
mode=-rw-r--r-- ,inode=404986395,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-bytecode_api_decl.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-bytecode_vm.Plo",{ mode=-rw-r--r--
,inode=404986396,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-bytecode_vm.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-bzlib.Plo",{ mode=-rw-r--r--
,inode=404986397,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-bzlib.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-cab.Plo",{ mode=-rw-r--r--
,inode=404986398,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-cab.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-cache.Plo",{ mode=-rw-r--r--
,inode=404986399,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-cache.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-chmunpack.Plo",{ mode=-rw-r--r--
,inode=410575698,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-chmunpack.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-cpio.Plo",{ mode=-rw-r--r--
,inode=410575699,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-cpio.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-cvd.Plo",{ mode=-rw-r--r--
,inode=410575700,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-cvd.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-dconf.Plo",{ mode=-rw-r--r--
,inode=410575701,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-dconf.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-disasm.Plo",{ mode=-rw-r--r--
,inode=410575702,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-disasm.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-dlp.Plo",{ mode=-rw-r--r--
,inode=410575704,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-dlp.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-dsig.Plo",{ mode=-rw-r--r--
,inode=410575705,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-dsig.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-elf.Plo",{ mode=-rw-r--r--
,inode=410575706,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-elf.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-entconv.Plo",{ mode=-rw-r--r--
,inode=410575707,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-entconv.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-explode.Plo",{ mode=-rw-r--r--
,inode=410575708,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-explode.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-filetypes.Plo",{ mode=-rw-r--r--
,inode=410575709,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-filetypes.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-filtering.Plo",{ mode=-rw-r--r--
,inode=410575710,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-filtering.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-fmap.Plo",{ mode=-rw-r--r--
,inode=410575711,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-fmap.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-fsg.Plo",{ mode=-rw-r--r--
,inode=410741760,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-fsg.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-hashtab.Plo",{ mode=-rw-r--r--
,inode=410741761,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-hashtab.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-htmlnorm.Plo",{ mode=-rw-r--r--
,inode=410741763,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-htmlnorm.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-infblock.Plo",{ mode=-rw-r--r--
,inode=410741764,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-infblock.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-inflate64.Plo",{ mode=-rw-r--r--
,inode=410741765,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-inflate64.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-is_tar.Plo",{ mode=-rw-r--r--
,inode=410741766,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-is_tar.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-ishield.Plo",{ mode=-rw-r--r--
,inode=410741767,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-ishield.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-js-norm.Plo",{ mode=-rw-r--r--
,inode=410741768,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-js-norm.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-line.Plo",{ mode=-rw-r--r--
,inode=410741769,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-line.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-lzma_iface.Plo",{ mode=-rw-r--r--
,inode=410882114,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-lzma_iface.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-macho.Plo",{ mode=-rw-r--r--
,inode=430554068,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-macho.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-matcher-ac.Plo",{ mode=-rw-r--r--
,inode=430554083,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-matcher-ac.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-matcher-bm.Plo",{ mode=-rw-r--r--
,inode=430554097,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-matcher-bm.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-matcher.Plo",{ mode=-rw-r--r--
,inode=430554109,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-matcher.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-mbox.Plo",{ mode=-rw-r--r--
,inode=430554219,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-mbox.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-message.Plo",{ mode=-rw-r--r--
,inode=430554234,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-message.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-mew.Plo",{ mode=-rw-r--r--
,inode=430554264,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-mew.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-mpool.Plo",{ mode=-rw-r--r--
,inode=430554949,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-mpool.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-msexpand.Plo",{ mode=-rw-r--r--
,inode=430554960,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-msexpand.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-mspack.Plo",{ mode=-rw-r--r--
,inode=430554967,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-mspack.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-nulsft.Plo",{ mode=-rw-r--r--
,inode=430554978,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-nulsft.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-ole2_extract.Plo",{ mode=-rw-r--r--
,inode=430554983,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-ole2_extract.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-others.Plo",{ mode=-rw-r--r--
,inode=430555914,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-others.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-packlibs.Plo",{ mode=-rw-r--r--
,inode=430555917,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-packlibs.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-pdf.Plo",{ mode=-rw-r--r--
,inode=430556219,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-pdf.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-pe.Plo",{ mode=-rw-r--r--
,inode=430556233,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-pe.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-pe_icons.Plo",{ mode=-rw-r--r--
,inode=430556364,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-pe_icons.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-perflogging.Plo",{ mode=-rw-r--r--
,inode=430557858,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-perflogging.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-petite.Plo",{ mode=-rw-r--r--
,inode=430557873,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-petite.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-phish_domaincheck_db.Plo",{
mode=-rw-r--r-- ,inode=430557885,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-phish_domaincheck_db.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-phish_whitelist.Plo",{
mode=-rw-r--r-- ,inode=430558515,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-phish_whitelist.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-phishcheck.Plo",{ mode=-rw-r--r--
,inode=430558533,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-phishcheck.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-readdb.Plo",{ mode=-rw-r--r--
,inode=430559843,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-readdb.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-rebuildpe.Plo",{ mode=-rw-r--r--
,inode=430559859,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-rebuildpe.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-regex_list.Plo",{ mode=-rw-r--r--
,inode=430559880,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-regex_list.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-regex_suffix.Plo",{ mode=-rw-r--r--
,inode=430559890,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-regex_suffix.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-rtf.Plo",{ mode=-rw-r--r--
,inode=430559898,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-rtf.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-scanners.Plo",{ mode=-rw-r--r--
,inode=430560399,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-scanners.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-sha1.Plo",{ mode=-rw-r--r--
,inode=430560420,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-sha1.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-sha256.Plo",{ mode=-rw-r--r--
,inode=430560868,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-sha256.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-sis.Plo",{ mode=-rw-r--r--
,inode=430560898,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-sis.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-special.Plo",{ mode=-rw-r--r--
,inode=430560912,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-special.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-spin.Plo",{ mode=-rw-r--r--
,inode=430560926,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-spin.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-table.Plo",{ mode=-rw-r--r--
,inode=430561715,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-table.Plo") = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-text.Plo",{ mode=-rw-r--r--
,inode=430561755,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-text.Plo")	 = 0 (0x0)
lstat("libclamav/.deps/libclamav_la-textdet.Plo",{ mode=-rw-r--r--
,inode=430561772,size=8,blksize=4096 }) = 0 (0x0)
unlink("libclamav/.deps/libclamav_la-textdet.Plo") = 0 (0x0)
getdirentries(0x3,0x8011e2000,0x1000,0x8011e1068,0xac,0x1b008) = 0 (0x0)
lseek(3,0x0,SEEK_SET)				 = 0 (0x0)
close(3)					 = 0 (0x0)
rmdir(0x8011e3080,0x5ff560,0x10,0x2000,0x626298,0x0) ERR#66 'Directory
not empty'
warning: failed to remove 'libclamav/.deps/'
write(2,"warning: failed to remove 'libcl"...,45) = 45 (0x2d)

Full output of 'truss rm -rf libclamav/.deps':
__sysctl(0x7fffffffe3f0,0x2,0x7fffffffe40c,0x7fffffffe400,0x0,0x0) = 0 (0x0)
mmap(0x0,656,PROT_READ|PROT_WRITE,MAP_ANON,-1,0x0) = 34365190144
(0x800533000)
munmap(0x800533000,656)				 = 0 (0x0)
__sysctl(0x7fffffffe460,0x2,0x80063d328,0x7fffffffe458,0x0,0x0) = 0 (0x0)
mmap(0x0,32768,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANON,-1,0x0) =
34365190144 (0x800533000)
issetugid(0x800534015,0x80052e686,0x800649b30,0x800649b00,0x598f,0x0) =
0 (0x0)
open("/etc/libmap.conf",O_RDONLY,0666)		 ERR#2 'No such file or directory'
open("/var/run/ld-elf.so.hints",O_RDONLY,057)	 = 3 (0x3)
read(3,"Ehnt\^A\0\0\0\M^@\0\0\0-\0\0\0\0"...,128) = 128 (0x80)
lseek(3,0x80,SEEK_SET)				 = 128 (0x80)
read(3,"/lib:/usr/lib:/usr/lib/compat:/u"...,45) = 45 (0x2d)
close(3)					 = 0 (0x0)
access("/lib/libc.so.7",0)			 = 0 (0x0)
open("/lib/libc.so.7",O_RDONLY,030751000)	 = 3 (0x3)
fstat(3,{ mode=-r--r--r-- ,inode=38225,size=1265520,blksize=4096 }) = 0
(0x0)
read(3,"\^?ELF\^B\^A\^A\t\0\0\0\0\0\0\0"...,4096) = 4096 (0x1000)
mmap(0x0,2334720,PROT_NONE,MAP_PRIVATE|MAP_ANON|MAP_NOCORE,-1,0x0) =
34366332928 (0x80064a000)
mmap(0x80064a000,1052672,PROT_READ|PROT_EXEC,MAP_PRIVATE|MAP_FIXED|MAP_NOCORE,3,0x0)
= 34366332928 (0x80064a000)
mmap(0x80084b000,122880,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_FIXED,3,0x101000)
= 34368434176 (0x80084b000)
mprotect(0x800869000,110592,PROT_READ|PROT_WRITE) = 0 (0x0)
close(3)					 = 0 (0x0)
sysarch(0x81,0x7fffffffe4e0,0x8005360c8,0x0,0xffffffffffce6310,0x800665d70)
= 0 (0x0)
mmap(0x0,896,PROT_READ|PROT_WRITE,MAP_ANON,-1,0x0) = 34365222912
(0x80053b000)
munmap(0x80053b000,896)				 = 0 (0x0)
mmap(0x0,43584,PROT_READ|PROT_WRITE,MAP_ANON,-1,0x0) = 34365222912
(0x80053b000)
munmap(0x80053b000,43584)			 = 0 (0x0)
sigprocmask(SIG_BLOCK,SIGHUP|SIGINT|SIGQUIT|SIGKILL|SIGPIPE|SIGALRM|SIGTERM|SIGURG|SIGSTOP|SIGTSTP|SIGCONT|SIGCHLD|SIGTTIN|SIGTTOU|SIGIO|SIGXCPU|SIGXFSZ|SIGVTALRM|SIGPROF|SIGWINCH|SIGINFO|SIGUSR1|SIGUSR2,0x0)
= 0 (0x0)
sigprocmask(SIG_SETMASK,0x0,0x0)		 = 0 (0x0)
__sysctl(0x7fffffffe480,0x2,0x503580,0x7fffffffe478,0x0,0x0) = 0 (0x0)
sigprocmask(SIG_BLOCK,SIGHUP|SIGINT|SIGQUIT|SIGKILL|SIGPIPE|SIGALRM|SIGTERM|SIGURG|SIGSTOP|SIGTSTP|SIGCONT|SIGCHLD|SIGTTIN|SIGTTOU|SIGIO|SIGXCPU|SIGXFSZ|SIGVTALRM|SIGPROF|SIGWINCH|SIGINFO|SIGUSR1|SIGUSR2,0x0)
= 0 (0x0)
sigprocmask(SIG_SETMASK,0x0,0x0)		 = 0 (0x0)
geteuid(0x7fffffffec20,0x402755,0xf,0x5f,0x0,0x0) = 1066 (0x42a)
sigaction(SIGINFO,{ 0x401410 SA_RESTART ss_t },{ SIG_DFL 0x0 ss_t }) = 0
(0x0)
ioctl(0,TIOCGETA,0xffffeb60)			 = 0 (0x0)
__sysctl(0x7fffffffe660,0x2,0x80086e788,0x7fffffffe658,0x0,0x0) = 0 (0x0)
readlink("/etc/malloc.conf",0x7fffffffe680,1024) ERR#2 'No such file or
directory'
issetugid(0x800742031,0x7fffffffe680,0xffffffffffffffff,0x0,0x0,0x0) = 0
(0x0)
break(0x600000)					 = 0 (0x0)
__sysctl(0x7fffffffe940,0x2,0x7fffffffe95c,0x7fffffffe950,0x0,0x0) = 0 (0x0)
mmap(0x0,1048576,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANON,-1,0x0) =
34368667648 (0x800884000)
mmap(0x800984000,507904,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANON,-1,0x0) =
34369716224 (0x800984000)
munmap(0x800884000,507904)			 = 0 (0x0)
lstat("libclamav/.deps",{ mode=drwxr-xr-x
,inode=58548,size=8192,blksize=4096 }) = 0 (0x0)
open(".",O_RDONLY,00)				 = 3 (0x3)
fchdir(0x3,0x5035c0,0x0,0x2,0x1cecf8,0x0)	 = 0 (0x0)
stat("libclamav/.deps",{ mode=drwxr-xr-x
,inode=58548,size=8192,blksize=4096 }) = 0 (0x0)
open("libclamav/.deps",O_NONBLOCK,044270600)	 = 4 (0x4)
fstat(4,{ mode=drwxr-xr-x ,inode=58548,size=8192,blksize=4096 }) = 0 (0x0)
fcntl(4,F_SETFD,FD_CLOEXEC)			 = 0 (0x0)
__sysctl(0x7fffffffe720,0x2,0x800880898,0x7fffffffe718,0x0,0x0) = 0 (0x0)
fstatfs(0x4,0x7fffffffe810,0x800880898,0x7fffffffe718,0x0,0x0) = 0 (0x0)
statfs(0x80090b200,0x800902358,0x800917180,0x0,0x0,0x8009002c0) = 0 (0x0)
fstat(4,{ mode=drwxr-xr-x ,inode=58548,size=8192,blksize=4096 }) = 0 (0x0)
fchdir(0x4,0x7fffffffea20,0x4,0x0,0x0,0x8009002c0) = 0 (0x0)
getdirentries(0x4,0x80091b000,0x1000,0x80091a068,0x0,0x8009002c0) = 4096
(0x1000)
getdirentries(0x4,0x80091b000,0x1000,0x80091a068,0x6c6c,0x1) = 1024 (0x400)
getdirentries(0x4,0x80091b000,0x1000,0x80091a068,0x8afc,0x1) = 0 (0x0)
lseek(4,0x0,SEEK_SET)				 = 0 (0x0)
close(4)					 = 0 (0x0)
unlink("bytecode_nojit.Plo")			 = 0 (0x0)
unlink("libclamav_internal_utils_la-md5.Plo")	 = 0 (0x0)
unlink("libclamav_internal_utils_la-others_common.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_la-qsort.Plo")	 = 0 (0x0)
unlink("libclamav_internal_utils_la-regcomp.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_la-regerror.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_la-regexec.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_la-regfree.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_la-str.Plo")	 = 0 (0x0)
unlink("libclamav_internal_utils_la-strlcpy.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_nothreads_la-md5.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_nothreads_la-others_common.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_nothreads_la-qsort.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_nothreads_la-regcomp.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_nothreads_la-regerror.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_nothreads_la-regexec.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_nothreads_la-regfree.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_nothreads_la-str.Plo") = 0 (0x0)
unlink("libclamav_internal_utils_nothreads_la-strlcpy.Plo") = 0 (0x0)
unlink("libclamav_la-7z.Plo")			 = 0 (0x0)
unlink("libclamav_la-7zBuf.Plo")		 = 0 (0x0)
unlink("libclamav_la-7zCrc.Plo")		 = 0 (0x0)
unlink("libclamav_la-7zDecode.Plo")		 = 0 (0x0)
unlink("libclamav_la-7zExtract.Plo")		 = 0 (0x0)
unlink("libclamav_la-7zFile.Plo")		 = 0 (0x0)
unlink("libclamav_la-7zHeader.Plo")		 = 0 (0x0)
unlink("libclamav_la-7zIn.Plo")			 = 0 (0x0)
unlink("libclamav_la-7zItem.Plo")		 = 0 (0x0)
unlink("libclamav_la-7zStream.Plo")		 = 0 (0x0)
unlink("libclamav_la-Bcj2.Plo")			 = 0 (0x0)
unlink("libclamav_la-Bra.Plo")			 = 0 (0x0)
unlink("libclamav_la-Bra86.Plo")		 = 0 (0x0)
unlink("libclamav_la-LzmaDec.Plo")		 = 0 (0x0)
unlink("libclamav_la-aspack.Plo")		 = 0 (0x0)
unlink("libclamav_la-autoit.Plo")		 = 0 (0x0)
unlink("libclamav_la-bignum.Plo")		 = 0 (0x0)
unlink("libclamav_la-binhex.Plo")		 = 0 (0x0)
unlink("libclamav_la-blob.Plo")			 = 0 (0x0)
unlink("libclamav_la-bytecode.Plo")		 = 0 (0x0)
unlink("libclamav_la-bytecode_api.Plo")		 = 0 (0x0)
unlink("libclamav_la-bytecode_api_decl.Plo")	 = 0 (0x0)
unlink("libclamav_la-bytecode_vm.Plo")		 = 0 (0x0)
unlink("libclamav_la-bzlib.Plo")		 = 0 (0x0)
unlink("libclamav_la-cab.Plo")			 = 0 (0x0)
unlink("libclamav_la-cache.Plo")		 = 0 (0x0)
unlink("libclamav_la-chmunpack.Plo")		 = 0 (0x0)
unlink("libclamav_la-cpio.Plo")			 = 0 (0x0)
unlink("libclamav_la-cvd.Plo")			 = 0 (0x0)
unlink("libclamav_la-dconf.Plo")		 = 0 (0x0)
unlink("libclamav_la-disasm.Plo")		 = 0 (0x0)
unlink("libclamav_la-dlp.Plo")			 = 0 (0x0)
unlink("libclamav_la-dsig.Plo")			 = 0 (0x0)
unlink("libclamav_la-elf.Plo")			 = 0 (0x0)
unlink("libclamav_la-entconv.Plo")		 = 0 (0x0)
unlink("libclamav_la-explode.Plo")		 = 0 (0x0)
unlink("libclamav_la-filetypes.Plo")		 = 0 (0x0)
unlink("libclamav_la-filtering.Plo")		 = 0 (0x0)
unlink("libclamav_la-fmap.Plo")			 = 0 (0x0)
unlink("libclamav_la-fsg.Plo")			 = 0 (0x0)
unlink("libclamav_la-hashtab.Plo")		 = 0 (0x0)
unlink("libclamav_la-htmlnorm.Plo")		 = 0 (0x0)
unlink("libclamav_la-infblock.Plo")		 = 0 (0x0)
unlink("libclamav_la-inflate64.Plo")		 = 0 (0x0)
unlink("libclamav_la-is_tar.Plo")		 = 0 (0x0)
unlink("libclamav_la-ishield.Plo")		 = 0 (0x0)
unlink("libclamav_la-js-norm.Plo")		 = 0 (0x0)
unlink("libclamav_la-line.Plo")			 = 0 (0x0)
unlink("libclamav_la-lzma_iface.Plo")		 = 0 (0x0)
unlink("libclamav_la-macho.Plo")		 = 0 (0x0)
unlink("libclamav_la-matcher-ac.Plo")		 = 0 (0x0)
unlink("libclamav_la-matcher-bm.Plo")		 = 0 (0x0)
unlink("libclamav_la-matcher.Plo")		 = 0 (0x0)
unlink("libclamav_la-mbox.Plo")			 = 0 (0x0)
unlink("libclamav_la-message.Plo")		 = 0 (0x0)
unlink("libclamav_la-mew.Plo")			 = 0 (0x0)
unlink("libclamav_la-mpool.Plo")		 = 0 (0x0)
unlink("libclamav_la-msexpand.Plo")		 = 0 (0x0)
unlink("libclamav_la-mspack.Plo")		 = 0 (0x0)
unlink("libclamav_la-nulsft.Plo")		 = 0 (0x0)
unlink("libclamav_la-ole2_extract.Plo")		 = 0 (0x0)
unlink("libclamav_la-others.Plo")		 = 0 (0x0)
unlink("libclamav_la-packlibs.Plo")		 = 0 (0x0)
unlink("libclamav_la-pdf.Plo")			 = 0 (0x0)
unlink("libclamav_la-pe.Plo")			 = 0 (0x0)
unlink("libclamav_la-pe_icons.Plo")		 = 0 (0x0)
unlink("libclamav_la-perflogging.Plo")		 = 0 (0x0)
unlink("libclamav_la-petite.Plo")		 = 0 (0x0)
unlink("libclamav_la-phish_domaincheck_db.Plo")	 = 0 (0x0)
unlink("libclamav_la-phish_whitelist.Plo")	 = 0 (0x0)
unlink("libclamav_la-phishcheck.Plo")		 = 0 (0x0)
unlink("libclamav_la-readdb.Plo")		 = 0 (0x0)
unlink("libclamav_la-rebuildpe.Plo")		 = 0 (0x0)
unlink("libclamav_la-regex_list.Plo")		 = 0 (0x0)
unlink("libclamav_la-regex_suffix.Plo")		 = 0 (0x0)
unlink("libclamav_la-rtf.Plo")			 = 0 (0x0)
unlink("libclamav_la-scanners.Plo")		 = 0 (0x0)
unlink("libclamav_la-sha1.Plo")			 = 0 (0x0)
unlink("libclamav_la-sha256.Plo")		 = 0 (0x0)
unlink("libclamav_la-sis.Plo")			 = 0 (0x0)
unlink("libclamav_la-special.Plo")		 = 0 (0x0)
unlink("libclamav_la-spin.Plo")			 = 0 (0x0)
unlink("libclamav_la-table.Plo")		 = 0 (0x0)
unlink("libclamav_la-text.Plo")			 = 0 (0x0)
unlink("libclamav_la-textdet.Plo")		 = 0 (0x0)
unlink("libclamav_la-textnorm.Plo")		 = 0 (0x0)
unlink("libclamav_la-tnef.Plo")			 = 0 (0x0)
unlink("libclamav_la-unarj.Plo")		 = 0 (0x0)
unlink("libclamav_la-uniq.Plo")			 = 0 (0x0)
unlink("libclamav_la-unsp.Plo")			 = 0 (0x0)
unlink("libclamav_la-untar.Plo")		 = 0 (0x0)
unlink("libclamav_la-unzip.Plo")		 = 0 (0x0)
unlink("libclamav_la-upack.Plo")		 = 0 (0x0)
unlink("libclamav_la-upx.Plo")			 = 0 (0x0)
unlink("libclamav_la-uuencode.Plo")		 = 0 (0x0)
unlink("libclamav_la-vba_extract.Plo")		 = 0 (0x0)
unlink("libclamav_la-version.Plo")		 = 0 (0x0)
unlink("libclamav_la-wwunpack.Plo")		 = 0 (0x0)
unlink("libclamav_la-yc.Plo")			 = 0 (0x0)
unlink("unrar.Plo")				 = 0 (0x0)
unlink("unrar15.Plo")				 = 0 (0x0)
unlink("unrar20.Plo")				 = 0 (0x0)
unlink("unrar_iface.Plo")			 = 0 (0x0)
unlink("unrarcmd.Plo")				 = 0 (0x0)
unlink("unrarfilter.Plo")			 = 0 (0x0)
unlink("unrarhlp.Plo")				 = 0 (0x0)
unlink("unrarppm.Plo")				 = 0 (0x0)
unlink("unrarvm.Plo")				 = 0 (0x0)
fchdir(0x3,0x5035c0,0x80090b200,0x5036c0,0x5036c0,0x0) = 0 (0x0)
rmdir(0x80090b200,0x5035c0,0x80090b200,0x5036c0,0x5036c0,0x0) = 0 (0x0)
fchdir(0x3,0x5035c0,0x5036c0,0x5036c0,0x5036c0,0x0) = 0 (0x0)
close(3)					 = 0 (0x0)
sigprocmask(SIG_BLOCK,SIGHUP|SIGINT|SIGQUIT|SIGKILL|SIGPIPE|SIGALRM|SIGTERM|SIGURG|SIGSTOP|SIGTSTP|SIGCONT|SIGCHLD|SIGTTIN|SIGTTOU|SIGIO|SIGXCPU|SIGXFSZ|SIGVTALRM|SIGPROF|SIGWINCH|SIGINFO|SIGUSR1|SIGUSR2,0x0)
= 0 (0x0)
sigprocmask(SIG_SETMASK,0x0,0x0)		 = 0 (0x0)
sigprocmask(SIG_BLOCK,SIGHUP|SIGINT|SIGQUIT|SIGKILL|SIGPIPE|SIGALRM|SIGTERM|SIGURG|SIGSTOP|SIGTSTP|SIGCONT|SIGCHLD|SIGTTIN|SIGTTOU|SIGIO|SIGXCPU|SIGXFSZ|SIGVTALRM|SIGPROF|SIGWINCH|SIGINFO|SIGUSR1|SIGUSR2,0x0)
= 0 (0x0)
sigprocmask(SIG_SETMASK,0x0,0x0)		 = 0 (0x0)
process exit, rval = 0

Best regards,
--Edwin
