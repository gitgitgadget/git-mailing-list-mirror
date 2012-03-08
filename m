From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] fast-import: teach ls command to accept empty path
Date: Thu, 8 Mar 2012 14:33:30 -0600
Message-ID: <20120308203330.GC8992@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308202721.GA8992@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 21:33:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5k1u-0003hS-Gv
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 21:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab2CHUdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 15:33:38 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41323 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab2CHUdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 15:33:37 -0500
Received: by yenl12 with SMTP id l12so516108yen.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RA83eSMDI6wYXmyd1nfsGOQzAkxsFyCce1zwuVAOxzs=;
        b=OYqxCpZiXXfL0pVMqFBJJOHsZtG11po5p54A9FBfGHePAmSC+AWzakz7L5p5bkE7V5
         a06/wfy/zIvP77BHcCWRjih3o1wvIxaAuXoTFO0yG0DrKWlbmNMiH88PDUtzbz+XjYI8
         EwRS4lM8HeMZndBes50yfWIYBEcJHqo4tQmm43O2ZTYNImexTAMQ/U0+1nfY6lekFPPo
         abptVVAdtBtjpgbf3eM1I50RiOvgIup6Cywq5ZQMY/IyWNawPgIj8QFTTV9L1CeuSGsr
         9sHK/zo7dEf8PTNnEgm39MpK3j1ExrunE1BOVXRGxrG3GE0j8EFLv1GkDYhiyqLOiChJ
         PphQ==
Received: by 10.60.29.65 with SMTP id i1mr3029596oeh.48.1331238816812;
        Thu, 08 Mar 2012 12:33:36 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id s9sm1475109oee.2.2012.03.08.12.33.35
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 12:33:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308202721.GA8992@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192645>

From: David Barr <davidbarr@google.com>

There is a pathological Subversion operation that svn-fe handles
incorrectly due to an unexpected response from fast-import:

  svn cp $SVN_ROOT $SVN_ROOT/subdirectory

When the following command is sent to fast-import:

 'ls' SP ':1' SP LF

The expected output is:

 '040000' SP 'tree' SP <dataref> HT LF

The actual output is:

 'missing' SP LF

This is because tree_content_get() is called but expects a non-empty
path. Instead, copy the root entry.

[jn: using a deep copy; w/ more tests]
[jn: with a fix from Dmitry to fully initialize root->versions[0]
 and versions[1] now that root can be passed to store_tree]

Reported-by: Andrew Sayers <andrew-git@pileofstuff.org>
Signed-off-by: David Barr <davidbarr@google.com>
Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c          |   17 ++++++++-
 t/t9300-fast-import.sh |   95 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index 1758da94..31857e95 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3004,7 +3004,10 @@ static void parse_ls(struct branch *b)
 	} else {
 		struct object_entry *e = parse_treeish_dataref(&p);
 		root = new_tree_entry();
+		hashclr(root->versions[0].sha1);
 		hashcpy(root->versions[1].sha1, e->idx.sha1);
+		root->versions[0].mode = 0;
+		root->versions[1].mode = S_IFDIR;
 		load_tree(root);
 		if (*p++ != ' ')
 			die("Missing space after tree-ish: %s", command_buf.buf);
@@ -3019,7 +3022,19 @@ static void parse_ls(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
-	tree_content_get(root, p, &leaf);
+	if (*p) {
+		tree_content_get(root, p, &leaf);
+	} else {
+		memcpy(&leaf, root, sizeof(leaf));
+		/*
+		 * store_tree scribbles over version[0] in leaf.tree's
+		 * entries, so we need a deep copy.
+		 */
+		if (root->tree && is_null_sha1(root->versions[1].sha1))
+			leaf.tree = dup_tree_content(root->tree);
+		else
+			leaf.tree = NULL;
+	}
 	/*
 	 * A directory in preparation would have a sha1 of zero
 	 * until it is saved.  Save, for simplicity.
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 438aaf6b..635bfadb 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1400,6 +1400,101 @@ test_expect_success \
 	 test_cmp expect.qux actual.qux &&
 	 test_cmp expect.qux actual.quux'
 
+test_expect_success 'N: root of unborn branch reads as present and empty' '
+	empty_tree=$(git mktree </dev/null) &&
+	echo "040000 tree $empty_tree	" >expect &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-empty
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read empty root directory via ls
+	COMMIT
+
+	ls ""
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'N: empty root reads as present and empty' '
+	empty_tree=$(git mktree </dev/null) &&
+	echo "040000 tree $empty_tree	" >expect &&
+	echo empty >msg &&
+	cmit=$(git commit-tree "$empty_tree" -p refs/heads/branch^0 <msg) &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-empty-existing
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read empty root directory via ls
+	COMMIT
+
+	ls ""
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'N: "ls" command can read subdir of named tree' '
+	branch_cmit=$(git rev-parse --verify refs/heads/branch^0) &&
+	subdir_tree=$(git rev-parse $branch_cmit:newdir) &&
+	echo "040000 tree $subdir_tree	newdir" >expect &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-subdir-of-named-tree
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read from commit with ls
+	COMMIT
+
+	ls $branch_cmit "newdir"
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'N: "ls" command can read root of named commit' '
+	branch_cmit=$(git rev-parse --verify refs/heads/branch^0) &&
+	branch_tree=$(git rev-parse --verify $branch_cmit^{tree}) &&
+	echo "040000 tree $branch_tree	" >expect &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-root-of-named-tree
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read root directory of commit with ls
+	COMMIT
+
+	ls $branch_cmit ""
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success PIPE 'N: read and copy root' '
+	cat >expect <<-\EOF &&
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/file2/newf
+	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/file2/oldf
+	:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 C100	file4	file3/file4
+	:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 C100	newdir/exec.sh	file3/newdir/exec.sh
+	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/newdir/interesting
+	EOF
+	git update-ref -d refs/heads/N12 &&
+	rm -f backflow &&
+	mkfifo backflow &&
+	(
+		exec <backflow &&
+		cat <<-EOF &&
+		commit refs/heads/N12
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		copy root directory by tree hash read via ls
+		COMMIT
+
+		from refs/heads/branch^0
+		ls ""
+		EOF
+		read mode type tree filename &&
+		echo "M 040000 $tree file3"
+	) |
+	git fast-import --cat-blob-fd=3 3>backflow &&
+	git diff-tree -C --find-copies-harder -r N12^ N12 >actual &&
+	compare_diff_raw expect actual
+'
+
 ###
 ### series O
 ###
-- 
1.7.9.2
