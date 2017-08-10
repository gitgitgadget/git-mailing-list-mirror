Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AECFE208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 14:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbdHJOnP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 10 Aug 2017 10:43:15 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:36885 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbdHJOnO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 10:43:14 -0400
Received: from hopa.kiewit.dartmouth.edu ([129.170.31.166] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dfog3-0005jn-6i
        for git@vger.kernel.org; Thu, 10 Aug 2017 10:43:13 -0400
Date:   Thu, 10 Aug 2017 10:43:06 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170810144305.5d4lcx6oubkemsss@hopa.kiewit.dartmouth.edu>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 129.170.31.166
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: fatal: Out of memory, getdelim failed under NFS mounts
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you René!  comments/answers embedded below

On Thu, 10 Aug 2017, René Scharfe wrote:

> Am 09.08.2017 um 19:39 schrieb Yaroslav Halchenko:
> > More context (may be different issue(s)) could be found at
> > http://git-annex.branchable.com/forum/git-annex_add_out_of_memory_error/
> > but currently I am consistently reproducing it while running
> > git (1:2.11.0-3 debian stretch build) within debian stretch singularity
> > environment [1].

> > External system is Centos 6.9, and git 1.7.1 (and installed in modules
> > 2.0.4) do not show similar buggy behavior.

> > NFS mounted partitions are bind mounted inside the sinularity space and
> > when I try to do some git operations, I get that error inconsistently , e.g.

> > 	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
> > 	fatal: Out of memory, getdelim failed
> > 	error: git://github.com/datalad/datalad did not send all necessary objects

> > 	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
> > 	fatal: Out of memory, getdelim failed
> > 	error: git://github.com/datalad/datalad did not send all necessary objects

> > 	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
> > 	From git://github.com/datalad/datalad
> > 	 * branch              master     -> FETCH_HEAD
> > 	fatal: Out of memory, getdelim failed

> > and some times it succeeds.  So it smells that some race condition
> > somewhere...?

> I doubt the type of file system matters.  

So far it has been a very consistent indicator.  I did not manage to get
this error while performing the same operation under /tmp (bind to local
mounted drive), where it also feels going faster (again suggesting that
original issue is some kind of a race)

> The questions are: How much
> main memory do you have, what is git trying to cram into it, is there
> a way to reduce the memory footprint or do you need to add more RAM?
> ... reordered ...
> "free" and "ulimit -a" can help you find out how much memory you can
> use.

I think those aren't the reason:

yhalchen@discovery:/mnt/scratch/yoh/datalad$ free -h
              total        used        free      shared  buff/cache   available
Mem:           126G        2.5G         90G        652K         33G        123G
Swap:          127G        1.7M        127G
yhalchen@discovery:/mnt/scratch/yoh/datalad$ ulimit
unlimited

> > any recommendations on how to pin point the "offender"? ;)
> Running "GIT_TRACE=1 git pull --ff-only origin master" would be a
> good start, I think, to find out which of the different activities
> that pull is doing causes the out-of-memory error.

samples of bad, and then good runs (from eyeballing -- the same until
error message):

yhalchen@discovery:/mnt/scratch/yoh$ cat git_trace_bad.log
14:05:25.782270 git.c:371               trace: built-in: git 'pull' '--ff-only' 'origin' 'master'
14:05:25.795036 run-command.c:350       trace: run_command: 'fetch' '--update-head-ok' 'origin' 'master'
14:05:25.795332 exec_cmd.c:116          trace: exec: 'git' 'fetch' '--update-head-ok' 'origin' 'master'
14:05:25.797212 git.c:371               trace: built-in: git 'fetch' '--update-head-ok' 'origin' 'master'
14:05:25.904088 run-command.c:350       trace: run_command: 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
14:05:26.085954 run-command.c:350       trace: run_command: 'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 11652 on discovery.hpcc.dartmouth.edu' '--pack_header=2,103'
14:05:26.086333 exec_cmd.c:116          trace: exec: 'git' 'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 11652 on discovery.hpcc.dartmouth.edu' '--pack_header=2,103'
14:05:26.088382 git.c:371               trace: built-in: git 'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 11652 on discovery.hpcc.dartmouth.edu' '--pack_header=2,103'
14:05:26.133326 run-command.c:350       trace: run_command: 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
14:05:26.133688 exec_cmd.c:116          trace: exec: 'git' 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
14:05:26.135493 git.c:371               trace: built-in: git 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
fatal: Out of memory, getdelim failed
error: git://github.com/datalad/datalad did not send all necessary objects

