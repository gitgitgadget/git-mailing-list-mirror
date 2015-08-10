From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/16] setup_temporary_shallow(): use tempfile module
Date: Mon, 10 Aug 2015 11:47:46 +0200
Message-ID: <8d770afe87ff1b667cfd7731bf1084a69b64cf94.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjh8-00021w-Kc
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbbHJJsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:22 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58786 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754720AbbHJJsJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:09 -0400
X-AuditID: 1207440f-f79df6d000007c0f-43-55c87358b14d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.DD.31759.85378C55; Mon, 10 Aug 2015 05:48:08 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lsx1021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:07 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBtRfCLU4MQJI4uuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGQebbzAW
	XBWoaDxyl7GB8QdvFyMnh4SAicTOWWtYIGwxiQv31rN1MXJxCAlcZpS41POKEcI5wSTx+cFD
	ZpAqNgFdiUU9zUwgtoiAmsTEtkNg3cwC6RInFrSD2cICHhKtH5aA2SwCqhJtj/YC9XJw8ApE
	Sbz6JQZiSgjISSy4kA5SwSlgIbG9cQMriC0kYC7xeN559gmMvAsYGVYxyiXmlObq5iZm5hSn
	JusWJyfm5aUW6Zro5WaW6KWmlG5ihAQP/w7GrvUyhxgFOBiVeHhnbD4eKsSaWFZcmXuIUZKD
	SUmU1yL/RKgQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd74DKAcb0piZVVqUT5MSpqDRUmcV32J
	up+QQHpiSWp2ampBahFMVoaDQ0mC93IRUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJp
	SUY8KC7ii4GRAZLiAdq7FaSdt7ggMRcoCtF6ilFRSpz3TyFQQgAkkVGaBzcWlhJeMYoDfSnM
	uwekigeYTuC6XwENZgIabBcINrgkESEl1cBoV2JkcCbC6fcL9gM9tj3J/qLNwheXtbxvetIy
	oYyBwemn772eSy1tBjc4VJrm399+Mf6JkcW+UpejneEph5s2BzwvqP+Wf1GoZO26q2orpJ5E
	5b6tepkzc/qZoJzEZI7r0kIF9o2N3GcUwo3q/zVMZpPenFVTI3Lnbeg+2U1VKqXb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275595>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 shallow.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/shallow.c b/shallow.c
index 7973e74..2ba29a5 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "tag.h"
@@ -208,50 +209,28 @@ int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 	return write_shallow_commits_1(out, use_pack_protocol, extra, 0);
 }
 
-static struct strbuf temporary_shallow = STRBUF_INIT;
-
-static void remove_temporary_shallow(void)
-{
-	if (temporary_shallow.len) {
-		unlink_or_warn(temporary_shallow.buf);
-		strbuf_reset(&temporary_shallow);
-	}
-}
-
-static void remove_temporary_shallow_on_signal(int signo)
-{
-	remove_temporary_shallow();
-	sigchain_pop(signo);
-	raise(signo);
-}
+static struct tempfile temporary_shallow;
 
 const char *setup_temporary_shallow(const struct sha1_array *extra)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
-	if (temporary_shallow.len)
-		die("BUG: attempt to create two temporary shallow files");
-
 	if (write_shallow_commits(&sb, 0, extra)) {
-		strbuf_addstr(&temporary_shallow, git_path("shallow_XXXXXX"));
-		fd = xmkstemp(temporary_shallow.buf);
-
-		atexit(remove_temporary_shallow);
-		sigchain_push_common(remove_temporary_shallow_on_signal);
+		fd = xmks_tempfile(&temporary_shallow, git_path("shallow_XXXXXX"));
 
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  temporary_shallow.buf);
-		close(fd);
+				  get_tempfile_path(&temporary_shallow));
+		close_tempfile(&temporary_shallow);
 		strbuf_release(&sb);
-		return temporary_shallow.buf;
+		return get_tempfile_path(&temporary_shallow);
 	}
 	/*
 	 * is_repository_shallow() sees empty string as "no shallow
 	 * file".
 	 */
-	return temporary_shallow.buf;
+	return get_tempfile_path(&temporary_shallow);
 }
 
 void setup_alternate_shallow(struct lock_file *shallow_lock,
-- 
2.5.0
