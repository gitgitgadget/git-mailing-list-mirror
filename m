From: Johan Herland <johan@herland.net>
Subject: [PATCH 04/15] git-note: (Plumbing) Add plumbing-level support for git
 notes
Date: Sun, 27 May 2007 16:11:36 +0200
Message-ID: <200705271611.36457.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:12:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJTd-0006vM-E8
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbXE0OLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbXE0OLu
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:11:50 -0400
Received: from smtp.getmail.no ([84.208.20.33]:48355 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774AbXE0OLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:11:49 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00003E3O6300@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:11:48 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP004WRE3C9OC0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:11:36 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000FQE3CJB50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:11:36 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48544>

This patch declares and implements two functions:

1. for_each_note_ref() - for iterating over note references in refs/notes.
   This is analogous to for_each_tag_ref(), for_each_branch_ref() and
   for_each_remote_ref(), which is already present.

2. cleanup_notes_subdirs() - a convenience function for removing empty
   subdirectories from refs/notes. These subdirectories would otherwise be
   left behind after removing notes, or after packing note refs.

The above functions will be used by subsequent git-note patches.

Signed-off-by: Johan Herland <johan@herland.net>
---
 refs.c |   20 ++++++++++++++++++++
 refs.h |    4 ++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 2ae3235..f0abfcd 100644
--- a/refs.c
+++ b/refs.c
@@ -569,6 +569,11 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/tags/", fn, 10, cb_data);
 }
 
+int for_each_note_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref("refs/notes/", fn, 11, cb_data);
+}
+
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref("refs/heads/", fn, 11, cb_data);
@@ -1433,3 +1438,18 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_reflog("", fn, cb_data);
 }
+
+void cleanup_notes_subdirs ()
+{
+	DIR *dir = opendir(git_path("refs/notes/"));
+
+	if (dir) {
+		struct dirent *de;
+		while ((de = readdir(dir)) != NULL) {
+			if (de->d_name[0] == '.')
+				continue;
+			rmdir(git_path("refs/notes/%s", de->d_name));
+		}
+		closedir(dir);
+	}
+}
diff --git a/refs.h b/refs.h
index f234eb7..6175bfb 100644
--- a/refs.h
+++ b/refs.h
@@ -21,6 +21,7 @@ typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flag
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_tag_ref(each_ref_fn, void *);
+extern int for_each_note_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 
@@ -64,4 +65,7 @@ extern int rename_ref(const char *oldref, const char *newref, const char *logmsg
 /** resolve ref in nested "gitlink" repository */
 extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *result);
 
+/** clean up empty subdirs below "refs/notes/" */
+extern void cleanup_notes_subdirs();
+
 #endif /* REFS_H */
-- 
1.5.2.101.gee49f
