From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/16] gc: use tempfile module to handle gc.pid file
Date: Mon, 10 Aug 2015 11:47:49 +0200
Message-ID: <f9c3b4016af0a3c503665e1c9fb8868919a66813.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjhA-00021w-Il
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbbHJJsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:36 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63301 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754733AbbHJJsM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:12 -0400
X-AuditID: 1207440e-f79516d0000012b3-d2-55c8735b919e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.1B.04787.B5378C55; Mon, 10 Aug 2015 05:48:12 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lsx4021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:11 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBtTfCLU4PlGJouuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGW9etLMV
	LOWpuPR5OlsDYx9XFyMnh4SAiUTj4jYWCFtM4sK99WwgtpDAZUaJnafSuhi5gOwTTBIL3s9g
	BUmwCehKLOppZgKxRQTUJCa2HQJrZhZIlzixoB3MFhZwl/g+cSpYDYuAqsTVb9PBhvIKREmc
	/zyBvYuRA2iZnMSCC+kgYU4BC4ntjRtYIfaaSzyed559AiPvAkaGVYxyiTmlubq5iZk5xanJ
	usXJiXl5qUW6xnq5mSV6qSmlmxghwcO3g7F9vcwhRgEORiUe3hmbj4cKsSaWFVfmHmKU5GBS
	EuW1yD8RKsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmENz4DKMebklhZlVqUD5OS5mBREudVW6Lu
	JySQnliSmp2aWpBaBJOV4eBQkuCVLwJqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3J
	iAfFRXwxMDJAUjxAe+1A2nmLCxJzgaIQracYFaXEef8UAiUEQBIZpXlwY2Ep4RWjONCXwryN
	IO08wHQC1/0KaDATyOBAsMEliQgpqQbGicyCZmZaUvfjpi9atqPWo1IkQ7tDhGddt86zzN+q
	bO9EXolpPb54yOhzSeuq+stnrtnGBx+U/W9zxvrXvyYPDsuGCRMWVbPsjnXy+jFB9fGi2jO8
	B9ftX6qyfZL9lo7c6t2G0ffZts5mrbu53rRgWmW+f9n8vZNvZrUtlFb2XRPywzHI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275599>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/gc.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c41354b..bfe589f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -11,6 +11,7 @@
  */
 
 #include "builtin.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "run-command.h"
@@ -42,20 +43,7 @@ static struct argv_array prune = ARGV_ARRAY_INIT;
 static struct argv_array prune_worktrees = ARGV_ARRAY_INIT;
 static struct argv_array rerere = ARGV_ARRAY_INIT;
 
-static char *pidfile;
-
-static void remove_pidfile(void)
-{
-	if (pidfile)
-		unlink(pidfile);
-}
-
-static void remove_pidfile_on_signal(int signo)
-{
-	remove_pidfile();
-	sigchain_pop(signo);
-	raise(signo);
-}
+static struct tempfile pidfile;
 
 static void git_config_date_string(const char *key, const char **output)
 {
@@ -201,7 +189,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	int fd;
 	char *pidfile_path;
 
-	if (pidfile)
+	if (is_tempfile_active(&pidfile))
 		/* already locked */
 		return NULL;
 
@@ -248,11 +236,8 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	write_in_full(fd, sb.buf, sb.len);
 	strbuf_release(&sb);
 	commit_lock_file(&lock);
-
-	pidfile = pidfile_path;
-	sigchain_push_common(remove_pidfile_on_signal);
-	atexit(remove_pidfile);
-
+	register_tempfile(&pidfile, pidfile_path);
+	free(pidfile_path);
 	return NULL;
 }
 
-- 
2.5.0
