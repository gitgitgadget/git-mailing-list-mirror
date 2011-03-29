From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] t9012-svn-fi: Add tests for svn-fi
Date: Tue, 29 Mar 2011 23:43:12 +0530
Message-ID: <1301422392-21177-6-git-send-email-artagnon@gmail.com>
References: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Cc: Peter Baumann <waste.manager@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:15:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dRp-0000lU-6r
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab1C2SPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:15:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35826 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1C2SPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:15:06 -0400
Received: by mail-gy0-f174.google.com with SMTP id 10so187404gyd.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=xDLblhkSrUuGZ/FVwgT+CmhgEur27e7IUyXxPHtBGrE=;
        b=XK2uqTqpZHDXxKCv3uYBcou5z9/ghUrFW7HySa5HWEQ2Tg+yjGyPzPrLMfCMvITM3z
         dS6KN/tZJZFCxoYUqT/Bvur9Pq8ZQ8VZI6HgI1WrZ86WERM+T+qUC0HkrunAg/XBqaCs
         vgDfKUYD1lwmDbKSqyRYCV+J7PsQnDryLAtIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uL4QOOAN7cJEA2RiIo5ob5tyeRcQGEWvXtSZwUzYRXuVrExPzir0uPnoSO/a62hD/t
         +7no730LamSD4a/KMPiPFSAPZQwOq8CXVqVWZBpmybfJ5L+8liUmdL+j3AgonRODYJhl
         gY/ZTFo+7DmRDcqhPtN1U7Z+iB8NrQEou4bgI=
Received: by 10.150.214.8 with SMTP id m8mr434992ybg.121.1301422505390;
        Tue, 29 Mar 2011 11:15:05 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id o2sm1971669ybn.21.2011.03.29.11.15.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 11:15:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170295>

Create a test-svn-fi in toplevel directory, add rules to build it, and
add some basic tests.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
Verifying svn:date is very non-trivial, because of timezone conversion
issues. I tried fuzzing those out and checking only year and month,
but a timezone shift can cause a change in both of them as
well. Example: 31 Dec 2011 11:45 PM in one timezone can very well be 1
Jan 2012 in another timezone.

More tests? Suggestions for reduced testcases of complex revision
history tasks? I'll probably import some tests from svnrdump in the
next iteration.

 .gitignore        |    1 +
 Makefile          |    3 +
 t/t9012-svn-fi.sh |  705 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 test-svn-fi.c     |   17 ++
 4 files changed, 726 insertions(+), 0 deletions(-)
 create mode 100755 t/t9012-svn-fi.sh
 create mode 100644 test-svn-fi.c

diff --git a/.gitignore b/.gitignore
index c460c66..1cf145d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -181,6 +181,7 @@
 /test-subprocess
 /test-svn-fe
 /test-treap
+/test-svn-fi
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 7206d35..7fc5a2c 100644
--- a/Makefile
+++ b/Makefile
@@ -435,6 +435,7 @@ TEST_PROGRAMS_NEED_X += test-string-pool
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-treap
+TEST_PROGRAMS_NEED_X += test-svn-fi
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-mktemp
 
@@ -2152,6 +2153,8 @@ test-string-pool$X: vcs-svn/lib.a
 
 test-svn-fe$X: vcs-svn/lib.a
 
+test-svn-fi$X: vcs-svn/lib.a
+
 .PRECIOUS: $(TEST_OBJS)
 
 test-%$X: test-%.o $(GITLIBS)
