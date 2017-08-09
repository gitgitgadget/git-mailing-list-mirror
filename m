Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4D0A1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 18:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbdHISK2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 14:10:28 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:53607 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752718AbdHISKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 14:10:25 -0400
X-Greylist: delayed 1850 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Aug 2017 14:10:25 EDT
Received: from hopa.kiewit.dartmouth.edu ([129.170.31.166] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dfUxB-0003u7-MI
        for git@vger.kernel.org; Wed, 09 Aug 2017 13:39:35 -0400
Date:   Wed, 9 Aug 2017 13:39:28 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 129.170.31.166
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: fatal: Out of memory, getdelim failed  under NFS mounts
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git gurus,

More context (may be different issue(s)) could be found at 
http://git-annex.branchable.com/forum/git-annex_add_out_of_memory_error/
but currently I am consistently reproducing it while running 
git (1:2.11.0-3 debian stretch build) within debian stretch singularity
environment [1].  

External system is Centos 6.9, and git 1.7.1 (and installed in modules
2.0.4) do not show similar buggy behavior.

NFS mounted partitions are bind mounted inside the sinularity space and
when I try to do some git operations, I get that error inconsistently , e.g.

	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
	fatal: Out of memory, getdelim failed
	error: git://github.com/datalad/datalad did not send all necessary objects

	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
	fatal: Out of memory, getdelim failed
	error: git://github.com/datalad/datalad did not send all necessary objects

	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
	From git://github.com/datalad/datalad
	 * branch              master     -> FETCH_HEAD
	fatal: Out of memory, getdelim failed

and some times it succeeds.  So it smells that some race condition
somewhere...?

any recommendations on how to pin point the "offender"? ;)  Here is the
trailer of one of the straced calls:

