From: David Steven Tweed <d.s.tweed@reading.ac.uk>
Subject: [PATCH] Make git prune remove temporary packs that look like write
 failures
Date: Tue, 5 Feb 2008 18:49:31 +0000 (GMT)
Message-ID: <Pine.GSO.4.63.0802051844220.15867@suma3>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: nico@cam.org, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 20:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMTRi-0000bn-PL
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 20:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759789AbYBET0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 14:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759784AbYBET0H
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 14:26:07 -0500
Received: from vimg1.rdg.ac.uk ([134.225.1.81]:57618 "EHLO vimg1.rdg.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755425AbYBET0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 14:26:04 -0500
X-Greylist: delayed 2189 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2008 14:26:04 EST
Received: from vimp1.rdg.ac.uk ([134.225.2.33])
	by vimg1.rdg.ac.uk (Exim: outgoing gateway)
	with esmtp id 1JMSrM-0002C9-EJ; Tue, 05 Feb 2008 18:49:32 +0000
Received: from suma3.rdg.ac.uk ([134.225.16.13] helo=suma3)
	by vimp1.rdg.ac.uk (Exim: virusscanner)
	with esmtp id 1JMSrM-0002lR-6t; Tue, 05 Feb 2008 18:49:32 +0000
Received: from sis05dst (helo=localhost)
	by suma3 (Exim: forwarder)
	with local-esmtp id 1JMSrL-00048H-00; Tue, 05 Feb 2008 18:49:31 +0000
X-X-Sender: sis05dst@suma3
X-Scan-Signature: df36447177a16a9b9e4582fff66fcd01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72682>

Write errors when repacking (eg, due to out-of-space conditions)
can leave temporary packs (and possibly other files beginning
with "tmp_") lying around which no existing
codepath removes and which aren't obvious to the casual user.
These can also be multi-megabyte files wasting noticeable space.
Unfortunately there's no way to definitely tell in builtin-prune
that a tmp_ file is not being used by a concurrent process.
However, it is documented that pruning should only be done
on a quiet repository. The names of removed files are printed.

Signed-off-by: David Tweed (david.tweed@gmail.com)
---

Per discussion of previous version, this now unconditionally
removes any tmp_ file existing when prune is run.

  builtin-prune.c |   25 +++++++++++++++++++++++++
  1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index b5e7684..9db3cf0 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -83,6 +83,30 @@ static void prune_object_dir(const char *path)
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
+	while ((de = readdir(dir)) != NULL) {
+		if (strncmp(de->d_name, "tmp_", 4) == 0) {
+			char name[4096];
+			sprintf(name, "%s/%s", dirname, de->d_name);
+			printf("Removing abandoned pack %s\n", name);
+			unlink(name);
+		}
+	}
+	closedir(dir);
+}
+
  int cmd_prune(int argc, const char **argv, const char *prefix)
  {
  	int i;
@@ -115,5 +139,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)

  	sync();
  	prune_packed_objects(show_only);
+	remove_temporary_files();
  	return 0;
  }
-- 
1.5.4.19.g40d1a-dirty
