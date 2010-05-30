From: Johan Herland <johan@herland.net>
Subject: [PATCH] diff.c: Ensure "index $from..$to" line contains unambiguous
 SHA1s
Date: Sun, 30 May 2010 15:37:17 +0200
Message-ID: <201005301537.18039.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 30 16:22:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIjPK-0002pj-FM
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 16:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab0E3OTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 10:19:35 -0400
Received: from smtp.getmail.no ([84.208.15.66]:46515 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754267Ab0E3OTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 10:19:35 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3800E0XJ677C60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 30 May 2010 15:37:19 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 29BCA1EA555C_C026A0FB	for <git@vger.kernel.org>; Sun,
 30 May 2010 13:37:18 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 7CF8F1EA2BBC_C026A0EF	for <git@vger.kernel.org>; Sun,
 30 May 2010 13:37:18 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3800DI0J667340@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 30 May 2010 15:37:18 +0200 (MEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148005>

In the metainfo section of git diffs there's an "index" line providing
abbreviated (unless --full-index is used) blob SHA1s from the
pre-/post-images used to generate the diff. These provide hints that
can be used to reconstruct a 3-way merge when applying the patch
(see the --3way option to 'git am' for more details).

In order for this to work, however, the blob SHA1s must not be
abbreviated into ambiguity.

This patch eliminates the possible ambiguity by using find_unique_abbrev()
to produce the abbreviated SHA1s (instead of blind abbreviation by way of
"%.*s").

A testcase verifying the fix is also included.

Signed-off-by: Johan Herland <johan@herland.net>
---
 diff.c                              |    6 +++---
 t/t4043-diff-index-unique-abbrev.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100755 t/t4043-diff-index-unique-abbrev.sh

diff --git a/diff.c b/diff.c
index 494f560..1aefa66 100644
--- a/diff.c
+++ b/diff.c
@@ -2419,9 +2419,9 @@ static void fill_metainfo(struct strbuf *msg,
 			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
 				abbrev = 40;
 		}
-		strbuf_addf(msg, "index %.*s..%.*s",
-			    abbrev, sha1_to_hex(one->sha1),
-			    abbrev, sha1_to_hex(two->sha1));
+		strbuf_addf(msg, "index %s..",
+			    find_unique_abbrev(one->sha1, abbrev));
+		strbuf_addstr(msg, find_unique_abbrev(two->sha1, abbrev));
 		if (one->mode == two->mode)
 			strbuf_addf(msg, " %06o", one->mode);
 		strbuf_addch(msg, '\n');
diff --git a/t/t4043-diff-index-unique-abbrev.sh b/t/t4043-diff-index-unique-abbrev.sh
new file mode 100755
index 0000000..d5ce72b
--- /dev/null
+++ b/t/t4043-diff-index-unique-abbrev.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description='test unique sha1 abbreviation on "index from..to" line'
+. ./test-lib.sh
+
+cat >expect_initial <<EOF
+100644 blob 51d2738463ea4ca66f8691c91e33ce64b7d41bb1	foo
+EOF
+
+cat >expect_update <<EOF
+100644 blob 51d2738efb4ad8a1e40bed839ab8e116f0a15e47	foo
+EOF
+
+test_expect_success 'setup' '
+	echo 4827 > foo &&
+	git add foo &&
+	git commit -m "initial" &&
+	git cat-file -p HEAD: > actual &&
+	test_cmp expect_initial actual &&
+	echo 11742 > foo &&
+	git commit -a -m "update" &&
+	git cat-file -p HEAD: > actual &&
+	test_cmp expect_update actual
+'
+
+cat >expect <<EOF
+index 51d27384..51d2738e 100644
+EOF
+
+test_expect_success 'diff does not produce ambiguous index line' '
+	git diff HEAD^..HEAD | grep index > actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.0.4
