From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH/RFC 2/3] builtin-fetch: add --dry-run option
Date: Fri,  6 Nov 2009 00:10:40 -0500
Message-ID: <1257484241-27219-3-git-send-email-jaysoffian@gmail.com>
References: <1257484241-27219-1-git-send-email-jaysoffian@gmail.com>
 <1257484241-27219-2-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 06:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6H6g-0006me-Fs
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 06:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbZKFFLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 00:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbZKFFLE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 00:11:04 -0500
Received: from mail-qy0-f174.google.com ([209.85.221.174]:57600 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbZKFFLA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 00:11:00 -0500
Received: by mail-qy0-f174.google.com with SMTP id 4so333511qyk.33
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 21:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BPXP0ppv3qlNGHE7YWgF52yiBM4KkniKMTnFgdXEvX8=;
        b=XHPOkoyr41oka4MGRSMTKyU/cTHY97PQA0EbXNx6Uf2epird+63UDvYhBZ1XX0YJ2Q
         nokBnuBYFYiplFmUEHfx+0+Roh4CQHBCBPj4KHt99R+1btpS6daMeBfsHKQZAX0dNPjg
         T8tgBmxYD3jBBICafpKAbsbmbhoaSDV+eK+Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aa/paXOBJGa4+afELc7ZMgXocef6ovysSMvA+kW1OrpzZ5P15NI9UpiWFDRpVCVdLj
         6oU617EZfVAMdaUwXCcJGsg3wjLHkzjpv8Qzzg6TVFd9kdyD8U0QVUpEEPn9dT8SkXyH
         t3TYDCIr6BPtjLa4DtjB6vtwnxS81IZ2pLpR4=
Received: by 10.224.41.82 with SMTP id n18mr2113335qae.254.1257484266495;
        Thu, 05 Nov 2009 21:11:06 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 20sm1014621qyk.13.2009.11.05.21.11.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 21:11:05 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1257484241-27219-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132274>

Teach fetch --dry-run. Unfortunately OPT__DRY_RUN() cannot be used as fetch
already uses "-n" for something else.
---
 builtin-fetch.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index cb48c57..985b36b 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -23,7 +23,7 @@ enum {
 	TAGS_SET = 2
 };
 
-static int append, force, keep, update_head_ok, verbosity;
+static int append, dry_run, force, keep, update_head_ok, verbosity;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -42,6 +42,8 @@ static struct option builtin_fetch_options[] = {
 		    "fetch all tags and associated objects", TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
+	OPT_BOOLEAN(0, "dry-run", &dry_run,
+		    "dry run"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
@@ -178,6 +180,8 @@ static int s_update_ref(const char *action,
 	char *rla = getenv("GIT_REFLOG_ACTION");
 	static struct ref_lock *lock;
 
+	if (dry_run)
+		return 0;
 	if (!rla)
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
@@ -303,7 +307,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
-	char *url, *filename = git_path("FETCH_HEAD");
+	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -586,7 +590,7 @@ static int do_fetch(struct transport *transport,
 		die("Don't know how to fetch from %s", transport->url);
 
 	/* if not appending, truncate FETCH_HEAD */
-	if (!append) {
+	if (!append && !dry_run) {
 		char *filename = git_path("FETCH_HEAD");
 		FILE *fp = fopen(filename, "w");
 		if (!fp)
-- 
1.6.4.2