14:05:26.138838 run-command.c:350       trace: run_command: 'gc' '--auto'
14:05:26.139131 exec_cmd.c:116          trace: exec: 'git' 'gc' '--auto'
14:05:26.141108 git.c:371               trace: built-in: git 'gc' '--auto'


yhalchen@discovery:/mnt/scratch/yoh$ cat git_trace_good.log
14:05:37.851862 git.c:371               trace: built-in: git 'pull' '--ff-only' 'origin' 'master'
14:05:37.854250 run-command.c:350       trace: run_command: 'fetch' '--update-head-ok' 'origin' 'master'
14:05:37.854527 exec_cmd.c:116          trace: exec: 'git' 'fetch' '--update-head-ok' 'origin' 'master'
14:05:37.856389 git.c:371               trace: built-in: git 'fetch' '--update-head-ok' 'origin' 'master'
14:05:37.954099 run-command.c:350       trace: run_command: 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
14:05:38.118652 run-command.c:350       trace: run_command: 'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 11688 on discovery.hpcc.dartmouth.edu' '--pack_header=2,103'
14:05:38.119011 exec_cmd.c:116          trace: exec: 'git' 'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 11688 on discovery.hpcc.dartmouth.edu' '--pack_header=2,103'
14:05:38.120924 git.c:371               trace: built-in: git 'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 11688 on discovery.hpcc.dartmouth.edu' '--pack_header=2,103'
14:05:38.167508 run-command.c:350       trace: run_command: 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
14:05:38.167851 exec_cmd.c:116          trace: exec: 'git' 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
14:05:38.169726 git.c:371               trace: built-in: git 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
From git://github.com/datalad/datalad
 * branch              master     -> FETCH_HEAD
   39f80454..1f90ef47  master     -> origin/master
14:05:38.306113 run-command.c:1130      run_processes_parallel: preparing to run up to 1 tasks
14:05:38.306148 run-command.c:1162      run_processes_parallel: done
14:05:38.306313 run-command.c:350       trace: run_command: 'gc' '--auto'
14:05:38.306616 exec_cmd.c:116          trace: exec: 'git' 'gc' '--auto'
14:05:38.308598 git.c:371               trace: built-in: git 'gc' '--auto'
14:05:38.311380 run-command.c:350       trace: run_command: 'merge' '--ff-only' 'FETCH_HEAD'
14:05:38.311645 exec_cmd.c:116          trace: exec: 'git' 'merge' '--ff-only' 'FETCH_HEAD'
14:05:38.313384 git.c:371               trace: built-in: git 'merge' '--ff-only' 'FETCH_HEAD'
14:05:45.092247 run-command.c:350       trace: run_command: 'gc' '--auto'
Updating 39f80454..1f90ef47
Fast-forward
14:05:45.092620 exec_cmd.c:116          trace: exec: 'git' 'gc' '--auto'
14:05:45.095862 git.c:371               trace: built-in: git 'gc' '--auto'


> Also: What does "wc -L .git/FETCH_HEAD .git/packed-refs" report?

"varying" and not consistent with causing an error (first trials, where I
did not cat .git/FETCH_HEAD kinda suggested differently):

yhalchen@discovery:/mnt/scratch/yoh/datalad$ cat .git/FETCH_HEAD; wc -L .git/FETCH_HEAD .git/packed-refs; git pull --ff-only origin master
1f90ef474ee200befea19ba77242fa44f16739f0                branch 'master' of git://github.com/datalad/datalad
 107 .git/FETCH_HEAD
  90 .git/packed-refs
 107 total
From git://github.com/datalad/datalad
 * branch              master     -> FETCH_HEAD
