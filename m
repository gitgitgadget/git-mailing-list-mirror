From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 4/4] builtin-fetch: add --dry-run option
Date: Tue, 10 Nov 2009 00:03:34 -0500
Message-ID: <1257829414-52316-5-git-send-email-jaysoffian@gmail.com>
References: <1257829414-52316-1-git-send-email-jaysoffian@gmail.com>
 <1257829414-52316-2-git-send-email-jaysoffian@gmail.com>
 <1257829414-52316-3-git-send-email-jaysoffian@gmail.com>
 <1257829414-52316-4-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 06:04:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ito-0006KC-P3
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 06:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbZKJFDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 00:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbZKJFDt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 00:03:49 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:6023 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbZKJFDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 00:03:47 -0500
Received: by qw-out-2122.google.com with SMTP id 3so727058qwe.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 21:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dxZ/Jshg54Ub+sCVZhm7Hx+JqX2PkUPt/HyifDpAdVs=;
        b=MGDHRq+dtnhqmBdb9WGz6TDO6tjbAZOf+zE1goijih3qYufMcYS0IT/2n6unyiPMc6
         jTJejz8c63S0ZvB0+kEirQuGGTdFsz86Z9Hyl7W8CWJ587V+k8N62Rqrhjzehs0tcspK
         dNKrnNd7D1W/85BiW/UelzVD7UdU6vl7p5yG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XlXheUE6S+KksMJyleHTW2FHtVqjFdAcqJ2L7l9s0z1y5wlJC/rA7eHdEQUG5fU6jM
         7t30tgZZ3pG+pV4L4s8e+uWNepTYtR7K70xiMuJR1zumNgc/TRbVmKx6K8t/s+G+KnQK
         eBKeB/esu0bL3+pwiUCjBPxfNZmFNayPRWQXQ=
Received: by 10.224.114.9 with SMTP id c9mr4590951qaq.281.1257829431112;
        Mon, 09 Nov 2009 21:03:51 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 23sm263372qyk.3.2009.11.09.21.03.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 21:03:50 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1257829414-52316-4-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132534>

Teach fetch --dry-run as users of "git remote prune" switching to "git fetch
--prune" may expect it. Unfortunately OPT__DRY_RUN() cannot be used as fetch
already uses "-n" for something else.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/fetch-options.txt |    5 +++++
 builtin-fetch.c                 |   14 ++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 500637a..ab6419f 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -12,6 +12,11 @@
 	`git clone` with `--depth=<depth>` option (see linkgit:git-clone[1])
 	by the specified number of commits.
 
+ifndef::git-pull[]
+--dry-run::
+	Show what would be done, without making any changes.
+endif::git-pull[]
+
 -f::
 --force::
 	When 'git-fetch' is used with `<rbranch>:<lbranch>`
diff --git a/builtin-fetch.c b/builtin-fetch.c
index fd31072..8082d36 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -26,7 +26,7 @@ enum {
 	TAGS_SET = 2
 };
 
-static int all, append, force, keep, multiple, prune, update_head_ok, verbosity;
+static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -51,6 +51,8 @@ static struct option builtin_fetch_options[] = {
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
 	OPT_BOOLEAN('p', "prune", &prune,
 		    "prune tracking branches no longer on remote"),
+	OPT_BOOLEAN(0, "dry-run", &dry_run,
+		    "dry run"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
@@ -187,6 +189,8 @@ static int s_update_ref(const char *action,
 	char *rla = getenv("GIT_REFLOG_ACTION");
 	static struct ref_lock *lock;
 
+	if (dry_run)
+		return 0;
 	if (!rla)
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
@@ -312,7 +316,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
-	char *url, *filename = git_path("FETCH_HEAD");
+	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -658,7 +662,7 @@ static int do_fetch(struct transport *transport,
 		die("Don't know how to fetch from %s", transport->url);
 
 	/* if not appending, truncate FETCH_HEAD */
-	if (!append) {
+	if (!append && !dry_run) {
 		char *filename = git_path("FETCH_HEAD");
 		FILE *fp = fopen(filename, "w");
 		if (!fp)
@@ -766,9 +770,11 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 static int fetch_multiple(struct string_list *list)
 {
 	int i, result = 0;
-	const char *argv[] = { "fetch", NULL, NULL, NULL, NULL, NULL };
+	const char *argv[] = { "fetch", NULL, NULL, NULL, NULL, NULL, NULL };
 	int argc = 1;
 
+	if (dry_run)
+		argv[argc++] = "--dry-run";
 	if (prune)
 		argv[argc++] = "--prune";
 	if (verbosity >= 2)
-- 
1.6.4.2
