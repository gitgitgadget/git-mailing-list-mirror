From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] Teach fast-import to import subtrees named by tree id
Date: Wed, 30 Jun 2010 22:18:19 -0500
Message-ID: <20100701031819.GA12524@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 05:18:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUAIf-00063G-Tq
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 05:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab0GADSs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 23:18:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53276 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0GADSr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 23:18:47 -0400
Received: by iwn7 with SMTP id 7so1568443iwn.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 20:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=vs3BOzBv30FkcTBK4in/qcaISXgog3yr9bAM6jSTXRs=;
        b=RmCPjcIeewlRAFNmSeZwKYIdB4zM8bKuKubseGRvVrvZvtsgXxzA6Gh/OxArMh0GNw
         T2VRcPtYGJ4g9Lz8agLmr/9+oP+yCVnQkYWNgmAeFEIL9NBva3sHjmcrtFHNiG7G4xOV
         3M/6XDZIgqzxi5OFkL62F4xeXpyKD/wYX4kqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=GpLQXKdVDWp1Cf+UWGNxpbp2uQd7yjNyiyZO/hsygCxEKL+av+s404yY0nKdMCP/iJ
         hY2gjCMu7SnyYfmMS29SuJs1d/YHGCFCpqQItFF9531l4kXQ7rP7NPaoex7Bdycpftjk
         wc1DK/EL6DP38fzrmuB2Q3lAtk7f5yCWXnx18=
Received: by 10.231.144.147 with SMTP id z19mr9203313ibu.81.1277954325783;
        Wed, 30 Jun 2010 20:18:45 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm19757008ibk.15.2010.06.30.20.18.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 20:18:45 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150005>

To simulate the svn cp command, it would be very useful to be
replace an arbitrary file in the current revision by an
arbitrary directory from a previous one.  Modify the filemodify
command to allow that:

 M 040000 <tree id> pathname

This would be most useful in combination with a facility to
print the commit ids for new revisions as they are written.

Cc: Shawn O. Pearce <spearce@spearce.org>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I actually thought fast-import already did this until David
mentioned that no, it does not.  Well, live and learn.

This and Sverre=E2=80=99s --print-marks command would allow svn-fe
to be simplified a great deal.

I was not sure whether to add a "feature" specification for
this, so I=E2=80=99ll try that as a separate patch.

Thoughts?
Jonathan

 Documentation/git-fast-import.txt |    8 ++++-
 fast-import.c                     |   24 ++++++++++------
 t/t9300-fast-import.sh            |   54 +++++++++++++++++++++++++++++=
++++++++
 3 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast=
-import.txt
index 19082b0..f4d9aeb 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -482,9 +482,11 @@ External data format::
 	'M' SP <mode> SP <dataref> SP <path> LF
 ....
 +
-Here `<dataref>` can be either a mark reference (`:<idnum>`)
+Here usually `<dataref>` must be either a mark reference (`:<idnum>`)
 set by a prior `blob` command, or a full 40-byte SHA-1 of an
-existing Git blob object.
+existing Git blob object.  If `<mode>` is `040000`` then
+`<dataref>` must be the full 40-byte SHA-1 of an existing
+Git tree object or a mark reference set with `--import-marks`.
=20
 Inline data format::
 	The data content for the file has not been supplied yet.
@@ -509,6 +511,8 @@ in octal.  Git only supports the following modes:
 * `160000`: A gitlink, SHA-1 of the object refers to a commit in
   another repository. Git links can only be specified by SHA or throug=
h
   a commit mark. They are used to implement submodules.
+* `040000`: A subdirectory.  Subdirectories can only be specified by
+  SHA or through a tree mark set with `--import-marks`.
=20
 In both formats `<path>` is the complete path of the file to be added
 (if not already existing) or modified (if already existing).
diff --git a/fast-import.c b/fast-import.c
index 1e5d66e..ad6843a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2131,6 +2131,7 @@ static void file_change_m(struct branch *b)
 	case S_IFREG | 0644:
 	case S_IFREG | 0755:
 	case S_IFLNK:
+	case S_IFDIR:
 	case S_IFGITLINK:
 		/* ok */
 		break;
@@ -2176,23 +2177,28 @@ static void file_change_m(struct branch *b)
 		 * another repository.
 		 */
 	} else if (inline_data) {
+		if (S_ISDIR(mode))
+			die("Directories cannot be specified 'inline': %s",
+				command_buf.buf);
 		if (p !=3D uq.buf) {
 			strbuf_addstr(&uq, p);
 			p =3D uq.buf;
 		}
 		read_next_command();
 		parse_and_store_blob(&last_blob, sha1, 0);
-	} else if (oe) {
-		if (oe->type !=3D OBJ_BLOB)
-			die("Not a blob (actually a %s): %s",
-				typename(oe->type), command_buf.buf);
 	} else {
-		enum object_type type =3D sha1_object_info(sha1, NULL);
+		enum object_type expected =3D S_ISDIR(mode) ?
+						OBJ_TREE: OBJ_BLOB;
+		enum object_type type =3D oe ? oe->type :
+					sha1_object_info(sha1, NULL);
 		if (type < 0)
-			die("Blob not found: %s", command_buf.buf);
-		if (type !=3D OBJ_BLOB)
-			die("Not a blob (actually a %s): %s",
-			    typename(type), command_buf.buf);
+			die("%s not found: %s",
+					S_ISDIR(mode) ?  "Tree" : "Blob",
+					command_buf.buf);
+		if (type !=3D expected)
+			die("Not a %s (actually a %s): %s",
+				typename(expected), typename(type),
+				command_buf.buf);
 	}
=20
 	tree_content_set(&b->branch_tree, p, sha1, mode, NULL);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 131f032..50d5913 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -796,6 +796,60 @@ test_expect_success \
 	'git fast-import <input &&
 	 test `git rev-parse N2^{tree}` =3D `git rev-parse N3^{tree}`'
=20
+test_expect_success \
+	'N: copy directory by id' \
+	'cat >expect <<-\EOF &&
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392=
694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
+	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39b=
e127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	EOF
+	 subdir=3D$(git rev-parse refs/heads/branch^0:file2) &&
+	 cat >input <<-INPUT_END &&
+	commit refs/heads/N4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_D=
ATE
+	data <<COMMIT
+	copy by tree hash
+	COMMIT
+
+	from refs/heads/branch^0
+	M 040000 $subdir file3
+	INPUT_END
+	 git fast-import <input &&
+	 git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
+	 compare_diff_raw expect actual'
+
+test_expect_success \
+	'N: modify copied tree' \
+	'cat >expect <<-\EOF &&
+	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181e=
aa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392=
694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
+	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39b=
e127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	EOF
+	 subdir=3D$(git rev-parse refs/heads/branch^0:file2) &&
+	 cat >input <<-INPUT_END &&
+	commit refs/heads/N5
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_D=
ATE
+	data <<COMMIT
+	copy by tree hash
+	COMMIT
+
+	from refs/heads/branch^0
+	M 040000 $subdir file3
+
+	commit refs/heads/N5
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_D=
ATE
+	data <<COMMIT
+	modify directory copy
+	COMMIT
+
+	M 644 inline file3/file5
+	data <<EOF
+	$file5_data
+	EOF
+	INPUT_END
+	 git fast-import <input &&
+	 git diff-tree -C --find-copies-harder -r N5^^ N5 >actual &&
+	 compare_diff_raw expect actual'
+
 ###
 ### series O
 ###
--=20
1.7.1.1
