From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add "--expire <time>" option to 'git prune'
Date: Thu, 29 Nov 2007 14:21:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711291419350.27959@racer.site>
References: <200711181225.52288.johannes.sixt@telecom.at>
 <7v3av3wg7h.fsf@gitster.siamese.dyndns.org> <200711182101.53936.johannes.sixt@telecom.at>
 <7v7ikfuxfk.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711290340470.27959@racer.site>
 <7vaboxy3va.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711291146090.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	pasky@suse.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 15:22:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxkH7-0000Fi-0R
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 15:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbXK2OVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 09:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbXK2OVg
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 09:21:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:40554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932083AbXK2OVf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 09:21:35 -0500
Received: (qmail invoked by alias); 29 Nov 2007 14:21:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 29 Nov 2007 15:21:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1945ORqcK14hLnpvflZZ0TKx3rcJo5C72DcmxpUy/
	/iNo3XETM3Q+Hg
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711291146090.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66536>


Earlier, 'git prune' would prune all loose unreachable objects.
This could be quite dangerous, as the objects could be used in
an ongoing operation.

This patch adds a mode to expire only loose, unreachable objects
which are older than a certain time.  For example, by

	git prune --expire 14.days

you can prune only those objects which are loose, unreachable
and older than 14 days (and thus probably outdated).

The implementation uses st.st_mtime rather than st.st_ctime,
because it can be tested better, using 'touch -d <time>' (and
omitting the test when the platform does not support that
command line switch).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 29 Nov 2007, Johannes Schindelin wrote:

	> Note that "prune" is not (yet) an option [for repo.or.cz], since 
	> it could possibly destroy objects which are needed in an ongoing 
	> push operation.
	> 
	> However, we could do exactly the same as with reflogs: introduce 
	> a grace period (with loose objects, we can use the ctime...)

	and this patch does that (except using mtime as ctime, for reasons 
	explained in the commit message.

	Obviously, this patch is asking for a cousin, changing
	git-gc to use this option, and maybe introduce a config
	variable gc.pruneAge.

 Documentation/git-prune.txt |    5 ++++-
 builtin-prune.c             |   21 ++++++++++++++++++++-
 t/t1410-reflog.sh           |   18 ++++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 0ace233..9835bdb 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -8,7 +8,7 @@ git-prune - Prune all unreachable objects from the object database
 
 SYNOPSIS
 --------
-'git-prune' [-n] [--] [<head>...]
+'git-prune' [-n] [--expire <expire>] [--] [<head>...]
 
 DESCRIPTION
 -----------
@@ -31,6 +31,9 @@ OPTIONS
 \--::
 	Do not interpret any more arguments as options.
 
+\--expire <time>::
+	Only expire loose objects older than <time>.
+
 <head>...::
 	In addition to objects
 	reachable from any of our references, keep objects
diff --git a/builtin-prune.c b/builtin-prune.c
index 44df59e..b5e7684 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -7,15 +7,24 @@
 
 static const char prune_usage[] = "git-prune [-n]";
 static int show_only;
+static unsigned long expire;
 
 static int prune_object(char *path, const char *filename, const unsigned char *sha1)
 {
+	const char *fullpath = mkpath("%s/%s", path, filename);
+	if (expire) {
+		struct stat st;
+		if (lstat(fullpath, &st))
+			return error("Could not stat '%s'", fullpath);
+		if (st.st_mtime > expire)
+			return 0;
+	}
 	if (show_only) {
 		enum object_type type = sha1_object_info(sha1, NULL);
 		printf("%s %s\n", sha1_to_hex(sha1),
 		       (type > 0) ? typename(type) : "unknown");
 	} else
-		unlink(mkpath("%s/%s", path, filename));
+		unlink(fullpath);
 	return 0;
 }
 
@@ -85,6 +94,16 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 			show_only = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--expire")) {
+			if (++i < argc) {
+				expire = approxidate(argv[i]);
+				continue;
+			}
+		}
+		else if (!prefixcmp(arg, "--expire=")) {
+			expire = approxidate(arg + 9);
+			continue;
+		}
 		usage(prune_usage);
 	}
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 12a53ed..f093802 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -201,4 +201,22 @@ test_expect_success 'delete' '
 	! grep dragon < output
 '
 
+test_expect_success 'prune --expire' '
+
+	BLOB=$(echo aleph | git hash-object -w --stdin) &&
+	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
+	test 20 = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	git reset --hard &&
+	if touch -d "Jan 1 1970" $BLOB_FILE
+	then
+		git prune --expire 1.day &&
+		test 19 = $(git count-objects | sed "s/ .*//") &&
+		! test -f $BLOB_FILE
+	else
+		say "Skipping test due to non-working touch -d"
+	fi
+
+'
+
 test_done
-- 
1.5.3.6.2087.g788ea4
