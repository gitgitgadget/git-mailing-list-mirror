From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-apply: guess correct -p<n> value for non-git patches.
Date: Wed, 21 Feb 2007 16:24:22 -0800
Message-ID: <7vtzxfm43t.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<20070217233203.GA6014@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
	<7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
	<7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702210014140.6485@iabervon.org>
	<Pine.LNX.4.64.0702210836210.4043@woody.linux-foundation.org>
	<7vr6sjnw15.fsf@assigned-by-dhcp.cox.net>
	<7vy7mrm9ch.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 22 01:24:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK1lW-0006Ui-S5
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 01:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945913AbXBVAYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 19:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161195AbXBVAYZ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 19:24:25 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64421 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161175AbXBVAYX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 19:24:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222002424.OOIA233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 19:24:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SQQN1W0051kojtg0000000; Wed, 21 Feb 2007 19:24:22 -0500
In-Reply-To: <7vy7mrm9ch.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 21 Feb 2007 14:31:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40331>

This enhances the third point in the previous commit.  When
applying a non-git patch that begins like this:

	--- 2.6.orig/mm/slab.c
	+++ 2.6/mm/slab.c
	@@ -N,M +L,K @@@
	...

and if you are in 'mm' subdirectory, we notice that -p2 is the
right option to use to apply the patch in file slab.c in the
current directory (i.e. mm/slab.c)

The guess function also knows about this pattern, where you
would need to use -p0 if applying from the top-level:

	--- mm/slab.c
	+++ mm/slab.c
	@@ -N,M +L,K @@@
	...

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-apply.c         |   59 +++++++++++++++++++++++++++++++++++++++++++++-
 t/t4119-apply-config.sh |   56 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 12f00e3..c7d4bdd 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -28,6 +28,7 @@ static int newfd = -1;
 
 static int unidiff_zero;
 static int p_value = 1;
+static int p_value_known;
 static int check_index;
 static int write_index;
 static int cached;
@@ -312,11 +313,54 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 	return name;
 }
 
+static int count_slashes(const char *cp)
+{
+	int cnt = 0;
+	char ch;
+
+	while ((ch = *cp++))
+		if (ch == '/')
+			cnt++;
+	return cnt;
+}
+
+/*
+ * Given the string after "--- " or "+++ ", guess the appropriate
+ * p_value for the given patch.
+ */
+static int guess_p_value(const char *nameline)
+{
+	char *name, *cp;
+	int val = -1;
+
+	if (is_dev_null(nameline))
+		return -1;
+	name = find_name(nameline, NULL, 0, TERM_SPACE | TERM_TAB);
+	if (!name)
+		return -1;
+	cp = strchr(name, '/');
+	if (!cp)
+		val = 0;
+	else if (prefix) {
+		/*
+		 * Does it begin with "a/$our-prefix" and such?  Then this is
+		 * very likely to apply to our directory.
+		 */
+		if (!strncmp(name, prefix, prefix_length))
+			val = count_slashes(prefix);
+		else {
+			cp++;
+			if (!strncmp(cp, prefix, prefix_length))
+				val = count_slashes(prefix) + 1;
+		}
+	}
+	free(name);
+	return val;
+}
+
 /*
  * Get the name etc info from the --/+++ lines of a traditional patch header
  *
- * NOTE! This hardcodes "-p1" behaviour in filename detection.
- *
  * FIXME! The end-of-filename heuristics are kind of screwy. For existing
  * files, we can happily check the index for a match, but for creating a
  * new file we should try to match whatever "patch" does. I have no idea.
@@ -327,6 +371,16 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 
 	first += 4;	/* skip "--- " */
 	second += 4;	/* skip "+++ " */
+	if (!p_value_known) {
+		int p, q;
+		p = guess_p_value(first);
+		q = guess_p_value(second);
+		if (p < 0) p = q;
+		if (0 <= p && p == q) {
+			p_value = p;
+			p_value_known = 1;
+		}
+	}
 	if (is_dev_null(first)) {
 		patch->is_new = 1;
 		patch->is_delete = 0;
@@ -2656,6 +2710,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		}
 		if (!strncmp(arg, "-p", 2)) {
 			p_value = atoi(arg + 2);
+			p_value_known = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--no-add")) {
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index 32e0d71..55f4673 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -19,7 +19,7 @@ test_expect_success setup '
 '
 
 # Also handcraft GNU diff output; note this has trailing whitespace.
-cat >gpatch.file <<\EOF
+cat >gpatch.file <<\EOF &&
 --- file1	2007-02-21 01:04:24.000000000 -0800
 +++ file1+	2007-02-21 01:07:44.000000000 -0800
 @@ -1 +1 @@
@@ -27,6 +27,12 @@ cat >gpatch.file <<\EOF
 +B 
 EOF
 
+sed -e 's|file1|sub/&|' gpatch.file >gpatch-sub.file &&
+sed -e '
+	/^--- /s|file1|a/sub/&|
+	/^+++ /s|file1|b/sub/&|
+' gpatch.file >gpatch-ab-sub.file &&
+
 test_expect_success 'apply --whitespace=strip' '
 
 	rm -f sub/file1 &&
@@ -124,7 +130,53 @@ test_expect_success 'same in subdir but with traditional patch input' '
 	git update-index --refresh &&
 
 	cd sub &&
-	git apply -p0 ../gpatch.file &&
+	git apply ../gpatch.file &&
+	if grep " " file1
+	then
+		echo "Eh?"
+		false
+	elif grep B file1
+	then
+		echo Happy
+	else
+		echo "Huh?"
+		false
+	fi
+'
+
+test_expect_success 'same but with traditional patch input of depth 1' '
+
+	cd "$D" &&
+	git config apply.whitespace strip &&
+	rm -f sub/file1 &&
+	cp saved sub/file1 &&
+	git update-index --refresh &&
+
+	cd sub &&
+	git apply ../gpatch-sub.file &&
+	if grep " " file1
+	then
+		echo "Eh?"
+		false
+	elif grep B file1
+	then
+		echo Happy
+	else
+		echo "Huh?"
+		false
+	fi
+'
+
+test_expect_success 'same but with traditional patch input of depth 2' '
+
+	cd "$D" &&
+	git config apply.whitespace strip &&
+	rm -f sub/file1 &&
+	cp saved sub/file1 &&
+	git update-index --refresh &&
+
+	cd sub &&
+	git apply ../gpatch-ab-sub.file &&
 	if grep " " file1
 	then
 		echo "Eh?"
-- 
1.5.0.1.615.gfb51
