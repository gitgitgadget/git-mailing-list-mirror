From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/15] fetch, remote: properly convey --no-prune options to subprocesses
Date: Wed, 23 Oct 2013 17:50:48 +0200
Message-ID: <1382543448-2586-16-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:59:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0qM-00076U-Pw
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab3JWP73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:59:29 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63606 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752169Ab3JWP71 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:59:27 -0400
X-AuditID: 12074413-b7fc76d000002aba-88-5267f0b84809
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 04.48.10938.8B0F7625; Wed, 23 Oct 2013 11:52:24 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLt8009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:52:22 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqLvjQ3qQQecCFYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE74+KR22wFb/kqWj/MZW1gbOPpYuTkkBAwkThw6TMrhC0mceHeerYuRi4OIYHLjBJb7hxl
	hHCuMEm8bTsDVsUmoCuxqKeZCcQWEVCTmNh2iAWkiFlgIrPE8emLWEASwgIREu0tv9hBbBYB
	VYnfR3aDNfAKuEi82rkIyOYAWicn8fBbLEiYEyh84fh0sPlCAs4SExZOZZ/AyLuAkWEVo1xi
	Tmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkjYCu9g3HVS7hCjAAejEg/vg5a0ICHW
	xLLiytxDjJIcTEqivHPepQcJ8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHdcRcox5uSWFmVWpQP
	k5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4D32HqhRsCg1PbUiLTOnBCHNxMEJIrhA
	NvAAbbgGUshbXJCYW5yZDlF0ilFRSpx3P0hCACSRUZoHNwCWYF4xigP9I8x7E6SKB5ic4Lpf
	AQ1mAho8ZUkayOCSRISUVAPjsvRdL68U1G6SOZ6/7HztnEclfwxWWHm2f9ESPD/VhL1T8N6W
	s0tjK/j5k0TNVMLYjBvevzux6MKMxAaftxXHZRsOvJunfMXc7aZ2VvoHkf3FrznZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236528>

If --no-prune is passed to one of the following commands:

    git fetch --all
    git fetch --multiple
    git fetch --recurse-submodules
    git remote update

then it must also be passed to the "fetch" subprocesses that those
commands use to do their work.  Otherwise there might be a fetch.prune
or remote.<name>.prune configuration setting that causes pruning to
occur, contrary to the user's express wish.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c  | 4 ++--
 builtin/remote.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 47b63a7..8711df0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -915,8 +915,8 @@ static void add_options_to_argv(struct argv_array *argv)
 {
 	if (dry_run)
 		argv_array_push(argv, "--dry-run");
-	if (prune > 0)
-		argv_array_push(argv, "--prune");
+	if (prune != -1)
+		argv_array_push(argv, prune ? "--prune" : "--no-prune");
 	if (update_head_ok)
 		argv_array_push(argv, "--update-head-ok");
 	if (force)
diff --git a/builtin/remote.c b/builtin/remote.c
index bffe2f9..f532f35 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1371,7 +1371,7 @@ static int get_remote_default(const char *key, const char *value, void *priv)
 
 static int update(int argc, const char **argv)
 {
-	int i, prune = 0;
+	int i, prune = -1;
 	struct option options[] = {
 		OPT_BOOL('p', "prune", &prune,
 			 N_("prune remotes after fetching")),
@@ -1386,8 +1386,8 @@ static int update(int argc, const char **argv)
 
 	argv_array_push(&fetch_argv, "fetch");
 
-	if (prune)
-		argv_array_push(&fetch_argv, "--prune");
+	if (prune != -1)
+		argv_array_push(&fetch_argv, prune ? "--prune" : "--no-prune");
 	if (verbose)
 		argv_array_push(&fetch_argv, "-v");
 	argv_array_push(&fetch_argv, "--multiple");
-- 
1.8.4
