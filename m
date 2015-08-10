From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/16] credential-cache--daemon: use tempfile module
Date: Mon, 10 Aug 2015 11:47:51 +0200
Message-ID: <d05a0b163a9bc88f1e948240913eda95126adfeb.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjh9-00021w-WD
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbbHJJsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:30 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45085 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754703AbbHJJsP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:15 -0400
X-AuditID: 1207440c-f79e16d000002a6e-1d-55c8735eb0aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 4F.F3.10862.E5378C55; Mon, 10 Aug 2015 05:48:14 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lsx6021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:13 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBtXfCLUYPZbfouuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGX8aFjAX
	tPBWPLm+namB8R1XFyMnh4SAicTz7i3sELaYxIV769m6GLk4hAQuM0rMatrMBOGcYJJ4e3QH
	G0gVm4CuxKKeZiYQW0RATWJi2yEWEJtZIF3ixIJ2MFtYwF1i+uarzCA2i4CqxLoLF4DiHBy8
	AlES258Lg5gSAnISCy6kg1RwClhIbG/cwApiCwmYSzyed559AiPvAkaGVYxyiTmlubq5iZk5
	xanJusXJiXl5qUW6hnq5mSV6qSmlmxghwcOzg/HbOplDjAIcjEo8vDM2Hw8VYk0sK67MPcQo
	ycGkJMprkX8iVIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb3wGUI43JbGyKrUoHyYlzcGiJM6r
	ukTdT0ggPbEkNTs1tSC1CCYrw8GhJMErXwTUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqU
	WFqSEQ+Ki/hiYGSApHiA9tqBtPMWFyTmAkUhWk8xKkqJ8/4pBEoIgCQySvPgxsJSwitGcaAv
	hXn3gFTxANMJXPcroMFMIIMDwQaXJCKkpBoY2259m3z8e1Mwm2Iu6x5eA+m3P9vvyMXunG/F
	blN/3Hl2b3gp676UO44xEgJK8k57n//X86p5qrSy5cjBKycEl1/33X1K6t7/h6XCfHUSTlFh
	6eWnnx+bkMcT/Hrj2YstV7jeaLDefpvbd+PCCU7+iY2VP/MD7K4Ft9YcO1mSen6l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275596>

Use the tempfile module to ensure that the socket file gets deleted on
program exit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 credential-cache--daemon.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index a671b2b..eef6fce 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -1,23 +1,11 @@
 #include "cache.h"
+#include "tempfile.h"
 #include "credential.h"
 #include "unix-socket.h"
 #include "sigchain.h"
 #include "parse-options.h"
 
-static const char *socket_path;
-
-static void cleanup_socket(void)
-{
-	if (socket_path)
-		unlink(socket_path);
-}
-
-static void cleanup_socket_on_signal(int sig)
-{
-	cleanup_socket();
-	sigchain_pop(sig);
-	raise(sig);
-}
+static struct tempfile socket_file;
 
 struct credential_cache_entry {
 	struct credential item;
@@ -256,6 +244,7 @@ static void check_socket_directory(const char *path)
 
 int main(int argc, const char **argv)
 {
+	const char *socket_path;
 	static const char *usage[] = {
 		"git-credential-cache--daemon [opts] <socket_path>",
 		NULL
@@ -272,14 +261,11 @@ int main(int argc, const char **argv)
 
 	if (!socket_path)
 		usage_with_options(usage, options);
-	check_socket_directory(socket_path);
-
-	atexit(cleanup_socket);
-	sigchain_push_common(cleanup_socket_on_signal);
 
+	check_socket_directory(socket_path);
+	register_tempfile(&socket_file, socket_path);
 	serve_cache(socket_path, debug);
-
-	unlink(socket_path);
+	delete_tempfile(&socket_file);
 
 	return 0;
 }
-- 
2.5.0