Already up-to-date.
yhalchen@discovery:/mnt/scratch/yoh/datalad$ cat .git/FETCH_HEAD; wc -L .git/FETCH_HEAD .git/packed-refs; git pull --ff-only origin master 
1f90ef474ee200befea19ba77242fa44f16739f0                branch 'master' of git://github.com/datalad/datalad
 107 .git/FETCH_HEAD
  90 .git/packed-refs
 107 total
fatal: Out of memory, getdelim failed
error: git://github.com/datalad/datalad did not send all necessary objects

yhalchen@discovery:/mnt/scratch/yoh/datalad$ cat .git/FETCH_HEAD; wc -L .git/FETCH_HEAD .git/packed-refs; git pull --ff-only origin master 
   0 .git/FETCH_HEAD
  90 .git/packed-refs
  90 total
fatal: Out of memory, getdelim failed
error: git://github.com/datalad/datalad did not send all necessary objects

yhalchen@discovery:/mnt/scratch/yoh/datalad$ cat .git/FETCH_HEAD; wc -L .git/FETCH_HEAD .git/packed-refs; git pull --ff-only origin master 
   0 .git/FETCH_HEAD
  90 .git/packed-refs
  90 total
fatal: Out of memory, getdelim failed
error: git://github.com/datalad/datalad did not send all necessary objects

yhalchen@discovery:/mnt/scratch/yoh/datalad$ cat .git/FETCH_HEAD; wc -L .git/FETCH_HEAD .git/packed-refs; git pull --ff-only origin master 
   0 .git/FETCH_HEAD
  90 .git/packed-refs
  90 total
From git://github.com/datalad/datalad
 * branch              master     -> FETCH_HEAD
Already up-to-date.


> getdelim() is used mostly to read lines from files like these and in
> the admittedly unlikely case that they are *really* long such an
> error would be expected.

packed-ref pointer seems to also relate to the strace output around the
point of message:

