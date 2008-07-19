From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH v2] Support gitlinks in fast-import.
Date: Sat, 19 Jul 2008 16:21:24 +0400
Organization: TEPKOM
Message-ID: <200807191621.25654.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 14:22:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKBSO-000799-Rk
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 14:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbYGSMVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 08:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753318AbYGSMVh
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 08:21:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:6496 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbYGSMVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 08:21:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so309725fgg.17
        for <git@vger.kernel.org>; Sat, 19 Jul 2008 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rxnn5exmzMlBLgAFfELsve4cvjAr/YsGTV8SJ0RfFkk=;
        b=Nm0C8AnQIoVmy+kLd4BY4aE6NtSVE9hHcLkdMbyF5nPcDXUvWhquQ9gsqo/F4N91aG
         KakvhED49A8J6QluVllsk9V/P6SQBWXTdZKqDuj2bifiSvjmGehkgwswrgT6okMC3+9s
         uB+sWbYju2UTr6BR/yjwZsr03mlXq1zXdxhaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Ff/cOTPs9s+dupwsAvsAdE8ei4capOOwjIlvksSDFSO/WaPN4ofCIFsT/ruy3LVdCz
         12/l8Nq1fs2F5Z5uSW+UZCP7mumgh68+j+9YyVXGg6EMGt2moDYwBp+dfRs8Fi68ZV0q
         /3g96cAAWGZYdEHh23tDuy8z2ImGKCGHSeKMg=
Received: by 10.86.82.6 with SMTP id f6mr1899653fgb.73.1216470094533;
        Sat, 19 Jul 2008 05:21:34 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id l19sm1323089fgb.7.2008.07.19.05.21.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 19 Jul 2008 05:21:33 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89108>

Currently fast-import/export cannot be used for
repositories with submodules. This patch extends
the relevant programs to make them correctly
process gitlinks.

Links can be represented by two forms of the
Modify command:

M 160000 SHA1 some/path

which sets the link target explicitly, or

M 160000 :mark some/path

where the mark refers to a commit. The latter
form can be used by importing tools to build
all submodules simultaneously in one physical
repository, and then simply fetch them apart.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	Changes:
	1) Fixed the typo in the documentation.
	2) Gitlinks are always exported as SHA.
	3) Added some comments.
	4) Added tests.

	-- Alexander

 Documentation/git-fast-import.txt |    3 +
 builtin-fast-export.c             |   17 +++-
 fast-import.c                     |   14 +++-
 t/t9300-fast-import.sh            |  152 +++++++++++++++++++++++++++++++++++++
 t/t9301-fast-export.sh            |   42 ++++++++++
 5 files changed, 223 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 395c055..d510ddb 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -481,6 +481,9 @@ in octal.  Git only supports the following modes:
   what you want.
 * `100755` or `755`: A normal, but executable, file.
 * `120000`: A symlink, the content of the file will be the link target.
+* `160000`: A gitlink, SHA-1 of the object refers to a commit in
+  another repository. Git links can only be specified by SHA or through
+  a commit mark. They are used to implement submodules.
 
 In both formats `<path>` is the complete path of the file to be added
 (if not already existing) or modified (if already existing).
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index d0a462f..30ccbd5 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -122,9 +122,16 @@ static void show_filemodify(struct diff_queue_struct *q,
 		if (is_null_sha1(spec->sha1))
 			printf("D %s\n", spec->path);
 		else {
-			struct object *object = lookup_object(spec->sha1);
-			printf("M %06o :%d %s\n", spec->mode,
-			       get_object_mark(object), spec->path);
+			/* Links refer to objects in another repositories, so
+			   output the SHA-1 verbatim */
+			if (S_ISGITLINK(spec->mode))
+				printf("M %06o %s %s\n", spec->mode,
+				       sha1_to_hex(spec->sha1), spec->path);
+			else {
+				struct object *object = lookup_object(spec->sha1);
+				printf("M %06o :%d %s\n", spec->mode,
+				       get_object_mark(object), spec->path);
+			}
 		}
 	}
 }
@@ -182,8 +189,10 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		diff_root_tree_sha1(commit->tree->object.sha1,
 				    "", &rev->diffopt);
 
+	/* Export the referenced blobs, and remember the marks */
 	for (i = 0; i < diff_queued_diff.nr; i++)
-		handle_object(diff_queued_diff.queue[i]->two->sha1);
+		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
+			handle_object(diff_queued_diff.queue[i]->two->sha1);
 
 	mark_object(&commit->object);
 	if (!is_encoding_utf8(encoding))
diff --git a/fast-import.c b/fast-import.c
index e72b286..cb6d1ee 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1868,6 +1868,7 @@ static void file_change_m(struct branch *b)
 	case S_IFREG | 0644:
 	case S_IFREG | 0755:
 	case S_IFLNK:
+	case S_IFGITLINK:
 	case 0644:
 	case 0755:
 		/* ok */
@@ -1900,7 +1901,18 @@ static void file_change_m(struct branch *b)
 		p = uq.buf;
 	}
 
