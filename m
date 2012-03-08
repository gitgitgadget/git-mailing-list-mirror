From: David Barr <davidbarr@google.com>
Subject: [PATCH] fast-import: fix ls command with empty path
Date: Thu,  8 Mar 2012 16:30:56 +1100
Message-ID: <1331184656-98629-1-git-send-email-davidbarr@google.com>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 06:32:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5VxS-00012L-QK
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 06:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab2CHFbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 00:31:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58694 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab2CHFbh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 00:31:37 -0500
Received: by iagz16 with SMTP id z16so207816iag.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 21:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Oo7/p3ZldsgTbJk+EwOEhO0A/h8AjPQvUeqB9UEdKMM=;
        b=FQP84eAWp2ONtTqaKi8jQsdlpL6wKmE5mBDUoW27i5AopU+IZveR2M9b6EwbygIlss
         ryqBzPYES6KBxv3cGYhcTVL99b245Oc9SCFAY+40DZK3rtRMoKmQyLii7mROUAmSiAk7
         F6jH+UM+HXnWl1+GZNsE3E2hWt5tHL0T6K2sjFE9f/LsZiCViO5tpjF7wyJiWTlnrM5T
         1iKF9ASVVmuovqlrGX0Xnot6Yy42K6X+6HG0o033xXuza4x3wqhDWYPiMSVluLxt/JCP
         9Ef5ZU4M6mjn2PQKsgLCpwudBbsa5ptP+0oYiYQhjdl4KHT64t0PJsQKhZc127zyRvrV
         f/Mg==
Received: by 10.50.181.162 with SMTP id dx2mr4496355igc.42.1331184696618;
        Wed, 07 Mar 2012 21:31:36 -0800 (PST)
Received: by 10.50.181.162 with SMTP id dx2mr4496328igc.42.1331184696492;
        Wed, 07 Mar 2012 21:31:36 -0800 (PST)
Received: from davidbarr-macpro.syd.corp.google.com (davidbarr-macpro.syd.corp.google.com [172.23.4.51])
        by mx.google.com with ESMTPS id s3sm614924igw.17.2012.03.07.21.31.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 21:31:35 -0800 (PST)
X-Mailer: git-send-email 1.7.9.3
In-Reply-To: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
X-Gm-Message-State: ALoCoQlq92MX7mzLpUPnYxolzbUZZB6Po/on99TS0dWhx0Bojby7AwytR1aWh5QB4tZG2Ar5cTa18+cHFPfDnFv0OWUX0Yvyjr1DbfUFr+eabv2g1kw5l4+kd7BBI9u3ZNrVUREX3NqfHT4Vho98MWW0BSrzRFSLvlUNL1IyiyRkT8NbyNJz568=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192520>

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
path. Instead, copy the root entry and force the mode to S_IFDIR.

Reported-by: Andrew Sayers <andrew-git@pileofstuff.org>
Signed-off-by: David Barr <davidbarr@google.com>
---
 fast-import.c          |    7 ++++++-
 t/t9300-fast-import.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index c1486ca..8dbfd4c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3019,7 +3019,12 @@ static void parse_ls(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
-	tree_content_get(root, p, &leaf);
+	if (*p) {
+		tree_content_get(root, p, &leaf);
+	} else {
+		leaf = *root;
+		leaf.versions[1].mode = S_IFDIR;
+	}
 	/*
 	 * A directory in preparation would have a sha1 of zero
 	 * until it is saved.  Save, for simplicity.
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 438aaf6..2558a2e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1400,6 +1400,37 @@ test_expect_success \
 	 test_cmp expect.qux actual.qux &&
 	 test_cmp expect.qux actual.quux'
 
+test_expect_success PIPE 'N: read and copy root' '
+	cat >expect <<-\EOF
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
1.7.9.3
