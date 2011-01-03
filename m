From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] fast-import: treat filemodify with empty tree as delete
Date: Mon, 3 Jan 2011 02:24:58 -0600
Message-ID: <20110103082458.GC8842@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Jan 03 09:25:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZfjB-00005a-5H
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 09:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab1ACIZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 03:25:10 -0500
Received: from mail-yw0-f66.google.com ([209.85.213.66]:60692 "EHLO
	mail-yw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab1ACIZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 03:25:08 -0500
Received: by ywi6 with SMTP id 6so3208719ywi.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 00:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ujORcWEmS5Rbiv4VsbhuerEBbYSjz8ghi2eKAaquu9A=;
        b=tb1Z3nR6S7PgJMB8dToTYnjFQrxafpfZLyONx8O5naXDrRRkBUS2+aZboTxqws99QQ
         fnWt1/3UgHRlCdia/Mt4/8I2+82x0/pmnXjPDTCyilYeAtPsfXN08v9tugVQlDaEZOSI
         8nWfd7BmgzNCAFkpR8MqgrFvg2aluIZPOKGBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VeL7EOKb9IZI4nXBlWD1VUJ6QyTiP2qhxW5tEoZY87UV+lU41LBNJ3a4U/psoWOhCk
         0VDlqGm+uHUdy5RsmqGJIl9gWDnmXh6TDvRMAFBW/nOqARdaCOEh59nM1is/K/9TqIm3
         Fj9lQ1b91N/H2R0JyG0sYEn7yTxqu7NaXj9dk=
Received: by 10.90.88.20 with SMTP id l20mr12218442agb.57.1294043107675;
        Mon, 03 Jan 2011 00:25:07 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id c34sm27875461anc.10.2011.01.03.00.25.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 00:25:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103080130.GA8842@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164447>

Date: Sat, 11 Dec 2010 16:42:28 -0600

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
If this seems like a good idea it might be a candidate for v1.7.4.x.
Perhaps fsck.c should learn a "no empty trees" rule, too.

 fast-import.c          |   10 ++++++++
 t/t9300-fast-import.sh |   58 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a5cea45..385d12d 100644
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
index 53aad51..b9aa3f0 100755
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
 
 test_expect_success \
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
+test_expect_success \
 	'N: copy root directory by tree hash' \
 	'cat >expect <<-\EOF &&
 	:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file3/newf
@@ -1898,14 +1948,6 @@ test_expect_success 'R: print two blobs to stdout' '
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
1.7.4.rc0.580.g89dc.dirty
