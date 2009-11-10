From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 4/4] builtin-fetch: add --dry-run option
Date: Mon,  9 Nov 2009 23:58:33 -0500
Message-ID: <1257829113-52168-5-git-send-email-jaysoffian@gmail.com>
References: <1257829113-52168-1-git-send-email-jaysoffian@gmail.com>
 <1257829113-52168-2-git-send-email-jaysoffian@gmail.com>
 <1257829113-52168-3-git-send-email-jaysoffian@gmail.com>
 <1257829113-52168-4-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 05:59:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ip4-0004pk-4l
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 05:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbZKJE64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 23:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755676AbZKJE6y
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 23:58:54 -0500
Received: from mail-qy0-f194.google.com ([209.85.221.194]:57263 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbZKJE6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 23:58:52 -0500
Received: by mail-qy0-f194.google.com with SMTP id 32so1481613qyk.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 20:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=//Q3IJVTDRGwDNlLIvukHNMVVjeNd7MmmEjSwjHcYRs=;
        b=KnUFh5wyeYUgn+4XN4AtVUe8P/jwrjBuxJ7WC/6+qgFkmdeicb4dMiVHOw7A3teZP+
         Mxz5MgGm6c9kcjy0+ybHUJwU4C0pAARA8MZUfjP4i5aezGCZBeuqzRP8mVd7kU9J/Toh
         PJqXijE1+aJtGCJAGc2/lf2pRzv/2cqaUAQEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=q3rb/+f3FcSZNTVtlO3yv0iJuwhoex4SeFiY7RsIteKzJ1AADWQngszBx7G9cizDi4
         3mQnhRiV0Pauip6p9cCyi3nzpqJZoWjhuwO3CStmQH4w3yy44tXc3odYR/Y+zABE5wI5
         +XGleSlABI55TJJeV7RFPsztzPMZQHWue97N0=
Received: by 10.224.44.2 with SMTP id y2mr4591231qae.125.1257829137750;
        Mon, 09 Nov 2009 20:58:57 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 23sm256850qyk.15.2009.11.09.20.58.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 20:58:57 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1257829113-52168-4-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132530>

Teach fetch --dry-run as users of "git remote prune" switching to "git fetch
--prune" may expect it. Unfortunately OPT__DRY_RUN() cannot be used as fetch
already uses "-n" for something else.
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
