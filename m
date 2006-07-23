From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-objects: check pack.window for default window size
Date: Sun, 23 Jul 2006 01:50:30 -0400
Message-ID: <20060723055030.GA25790@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 23 07:50:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4WrL-0007Hp-4J
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 07:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWGWFuc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 01:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWGWFuc
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 01:50:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2266 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750800AbWGWFub (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Jul 2006 01:50:31 -0400
Received: (qmail 12061 invoked from network); 23 Jul 2006 01:50:06 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Jul 2006 01:50:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Jul 2006 01:50:30 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24086>

Signed-off-by: Jeff King <peff@peff.net>
---
For some repositories, deltas simply don't make sense. One can disable
them for git-repack by adding --window, but git-push insists on making
the deltas which can be very CPU-intensive for little benefit.

 Documentation/config.txt |    4 ++++
 pack-objects.c           |   13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0b434c1..bc43da8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -193,6 +193,10 @@ merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
 
+pack.window::
+	The size of the window used by gitlink:git-pack-objects[1] when no
+	window size is given on the command line. Defaults to 10.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/pack-objects.c b/pack-objects.c
index 04a48b9..861c7f0 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -63,6 +63,7 @@ static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static volatile sig_atomic_t progress_update = 0;
+static int window = 10;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -1216,16 +1217,26 @@ static void setup_progress_signal(void)
 	setitimer(ITIMER_REAL, &v, NULL);
 }
 
+static int git_pack_config(const char *k, const char *v)
+{
+	if(!strcmp(k, "pack.window")) {
+		window = git_config_int(k, v);
+		return 0;
+	}
+	return git_default_config(k, v);
+}
+
 int main(int argc, char **argv)
 {
 	SHA_CTX ctx;
 	char line[40 + 1 + PATH_MAX + 2];
-	int window = 10, depth = 10, pack_to_stdout = 0;
+	int depth = 10, pack_to_stdout = 0;
 	struct object_entry **list;
 	int num_preferred_base = 0;
 	int i;
 
 	setup_git_directory();
+	git_config(git_pack_config);
 
 	progress = isatty(2);
 	for (i = 1; i < argc; i++) {
-- 
1.4.2.rc1.ge7a0-dirty
