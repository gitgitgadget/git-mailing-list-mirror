From: Junio C Hamano <junkio@cox.net>
Subject: Re: Creating attachments using git-format-patch
Date: Sun, 04 Mar 2007 16:09:52 -0800
Message-ID: <7vzm6s360f.fsf@assigned-by-dhcp.cox.net>
References: <loom.20070303T215950-974@post.gmane.org>
	<7vhct27xk2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703032356050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslcl7jxo.fsf@assigned-by-dhcp.cox.net>
	<7vmz2t7i1x.fsf@assigned-by-dhcp.cox.net>
	<45EB2294.9040702@issaris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Panagiotis Issaris <takis.issaris@uhasselt.be>,
	git@vger.kernel.org
To: Panagiotis Issaris <takis@issaris.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 01:10:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO0mG-0001WR-V9
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 01:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbXCEAJ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 19:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbXCEAJ4
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 19:09:56 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37961 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbXCEAJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 19:09:54 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305000954.FIFT748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Mar 2007 19:09:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Wo9s1W00J1kojtg0000000; Sun, 04 Mar 2007 19:09:53 -0500
In-Reply-To: <45EB2294.9040702@issaris.org> (Panagiotis Issaris's message of
	"Sun, 04 Mar 2007 20:48:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41392>

Panagiotis Issaris <takis@issaris.org> writes:

> The patch did not work for me in the sense that the patches still
> appeared as inline text in both Mutt (1.5.13) and Thunderbird (2 beta
> 2).

Ok, I'll park this in 'next'.

-- >8 --
From: Junio C Hamano <junkio@cox.net>
Date: Sun, 4 Mar 2007 16:08:04 -0800
Subject: [PATCH] format-patch --attach: not folding some long headers.

Panagiotis Issaris reports that some MUAs seem not to like
folded "content-type" and "content-disposition" headers, so this
makes format-patch --attach output to avoid them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 log-tree.c                                         |    6 ++--
 t/t4013-diff-various.sh                            |    2 +-
 ....format-patch_--attach_--stdout_initial..master |   27 ++++++-------------
 ...format-patch_--attach_--stdout_initial..master^ |   18 ++++---------
 ...ff.format-patch_--attach_--stdout_initial..side |    9 ++----
 ....format-patch_--inline_--stdout_initial..master |   27 ++++++-------------
 ...format-patch_--inline_--stdout_initial..master^ |   18 ++++---------
 ...ff.format-patch_--inline_--stdout_initial..side |    9 ++----
 8 files changed, 40 insertions(+), 76 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7b3ad7d..8797aa1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -186,7 +186,7 @@ void show_log(struct rev_info *opt, const char *sep)
 			snprintf(subject_buffer, sizeof(subject_buffer) - 1,
 				 "%s"
 				 "MIME-Version: 1.0\n"
-				 "Content-Type: multipart/mixed;\n"
+				 "Content-Type: multipart/mixed;"
 				 " boundary=\"%s%s\"\n"
 				 "\n"
 				 "This is a multi-part message in MIME "
@@ -202,10 +202,10 @@ void show_log(struct rev_info *opt, const char *sep)
 
 			snprintf(buffer, sizeof(buffer) - 1,
 				 "--%s%s\n"
-				 "Content-Type: text/x-patch;\n"
+				 "Content-Type: text/x-patch;"
 				 " name=\"%s.diff\"\n"
 				 "Content-Transfer-Encoding: 8bit\n"
-				 "Content-Disposition: %s;\n"
+				 "Content-Disposition: %s;"
 				 " filename=\"%s.diff\"\n\n",
 				 mime_boundary_leader, opt->mime_boundary,
 				 sha1,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 28787a1..8345ef5 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -106,7 +106,7 @@ do
 			echo "\$ git $cmd"
 			git $cmd |
 			sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
-			    -e "s/^\\( *boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
+			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
 			echo "\$"
 		} >"$actual" &&
 		if test -f "$expect"
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index 33ce92d..cf6891f 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
@@ -4,8 +4,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
 Subject: [PATCH] Second
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -21,11 +20,9 @@ This is the second commit.
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
- filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: attachment; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -66,8 +63,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH] Third
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -80,11 +76,9 @@ Content-Transfer-Encoding: 8bit
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
- filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: attachment; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -115,8 +109,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH] Side
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -130,11 +123,9 @@ Content-Transfer-Encoding: 8bit
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
- filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: attachment; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index d97625a..fe02587 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
@@ -4,8 +4,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
 Subject: [PATCH] Second
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -21,11 +20,9 @@ This is the second commit.
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
- filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: attachment; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -66,8 +63,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH] Third
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -80,11 +76,9 @@ Content-Transfer-Encoding: 8bit
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
- filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: attachment; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index 0b6853d..9ff828e 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
@@ -4,8 +4,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH] Side
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -19,11 +18,9 @@ Content-Transfer-Encoding: 8bit
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
- filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: attachment; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
index 68c9884..aa110c0 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
@@ -4,8 +4,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
 Subject: [PATCH] Second
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -21,11 +20,9 @@ This is the second commit.
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
- filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -66,8 +63,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH] Third
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -80,11 +76,9 @@ Content-Transfer-Encoding: 8bit
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
- filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -115,8 +109,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH] Side
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -130,11 +123,9 @@ Content-Transfer-Encoding: 8bit
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
- filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
index 6008e77..95e9ea4 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
@@ -4,8 +4,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
 Subject: [PATCH] Second
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -21,11 +20,9 @@ This is the second commit.
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
- filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -66,8 +63,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH] Third
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -80,11 +76,9 @@ Content-Transfer-Encoding: 8bit
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
- filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..side b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
index c4d3da9..86ae923 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
@@ -4,8 +4,7 @@ From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH] Side
 MIME-Version: 1.0
-Content-Type: multipart/mixed;
- boundary="------------g-i-t--v-e-r-s-i-o-n"
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
 
 This is a multi-part message in MIME format.
 --------------g-i-t--v-e-r-s-i-o-n
@@ -19,11 +18,9 @@ Content-Transfer-Encoding: 8bit
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
- name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
- filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
-- 
1.5.0.2.878.g38f47
