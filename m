From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Don't access line[-1] for a zero-length "line" from fgets.
Date: Fri, 04 Jan 2008 18:37:41 +0100
Message-ID: <87sl1d7aqi.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 18:38:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAqVE-0000JG-OG
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 18:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYADRiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 12:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbYADRhy
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 12:37:54 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:33367 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbYADRhr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 12:37:47 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5014217B5C7
	for <git@vger.kernel.org>; Fri,  4 Jan 2008 18:37:42 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 3386C17B595
	for <git@vger.kernel.org>; Fri,  4 Jan 2008 18:37:42 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id BFB48558D6; Fri,  4 Jan 2008 18:37:41 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69586>

A NUL byte at beginning of file, or just after a newline
would provoke an invalid buf[-1] access in a few places.

* builtin-grep.c (cmd_grep): Don't access buf[-1].
* builtin-pack-objects.c (get_object_list): Likewise.
* builtin-rev-list.c (read_revisions_from_stdin): Likewise.
* bundle.c (read_bundle_header): Likewise.
* server-info.c (read_pack_info_file): Likewise.
* transport.c (insert_packed_refs): Likewise.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 builtin-grep.c         |    2 +-
 builtin-pack-objects.c |    2 +-
 builtin-rev-list.c     |    2 +-
 bundle.c               |    2 +-
 server-info.c          |    2 +-
 transport.c            |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index f1ff8dc..0d6cc73 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -644,7 +644,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 				die("'%s': %s", argv[1], strerror(errno));
 			while (fgets(buf, sizeof(buf), patterns)) {
 				int len = strlen(buf);
-				if (buf[len-1] == '\n')
+				if (len && buf[len-1] == '\n')
 					buf[len-1] = 0;
 				/* ignore empty line like grep does */
 				if (!buf[0])
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e0ce114..a39cb82 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2013,7 +2013,7 @@ static void get_object_list(int ac, const char **av)

 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
-		if (line[len - 1] == '\n')
+		if (len && line[len - 1] == '\n')
 			line[--len] = 0;
 		if (!len)
 			break;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 1cb5f67..de80158 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -520,7 +520,7 @@ static void read_revisions_from_stdin(struct rev_info *revs)

 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
-		if (line[len - 1] == '\n')
+		if (len && line[len - 1] == '\n')
 			line[--len] = 0;
 		if (!len)
 			break;
diff --git a/bundle.c b/bundle.c
index 9b9b916..be204d8 100644
--- a/bundle.c
+++ b/bundle.c
@@ -48,7 +48,7 @@ int read_bundle_header(const char *path, struct bundle_header *header)
 			: &header->references;
 		char delim;

-		if (buffer[len - 1] == '\n')
+		if (len && buffer[len - 1] == '\n')
 			buffer[len - 1] = '\0';
 		if (get_sha1_hex(buffer + offset, sha1)) {
 			warning("unrecognized header: %s", buffer);
diff --git a/server-info.c b/server-info.c
index a051e49..c1c073b 100644
--- a/server-info.c
+++ b/server-info.c
@@ -101,7 +101,7 @@ static int read_pack_info_file(const char *infofile)

 	while (fgets(line, sizeof(line), fp)) {
 		int len = strlen(line);
-		if (line[len-1] == '\n')
+		if (len && line[len-1] == '\n')
 			line[--len] = 0;

 		if (!len)
diff --git a/transport.c b/transport.c
index 4e151a9..babaa21 100644
--- a/transport.c
+++ b/transport.c
@@ -118,7 +118,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 		if (hexval(buffer[0]) > 0xf)
 			continue;
 		len = strlen(buffer);
-		if (buffer[len - 1] == '\n')
+		if (len && buffer[len - 1] == '\n')
 			buffer[--len] = '\0';
 		if (len < 41)
 			continue;
--
1.5.4.rc2.18.ga0289
