From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 05/11] Add a library function to add an alternate to the
 alternates file
Date: Sat, 8 Mar 2008 18:04:10 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081804090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY86T-0008Dx-Hy
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbYCHXEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYCHXEN
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:04:13 -0500
Received: from iabervon.org ([66.92.72.58]:42227 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbYCHXEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:04:12 -0500
Received: (qmail 18581 invoked by uid 1000); 8 Mar 2008 23:04:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:04:10 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76607>

This is in the core so that, if the alternates file has already been
read, the addition can be parsed and put into effect for the current
process.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 cache.h     |    1 +
 sha1_file.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index bdefcc9..6aae174 100644
--- a/cache.h
+++ b/cache.h
@@ -587,6 +587,7 @@ extern struct alternate_object_database {
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
+extern void add_to_alternates_file(const char *reference);
 
 struct pack_window {
 	struct pack_window *next;
diff --git a/sha1_file.c b/sha1_file.c
index 445a871..4ce4d9d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -379,6 +379,25 @@ static void read_info_alternates(const char * relative_base, int depth)
 	munmap(map, mapsz);
 }
 
+void add_to_alternates_file(const char *reference)
+{
+	char *file;
+	char *alt;
+	int fd;
+
+	file = mkpath("%s/objects/info/alternates", get_git_dir());
+	fd = open(file, O_CREAT | O_WRONLY | O_APPEND, 0666);
+	if (fd < 0)
+		die("failed to create %s", file);
+	alt = mkpath("%s/objects\n", reference);
+	write_or_die(fd, alt, strlen(alt));
+	if (close(fd))
+		die("could not close %s", file);
+	fprintf(stderr, "Wrote %s to %s\n", alt, file);
+	if (alt_odb_tail)
+		link_alt_odb_entries(alt, alt + strlen(alt), '\n', NULL, 0);
+}
+
 void prepare_alt_odb(void)
 {
 	const char *alt;
-- 
1.5.4.3.327.g614d7.dirty

