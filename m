From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 1/2] fast-import: test behavior of garbage after mark references
Date: Mon,  2 Apr 2012 21:51:49 -0400
Message-ID: <1333417910-17955-2-git-send-email-pw@padd.com>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 03:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEsuw-0001BF-P7
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 03:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab2DCBwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 21:52:14 -0400
Received: from honk.padd.com ([74.3.171.149]:47811 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab2DCBwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 21:52:14 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 4C31820CE;
	Mon,  2 Apr 2012 18:52:13 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 012E9313CD; Mon,  2 Apr 2012 21:52:10 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc2.57.gb1c2d
In-Reply-To: <1333417910-17955-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194585>

Add 15 tests to see what happens when extra characters
appear after a mark reference, in all places that take marks.
Ten of these fail.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9300-fast-import.sh |  267 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 0f5b5e5..621f02a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2635,4 +2635,271 @@ test_expect_success \
 	'n=$(grep $a verify | wc -l) &&
 	 test 1 = $n'
 
+###
+### series S
+###
+#
+# Set up is roughly this.  Commits marked 1,2,3,4.  Blobs
+# marked 100 + commit.  Notes 200 +.  Make sure missing spaces
+# and EOLs after mark references cause errors.
+#
+# 1--2--4
+#  \   /
+#   -3-
+#
+test_tick
+
+cat >input <<INPUT_END
+commit refs/heads/S
+mark :1
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+commit 1
+COMMIT
+M 100644 inline hello.c
+data <<BLOB
+blob 1
+BLOB
+
+commit refs/heads/S
+mark :2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+commit 2
+COMMIT
+from :1
+M 100644 inline hello.c
+data <<BLOB
+blob 2
+BLOB
+
+blob
+mark :103
+data <<BLOB
+blob 3
+BLOB
+
+blob
+mark :202
+data <<BLOB
+note 2
+BLOB
+INPUT_END
+
+test_expect_success 'S: add commits 1 and 2, and blob 103' '
+	git fast-import --export-marks=marks <input
+'
+
+#
+# filemodify, three datarefs
+#
+test_expect_failure 'S: filemodify markref no space' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit N
+	COMMIT
+	M 100644 :103x hello.c
+	EOF
+	cat err &&
+	grep -q "Missing space after mark" err
+'
+
+test_expect_failure 'S: filemodify inline no space' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit N
+	COMMIT
+	M 100644 inlineX hello.c
+	data <<BLOB
+	inline
+	BLOB
+	EOF
+	cat err &&
+	grep -q "Missing space after .inline." err
+'
+
+test_expect_success 'S: filemodify sha1 no space' '
+	sha1=$(grep -w :103 marks | cut -d\  -f2) &&
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit N
+	COMMIT
+	M 100644 ${sha1}x hello.c
+	EOF
+	cat err &&
+	grep -q "Missing space after SHA1" err
+'
+
+#
+# notemodify, three ways to say dataref
+#
+test_expect_failure 'S: notemodify dataref markref no space' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit S note dataref markref
+	COMMIT
+	N :103x :2
+	EOF
+	cat err &&
+	grep -q "Missing space after mark" err
+'
+
+test_expect_failure 'S: notemodify dataref inline no space' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit S note dataref inline
+	COMMIT
+	N inlineX :2
+	data <<BLOB
+	note blob
+	BLOB
+	EOF
+	cat err &&
+	grep -q "Missing space after .inline." err
+'
+
+test_expect_success 'S: notemodify dataref sha1 no space' '
+	sha1=$(grep -w :2 marks | cut -d\  -f2) &&
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit S note dataref sha1
+	COMMIT
+	N ${sha1}x :2
+	EOF
+	cat err &&
+	grep -q "Missing space after SHA1" err
+'
+
+#
+# notemodify, mark in committish
+#
+test_expect_failure 'S: notemodify committish markref junk at eol' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/Snotes
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit S note committish
+	COMMIT
+	N :202 :2x
+	EOF
+	cat err &&
+	grep -q "Garbage after mark" err
+'
+
+#
+# from
+#
+test_expect_failure 'S: from markref junk at eol' '
+	# no &&
+	git fast-import --import-marks=marks --export-marks=marks <<-EOF 2>err
+	commit refs/heads/S2
+	mark :3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit 3
+	COMMIT
+	from :1x
+	M 100644 :103 hello.c
+	EOF
+
+	ret=$? &&
+	echo returned $ret &&
+	test $ret -ne 0 && # failed, but it created the commit
+
+	# go create the commit, need it for merge test
+	git fast-import --import-marks=marks --export-marks=marks <<-EOF &&
+	commit refs/heads/S2
+	mark :3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit 3
+	COMMIT
+	from :1
+	M 100644 :103 hello.c
+	EOF
+
+	# now evaluate the error
+	cat err &&
+	grep -q "Garbage after mark" err
+'
+
+
+#
+# merge
+#
+test_expect_failure 'S: merge markref junk at eol' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	mark :4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit 3
+	COMMIT
+	from :2
+	merge :3x
+	M 100644 :103 hello.c
+	EOF
+	cat err &&
+	grep -q "Garbage after mark" err
+'
+
+#
+# tag, from markref
+#
+test_expect_failure 'S: tag markref junk at eol' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	tag refs/tags/Stag
+	from :2x
+	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<TAG
+	tag S
+	TAG
+	EOF
+	cat err &&
+	grep -q "Garbage after mark" err
+'
+
+#
+# cat-blob markref
+#
+test_expect_success 'S: cat-blob markref junk at eol' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	cat-blob :2x
+	EOF
+	cat err &&
+	grep -q "Garbage after mark" err
+'
+
+#
+# ls markref
+#
+test_expect_failure 'S: ls markref space' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	ls :2x hello.c
+	EOF
+	cat err &&
+	grep -q "Missing space after mark" err
+'
+
+test_expect_failure 'S: ls sha1 space' '
+	sha1=$(grep -w :2 marks | cut -d\  -f2) &&
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	ls ${sha1}x hello.c
+	EOF
+	cat err &&
+	grep -q "Missing space after SHA1" err
+'
+
 test_done
-- 
1.7.10.rc2.2.g38670
