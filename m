From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] builtin-replace: teach "git replace" to actually
 replace
Date: Mon, 2 Feb 2009 06:12:53 +0100
Message-ID: <20090202061253.14305fad.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 06:14:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTr8s-0005cZ-AU
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 06:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbZBBFNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 00:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbZBBFNI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 00:13:08 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:59534 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbZBBFNH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 00:13:07 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3EACC81807C;
	Mon,  2 Feb 2009 06:12:58 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id 40585818073;
	Mon,  2 Feb 2009 06:12:56 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108046>

Teach the syntax: "git replace <object> <replacement>", so that
"git replace" can now create replace refs. These replace refs
will be used by read_sha1_file to substitute <object> with
<replacement> for most of the commands.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-replace.c  |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t6050-replace.sh |   10 ++++++++++
 2 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/builtin-replace.c b/builtin-replace.c
index b5c40aa..e3767b9 100644
--- a/builtin-replace.c
+++ b/builtin-replace.c
@@ -14,6 +14,7 @@
 #include "parse-options.h"
 
 static const char * const git_replace_usage[] = {
+	"git replace [-f] <object> <replacement>",
 	"git replace -d <object>...",
 	"git replace -l [<pattern>]",
 	NULL
@@ -77,12 +78,46 @@ static int delete_replace_ref(const char *name, const char *ref,
 	return 0;
 }
 
+static int replace_object(const char *object_ref, const char *replace_ref,
+			  int force)
+{
+	unsigned char object[20], prev[20], repl[20];
+	char ref[PATH_MAX];
+	struct ref_lock *lock;
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+	if (get_sha1(replace_ref, repl))
+		die("Failed to resolve '%s' as a valid ref.", replace_ref);
+
+	if (snprintf(ref, sizeof(ref),
+		     "refs/replace/%s",
+		     sha1_to_hex(object)) > sizeof(ref) - 1)
+		die("replace ref name too long: %.*s...", 50, ref);
+	if (check_ref_format(ref))
+		die("'%s' is not a valid ref name.", ref);
+
+	if (!resolve_ref(ref, prev, 1, NULL))
+		hashclr(prev);
+	else if (!force)
+		die("replace ref '%s' already exists", ref);
+
+	lock = lock_any_ref_for_update(ref, prev, 0);
+	if (!lock)
+		die("%s: cannot lock the ref", ref);
+	if (write_ref_sha1(lock, repl, NULL) < 0)
+		die("%s: cannot update the ref", ref);
+
+	return 0;
+}
+
 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
-	int list = 0, delete = 0;
+	int list = 0, delete = 0, force = 0;
 	struct option options[] = {
 		OPT_BOOLEAN('l', NULL, &list, "list replace refs"),
 		OPT_BOOLEAN('d', NULL, &delete, "delete replace refs"),
+		OPT_BOOLEAN('f', NULL, &force, "replace the ref if it exists"),
 		OPT_END()
 	};
 
@@ -91,15 +126,28 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	if (list && delete)
 		usage_with_options(git_replace_usage, options);
 
+	if (force && (list || delete))
+		usage_with_options(git_replace_usage, options);
+
+	/* Delete refs */
 	if (delete) {
 		if (argc < 1)
 			usage_with_options(git_replace_usage, options);
 		return for_each_replace_name(argv, delete_replace_ref);
 	}
 
+	/* Replace object */
+	if (!list && argc) {
+		if (argc != 2)
+			usage_with_options(git_replace_usage, options);
+		return replace_object(argv[0], argv[1], force);
+	}
+
 	/* List refs, even if "list" is not set */
 	if (argc > 1)
 		usage_with_options(git_replace_usage, options);
+	if (force)
+		usage_with_options(git_replace_usage, options);
 
 	return list_replace_refs(argv[0]);
 }
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index bf4c93f..448a19a 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -114,9 +114,19 @@ test_expect_success '"git replace" listing and deleting' '
      test_must_fail git replace -d &&
      test_must_fail git replace -l -d $HASH2 &&
      git replace -d $HASH2 &&
+     git show $HASH2 | grep "A U Thor" &&
      test -z "$(git replace -l)"
 '
 
+test_expect_success '"git replace" replacing' '
+     git replace $HASH2 $R &&
+     git show $HASH2 | grep "O Thor" &&
+     test_must_fail git replace $HASH2 $R &&
+     git replace -f $HASH2 $R &&
+     test_must_fail git replace -f &&
+     test "$HASH2" = "$(git replace)"
+'
+
 #
 #
 test_done
-- 
1.6.1.2.353.g99fdd.dirty
