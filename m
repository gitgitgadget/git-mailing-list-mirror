From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fetch-pack: remove --keep-auto and make it the default.
Date: Wed, 24 Jan 2007 17:14:00 -0800
Message-ID: <7v7ivbc3hj.fsf@assigned-by-dhcp.cox.net>
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
X-From: git-owner@vger.kernel.org Thu Jan 25 02:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9tBn-0001YA-32
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 02:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbXAYBOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 20:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXAYBOE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 20:14:04 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60023 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbXAYBOD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 20:14:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125011401.DBCD7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 20:14:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FDEK1W00A1kojtg0000000; Wed, 24 Jan 2007 20:14:19 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37699>

This makes git-fetch over git native protocol to automatically
decide to keep the downloaded pack if the fetch results in more
than 100 objects, just like receive-pack invoked by git-push
does.  This logic is disabled when --keep is explicitly given
from the command line, so that a very small clone still keeps
the downloaded pack as before.

The 100 threshold can be adjusted with fetch.unpacklimit
configuration.  We might want to introduce transfer.unpacklimit
to consolidate the two unpacklimit variables, which will be a
topic for the next patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
  Nicolas Pitre <nico@cam.org> writes:

  > On Tue, 23 Jan 2007, Johannes Schindelin wrote:
  >
  >> On Mon, 22 Jan 2007, Junio C Hamano wrote:
  >> 
  >> > We may want to later make this the default.
  >> 
  >> You have my vote for sooner rather than later.
  >
  > Seconded.
  >
  > Nicolas

  Ok, how about this, on top of the previous ones?

 Documentation/config.txt |   10 ++++++++++
 fetch-pack.c             |   31 +++++++++++++++++--------------
 t/t5500-fetch-pack.sh    |    3 ++-
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d8244b1..383ff29 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -295,6 +295,16 @@ diff.renames::
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
 
+fetch.unpackLimit::
+	If the number of objects fetched over the git native
+	transfer is below this
+	limit, then the objects will be unpacked into loose object
+	files. However if the number of received objects equals or
+	exceeds this limit then the received pack will be stored as
+	a pack, after adding any missing delta bases.  Storing the
+	pack from a push can make the push operation complete faster,
+	especially on slow filesystems.
+
 format.headers::
 	Additional email headers to include in a patch to be submitted
 	by mail.  See gitlink:git-format-patch[1].
diff --git a/fetch-pack.c b/fetch-pack.c
index dd67e48..fc0534c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -8,7 +8,7 @@
 #include "sideband.h"
 
 static int keep_pack;
-static int keep_auto;
+static int unpack_limit = 100;
 static int quiet;
 static int verbose;
 static int fetch_all;
@@ -503,14 +503,14 @@ static int get_pack(int xd[2])
 
 	av = argv;
 	*hdr_arg = 0;
-	if (keep_auto) {
+	if (unpack_limit) {
 		struct pack_header header;
 
 		if (read_pack_header(fd[0], &header))
 			die("protocol error: bad pack header");
 		snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%u,%u",
 			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
-		if (ntohl(header.hdr_entries) < keep_auto)
+		if (ntohl(header.hdr_entries) < unpack_limit)
 			do_keep = 0;
 		else
 			do_keep = 1;
@@ -523,7 +523,7 @@ static int get_pack(int xd[2])
 			*av++ = "-v";
 		if (use_thin_pack)
 			*av++ = "--fix-thin";
-		if (keep_pack > 1 || keep_auto) {
+		if (keep_pack > 1 || unpack_limit) {
 			int s = sprintf(keep_arg,
 					"--keep=fetch-pack %d on ", getpid());
 			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
@@ -642,6 +642,16 @@ static int remove_duplicates(int nr_heads, char **heads)
 	return dst;
 }
 
+static int fetch_pack_config(const char *var, const char *value)
+{
+	if (strcmp(var, "fetch.unpacklimit") == 0) {
+		unpack_limit = git_config_int(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value);
+}
+
 static struct lock_file lock;
 
 int main(int argc, char **argv)
@@ -653,6 +663,8 @@ int main(int argc, char **argv)
 	struct stat st;
 
 	setup_git_directory();
+	setup_ident();
+	git_config(fetch_pack_config);
 
 	nr_heads = 0;
 	heads = NULL;
@@ -674,16 +686,7 @@ int main(int argc, char **argv)
 			}
 			if (!strcmp("--keep", arg) || !strcmp("-k", arg)) {
 				keep_pack++;
-				continue;
-			}
-			if (!strcmp("--keep-auto", arg)) {
-				keep_auto = 100;
-				continue;
-			}
-			if (!strncmp("--keep-auto=", arg, 12)) {
-				keep_auto = strtoul(arg + 12, NULL, 0);
-				if (keep_auto < 20)
-					keep_auto = 20;
+				unpack_limit = 0;
 				continue;
 			}
 			if (!strcmp("--thin", arg)) {
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index ef78df6..7fd651b 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -97,7 +97,8 @@ pull_to_client () {
 (
 	mkdir client &&
 	cd client &&
-	git-init 2>> log2.txt
+	git-init 2>> log2.txt &&
+	git repo-config fetch.unpacklimit 0
 )
 
 add A1
