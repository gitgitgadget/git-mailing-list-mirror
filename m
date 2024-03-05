Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FA26AD0
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674129; cv=none; b=LUFlIhvIE05Q3MTmTz3Qjxh9bCzSLjukbFeGk4VoKWnJZt9Bla4sP+1lFFeY51lHHgqtvUjtZ7VK2ldhS0GqMXBjdGXSCk1gU/57GXMHUO2vYgwNmbMMjZrpX5JUVCewJHofl/avLqKIMfuspV7Eym1jQd/TBXSfS+dYgjHVZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674129; c=relaxed/simple;
	bh=m9Wgwfvor+cH/1vckG8HvoRHsntYHHdlCtbfEPoF8rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPO8YoQwjvdNjQ1qx9HnbPlN5KWSVvhY1XO1WMSu7+OhN9jZ0SbCehJQUmYEcNK4ZrFLonzq+l7RGqGG3FIUnmW5g8AySBGLHfNkWg30y4/HUnqGjAGHMdNy2rUZxmNu+spD6zClXdFesY2mDBWzGPpfnvDtoZzovctVsc1WjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIg-000000002Nk-0j5P
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:14 +0100
Received: from [10.20.10.230] (port=20122 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIf-006KUt-07;
	Tue, 05 Mar 2024 22:26:13 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 86F48180036;
	Tue,  5 Mar 2024 22:26:11 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:11 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Elijah Newren <newren@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 00/22] avoid redundant pipelines
Date: Tue,  5 Mar 2024 22:24:59 +0100
Message-ID: <20240305212533.12947-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
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
or "awk" command. Both of these are capable of filtering themselves. I'm
a bit on the fence about this part because readability suffers in some
cases. It was a fun exercise, though :-)

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
 t/t4150-am.sh                               |  2 +-
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
 t/t9300-fast-import.sh                      | 10 +++---
 t/t9350-fast-export.sh                      |  4 +--
 t/t9400-git-cvsserver-server.sh             | 35 ++++++++++-----------
 t/t9802-git-p4-filetype.sh                  |  2 +-
 t/t9807-git-p4-submit.sh                    |  2 +-
 t/t9824-git-p4-git-lfs.sh                   |  4 +--
 38 files changed, 86 insertions(+), 94 deletions(-)

-- 
2.44.0

