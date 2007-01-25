From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Consolidate {receive,fetch}.unpackLimit
Date: Wed, 24 Jan 2007 17:14:08 -0800
Message-ID: <7v1wljc3hb.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0701231101040.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 02:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9tBv-0001ak-PA
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 02:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbXAYBOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 20:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbXAYBOL
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 20:14:11 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38669 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbXAYBOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 20:14:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125011409.YCUH18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 20:14:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FDET1W00W1kojtg0000000; Wed, 24 Jan 2007 20:14:27 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37700>

This allows transfer.unpackLimit to specify what these two
configuration variables want to set.

We would probably want to deprecate the two separate variables,
as I do not see much point in specifying them independently.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/config.txt |    5 +++++
 fetch-pack.c             |   14 +++++++++++++-
 receive-pack.c           |   24 ++++++++++++++++--------
 t/t5500-fetch-pack.sh    |    2 +-
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 383ff29..8086d75 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -488,3 +488,8 @@ receive.denyNonFastForwards::
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
 
+transfer.unpackLimit::
+	When `fetch.unpackLimit` or `receive.unpackLimit` are
+	not set, the value of this variable is used instead.
+
+
diff --git a/fetch-pack.c b/fetch-pack.c
index fc0534c..83a1d7b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -8,6 +8,8 @@
 #include "sideband.h"
 
 static int keep_pack;
+static int transfer_unpack_limit = -1;
+static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
 static int quiet;
 static int verbose;
@@ -645,7 +647,12 @@ static int remove_duplicates(int nr_heads, char **heads)
 static int fetch_pack_config(const char *var, const char *value)
 {
 	if (strcmp(var, "fetch.unpacklimit") == 0) {
-		unpack_limit = git_config_int(var, value);
+		fetch_unpack_limit = git_config_int(var, value);
+		return 0;
+	}
+
+	if (strcmp(var, "transfer.unpacklimit") == 0) {
+		transfer_unpack_limit = git_config_int(var, value);
 		return 0;
 	}
 
@@ -666,6 +673,11 @@ int main(int argc, char **argv)
 	setup_ident();
 	git_config(fetch_pack_config);
 
+	if (0 <= transfer_unpack_limit)
+		unpack_limit = transfer_unpack_limit;
+	else if (0 <= fetch_unpack_limit)
+		unpack_limit = fetch_unpack_limit;
+
 	nr_heads = 0;
 	heads = NULL;
 	for (i = 1; i < argc; i++) {
diff --git a/receive-pack.c b/receive-pack.c
index b3a4552..8b59b32 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -10,6 +10,8 @@
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
 static int deny_non_fast_forwards = 0;
+static int receive_unpack_limit = -1;
+static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
 
@@ -18,21 +20,22 @@ static int capabilities_sent;
 
 static int receive_pack_config(const char *var, const char *value)
 {
-	git_default_config(var, value);
-
-	if (strcmp(var, "receive.denynonfastforwards") == 0)
-	{
+	if (strcmp(var, "receive.denynonfastforwards") == 0) {
 		deny_non_fast_forwards = git_config_bool(var, value);
 		return 0;
 	}
 
-	if (strcmp(var, "receive.unpacklimit") == 0)
-	{
-		unpack_limit = git_config_int(var, value);
+	if (strcmp(var, "receive.unpacklimit") == 0) {
+		receive_unpack_limit = git_config_int(var, value);
 		return 0;
 	}
 
-	return 0;
+	if (strcmp(var, "transfer.unpacklimit") == 0) {
+		transfer_unpack_limit = git_config_int(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value);
 }
 
 static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
@@ -431,6 +434,11 @@ int main(int argc, char **argv)
 	ignore_missing_committer_name();
 	git_config(receive_pack_config);
 
+	if (0 <= transfer_unpack_limit)
+		unpack_limit = transfer_unpack_limit;
+	else if (0 <= receive_unpack_limit)
+		unpack_limit = receive_unpack_limit;
+
 	write_head_info();
 
 	/* EOF */
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 7fd651b..058cce0 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -98,7 +98,7 @@ pull_to_client () {
 	mkdir client &&
 	cd client &&
 	git-init 2>> log2.txt &&
-	git repo-config fetch.unpacklimit 0
+	git repo-config transfer.unpacklimit 0
 )
 
 add A1
-- 
1.5.0.rc2.gae1d
