From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/24] expire_reflog(): move dry_run to flags argument
Date: Fri, 12 Dec 2014 09:56:50 +0100
Message-ID: <1418374623-5566-12-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM3C-00052F-D0
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965456AbaLLI6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:58:08 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64796 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964947AbaLLI5a (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:30 -0500
X-AuditID: 1207440d-f79976d000005643-0a-548aadf765f0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.2A.22083.7FDAA845; Fri, 12 Dec 2014 03:57:27 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nL023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:26 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqPt9bVeIwYGdHBZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujGVnxQtmCFU8vd3J2sB4ja+LkYNDQsBE4tkb2y5GTiBTTOLCvfVsXYxcHEIC
	lxklbt/9yALhHGOS2H6hnQmkik1AV2JRTzOYLSKgJjGx7RALiM0scIJRYnZDCIgtLOApMXP/
	UUYQm0VAVeLbnV9MIMt4BVwk7qyshdgrJ7F1nTdIBSdQ9GLLE7ApQgLOEltXdLJOYORdwMiw
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkqHh3MP5fJ3OIUYCDUYmHd0Jy
	V4gQa2JZcWXuIUZJDiYlUd7vk4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHj/RgHleFMSK6tS
	i/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvHFrgBoFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQTERXwyMCpAUD9DeYJB23uKCxFygKETrKUZFKXFeaZCEAEgiozQP
	biwsVbxiFAf6Upi3DqSKB5hm4LpfAQ1mAhq8fEsHyOCSRISUVANj1lmTqfsqT8WIzz30Ou0t
	712tneaKyt8TEvp9N/7cufiSRLqN/745n3leTtauWPfJ5/o0a9df+f5X/92Y7Z4xUVimZ//W
	GaEsH87Y3t5yNq1lzpfaVLPjqxR81C8e0pCOZRT3r9RR2CjlufzCNfF0tZu+edzJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261338>

The policy objects don't care about "--dry-run". So move it to
expire_reflog()'s flags parameter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index dfff5f2..2f21735 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -20,9 +20,12 @@ static const char reflog_delete_usage[] =
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
 
+enum expire_reflog_flags {
+	EXPIRE_REFLOGS_DRY_RUN = 1 << 0
+};
+
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
-	int dry_run;
 	int stalefix;
 	int rewrite;
 	int updateref;
@@ -438,7 +441,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 	}
 
 	log_file = git_pathdup("logs/%s", refname);
-	if (!cmd->dry_run) {
+	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		/*
 		 * Even though holding $GIT_DIR/logs/$reflog.lock has
 		 * no locking implications, we use the lock_file
@@ -467,7 +470,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
 	reflog_expiry_cleanup(&cb);
 
-	if (cb.newlog) {
+	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
@@ -658,7 +661,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
-			cb.dry_run = 1;
+			flags |= EXPIRE_REFLOGS_DRY_RUN;
 		else if (starts_with(arg, "--expire=")) {
 			if (parse_expiry_date(arg + 9, &cb.expire_total))
 				die(_("'%s' is not a valid timestamp"), arg);
@@ -752,7 +755,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
-			cb.dry_run = 1;
+			flags |= EXPIRE_REFLOGS_DRY_RUN;
 		else if (!strcmp(arg, "--rewrite"))
 			cb.rewrite = 1;
 		else if (!strcmp(arg, "--updateref"))
-- 
2.1.3
