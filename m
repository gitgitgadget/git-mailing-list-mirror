From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use LF and allow comments in objects/info/alternates file.
Date: Tue, 16 Aug 2005 22:48:39 -0700
Message-ID: <7vbr3x2jwo.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net>
	<20050813120815.GC5608@pasky.ji.cz>
	<7v1x4wcca0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508141726390.3553@g5.osdl.org>
	<7vr7cw7ypt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508161156430.3553@g5.osdl.org>
	<7vacjhaa7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 07:49:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Gn7-0000BF-BW
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 07:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVHQFsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 01:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVHQFsm
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 01:48:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:55001 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750865AbVHQFsm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 01:48:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817054841.HPRA17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 01:48:41 -0400
To: git@vger.kernel.org
In-Reply-To: <7vacjhaa7y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 16 Aug 2005 13:38:25 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Yes, using the same format for the file and the environment variable
was a big mistake.  This uses LF as the path separator, and allows
lines that begin with '#' to be comments.  ':' is no longer a separator
in objects/info/alternates file.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 sha1_file.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

9577e7e3db2299febdc17539478bba38874d4120
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -240,14 +240,21 @@ static struct alternate_object_database 
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static void link_alt_odb_entries(const char *alt, const char *ep)
+static void link_alt_odb_entries(const char *alt, const char *ep, int sep)
 {
 	const char *cp, *last;
 	struct alternate_object_database *ent;
 
 	last = alt;
-	do {
-		for (cp = last; cp < ep && *cp != ':'; cp++)
+	while (last < ep) {
+		cp = last;
+		if (cp < ep && *cp == '#') {
+			while (cp < ep && *cp != sep)
+				cp++;
+			last = cp + 1;
+			continue;
+		}
+		for ( ; cp < ep && *cp != sep; cp++)
 			;
 		if (last != cp) {
 			/* 43 = 40-byte + 2 '/' + terminating NUL */
@@ -264,16 +271,16 @@ static void link_alt_odb_entries(const c
 			ent->base[pfxlen] = ent->base[pfxlen + 3] = '/';
 			ent->base[entlen-1] = 0;
 		}
-		while (cp < ep && *cp == ':')
+		while (cp < ep && *cp == sep)
 			cp++;
 		last = cp;
-	} while (cp < ep);
+	}
 }
 
 void prepare_alt_odb(void)
 {
 	char path[PATH_MAX];
-	char *map, *ep;
+	char *map;
 	int fd;
 	struct stat st;
 	char *alt = gitenv(ALTERNATE_DB_ENVIRONMENT) ? : "";
@@ -282,7 +289,7 @@ void prepare_alt_odb(void)
 	if (alt_odb_tail)
 		return;
 	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(alt, alt + strlen(alt));
+	link_alt_odb_entries(alt, alt + strlen(alt), ':');
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
@@ -296,10 +303,7 @@ void prepare_alt_odb(void)
 	if (map == MAP_FAILED)
 		return;
 
-	/* Remove the trailing newline */
-	for (ep = map + st.st_size - 1; map < ep && ep[-1] == '\n'; ep--)
-		;
-	link_alt_odb_entries(map, ep);
+	link_alt_odb_entries(map, map + st.st_size, '\n');
 	munmap(map, st.st_size);
 }
 
