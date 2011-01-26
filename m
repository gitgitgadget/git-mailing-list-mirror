From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] fast-import: treat filemodify with empty tree as delete
Date: Wed, 26 Jan 2011 16:41:04 -0600
Message-ID: <20110126224104.GA20388@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino>
 <20110103082458.GC8842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 23:41:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiE3W-0006dT-Lc
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 23:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab1AZWlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 17:41:20 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47636 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab1AZWlS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 17:41:18 -0500
Received: by wwa36 with SMTP id 36so1530054wwa.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EWgFlZ3aLtmGaek8Cwn4GdAS05EzLRc07fcspc/AsGk=;
        b=pdccUYydk8P/YhMG2VKNrJPhSFVFLmcct4ljSzINTUWxF2QQ7InmlCJoSSWrg+qP8/
         T4aB6OXjYDwOm5g8DWliuZIlSDcLdtdM09GBBWSe5qnqg491bo4m7wiQIMJAvf83ZdLf
         91wr3YCu8bXS3Y2uGXhcYobsFVj9f7uf31QHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lCfVnwQLX74Ynnjh0p/FvPTuooOVlWLj4mD+P8xbhoz4C2KEvgYWZM21/o+cQC2A7l
         E8ExdbNgPLhrPNd25Fx+ekr4/XdAcOlLIGMZw4e3FAPrxAdnhsHOAfAn4oFNC24L1dpm
         1+GhXrdng8JO6+udg3NV2vkHOmHwVtLDXxtIY=
Received: by 10.216.25.136 with SMTP id z8mr5511870wez.93.1296081676828;
        Wed, 26 Jan 2011 14:41:16 -0800 (PST)
Received: from burratino ([69.209.75.28])
        by mx.google.com with ESMTPS id m6sm8055897wej.34.2011.01.26.14.41.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 14:41:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103082458.GC8842@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165559>

Date: Sat, 11 Dec 2010 16:42:28 -0600

Normal git processes do not allow one to build a tree with an empty
subtree entry without trying hard at it.  This is in keeping with the
general UI philosophy: git tracks content, not empty directories.

v1.7.3-rc0~75^2 (2010-06-30) changed that by making it easy to include
an empty subtree in fast-import's active commit:

	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 subdir

It is easy to trigger this by accident by reading an empty tree (for
example, the tree corresponding to an empty root commit) and trying to
move it to a subtree.  It is better and more closely analogous to "git
read-tree --prefix" to treat such commands as a request to remove
("to empty") the subdir.

Noticed-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Change since v1: commit message.

Resubmitting this fix separately from the 3-part series it came from.
Seems to work okay. :)

 fast-import.c          |   10 ++++++++
 t/t9300-fast-import.sh |   58 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7857760..8b19d87 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2231,6 +2231,16 @@ static void file_change_m(struct branch *b)
 		p = uq.buf;
 	}
 
+	/*
+	 * Git does not track empty, non-toplevel directories.
+	 */
+	if (S_ISDIR(mode) &&
+	    !memcmp(sha1, (const unsigned char *) EMPTY_TREE_SHA1_BIN, 20) &&
+	    *p) {
+		tree_content_remove(&b->branch_tree, p, NULL);
+		return;
+	}
+
 	if (S_ISGITLINK(mode)) {
 		if (inline_data)
 			die("Git links cannot be specified 'inline': %s",
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 222d105..80ddfe0 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -42,6 +42,14 @@ echo "$@"'
 
 >empty
 
+test_expect_success 'setup: have pipes?' '
+	rm -f frob &&
+	if mkfifo frob
+	then
+		test_set_prereq PIPE
+	fi
+'
+
 ###
 ### series A
 ###
@@ -899,6 +907,48 @@ test_expect_success \
 	 compare_diff_raw expect actual'
 
+test_expect_success \
+	'N: delete directory by copying' \
+	'cat >expect <<-\EOF &&
+	OBJID
+	:100644 000000 OBJID OBJID D	foo/bar/qux
+	OBJID
+	:000000 100644 OBJID OBJID A	foo/bar/baz
+	:000000 100644 OBJID OBJID A	foo/bar/qux
+	EOF
+	 empty_tree=$(git mktree </dev/null) &&
+	 cat >input <<-INPUT_END &&
+	commit refs/heads/N-delete
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	collect data to be deleted
+	COMMIT
+
+	deleteall
+	M 100644 inline foo/bar/baz
+	data <<DATA_END
+	hello
+	DATA_END
+	C "foo/bar/baz" "foo/bar/qux"
+	C "foo/bar/baz" "foo/bar/quux/1"
+	C "foo/bar/baz" "foo/bar/quuux"
+	M 040000 $empty_tree foo/bar/quux
+	M 040000 $empty_tree foo/bar/quuux
+
+	commit refs/heads/N-delete
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	delete subdirectory
+	COMMIT
+
+	M 040000 $empty_tree foo/bar/qux
+	INPUT_END
+	 git fast-import <input &&
+	 git rev-list N-delete |
+		git diff-tree -r --stdin --root --always |
+		sed -e "s/$_x40/OBJID/g" >actual &&
+	 test_cmp expect actual'
+
 test_expect_success \
 	'N: copy root directory by tree hash' \
 	'cat >expect <<-\EOF &&
 	:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file3/newf
@@ -1889,14 +1939,6 @@ test_expect_success 'R: print two blobs to stdout' '
 	test_cmp expect actual
 '
 
-test_expect_success 'setup: have pipes?' '
-	rm -f frob &&
-	if mkfifo frob
-	then
-		test_set_prereq PIPE
-	fi
-'
-
 test_expect_success PIPE 'R: copy using cat-file' '
 	expect_id=$(git hash-object big) &&
 	expect_len=$(wc -c <big) &&
-- 
1.7.4.rc3
