Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F754735
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532005; cv=none; b=o8rjbOr15RqiiwU25W8cI3j5SWj8JzyHEDHUlixCvM6uUZXU1MPmXHU5rzJIW2HTTNoLUJ7h6Z69a7BNKGyZZELvrNhWwgHsvgPo4jzLpmfaBnOGLSOxZjHQiX0xSb5Q73x+5Jvdjt0aeu2zxW4WC9IX+CQ6GfjTujbLuLIFqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532005; c=relaxed/simple;
	bh=UGgr88uNTEWGAOv7xOyQk7l8H9bDEH+eOl/3qpkSe10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7BGCDgTJvcov3Svaj4F65GxUZv5rwuSva7ivJ4zpq3vc98T04p0F/RKaD+vAoqUgm/Y6VDgont6//S4yAnAIxT90AcXQamRVq8OmkZuKlI9Pg1iOwXmsGnLCQBynQCfzgT18Cd9ccbmwqw7ra+SEtWdQXXLunTP+Cx7XDFpTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVg-0000000028v-1McC
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:33 +0100
Received: from [10.20.10.233] (port=25356 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVf-006ahr-0a;
	Fri, 15 Mar 2024 20:46:31 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id D3B901800FD;
	Fri, 15 Mar 2024 20:46:29 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:29 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Elijah Newren <newren@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 00/22] avoid redundant pipelines
Date: Fri, 15 Mar 2024 20:45:57 +0100
Message-ID: <20240315194620.10713-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305212533.12947-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

As follow-up to [1], here's a series that eliminates redundant
pipelines, mostly under t/.

Spawning a process is notoriously slow on Windows, so this will improve
test performance.

1/22 to 14/22 remove redundant uses of "cat" where the shell handles
input redirection from a file or the command can take a file argument.

15/22 to 20/22 merge redundant uses of "grep" into the following "sed"
or "awk" command. Both of these are capable of filtering themselves.

21/22 merges multiple "sed" calls into one and replaces a whole "cat |
grep | awk" construct with a single "awk" call and uses "sort -u"
instead of "sort | uniq".

22/22 finally is a bit of an outlier in that it replaces a subshell with
a shell compound command.

In the tests, I have completely arbitrarily separated the commits into
thousands blocks to keep the commits and their reviews manageable.

All tests that I was able to run still pass. I don't have p4 or cvs
installed.

[1] https://lore.kernel.org/git/20240216171046.927552-1-dev+git@drbeat.li/


Changes from v1 (see also the range-diff below):

- 09/22: leave a "cat" that concatenates two files as input to "git am"

- 14/22: replace all instances of

      cat >expect.unsorted <<... && sort expect.unsorted >expect

  with

      "sort >expect <<..."

- 19/22: avoid "sed -E" (use extended regex syntax) which may not be
  supported on each platform with equivalent basic regexes

