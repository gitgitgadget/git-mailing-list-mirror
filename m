From: David Steven Tweed <d.s.tweed@reading.ac.uk>
Subject: [PATCH v2] Make git prune remove temporary packs that look like
 write failures
Date: Wed, 6 Feb 2008 23:48:33 +0000 (GMT)
Message-ID: <Pine.GSO.4.63.0802062342020.7187@suma3>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: nico@cam.org, Johannes.Schindelin@gmx.de, casey@nrlssc.navy.mil
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 00:49:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMu0w-0001DE-QM
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 00:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760014AbYBFXsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 18:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759821AbYBFXsi
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 18:48:38 -0500
Received: from vimg3.rdg.ac.uk ([134.225.1.80]:57895 "EHLO vimg3.rdg.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758476AbYBFXsh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 18:48:37 -0500
Received: from vimp1.rdg.ac.uk ([134.225.2.33])
	by vimg3.rdg.ac.uk (Exim: gateway)
	with esmtp id 1JMu0J-00045p-00; Wed, 06 Feb 2008 23:48:35 +0000
Received: from suma3.rdg.ac.uk ([134.225.16.13] helo=suma3)
	by vimp1.rdg.ac.uk (Exim: virusscanner)
	with esmtp id 1JMu0I-0006R6-UQ; Wed, 06 Feb 2008 23:48:35 +0000
Received: from sis05dst (helo=localhost)
	by suma3 (Exim: forwarder)
	with local-esmtp id 1JMu0H-0001uV-00; Wed, 06 Feb 2008 23:48:33 +0000
X-X-Sender: sis05dst@suma3
X-Scan-Signature: d4ee3f2c3b5c07d2449287d698a6b1d5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72877>

Write errors when repacking (eg, due to out-of-space conditions)
can leave temporary packs (and possibly other files beginning
with "tmp_") lying around which no existing
codepath removes and which aren't obvious to the casual user.
These can also be multi-megabyte files wasting noticeable space.
Unfortunately there's no way to definitely tell in builtin-prune
that a tmp_ file is not being used by a concurrent process.
However, it is documented that pruning should only be done
on a quiet repository and --expire is honoured (using code
from Johannes Schindelin). The names of removed files are printed.

Signed-off-by: David Tweed (david.tweed@gmail.com)
---

This version incorporates all the agreed with changes from the
previous version, and since I was modifying the relevant
context lines it includes Johannes' code honouring --expire
(but not the test he wrote which is presumably best sent as a separate 
patch from him).

Hopefully this one won't get whitespace munged.

 builtin-prune.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index b5e7684..f25ddb6 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -83,6 +83,44 @@ static void prune_object_dir(const char *path)
 	}
 }

+/*
+ * Write errors (particularly out of space) can result in
+ * failed temporary packs (and more rarely indexes and other
+ * files begining with "tmp_") accumulating in the
+ * object directory.
+ */
+static void remove_temporary_files(void)
+{
+	DIR *dir;
+	struct dirent *de;
+	char* dirname=get_object_directory();
+
+	dir = opendir(dirname);
+	if (!dir) {
+		fprintf(stderr, "Unable to open object directory %s\n",
+			dirname);
+		return;
+	}
+	while ((de = readdir(dir)) != NULL) {
+		if (!prefixcmp(de->d_name, "tmp_")) {
+			char name[PATH_MAX];
+			int c = snprintf(name, PATH_MAX, "%s/%s",
+					 dirname, de->d_name);
+			if (c < 0 || c >= PATH_MAX)
+				continue;
+			if (expire) {
+				struct stat st;
+				if (stat(name, &st) != 0 || st.st_mtime >= expire)
+					continue;
+			}
+			printf("Removing stale temporary file %s\n", name);
+			if (!show_only)
+				unlink(name);
+		}
+	}
+	closedir(dir);
+}
+
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -115,5 +153,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)

 	sync();
 	prune_packed_objects(show_only);
+	remove_temporary_files();
 	return 0;
 }
