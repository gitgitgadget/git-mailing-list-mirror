From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Add a library function to add an alternate to the
 alternates file
Date: Sun, 9 Mar 2008 18:46:39 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803091842100.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 23:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYUIl-0001jZ-1k
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 23:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbYCIWqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 18:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYCIWqn
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 18:46:43 -0400
Received: from iabervon.org ([66.92.72.58]:47974 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142AbYCIWqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 18:46:42 -0400
Received: (qmail 19093 invoked by uid 1000); 9 Mar 2008 22:46:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2008 22:46:39 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76678>

This is in the core so that, if the alternates file has already been
read, the addition can be parsed and put into effect for the current
process.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 cache.h     |    1 +
 sha1_file.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 4a113b0..96dcb49 100644
--- a/cache.h
+++ b/cache.h
@@ -589,6 +589,7 @@ extern struct alternate_object_database {
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
+extern void add_to_alternates_file(const char *reference);
 
 struct pack_window {
 	struct pack_window *next;
diff --git a/sha1_file.c b/sha1_file.c
index 445a871..1aa3cef 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -379,6 +379,18 @@ static void read_info_alternates(const char * relative_base, int depth)
 	munmap(map, mapsz);
 }
 
+void add_to_alternates_file(const char *reference)
+{
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), 1);
+	char *alt = mkpath("%s/objects\n", reference);
+	write_or_die(fd, alt, strlen(alt));
+	if (commit_lock_file(lock))
+		die("could not close alternates file");
+	if (alt_odb_tail)
+		link_alt_odb_entries(alt, alt + strlen(alt), '\n', NULL, 0);
+}
+
 void prepare_alt_odb(void)
 {
 	const char *alt;
-- 
1.5.4.3.610.gea6cd
