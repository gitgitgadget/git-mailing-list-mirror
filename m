From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/23] fetch, remote: properly convey --no-prune options to subprocesses
Date: Wed, 30 Oct 2013 06:33:04 +0100
Message-ID: <1383111192-23780-16-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:34:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOQU-0005v6-KE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690Ab3J3Feb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:34:31 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42516 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752537Ab3J3Fe2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:34:28 -0400
X-AuditID: 12074414-b7fb46d000002a4d-26-52709a63561c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F0.6E.10829.36A90725; Wed, 30 Oct 2013 01:34:27 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIQ014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:25 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqJs8qyDI4FCfqMX0rtUsFl1Xupks
	GnqvMFvMu7uLyWLVrWXMFitn3GC0uL1iPrPF085Ki3kvXrBZ/GjpYXbg8vj7/gOTx6V1L5k8
	Dv2Zwu7x7EQ7m8ell9/ZPJ717mH0uHhJ2WNGy2sWj8+b5DwOXH7MFsAVxW2TlFhSFpyZnqdv
	l8Cd0briJmPBe76K150b2RsYO3i6GDk5JARMJA6332GCsMUkLtxbz9bFyMUhJHCZUWLD5pfM
	EM4VJonW4/PZQKrYBHQlFvU0g3WICKhJTGw7xAJSxCwwkVni+PRFLCAJYYFoiSsLf4HZLAKq
	EhvnvGEEsXkFXCXWLLvNArFOQeJG81RWEJsTKP5p1012EFtIwEWiqf0z+wRG3gWMDKsY5RJz
	SnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQgJXZAfjkZNyhxgFOBiVeHg7HuUHCbEm
	lhVX5h5ilORgUhLlTZtSECTEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHf6caBy3pTEyqrUonyY
	lDQHi5I477fF6n5CAumJJanZqakFqUUwWRkODiUJXuWZQEMFi1LTUyvSMnNKENJMHJwgggtk
	Aw/QBh6QQt7igsTc4sx0iKJTjIpS4rxzQRICIImM0jy4AbAU84pRHOgfYYh2HmB6gut+BTSY
	CWjwHpY8kMEliQgpqQbGwitpDh96PBrvH3C1ck01Cyw+mt0ynSe9K+7J8TrPYMP56vculv5Y
	98B+m6200p0jIhlqs9q4T8vbTT/edE705dHUHG9zu4WuT8qzNguvarx1eGVrTeRy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236963>

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
index 1514b90..5ddb9af 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -936,8 +936,8 @@ static void add_options_to_argv(struct argv_array *argv)
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
1.8.4.1
