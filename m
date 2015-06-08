From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/14] credential-cache--daemon: use tempfile module
Date: Mon,  8 Jun 2015 11:07:45 +0200
Message-ID: <137a4c21a5e8f87a4ebea1314a19ead1b934b72e.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:09:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t33-0002r8-DA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbbFHJIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:44 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60500 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752944AbbFHJIX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:23 -0400
X-AuditID: 1207440e-f79fc6d000000caf-66-55755b78c0b7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 55.15.03247.87B55755; Mon,  8 Jun 2015 05:08:08 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojc010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:08:07 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqFsRXRpqcPmEjEXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE7o3veZraC
	Ft6Kk/tfsjcwvuPqYuTgkBAwkTg01aqLkRPIFJO4cG89WxcjF4eQwGVGid6FK9ghnBNMEucm
	/GACqWIT0JVY1NMMZosIOEqceHCdFcRmFnCQ2Py5kRHEFhZwkfh76iw7iM0ioCox5/JeZhCb
	VyBKYmN3BxvENjmJ88d/gsU5BSwkfn3dxQRykJCAucSPuawTGHkXMDKsYpRLzCnN1c1NzMwp
	Tk3WLU5OzMtLLdI11svNLNFLTSndxAgJHr4djO3rZQ4xCnAwKvHwHlhUEirEmlhWXJl7iFGS
	g0lJlPdjRGmoEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFeJgugHG9KYmVValE+TEqag0VJnFdt
	ibqfkEB6YklqdmpqQWoRTFaGg0NJgvdHJFCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFi
	aUlGPCgu4ouBkQGS4gHaewqknbe4IDEXKArReopRUUqc1ygKKCEAksgozYMbC0sJrxjFgb4U
	5rUBqeIBphO47ldAg5mABn//WgwyuCQRISXVwJi26Rq/mvkXy9f5RW0GLCuSTJdcLHuqmrp5
	9576KWudrxwMu/v9+NGv88ykHXy/Hf9jN2vyYfVGrrmszb9jZff9mqhZt8zo3cttD2oNrvJM
	lVSRmsu4UreXS7H6dpGN6l6W7zIBb3rcbhT9n7Zo2RanLoOQtzmxkw8d+XHgu+Pu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271009>

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
2.1.4