[pid 12843] open(".git/packed-refs", O_RDONLY) = 3
[pid 12843] fstat(3, {st_mode=S_IFREG|0644, st_size=5042, ...}) = 0
[pid 12843] fstat(3, {st_mode=S_IFREG|0644, st_size=5042, ...}) = 0
[pid 12843] brk(0x2b5704317000)         = 0x2b5704276000
[pid 12843] mmap(NULL, 1048576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b570451d000
[pid 12843] read(3, "# pack-refs with: peeled fully-p"..., 524288) = 5042
[pid 12843] read(3, "", 524288)         = 0
[pid 12843] fstat(2, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid 12843] write(2, "fatal: Out of memory, getdelim f"..., 38fatal: Out of memory, getdelim failed
) = 38
[pid 12843] lseek(0, -41, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
[pid 12843] exit_group(128)             = ?


I verified that content of that packed-refs didn't change between good and bad
runs.

NB is there a diff which could be given regexes within a line to ignore
in diffs in so we could still retain original lines, i.e. answer to
https://stackoverflow.com/questions/15841223/diff-while-ignoring-patterns-within-a-line-but-not-the-entire-line
?

FWIW -- here is a diff (from good to bad run) of strace (with pid/address
info changed to stay the same for comparisons):

@@ -3121,6 +3118,7 @@
 [pid YYYYY] close(3)                    = 0
 [pid YYYYY] brk(NULL)                   = 0xXXXXX
 [pid YYYYY] brk(0xXXXXX)         = 0xXXXXX
+[pid YYYYY] mmap(NULL, 1048576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xXXXXX
 [pid YYYYY] open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
 [pid YYYYY] open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
 [pid YYYYY] open("/usr/lib/locale/en_US/LC_MESSAGES", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
@@ -3144,11 +3142,9 @@
 [pid YYYYY] lstat(".git/commondir", 0xXXXXX) = -1 ENOENT (No such file or directory)
 [pid YYYYY] open(".git/config", O_RDONLY) = 3
 [pid YYYYY] fstat(3, {st_mode=S_IFREG|0644, st_size=257, ...}) = 0
-[pid YYYYY] mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xXXXXX
 [pid YYYYY] read(3, "[core]\n\trepositoryformatversion "..., 524288) = 257
 [pid YYYYY] read(3, "", 524288)         = 0
 [pid YYYYY] close(3)                    = 0
-[pid YYYYY] munmap(0xXXXXX, 528384) = 0
 [pid YYYYY] stat(".", {st_mode=S_IFDIR|0755, st_size=907, ...}) = 0
 [pid YYYYY] getcwd("/mnt/scratch/yoh/datalad", 129) = 25
 [pid YYYYY] chdir(".")                  = 0
@@ -3163,7 +3159,6 @@
 [pid YYYYY] access(".git/config", R_OK) = 0
 [pid YYYYY] open(".git/config", O_RDONLY) = 3
 [pid YYYYY] fstat(3, {st_mode=S_IFREG|0644, st_size=257, ...}) = 0
-[pid YYYYY] brk(0xXXXXX)         = 0xXXXXX
 [pid YYYYY] read(3, "[core]\n\trepositoryformatversion "..., 524288) = 257
 [pid YYYYY] read(3, "", 524288)         = 0
 [pid YYYYY] close(3)                    = 0
@@ -3180,245 +3175,48 @@
 [pid YYYYY] read(0, "1f90ef474ee200befea19ba77242fa44"..., 4096) = 82
 [pid YYYYY] open(".git/refs/", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
 [pid YYYYY] fstat(3, {st_mode=S_IFDIR|0755, st_size=70, ...}) = 0
-[pid YYYYY] brk(0xXXXXX)         = 0xXXXXX
+[pid YYYYY] mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xXXXXX
 [pid YYYYY] getdents(3, /* 5 entries */, 524288) = 136
 [pid YYYYY] stat(".git/refs/heads", {st_mode=S_IFDIR|0755, st_size=24, ...}) = 0
 [pid YYYYY] stat(".git/refs/remotes", {st_mode=S_IFDIR|0755, st_size=24, ...}) = 0
 [pid YYYYY] stat(".git/refs/tags", {st_mode=S_IFDIR|0755, st_size=47, ...}) = 0
 [pid YYYYY] getdents(3, /* 0 entries */, 524288) = 0
+[pid YYYYY] munmap(0xXXXXX, 528384) = 0
 [pid YYYYY] close(3)                    = 0
 [pid YYYYY] open(".git/refs/bisect", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
 [pid YYYYY] open(".git/packed-refs", O_RDONLY) = 3
 [pid YYYYY] fstat(3, {st_mode=S_IFREG|0644, st_size=5042, ...}) = 0
 [pid YYYYY] fstat(3, {st_mode=S_IFREG|0644, st_size=5042, ...}) = 0
-[pid YYYYY] read(3, "# pack-refs with: peeled fully-p"..., 524288) = 5042
-[pid YYYYY] read(3, "", 524288)         = 0
-[pid YYYYY] close(3)                    = 0
-[pid YYYYY] open(".git/objects/pack", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
-[pid YYYYY] fstat(3, {st_mode=S_IFDIR|0755, st_size=405, ...}) = 0
-[pid YYYYY] getdents(3, /* 8 entries */, 524288) = 480
-[pid YYYYY] access(".git/objects/pack/pack-a5ed9c83e2a39b21a2ab12dc351d2a7513d76e48.keep", F_OK) = -1 ENOENT (No such file or directory)
-[pid YYYYY] stat(".git/objects/pack/pack-a5ed9c83e2a39b21a2ab12dc351d2a7513d76e48.pack", {st_mode=S_IFREG|0444, st_size=124835, ...}) = 0
-[pid YYYYY] access(".git/objects/pack/pack-fd9e70075570d8ec41f12605852f54f1cb9771a8.keep", F_OK) = -1 ENOENT (No such file or directory)
-[pid YYYYY] stat(".git/objects/pack/pack-fd9e70075570d8ec41f12605852f54f1cb9771a8.pack", {st_mode=S_IFREG|0444, st_size=10019975, ...}) = 0
-[pid YYYYY] access(".git/objects/pack/pack-f1fc124e3aa1619d65a6ba56219f84871a762775.keep", F_OK) = -1 ENOENT (No such file or directory)
-[pid YYYYY] stat(".git/objects/pack/pack-f1fc124e3aa1619d65a6ba56219f84871a762775.pack", {st_mode=S_IFREG|0444, st_size=610330, ...}) = 0




-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
