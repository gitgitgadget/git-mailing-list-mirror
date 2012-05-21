From: mhagger@alum.mit.edu
Subject: [PATCH v2 3/4] cmd_fetch_pack(): combine the loop termination conditions
Date: Mon, 21 May 2012 09:59:58 +0200
Message-ID: <1337587199-21099-4-git-send-email-mhagger@alum.mit.edu>
References: <1337587199-21099-1-git-send-email-mhagger@alum.mit.edu>
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 10:08:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWNen-0002wI-IZ
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 10:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab2EUIHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 04:07:49 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:49936 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755897Ab2EUIHo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 04:07:44 -0400
X-AuditID: 1207440e-b7f256d0000008c1-43-4fb9f6251cad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 48.67.02241.526F9BF4; Mon, 21 May 2012 04:00:37 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4L80LO0006950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2012 04:00:36 -0400
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1337587199-21099-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqKv6bae/wezJvBZdV7qZLBp6rzBb
	3F4xn9mie8pbRgcWj7/vPzB57Jx1l93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4Mz5PvMBS
	MEm6YuLprywNjNNFuhg5OSQETCQWTpvCBmGLSVy4tx7I5uIQErjMKLHuz2IWCOcMk8Tav7eZ
	QarYBKQkXjb2sIPYIgJqEhPbDgEVcXAwCxRLXF5sAhIWFgiUWDS/nQnEZhFQleh7/wuslVfA
	RWLWzeWMEMvkJZ7e7wNbzCngKnHo+m4WEFsIqGbDw8VsExh5FzAyrGKUS8wpzdXNTczMKU5N
	1i1OTszLSy3SNdbLzSzRS00p3cQICR++HYzt62UOMQpwMCrx8DrN2OkvxJpYVlyZe4hRkoNJ
	SZTX9BNQiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv3YdAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/
	IYH0xJLU7NTUgtQimKwMB4eSBO/Ur0CNgkWp6akVaZk5JQhpJg5OEMEFsoEHaEMCSCFvcUFi
	bnFmOkTRKUZFKXHeZpCEAEgiozQPbgAs0l8xigP9I8y7FKSKB5gk4LpfAQ1mAhoc9AJscEki
	QkqqgXH2W1P9hZY9sU8zr2/7/PcK4ynJSJ2PJrqnPZ2zZl+euS9h6419FizLtTYIfX59+rHr
	i89PTVdHit1fYjnBbMc6FREpsd6gOQLZLhH983Zqb3+W+ND65ew/m4Ua19laF1prOiR9lLZi
	1M23fyxlVJ9wyG7JgbztzXvuTdzmGaRttke1/EZNg7ESS3FGoqEWc1FxIgB3Mg1E 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198092>

From: Michael Haggerty <mhagger@alum.mit.edu>

If an argument that does not start with '-' is found, the loop is
terminated.  So move that check into the for-loop condition.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c |  113 ++++++++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 58 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dabf5e9..96849a4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -911,67 +911,64 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	packet_trace_identity("fetch-pack");
 
 	heads = NULL;
-	for (i = 1; i < argc; i++) {
+	for (i = 1; i < argc && *argv[i] == '-'; i++) {
 		const char *arg = argv[i];
 
-		if (*arg == '-') {
-			if (!prefixcmp(arg, "--upload-pack=")) {
-				args.uploadpack = arg + 14;
-				continue;
-			}
-			if (!prefixcmp(arg, "--exec=")) {
-				args.uploadpack = arg + 7;
-				continue;
-			}
-			if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
-				args.quiet = 1;
-				continue;
-			}
-			if (!strcmp("--keep", arg) || !strcmp("-k", arg)) {
-				args.lock_pack = args.keep_pack;
-				args.keep_pack = 1;
-				continue;
-			}
-			if (!strcmp("--thin", arg)) {
-				args.use_thin_pack = 1;
-				continue;
-			}
-			if (!strcmp("--include-tag", arg)) {
-				args.include_tag = 1;
-				continue;
-			}
-			if (!strcmp("--all", arg)) {
-				args.fetch_all = 1;
-				continue;
-			}
-			if (!strcmp("--stdin", arg)) {
-				args.stdin_refs = 1;
-				continue;
-			}
-			if (!strcmp("-v", arg)) {
-				args.verbose = 1;
-				continue;
-			}
-			if (!prefixcmp(arg, "--depth=")) {
-				args.depth = strtol(arg + 8, NULL, 0);
-				continue;
-			}
-			if (!strcmp("--no-progress", arg)) {
-				args.no_progress = 1;
-				continue;
-			}
-			if (!strcmp("--stateless-rpc", arg)) {
-				args.stateless_rpc = 1;
-				continue;
-			}
-			if (!strcmp("--lock-pack", arg)) {
-				args.lock_pack = 1;
-				pack_lockfile_ptr = &pack_lockfile;
-				continue;
-			}
-			usage(fetch_pack_usage);
+		if (!prefixcmp(arg, "--upload-pack=")) {
+			args.uploadpack = arg + 14;
+			continue;
+		}
+		if (!prefixcmp(arg, "--exec=")) {
+			args.uploadpack = arg + 7;
+			continue;
+		}
+		if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
+			args.quiet = 1;
+			continue;
+		}
+		if (!strcmp("--keep", arg) || !strcmp("-k", arg)) {
+			args.lock_pack = args.keep_pack;
+			args.keep_pack = 1;
+			continue;
+		}
+		if (!strcmp("--thin", arg)) {
+			args.use_thin_pack = 1;
+			continue;
+		}
+		if (!strcmp("--include-tag", arg)) {
+			args.include_tag = 1;
+			continue;
+		}
+		if (!strcmp("--all", arg)) {
+			args.fetch_all = 1;
+			continue;
 		}
-		break;
+		if (!strcmp("--stdin", arg)) {
+			args.stdin_refs = 1;
+			continue;
+		}
+		if (!strcmp("-v", arg)) {
+			args.verbose = 1;
+			continue;
+		}
+		if (!prefixcmp(arg, "--depth=")) {
+			args.depth = strtol(arg + 8, NULL, 0);
+			continue;
+		}
+		if (!strcmp("--no-progress", arg)) {
+			args.no_progress = 1;
+			continue;
+		}
+		if (!strcmp("--stateless-rpc", arg)) {
+			args.stateless_rpc = 1;
+			continue;
+		}
+		if (!strcmp("--lock-pack", arg)) {
+			args.lock_pack = 1;
+			pack_lockfile_ptr = &pack_lockfile;
+			continue;
+		}
+		usage(fetch_pack_usage);
 	}
 
 	if (i < argc)
-- 
1.7.10