diff --git a/t/t9012-svn-fi.sh b/t/t9012-svn-fi.sh
new file mode 100755
index 0000000..8bc2075
--- /dev/null
+++ b/t/t9012-svn-fi.sh
@@ -0,0 +1,705 @@
+#!/bin/sh
+
+test_description='check svn dumpfile exporter'
+
+. ./test-lib.sh
+
+svnrepo="testsvn"
+
+if svnadmin --help >/dev/null 2>&1
+then
+    load_dump () {
+	svnadmin load "$1"
+    }
+    test_set_prereq SVN
+fi
+
+reinit_svn () {
+	rm -rf "$svnrepo" &&
+	rm -f stream &&
+	svnadmin create "$svnrepo" &&
+	printf "#!/bin/sh" > "$svnrepo"/hooks/pre-revprop-change &&
+	chmod +x "$svnrepo"/hooks/pre-revprop-change &&
+	mkfifo stream
+}
+
+svn_look () {
+	subcommand=$1 &&
+	shift &&
+	svnlook "$subcommand" "$svnrepo" "$@"
+}
+
+try_load () {
+	input=$1 &&
+	maybe_fail=${2:+test_$2} &&
+
+	{
+		$maybe_fail test-svn-fi "$input" >stream &
+	} &&
+	load_dump "$svnrepo" <stream &&
+	wait $!
+}
+
+test_expect_success SVN 'M: regular files' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 foo
+	 bar
+	EOF
+	cat >expect.cat.foo <<-\EOF &&
+	nothing
+	EOF
+	cat >expect.cat.bar <<-\EOF &&
+	nothing again
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 9
+	something
+	M 100644 inline foo
+	data 8
+	nothing
+	M 100644 inline bar
+	data 14
+	nothing again
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	svn_look cat foo >actual.cat.foo &&
+	svn_look cat bar >actual.cat.bar &&
+	test_cmp expect.tree actual.tree &&
+	test_cmp expect.cat.foo actual.cat.foo &&
+	test_cmp expect.cat.bar actual.cat.bar
+'
+
+test_expect_success SVN 'D: regular files' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 9
+	something
+	M 100644 inline foo
+	data 7
+	nothing
+	commit refs/heads/master
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	D foo
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+test_expect_success SVN 'D: directories' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 9
+	something
+	M 100644 inline subdir/foo
+	data 7
+	nothing
+	commit refs/heads/master
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	D subdir
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+test_expect_success SVN 'R: regular files' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 bar
+	EOF
+	cat >expect.cat <<-\EOF &&
+	nothing
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 9
+	something
+	M 100644 inline foo
+	data 8
+	nothing
+	commit refs/heads/master
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 6
+	rename
+	R foo bar
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	svn_look cat bar >actual.cat &&
+	test_cmp expect.tree actual.tree &&
+	test_cmp expect.cat actual.cat
+'
+
+test_expect_success SVN 'R: directories' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 subdir2/
+	  foo
+	  bar
+	EOF
+	cat >expect.cat.foo <<-\EOF &&
+	nothing
+	EOF
+	cat >expect.cat.bar <<-\EOF &&
+	nothing again
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 9
+	something
+	M 100644 inline subdir/foo
+	data 8
+	nothing
+	M 100644 inline subdir/bar
+	data 14
+	nothing again
+	commit refs/heads/master
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 12
+	replace root
+	R subdir subdir2
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	svn_look cat subdir2/foo >actual.cat.foo &&
+	svn_look cat subdir2/bar >actual.cat.bar &&
+	test_cmp expect.tree actual.tree &&
+	test_cmp expect.cat.foo actual.cat.foo &&
+	test_cmp expect.cat.bar actual.cat.bar
+'
+
+test_expect_success SVN 'C: regular files' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 foo
+	 bar
+	EOF
+	cat >expect.cat <<-\EOF &&
+	nothing
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 9
+	something
+	M 100644 inline foo
+	data 8
+	nothing
+	commit refs/heads/master
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 6
+	rename
+	C foo bar
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	svn_look cat foo >actual.cat.foo &&
+	svn_look cat bar >actual.cat.bar &&
+	test_cmp expect.tree actual.tree &&
+	test_cmp expect.cat actual.cat.foo &&
+	test_cmp expect.cat actual.cat.bar
+'
+
+test_expect_success SVN 'C: directories' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 subdir/
+	  foo
+	  bar
+	 subdir2/
+	  foo
+	  bar
+	EOF
+	cat >expect.cat.foo <<-\EOF &&
+	nothing
+	EOF
+	cat >expect.cat.bar <<-\EOF &&
+	nothing again
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 9
+	something
+	M 100644 inline subdir/foo
+	data 8
+	nothing
+	M 100644 inline subdir/bar
+	data 14
+	nothing again
+	commit refs/heads/master
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 12
+	replace root
+	C subdir subdir2
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	svn_look cat subdir2/foo >actual.cat.foo &&
+	svn_look cat subdir2/bar >actual.cat.bar &&
+	test_cmp expect.tree actual.tree &&
+	test_cmp expect.cat.foo actual.cat.foo &&
+	test_cmp expect.cat.bar actual.cat.bar
+'
+
+test_expect_success SVN 'ignore checkpoint, progress, feature, option' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	EOF
+	cat >input <<-EOF &&
+	checkpoint
+	progress 3
+	feature foo
+	option bar
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+test_expect_success SVN 'ignore tag' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 foo
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 9
+	something
+	M 644 inline foo
+	data 0
+	tag moo
+	from master
+	tagger <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	data 8
+	nothing
+	tag bar
+	from master
+	tagger $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	data 10
+	something
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+test_expect_success SVN 'ignore notemodify' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 9
+	something
+	N moo :1
+	data 8
+	nothing
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+test_expect_success SVN 'svn:special and svn:executable' '
+	reinit_svn &&
+	test_tick &&
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	nothing
+	M 644 inline baz
+	data 0
+	M 100755 inline foo
+	data 0
+	M 755 inline moo
+	data 0
+	M 120000 inline bar
+	data 0
+	EOF
+	try_load input &&
+	svn_look propget svn:executable foo &&
+	svn_look propget svn:executable moo &&
+	svn_look propget svn:special bar
+'
+
+test_expect_success SVN 'invalid toplevel command' '
+	reinit_svn &&
+	test_tick &&
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	marks :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	M 100644 inline foo
+	data 0
+	EOF
+	test_must_fail try_load input
+'
+
+test_expect_success SVN 'invalid command after commit' '
+	reinit_svn &&
+	test_tick &&
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	datum 0
+	M 100644 inline foo
+	data 0
+	EOF
+	test_must_fail try_load input
+'
+
+test_expect_success SVN 'empty log, empty file' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 foo
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	M 100644 inline foo
+	data 0
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+test_expect_success SVN 'missing lf after data' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.log <<-\EOF &&
+	something
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 9
+	somethingM 100644 inline foo
+	data 0
+	EOF
+	try_load input &&
+	svn_look log >actual.log &&
+	test_cmp expect.log actual.log
+'
+
+test_expect_success SVN 'revprops: svn:author, svn:log' '
+	reinit_svn &&
+	test_tick &&
+	echo "nothing" >expect.log &&
+	echo "author" >expect.author &&
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <author@example.com> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	nothing
+	M 100644 inline foo
+	data 0
+	EOF
+	try_load input &&
+	svn_look log >actual.log &&
+	svn_look author >actual.author &&
+	test_cmp expect.log actual.log &&
+	test_cmp expect.author actual.author
+'
+
+test_expect_success SVN 'missing author line' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 foo
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	M 100644 inline foo
+	data 0
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+test_expect_success SVN 'author email without @' '
+	reinit_svn &&
+	test_tick &&
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <example> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	M 100644 inline foo
+	data 0
+	EOF
+	try_load input
+'
+
+test_expect_success SVN 'blob marks unsupported' '
+	reinit_svn &&
+	test_tick &&
+	cat >input <<-EOF &&
+	blob
+	mark :1
+	data 0
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :2
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	M 100644 :1 foo
+	data 0
+	EOF
+	test_must_fail try_load input
+'
+
+test_expect_success SVN 'malformed filemodify line' '
+	reinit_svn &&
+	test_tick &&
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	M 100644 inline
+	data 0
+	EOF
+	test_must_fail try_load input
+'
+
+test_expect_success SVN 'malformed author line' '
+	reinit_svn &&
+	test_tick &&
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author 2d3%*s&f#k|
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	M 100644 inline foo
+	data 0
+	EOF
+	test_must_fail try_load input
+'
+
+test_expect_success SVN 'missing committer line' '
+	reinit_svn &&
+	test_tick &&
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	data 0
+	M 100644 inline foo
+	data 0
+	EOF
+	test_must_fail try_load input
+'
+
+test_expect_success SVN 'malformed data length' '
+	reinit_svn &&
+	test_tick &&
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_AUTHOR_DATE
+	data 0
+	M 100644 inline foo
+	data 14238
+	EOF
+	test_must_fail try_load input
+'
+
+test_expect_success SVN 'recursive directory creation' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 alpha/
+	  beta/
+	   gamma
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	nothing
+	M 100644 inline alpha/beta/gamma
+	data 12
+	some content
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+test_expect_success SVN 'replace symlink with normal file' '
+	reinit_svn &&
+	test_tick &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 alpha/
+	  beta/
+	   gamma
+	EOF
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	nothing
+	M 120000 inline alpha/beta/gamma
+	data 0
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	nothing
+	M 100644 inline alpha/beta/gamma
+	data 0
+	EOF
+	try_load input &&
+	svn_look tree -r1 >actual.tree1 &&
+	svn_look tree -r2 >actual.tree2 &&
+	test_cmp expect.tree actual.tree1 &&
+	test_cmp expect.tree actual.tree2
+'
+
+test_expect_success SVN 'path includes symlink' '
+	reinit_svn &&
+	test_tick &&
+	cat >input <<-EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	nothing
+	M 120000 inline alpha/beta/gamma
+	data 0
+	commit refs/heads/master
+	mark :1
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	nothing
+	M 100644 inline alpha/beta/gamma/bar
+	data 0
+	EOF
+	test_must_fail try_load input
+'
+
+test_done
diff --git a/test-svn-fi.c b/test-svn-fi.c
new file mode 100644
index 0000000..cc6b312
--- /dev/null
+++ b/test-svn-fi.c
@@ -0,0 +1,17 @@
+/*
+ * test-svn-fe: Code to exercise the svn import lib
+ */
+
+#include "git-compat-util.h"
+#include "vcs-svn/svnload.h"
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2)
+		usage("test-svn-fe <file>");
+	if (svnload_init(argv[1]))
+		return 1;
+	svnload_read();
+	svnload_deinit();
+	return 0;
+}
-- 
1.7.4.rc1.7.g2cf08.dirty
