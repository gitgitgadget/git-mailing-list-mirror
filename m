From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add "--expire <time>" option to 'git prune'
Date: Thu, 29 Nov 2007 20:59:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711292058110.27959@racer.site>
References: <200711181225.52288.johannes.sixt@telecom.at>
 <7v3av3wg7h.fsf@gitster.siamese.dyndns.org> <200711182101.53936.johannes.sixt@telecom.at>
 <7v7ikfuxfk.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711290340470.27959@racer.site>
 <7vaboxy3va.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711291146090.27959@racer.site>
 <Pine.LNX.4.64.0711291419350.27959@racer.site> <7vlk8gvmts.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	pasky@suse.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 22:01:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxqVK-0008GO-Re
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 22:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbXK2VAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 16:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbXK2VAl
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 16:00:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:51274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932578AbXK2VAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 16:00:40 -0500
Received: (qmail invoked by alias); 29 Nov 2007 21:00:37 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp021) with SMTP; 29 Nov 2007 22:00:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/S0GYomK7SdPZDJFWSfl+7Fy1wW8xAq25SxcwZnW
	LACvtU7Mx6FHmy
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlk8gvmts.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66562>


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

	On Thu, 29 Nov 2007, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > The implementation uses st.st_mtime rather than st.st_ctime,
	> > because it can be tested better, using 'touch -d <time>' (and
	> > omitting the test when the platform does not support that
	> > command line switch).
	> 
	> But I think you can use more portable -t for setting mtime to
	> 1970/01/01, but I had a feeling that earlier we were bitten by
	> non-portability of "touch" and introduced test-chmtime.

	Somehow that slipped by me.  This patch uses test-chmtime.

 Documentation/git-prune.txt |    5 ++++-
 builtin-prune.c             |   21 ++++++++++++++++++++-
 t/t1410-reflog.sh           |   17 +++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

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
index 12a53ed..4a17573 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -201,4 +201,21 @@ test_expect_success 'delete' '
 	! grep dragon < output
 '
 
+test_expect_success 'prune --expire' '
+
+	BLOB=$(echo aleph | git hash-object -w --stdin) &&
+	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
+	test 20 = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	git reset --hard &&
+	git prune --expire=1.hour.ago &&
+	test 20 = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	test-chmtime -86400 $BLOB_FILE &&
+	git prune --expire 1.day &&
+	test 19 = $(git count-objects | sed "s/ .*//") &&
+	! test -f $BLOB_FILE
+
+'
+
 test_done
-- 
1.5.3.6.2088.g8c260
