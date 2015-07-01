From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/13] rerere: explain the remainder
Date: Tue, 30 Jun 2015 23:04:58 -0700
Message-ID: <1435730699-9124-13-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:06:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB9u-0004e5-MX
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbbGAGFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:50 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38266 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbGAGF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:28 -0400
Received: by igrv9 with SMTP id v9so27943641igr.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=+VJcqFn/ebkvTm+6gwJc9X3B8IGgRRy+UALRReIVa5Y=;
        b=UP7Xk9CF/w8EMmQ8OPcaTh4YSC58TPyJPn0tICpTT5fttIrZeF4J78wneWXtoa5W91
         2DwGmNU5YzXFXeXkGssKt63BbzsAU2rMrSKelvlHi27+00BsdepE8+DLfv0YUMTLSvKj
         IM9s6J7fRfQj2zw0H67me9OGXvn2B+S3gC9upFb2fukQQhs1D1AqW0w8CSol7spNlPd6
         iuwYF6GkvMKvWHYgGWrk1QmCWq9HnAgTb01p9ee6ua7AgGq3PC/JRAtn2sCBBrxiydqR
         +UhvEFa98g1DAySNgJPlogt8YkZK7TOMKMM/uj/kPigMlmRe/hcbiVXdZm+bbcVp4bnt
         xw3Q==
X-Received: by 10.42.161.74 with SMTP id s10mr2028779icx.5.1435730726765;
        Tue, 30 Jun 2015 23:05:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id q16sm984053igr.12.2015.06.30.23.05.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273130>

Explain the internals of rerere as in-code comments, while
sprinkling "NEEDSWORK" comment to highlight iffy bits and
questionable assumptions.

This covers the codepath that implements "rerere gc" and "rerere
clear".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rerere.c b/rerere.c
index 3782be6..7ef951e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -844,6 +844,9 @@ int rerere_forget(struct pathspec *pathspec)
 	return write_rr(&merge_rr, fd);
 }
 
+/*
+ * Garbage collection support
+ */
 static time_t rerere_created_at(const char *name)
 {
 	struct stat st;
@@ -856,11 +859,19 @@ static time_t rerere_last_used_at(const char *name)
 	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
 
+/*
+ * Remove the recorded resolution for a given conflict ID
+ */
 static void unlink_rr_item(const char *name)
 {
 	unlink(rerere_path(name, "thisimage"));
 	unlink(rerere_path(name, "preimage"));
 	unlink(rerere_path(name, "postimage"));
+	/*
+	 * NEEDSWORK: what if this rmdir() fails?  Wouldn't we then
+	 * assume that we already have preimage recorded in
+	 * do_plain_rerere()?
+	 */
 	rmdir(git_path("rr-cache/%s", name));
 }
 
@@ -880,6 +891,7 @@ void rerere_gc(struct string_list *rr)
 	dir = opendir(git_path("rr-cache"));
 	if (!dir)
 		die_errno("unable to open rr-cache directory");
+	/* Collect stale conflict IDs ... */
 	while ((e = readdir(dir))) {
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
@@ -897,11 +909,19 @@ void rerere_gc(struct string_list *rr)
 			string_list_append(&to_remove, e->d_name);
 	}
 	closedir(dir);
+	/* ... and then remove them one-by-one */
 	for (i = 0; i < to_remove.nr; i++)
 		unlink_rr_item(to_remove.items[i].string);
 	string_list_clear(&to_remove, 0);
 }
 
+/*
+ * During a conflict resolution, after "rerere" recorded the
+ * preimages, abandon them if the user did not resolve them or
+ * record their resolutions.  And drop $GIT_DIR/MERGE_RR.
+ *
+ * NEEDSWORK: shouldn't we be calling this from "reset --hard"?
+ */
 void rerere_clear(struct string_list *merge_rr)
 {
 	int i;
-- 
2.5.0-rc0-209-g5e1f148