Beat Bolli (22):
  doc: avoid redundant use of cat
  contrib/subtree/t: avoid redundant use of cat
  t/lib-cvs.sh: avoid redundant use of cat
  t/annotate-tests.sh: avoid redundant use of cat
  t/perf: avoid redundant use of cat
  t/t0*: avoid redundant uses of cat
  t/t1*: avoid redundant uses of cat
  t/t3*: avoid redundant uses of cat
  t/t4*: avoid redundant uses of cat
  t/t5*: avoid redundant uses of cat
  t/t6*: avoid redundant uses of cat
  t/t7*: avoid redundant use of cat
  t/t8*: avoid redundant use of cat
  t/t9*: avoid redundant uses of cat
  t/t1*: merge a "grep | sed" pipeline
  t/t3*: merge a "grep | awk" pipeline
  t/t4*: merge a "grep | sed" pipeline
  t/t5*: merge a "grep | sed" pipeline
  t/t8*: merge "grep | sed" pipelines
  t/t9*: merge "grep | sed" pipelines
  contrib/coverage-diff: avoid redundant pipelines
  git-quiltimport: avoid an unnecessary subshell

 Documentation/howto/update-hook-example.txt |  4 +--
 contrib/coverage-diff.sh                    |  9 ++----
 contrib/subtree/t/t7900-subtree.sh          |  2 +-
 git-quiltimport.sh                          |  2 +-
 t/annotate-tests.sh                         |  2 +-
 t/lib-cvs.sh                                |  4 +--
 t/perf/repos/inflate-repo.sh                |  2 +-
 t/t0002-gitfile.sh                          |  2 +-
 t/t0011-hashmap.sh                          |  2 +-
 t/t0028-working-tree-encoding.sh            |  4 +--
 t/t0204-gettext-reencode-sanity.sh          |  2 +-
 t/t1007-hash-object.sh                      |  6 ++--
 t/t1091-sparse-checkout-builtin.sh          |  2 +-
 t/t1509/prepare-chroot.sh                   |  2 +-
 t/t3200-branch.sh                           |  2 +-
 t/t3321-notes-stripspace.sh                 |  8 ++---
 t/t3920-crlf-messages.sh                    |  4 +--
 t/t4002-diff-basic.sh                       |  2 +-
 t/t4020-diff-external.sh                    |  2 +-
 t/t4205-log-pretty-formats.sh               |  2 +-
 t/t4301-merge-tree-write-tree.sh            |  8 ++---
 t/t5100-mailinfo.sh                         |  2 +-
 t/t5317-pack-objects-filter-objects.sh      |  2 +-
 t/t5401-update-hooks.sh                     |  2 +-
 t/t5534-push-signed.sh                      |  2 +-
 t/t6112-rev-list-filters-objects.sh         |  2 +-
 t/t6413-merge-crlf.sh                       |  4 +--
 t/t7704-repack-cruft.sh                     |  2 +-
 t/t8010-cat-file-filters.sh                 |  2 +-
 t/t8013-blame-ignore-revs.sh                | 28 ++++++++---------
 t/t9118-git-svn-funky-branch-names.sh       |  2 +-
 t/t9300-fast-import.sh                      | 14 +++------
 t/t9350-fast-export.sh                      |  4 +--
 t/t9400-git-cvsserver-server.sh             | 35 ++++++++++-----------
 t/t9802-git-p4-filetype.sh                  |  2 +-
 t/t9807-git-p4-submit.sh                    |  2 +-
 t/t9824-git-p4-git-lfs.sh                   |  4 +--
 37 files changed, 85 insertions(+), 97 deletions(-)

