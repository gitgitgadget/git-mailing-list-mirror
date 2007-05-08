From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] Add pack.depth option to git-pack-objects and change default depth to 50
Date: Tue,  8 May 2007 09:28:26 -0400
Message-ID: <11786309072612-git-send-email-tytso@mit.edu>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu>
Cc: Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 15:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlPkD-0008S8-RS
	for gcvg-git@gmane.org; Tue, 08 May 2007 15:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934716AbXEHN2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 09:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934738AbXEHN2j
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 09:28:39 -0400
Received: from THUNK.ORG ([69.25.196.29]:60762 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934716AbXEHN2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 09:28:36 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HlPqo-0002Rs-Nd; Tue, 08 May 2007 09:35:35 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HlPjv-0007qK-Cb; Tue, 08 May 2007 09:28:27 -0400
X-Mailer: git-send-email 1.5.2.rc2.22.ga39d
In-Reply-To: <11786309073709-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46575>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/config.txt           |    6 +++++-
 Documentation/git-pack-objects.txt |    2 +-
 Documentation/git-repack.txt       |    2 +-
 builtin-pack-objects.c             |    6 +++++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 24f9655..c7674c2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -544,7 +544,11 @@ merge.<driver>.recursive::
 
 pack.window::
 	The size of the window used by gitlink:git-pack-objects[1] when no
-	window size is given on the command line. Defaults to 10.
+	window size is given on the command line.  Defaults to 10.
+
+pack.depth::
+	The maximum delta depth used by gitlink:git-pack-objects[1] when no
+	maximum depth is given on the command line.  Defaults to 50.
 
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d9e11c6..bd3ee45 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -83,7 +83,7 @@ base-name::
 	it too deep affects the performance on the unpacker
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
-	The default value for both --window and --depth is 10.
+	The default value for --window is 10 and --depth is 50.
 
 --incremental::
 	This flag causes an object already in a pack ignored
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d39abc1..cc3b0b2 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -63,7 +63,7 @@ OPTIONS
 	space. `--depth` limits the maximum delta depth; making it too deep
 	affects the performance on the unpacker side, because delta data needs
 	to be applied that many times to get to the necessary object.
-	The default value for both --window and --depth is 10.
+	The default value for --window is 10 and --depth is 50.
 
 
 Configuration
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 7bff8ea..966f843 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -64,6 +64,7 @@ static char tmpname[PATH_MAX];
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static int window = 10;
+static int depth = 50;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress progress_state;
@@ -1489,6 +1490,10 @@ static int git_pack_config(const char *k, const char *v)
 		window = git_config_int(k, v);
 		return 0;
 	}
+	if(!strcmp(k, "pack.depth")) {
+		depth = git_config_int(k, v);
+		return 0;
+	}
 	return git_default_config(k, v);
 }
 
@@ -1584,7 +1589,6 @@ static int adjust_perm(const char *path, mode_t mode)
 
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
-	int depth = 10;
 	int use_internal_rev_list = 0;
 	int thin = 0;
 	uint32_t i;
-- 
1.5.2.rc2.22.ga39d
