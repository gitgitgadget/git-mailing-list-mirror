From: Max Kirillov <max@max630.net>
Subject: [PATCH/RFC 1/2] sha1_file: close all pack files after running
Date: Thu,  1 Oct 2015 06:29:22 +0300
Message-ID: <1443670163-31193-2-git-send-email-max@max630.net>
References: <1443670163-31193-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 05:30:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhUZd-0001TF-03
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 05:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbbJAD34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 23:29:56 -0400
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net ([173.201.192.238]:54471
	"EHLO p3plsmtpa07-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755242AbbJAD3t (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2015 23:29:49 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-09.prod.phx3.secureserver.net with 
	id PfVh1r0055B68XE01fVosV; Wed, 30 Sep 2015 20:29:49 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1443670163-31193-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278883>

When a builtin has done its job, but waits for pager or not waited
by its caller and still hanging it keeps pack files opened.
This can cause a number of issues, for example on Windows git gc
cannot remove the packs.

Fix this by explicitly closing all pack files and unmapping memory
from the packs after running builtin. Do not die() if the memory region
is still used though, just print a warning, because failure to close
a file should not prevent the currently running program from finishing
its task.

Signed-off-by: Max Kirillov <max@max630.net>
---
 cache.h     |  1 +
 git.c       |  2 ++
 sha1_file.c | 32 +++++++++++++++++++++++++++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 79066e5..153bc46 100644
--- a/cache.h
+++ b/cache.h
@@ -1279,6 +1279,7 @@ extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *, int, int);
+extern void close_all_packs(void);
 
 /*
  * Return the SHA-1 of the nth object within the specified packfile.
diff --git a/git.c b/git.c
index 5feba41..ad34680 100644
--- a/git.c
+++ b/git.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "cache.h"
 #include "exec_cmd.h"
 #include "help.h"
 #include "run-command.h"
@@ -348,6 +349,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	trace_argv_printf(argv, "trace: built-in: git");
 
 	status = p->fn(argc, argv, prefix);
+	close_all_packs();
 	if (status)
 		return status;
 
diff --git a/sha1_file.c b/sha1_file.c
index 08302f5..62f1dad 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -773,20 +773,28 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-void close_pack_windows(struct packed_git *p)
+static int close_pack_windows_nodie(struct packed_git *p)
 {
 	while (p->windows) {
 		struct pack_window *w = p->windows;
 
 		if (w->inuse_cnt)
-			die("pack '%s' still has open windows to it",
-			    p->pack_name);
+			return 1;
+
 		munmap(w->base, w->len);
 		pack_mapped -= w->len;
 		pack_open_windows--;
 		p->windows = w->next;
 		free(w);
 	}
+
+	return 0;
+}
+
+void close_pack_windows(struct packed_git *p)
+{
+	if (close_pack_windows_nodie(p))
+		die("pack '%s' still has open windows to it", p->pack_name);
 }
 
 /*
@@ -866,6 +874,24 @@ static int close_one_pack(void)
 	return 0;
 }
 
+void close_all_packs(void)
+{
+	struct packed_git *p = NULL;
+
+	for (p = packed_git; p; p = p->next) {
+		if (close_pack_windows_nodie(p))
+			warning("pack '%s' still has open windows to it", p->pack_name);
+
+		if (p->pack_fd != -1) {
+			if (close(p->pack_fd) != 0)
+				warning("close(%s) failed: %d", p->pack_name, errno);
+			p->pack_fd = -1;
+		}
+
+		close_pack_index(p);
+	}
+}
+
 void unuse_pack(struct pack_window **w_cursor)
 {
 	struct pack_window *w = *w_cursor;
-- 
2.3.4.2801.g3d0809b