Range-diff from v1:

 1:  270f19b35e36 =  1:  270f19b35e36 doc: avoid redundant use of cat
 2:  eed1fc58a7e4 =  2:  eed1fc58a7e4 contrib/subtree/t: avoid redundant use of cat
 3:  c131707668ac =  3:  c131707668ac t/lib-cvs.sh: avoid redundant use of cat
 4:  da69f859de63 =  4:  da69f859de63 t/annotate-tests.sh: avoid redundant use of cat
 5:  07b3bf33577f =  5:  07b3bf33577f t/perf: avoid redundant use of cat
 6:  38907650b33e =  6:  38907650b33e t/t0*: avoid redundant uses of cat
 7:  b8b8b7ae47a6 =  7:  b8b8b7ae47a6 t/t1*: avoid redundant uses of cat
 8:  7c91c4092e7d =  8:  7c91c4092e7d t/t3*: avoid redundant uses of cat
 9:  3c9df39774d8 !  9:  1a80eaa97169 t/t4*: avoid redundant uses of cat
    @@ t/t4020-diff-external.sh: keep_only_cr () {
      
      test_expect_success 'diff --cached' '
     
    - ## t/t4150-am.sh ##
    -@@ t/t4150-am.sh: test_expect_success 'am takes patches from a Pine mailbox' '
    - 	rm -fr .git/rebase-apply &&
    - 	git reset --hard &&
    - 	git checkout first &&
    --	cat pine patch1 | git am &&
    -+	git am pine patch1 &&
    - 	test_path_is_missing .git/rebase-apply &&
    - 	git diff --exit-code main^..HEAD
    - '
    -
      ## t/t4205-log-pretty-formats.sh ##
     @@ t/t4205-log-pretty-formats.sh: test_expect_success 'NUL termination with --reflog --pretty=oneline' '
      	for r in $revs
10:  a3207b26a80e = 10:  3ac01bbcaafa t/t5*: avoid redundant uses of cat
11:  bde50bfd2552 = 11:  a4a6aaf4654b t/t6*: avoid redundant uses of cat
12:  84978c31631f = 12:  4b7b9df129a3 t/t7*: avoid redundant use of cat
13:  a555a1809e84 = 13:  ebf1e5eeadbd t/t8*: avoid redundant use of cat
14:  667c04d6c665 ! 14:  34cf66aeff80 t/t9*: avoid redundant uses of cat
    @@ t/t9300-fast-import.sh: test_expect_success 'L: nested tree copy does not corrup
      	test_cmp expect actual &&
      	git fsck $(git rev-parse L2)
      '
    -@@ t/t9300-fast-import.sh: test_expect_success 'Q: verify first notes tree' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'Q: verify first notes commit' '
    + '
    + 
    + test_expect_success 'Q: verify first notes tree' '
    +-	cat >expect.unsorted <<-EOF &&
    ++	sort >expect <<-EOF &&
    + 	100644 blob $commit1
      	100644 blob $commit2
      	100644 blob $commit3
      	EOF
     -	cat expect.unsorted | sort >expect &&
    -+	sort expect.unsorted >expect &&
      	git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
      	test_cmp expect actual
      '
    -@@ t/t9300-fast-import.sh: test_expect_success 'Q: verify second notes tree' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'Q: verify second notes commit' '
    + '
    + 
    + test_expect_success 'Q: verify second notes tree' '
    +-	cat >expect.unsorted <<-EOF &&
    ++	sort >expect <<-EOF &&
    + 	100644 blob $commit1
      	100644 blob $commit2
      	100644 blob $commit3
      	EOF
     -	cat expect.unsorted | sort >expect &&
    -+	sort expect.unsorted >expect &&
      	git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
      	test_cmp expect actual
      '
    -@@ t/t9300-fast-import.sh: test_expect_success 'Q: verify third notes tree' '
    - 	cat >expect.unsorted <<-EOF &&
    +@@ t/t9300-fast-import.sh: test_expect_success 'Q: verify third notes commit' '
    + '
    + 
    + test_expect_success 'Q: verify third notes tree' '
    +-	cat >expect.unsorted <<-EOF &&
    ++	sort >expect <<-EOF &&
      	100644 blob $commit1
      	EOF
     -	cat expect.unsorted | sort >expect &&
    -+	sort expect.unsorted >expect &&
      	git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
      	test_cmp expect actual
      '
    -@@ t/t9300-fast-import.sh: test_expect_success 'Q: verify fourth notes tree' '
    - 	cat >expect.unsorted <<-EOF &&
    +@@ t/t9300-fast-import.sh: test_expect_success 'Q: verify fourth notes commit' '
    + '
    + 
    + test_expect_success 'Q: verify fourth notes tree' '
    +-	cat >expect.unsorted <<-EOF &&
    ++	sort >expect <<-EOF &&
      	100644 blob $commit2
      	EOF
     -	cat expect.unsorted | sort >expect &&
    -+	sort expect.unsorted >expect &&
      	git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
      	test_cmp expect actual
      '
15:  6dd79d30c42a = 15:  be300cb0a65a t/t1*: merge a "grep | sed" pipeline
16:  db61133fa92f = 16:  d6f5e21942ff t/t3*: merge a "grep | awk" pipeline
17:  5ce7ddeb2fbd = 17:  68a5f3f743d0 t/t4*: merge a "grep | sed" pipeline
18:  6ed68fe96493 = 18:  3a7e2a8fc388 t/t5*: merge a "grep | sed" pipeline
19:  698a5524b5c4 ! 19:  e6ec4b3a0451 t/t8*: merge "grep | sed" pipelines
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success setup '
      	git blame --line-porcelain file >blame_raw &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      	git rev-parse X >expect &&
      	test_cmp expect actual &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 2/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
      	git rev-parse X >expect &&
      	test_cmp expect actual
      '
    @@ t/t8013-blame-ignore-revs.sh: do
      		git blame --line-porcelain --ignore-rev $I file >blame_raw &&
      
     -		grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
    -+		sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
    ++		sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      		git rev-parse A >expect &&
      		test_cmp expect actual &&
      
     -		grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
    -+		sed -Ene "/^[0-9a-f]+ [0-9]+ 2/s/ .*//p" blame_raw >actual &&
    ++		sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
      		git rev-parse B >expect &&
      		test_cmp expect actual
      	'
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_rev_adding_unblamable_l
      	git blame --line-porcelain file --ignore-rev Y >blame_raw &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 3" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 3/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 3/s/ .*//p" blame_raw >actual &&
      	test_cmp expect actual &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 4" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 4/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 4/s/ .*//p" blame_raw >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_revs_from_files '
      	git blame --line-porcelain file --ignore-revs-file ignore_x --ignore-revs-file ignore_y >blame_raw &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      	git rev-parse A >expect &&
      	test_cmp expect actual &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 2/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
      	git rev-parse B >expect &&
      	test_cmp expect actual
      '
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_revs_from_configs_and_f
      	git blame --line-porcelain file --ignore-revs-file ignore_y >blame_raw &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      	git rev-parse A >expect &&
      	test_cmp expect actual &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 2/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
      	git rev-parse B >expect &&
      	test_cmp expect actual
      '
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success override_ignore_revs_file '
      	git rev-parse X >expect &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      	test_cmp expect actual &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 2/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
      	test_cmp expect actual
      	'
      test_expect_success bad_files_and_revs '
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_merge '
      	git blame --line-porcelain file --ignore-rev M >blame_raw &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      	git rev-parse B >expect &&
      	test_cmp expect actual &&
      
     -	grep -E "^[0-9a-f]+ [0-9]+ 9" blame_raw | sed -e "s/ .*//" >actual &&
    -+	sed -Ene "/^[0-9a-f]+ [0-9]+ 9/s/ .*//p" blame_raw >actual &&
    ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 9/s/ .*//p" blame_raw >actual &&
      	git rev-parse C >expect &&
      	test_cmp expect actual
      '
20:  6b3345667040 = 20:  4772acb80163 t/t9*: merge "grep | sed" pipelines
21:  1784d5f3fdc1 = 21:  a34653f91589 contrib/coverage-diff: avoid redundant pipelines
22:  4858de8ce44f = 22:  6c62dee0daa1 git-quiltimport: avoid an unnecessary subshell
-- 
2.44.0

From: Beat Bolli <dev+git@drbeat.li>

*** BLURB HERE ***

Beat Bolli (22):
  doc: avoid redundant use of cat
  contrib/subtree/t: avoid redundant use of cat
  t/lib-cvs.sh: avoid redundant use of cat
  t/annotate-tests.sh: avoid redundant use of cat
  t/perf: avoid redundant use of cat
  t/t0*: avoid redundant uses of cat
  t/t1*: avoid redundant uses of cat
  t/t3*: avoid redundant uses of cat
  t/t4*: avoid redundant uses of cat
  t/t5*: avoid redundant uses of cat
  t/t6*: avoid redundant uses of cat
  t/t7*: avoid redundant use of cat
  t/t8*: avoid redundant use of cat
  t/t9*: avoid redundant uses of cat
  t/t1*: merge a "grep | sed" pipeline
  t/t3*: merge a "grep | awk" pipeline
  t/t4*: merge a "grep | sed" pipeline
  t/t5*: merge a "grep | sed" pipeline
  t/t8*: merge "grep | sed" pipelines
  t/t9*: merge "grep | sed" pipelines
  contrib/coverage-diff: avoid redundant pipelines
  git-quiltimport: avoid an unnecessary subshell

 Documentation/howto/update-hook-example.txt |  4 +--
 contrib/coverage-diff.sh                    |  9 ++----
 contrib/subtree/t/t7900-subtree.sh          |  2 +-
 git-quiltimport.sh                          |  2 +-
 t/annotate-tests.sh                         |  2 +-
 t/lib-cvs.sh                                |  4 +--
 t/perf/repos/inflate-repo.sh                |  2 +-
 t/t0002-gitfile.sh                          |  2 +-
 t/t0011-hashmap.sh                          |  2 +-
 t/t0028-working-tree-encoding.sh            |  4 +--
 t/t0204-gettext-reencode-sanity.sh          |  2 +-
 t/t1007-hash-object.sh                      |  6 ++--
 t/t1091-sparse-checkout-builtin.sh          |  2 +-
 t/t1509/prepare-chroot.sh                   |  2 +-
 t/t3200-branch.sh                           |  2 +-
 t/t3321-notes-stripspace.sh                 |  8 ++---
 t/t3920-crlf-messages.sh                    |  4 +--
 t/t4002-diff-basic.sh                       |  2 +-
 t/t4020-diff-external.sh                    |  2 +-
 t/t4205-log-pretty-formats.sh               |  2 +-
 t/t4301-merge-tree-write-tree.sh            |  8 ++---
 t/t5100-mailinfo.sh                         |  2 +-
 t/t5317-pack-objects-filter-objects.sh      |  2 +-
 t/t5401-update-hooks.sh                     |  2 +-
 t/t5534-push-signed.sh                      |  2 +-
 t/t6112-rev-list-filters-objects.sh         |  2 +-
 t/t6413-merge-crlf.sh                       |  4 +--
 t/t7704-repack-cruft.sh                     |  2 +-
 t/t8010-cat-file-filters.sh                 |  2 +-
 t/t8013-blame-ignore-revs.sh                | 28 ++++++++---------
 t/t9118-git-svn-funky-branch-names.sh       |  2 +-
 t/t9300-fast-import.sh                      | 14 +++------
 t/t9350-fast-export.sh                      |  4 +--
 t/t9400-git-cvsserver-server.sh             | 35 ++++++++++-----------
 t/t9802-git-p4-filetype.sh                  |  2 +-
 t/t9807-git-p4-submit.sh                    |  2 +-
 t/t9824-git-p4-git-lfs.sh                   |  4 +--
 37 files changed, 85 insertions(+), 97 deletions(-)

-- 
2.44.0