...
[pid 19713] getcwd("/ihome/yhalchen/datalad", 129) = 24
[pid 19713] stat(".git", {st_mode=S_IFDIR|0755, st_size=322, ...}) = 0
[pid 19713] lstat(".git/HEAD", {st_mode=S_IFREG|0644, st_size=41, ...}) = 0
[pid 19713] open(".git/HEAD", O_RDONLY) = 3
[pid 19713] read(3, "39f80454d31cfb691b006302b1f29dee"..., 255) = 41
[pid 19713] read(3, "", 214)            = 0
[pid 19713] close(3)                    = 0
[pid 19713] lstat(".git/commondir", 0x7ffc1a571190) = -1 ENOENT (No such file or directory)
[pid 19713] access(".git/objects", X_OK) = 0
[pid 19713] access(".git/refs", X_OK)   = 0
[pid 19713] lstat(".git/commondir", 0x7ffc1a571120) = -1 ENOENT (No such file or directory)
[pid 19713] open(".git/config", O_RDONLY) = 3
[pid 19713] fstat(3, {st_mode=S_IFREG|0644, st_size=257, ...}) = 0
[pid 19713] mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ba7894e7000
[pid 19713] read(3, "[core]\n\trepositoryformatversion "..., 524288) = 257
[pid 19713] read(3, "", 524288)         = 0
[pid 19713] close(3)                    = 0
[pid 19713] munmap(0x2ba7894e7000, 528384) = 0
[pid 19713] stat(".", {st_mode=S_IFDIR|0755, st_size=907, ...}) = 0
[pid 19713] getcwd("/ihome/yhalchen/datalad", 129) = 24
[pid 19713] chdir(".")                  = 0
[pid 19713] getcwd("/ihome/yhalchen/datalad", 130) = 24
[pid 19713] lstat("/ihome/yhalchen/datalad", {st_mode=S_IFDIR|0755, st_size=907, ...}) = 0
[pid 19713] chdir("/ihome/yhalchen/datalad") = 0
[pid 19713] stat(".git", {st_mode=S_IFDIR|0755, st_size=322, ...}) = 0
[pid 19713] lstat(".git/commondir", 0x7ffc1a571140) = -1 ENOENT (No such file or directory)
[pid 19713] access("/etc/gitconfig", R_OK) = -1 ENOENT (No such file or directory)
[pid 19713] access("/ihome/yhalchen/.config/git/config", R_OK) = -1 ENOENT (No such file or directory)
[pid 19713] access("/ihome/yhalchen/.gitconfig", R_OK) = -1 ENOENT (No such file or directory)
[pid 19713] access(".git/config", R_OK) = 0
[pid 19713] open(".git/config", O_RDONLY) = 3
[pid 19713] fstat(3, {st_mode=S_IFREG|0644, st_size=257, ...}) = 0
[pid 19713] brk(0x2ba78afea000)         = 0x2ba78afea000
[pid 19713] read(3, "[core]\n\trepositoryformatversion "..., 524288) = 257
[pid 19713] read(3, "", 524288)         = 0
[pid 19713] close(3)                    = 0
[pid 19713] access("/etc/gitconfig", R_OK) = -1 ENOENT (No such file or directory)
[pid 19713] access("/ihome/yhalchen/.config/git/config", R_OK) = -1 ENOENT (No such file or directory)
[pid 19713] access("/ihome/yhalchen/.gitconfig", R_OK) = -1 ENOENT (No such file or directory)
[pid 19713] access(".git/config", R_OK) = 0
[pid 19713] open(".git/config", O_RDONLY) = 3
[pid 19713] fstat(3, {st_mode=S_IFREG|0644, st_size=257, ...}) = 0
[pid 19713] read(3, "[core]\n\trepositoryformatversion "..., 524288) = 257
[pid 19713] read(3, "", 524288)         = 0
[pid 19713] close(3)                    = 0
[pid 19713] open(".git/objects/pack", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
[pid 19713] fstat(3, {st_mode=S_IFDIR|0755, st_size=270, ...}) = 0
[pid 19713] getdents(3, /* 6 entries */, 524288) = 336
[pid 19713] access(".git/objects/pack/pack-fd9e70075570d8ec41f12605852f54f1cb9771a8.keep", F_OK) = -1 ENOENT (No such file or directory)
[pid 19713] stat(".git/objects/pack/pack-fd9e70075570d8ec41f12605852f54f1cb9771a8.pack", {st_mode=S_IFREG|0444, st_size=10019975, ...}) = 0
[pid 19713] access(".git/objects/pack/pack-f1fc124e3aa1619d65a6ba56219f84871a762775.keep", F_OK) = -1 ENOENT (No such file or directory)
[pid 19713] stat(".git/objects/pack/pack-f1fc124e3aa1619d65a6ba56219f84871a762775.pack", {st_mode=S_IFREG|0444, st_size=610330, ...}) = 0
[pid 19713] getdents(3, /* 0 entries */, 524288) = 0
[pid 19713] close(3)                    = 0
[pid 19713] getcwd("/ihome/yhalchen/datalad", 129) = 24
[pid 19713] open(".git/objects/info/alternates", O_RDONLY|O_NOATIME|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 19713] open(".git/objects/17", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
[pid 19713] fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 17), ...}) = 0
[pid 19713] close(1)                    = 0
[pid 19713] exit_group(0)               = ?
[pid 19713] +++ exited with 0 +++
[pid 19710] <... wait4 resumed> [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 19713
[pid 19710] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=19713, si_uid=14076, si_status=0, si_utime=0, si_stime=0} ---
[pid 19710] exit_group(1)               = ?
[pid 19710] +++ exited with 1 +++
<... wait4 resumed> [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0, NULL) = 19710
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=19710, si_uid=14076, si_status=1, si_utime=0, si_stime=2} ---
exit_group(1)                           = ?
+++ exited with 1 +++


PS please CC me in replies! Thanks in advance

[1] http://datasets.datalad.org/singularity/neurodebian-v2.1.img.tgz
it is a tarball to extract/run with , I promise I did no evil in there ;)

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