-	if (inline_data) {
+	if (S_ISGITLINK(mode)) {
+		if (inline_data)
+			die("Git links cannot be specified 'inline': %s",
+				command_buf.buf);
+		else if (oe) {
+			if (oe->type != OBJ_COMMIT)
+				die("Not a commit (actually a %s): %s",
+					typename(oe->type), command_buf.buf);
+		}
+		/* else: accept the sha1 without check, as its object
+		         is expected to be in another repository */
+	} else if (inline_data) {
 		static struct strbuf buf = STRBUF_INIT;
 
 		if (p != uq.buf) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5edf56f..235a8a6 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -918,4 +918,156 @@ test_expect_success \
 	 grep "progress " <input >expect &&
 	 test_cmp expect actual'
 
+###
+### series P (gitlinks)
+###
+
+cat >input <<INPUT_END
+blob
+mark :1
+data 10
+test file
+
+reset refs/heads/sub
+commit refs/heads/sub
+mark :2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 12
+sub_initial
+M 100644 :1 file
+
+blob
+mark :3
+data <<DATAEND
+[submodule "sub"]
+	path = sub
+	url = "`pwd`/sub"
+DATAEND
+
+commit refs/heads/subuse1
+mark :4
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 8
+initial
+from refs/heads/master
+M 100644 :3 .gitmodules
+M 160000 :2 sub
+
+blob
+mark :5
+data 20
+test file
+more data
+
+commit refs/heads/sub
+mark :6
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 11
+sub_second
+from :2
+M 100644 :5 file
+
+commit refs/heads/subuse1
+mark :7
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 7
+second
+from :4
+M 160000 :6 sub
+
+INPUT_END
+
+test_expect_success \
+	'P: supermodule & submodule mix' \
+	'git-fast-import <input &&
+	 git checkout subuse1 &&
+	 rm -rf sub && mkdir sub && cd sub &&
+	 git init &&
+	 git fetch .. refs/heads/sub:refs/heads/master &&
+	 git checkout master &&
+	 cd .. &&
+	 git submodule init &&
+	 git submodule update'
+
+SUBLAST=$(git-rev-parse --verify sub)
+SUBPREV=$(git-rev-parse --verify sub^)
+
+cat >input <<INPUT_END
+blob
+mark :1
+data <<DATAEND
+[submodule "sub"]
+	path = sub
+	url = "`pwd`/sub"
+DATAEND
+
+commit refs/heads/subuse2
+mark :2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 8
+initial
+from refs/heads/master
+M 100644 :1 .gitmodules
+M 160000 $SUBPREV sub
+
+commit refs/heads/subuse2
+mark :3
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 7
+second
+from :2
+M 160000 $SUBLAST sub
+
+INPUT_END
+
+test_expect_success \
+	'P: verbatim SHA gitlinks' \
+	'git branch -D sub &&
+	 git gc && git prune &&
+	 git-fast-import <input &&
+	 test $(git-rev-parse --verify subuse2) = $(git-rev-parse --verify subuse1)'
+
+test_tick
+cat >input <<INPUT_END
+commit refs/heads/subuse3
+mark :1
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+corrupt
+COMMIT
+
+from refs/heads/subuse2
+M 160000 inline sub
+data <<DATA
+$SUBPREV
+DATA
+
+INPUT_END
+
+test_expect_success 'P: fail on inline gitlink' '
+    ! git-fast-import <input'
+
+test_tick
+cat >input <<INPUT_END
+blob
+mark :1
+data <<DATA
+$SUBPREV
+DATA
+
+commit refs/heads/subuse3
+mark :2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+corrupt
+COMMIT
+
+from refs/heads/subuse2
+M 160000 :1 sub
+
+INPUT_END
+
+test_expect_success 'P: fail on blob mark in gitlink' '
+    ! git-fast-import <input'
+
 test_done
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index f09bfb1..f18eec9 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -120,4 +120,46 @@ test_expect_success 'signed-tags=strip' '
 
 '
 
+test_expect_success 'setup submodule' '
+
+	git checkout -f master &&
+	mkdir sub &&
+	cd sub &&
+	git init  &&
+	echo test file > file &&
+	git add file &&
+	git commit -m sub_initial &&
+	cd .. &&
+	git submodule add "`pwd`/sub" sub &&
+	git commit -m initial &&
+	test_tick &&
+	cd sub &&
+	echo more data >> file &&
+	git add file &&
+	git commit -m sub_second &&
+	cd .. &&
+	git add sub &&
+	git commit -m second
+
+'
+
+test_expect_success 'submodule fast-export | fast-import' '
+
+	SUBENT1=$(git ls-tree master^ sub) &&
+	SUBENT2=$(git ls-tree master sub) &&
+	rm -rf new &&
+	mkdir new &&
+	git --git-dir=new/.git init &&
+	git fast-export --signed-tags=strip --all |
+	(cd new &&
+	 git fast-import &&
+	 test "$SUBENT1" = "$(git ls-tree refs/heads/master^ sub)" &&
+	 test "$SUBENT2" = "$(git ls-tree refs/heads/master sub)" &&
+	 git checkout master &&
+	 git submodule init &&
+	 git submodule update &&
+	 cmp sub/file ../sub/file)
+
+'
+
 test_done
-- 
1.5.6.3.18.gfe82
