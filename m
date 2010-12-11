From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] fast-import: treat filemodify with empty tree as delete
Date: Sat, 11 Dec 2010 16:47:32 -0600
Message-ID: <20101211224732.GA18822@burratino>
References: <20101210102007.GA26298@burratino>
 <C59168D0-B409-4A83-B96C-8CCD42D0B62F@cordelta.com>
 <20101211184654.GA17464@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Dec 11 23:47:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRYEF-0005wT-JD
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 23:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab0LKWrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Dec 2010 17:47:42 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:33579 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab0LKWrl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Dec 2010 17:47:41 -0500
Received: by gxk19 with SMTP id 19so3151750gxk.11
        for <git@vger.kernel.org>; Sat, 11 Dec 2010 14:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BM2gyvTADuI8UT50E6wm2asA7ycZNTZRqiJsHF976gs=;
        b=wnEWhhmCfB2RvFqxkLnVO3vAeRihJKhxWYCUuKj65fYu5NOBeYN2ew10WEXU0Y4hMa
         KoRhHBJoxn7jEq53zxpJG0vmhEiS41Rvr3qRkfurTG1bXeCKoGod8YK3nIZAT+A4wOHd
         bSIPmHVxMLcWVyhDEsPmga2lfbKF7BEZEsOjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DjfwcPGgwwcrfHL7w0Rdlut0RBNr8/D31yc12m4R8UwXlCoNqN4hB3Kse5xcFIXHG6
         yCgTeAM7+fPr4xsIbC+artGujI25f1S9kLKbFd5dAE46dwa8OhHpDAgJOjUDjV8vI592
         fvE4QVLkqa9O/HMrkxDO+kbixgRwkG81p37DU=
Received: by 10.236.109.12 with SMTP id r12mr4637271yhg.32.1292107660925;
        Sat, 11 Dec 2010 14:47:40 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id z5sm538096yhc.31.2010.12.11.14.47.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Dec 2010 14:47:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101211184654.GA17464@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163461>

Jonathan Nieder wrote:

> Maybe fast-import should make the check itself, to avoid
> writing trees with empty directories that would be hard to
> re-create with "git write-tree".

Like this, maybe?

-- 8< --
Subject: fast-import: treat filemodify with empty tree as delete

Traditionally, git trees do not contain entries for empty
subdirectories.  Generally speaking, subtrees are not created or
destroyed explicitly; instead, they automatically appear when needed
to hold regular files, symlinks, and submodules.

v1.7.3-rc0~75^2 (Teach fast-import to import subtrees named by tree
id, 2010-06-30) changed that, by allowing an empty subtree to be
included in a fast-import stream explicitly:

	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 subdir

That was unintentional.  Better and more closely analogous to "git
read-tree --prefix" to treat such an input line as a request to delete
("to empty") subdir.

Noticed-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Tests use the "ls" command from vcs-svn-pu.  The actual change
would apply cleanly to master or maint, though.

 fast-import.c          |   10 ++++
 t/t9300-fast-import.sh |  107 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 109 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index e62f34d..c774893 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2196,6 +2196,16 @@ static void file_change_m(struct branch *b)
 		p = uq.buf;
 	}
 
+	/*
+	 * Git does not track empty, non-toplevel directories.
+	 */
+	if (S_ISDIR(mode) &&
+	    !memcmp(sha1, (unsigned char *) EMPTY_TREE_SHA1_BIN, 20) &&
+	    *p) {
+		tree_content_remove(&b->branch_tree, p, NULL);
+		return;
+	}
+
 	if (S_ISGITLINK(mode)) {
 		if (inline_data)
 			die("Git links cannot be specified 'inline': %s",
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index b0e3bda..c17f704 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -25,6 +25,14 @@ echo "$@"'
 
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
@@ -881,6 +889,97 @@ test_expect_success \
 	 git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
 	 compare_diff_raw expect actual'
 
+test_expect_success PIPE 'N: read and copy directory' '
+	cat >expect <<-\EOF
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
+	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	EOF
+	git update-ref -d refs/heads/N4 &&
+	rm -f backflow &&
+	mkfifo backflow &&
+	(
+		exec <backflow &&
+		cat <<-EOF &&
+		commit refs/heads/N4
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		copy by tree hash, part 2
+		COMMIT
+
+		from refs/heads/branch^0
+		ls "file2"
+		EOF
+		read mode type tree filename &&
+		echo "M 040000 $tree file3"
+	) |
+	git fast-import --cat-blob-fd=3 3>backflow &&
+	git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success PIPE 'N: read and copy "empty" directory' '
+	cat <<-\EOF >expect &&
+	OBJNAME
+	:000000 100644 OBJNAME OBJNAME A	greeting
+	OBJNAME
+	:100644 000000 OBJNAME OBJNAME D	unrelated
+	OBJNAME
+	:000000 100644 OBJNAME OBJNAME A	unrelated
+	EOF
+	git update-ref -d refs/heads/copy-empty &&
+	rm -f backflow &&
+	mkfifo backflow &&
+	(
+		exec <backflow &&
+		cat <<-EOF &&
+		commit refs/heads/copy-empty
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		copy "empty" (missing) directory
+		COMMIT
+
+		M 100644 inline src/greeting
+		data <<BLOB
+		hello
+		BLOB
+		C src/greeting dst1/non-greeting
+		C src/greeting unrelated
+		# leave behind "empty" src directory
+		D src/greeting
+		ls "src"
+		EOF
+		read mode type tree filename &&
+		sed -e "s/X\$//" <<-EOF
+		M $mode $tree dst1
+		M $mode $tree dst2
+
+		commit refs/heads/copy-empty
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		copy empty directory to root
+		COMMIT
+
+		M $mode $tree X
+
+		commit refs/heads/copy-empty
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		add another file
+		COMMIT
+
+		M 100644 inline greeting
+		data <<BLOB
+		hello
+		BLOB
+		EOF
+	) |
+	git fast-import --cat-blob-fd=3 3>backflow &&
+	git rev-list copy-empty |
+	git diff-tree -r --root --stdin |
+	sed "s/$_x40/OBJNAME/g" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success \
 	'N: copy root directory by tree hash' \
 	'cat >expect <<-\EOF &&
@@ -1773,14 +1872,6 @@ test_expect_success 'R: print two blobs to stdout' '
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
1.7.2.4
