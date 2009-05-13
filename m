From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] Change prettify_ref to prettify_refname
Date: Thu, 14 May 2009 00:22:04 +0300
Message-ID: <1242249726-8514-2-git-send-email-felipe.contreras@gmail.com>
References: <1242249726-8514-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 23:22:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4LuS-0006Qz-0S
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990AbZEMVWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 17:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757795AbZEMVWO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:22:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:63119 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbZEMVWN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 17:22:13 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1102805fga.17
        for <git@vger.kernel.org>; Wed, 13 May 2009 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=M7JRtVY2bvi+Ggqluj+8iEvuNBm6uNHXCxJpPgGgzCE=;
        b=yBcYcVGeQ1nxgqCF6jXuAucV0tywlj3SoUCqJDZPlVAXYM0ebE22KfvwOVFJH0yE5r
         cUHoeS/KqREhk/G7AA0gSrUP3b1A6jtXolbbncCmgqfGlA5brpLu8JjEXg7E0mO/EUHr
         7gLRkdN6oGUQeAWtUDIWA8i7gaN4bntc6tyJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=corB73wLoYJAw2ygjrTEkgZRXY5mw6jY1B15RwUcQnaNHTAAR5CLVsSF0PC6RTVYME
         vUwmVV+3XmLAR3xhFGclgZFxObujS9k4mgOSSH3oti9Z2X9PdQ1JS5vKXMxy5WMjcwWy
         kAKfQsdMM2YL1S8h8mxAGgB8kOHbKoJoRiRvc=
Received: by 10.86.79.12 with SMTP id c12mr1694807fgb.64.1242249732295;
        Wed, 13 May 2009 14:22:12 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 4sm765861fgg.23.2009.05.13.14.22.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 14:22:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1242249726-8514-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119108>

In preparation to be used when the ref object is not available

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-fetch.c     |    2 +-
 builtin-send-pack.c |    4 ++--
 refs.c              |    3 +--
 refs.h              |    2 +-
 transport.c         |    4 ++--
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 3c998ea..ebd0c08 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -197,7 +197,7 @@ static int update_local_ref(struct ref *ref,
 	struct commit *current = NULL, *updated;
 	enum object_type type;
 	struct branch *current_branch = branch_get(NULL);
-	const char *pretty_ref = prettify_ref(ref);
+	const char *pretty_ref = prettify_refname(ref->name);
 
 	*display = 0;
 	type = sha1_object_info(ref->new_sha1, NULL);
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d5a1c48..b2279b0 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -174,9 +174,9 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 {
 	fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
 	if (from)
-		fprintf(stderr, "%s -> %s", prettify_ref(from), prettify_ref(to));
+		fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
 	else
-		fputs(prettify_ref(to), stderr);
+		fputs(prettify_refname(to->name), stderr);
 	if (msg) {
 		fputs(" (", stderr);
 		fputs(msg, stderr);
diff --git a/refs.c b/refs.c
index e65a3b4..e74461e 100644
--- a/refs.c
+++ b/refs.c
@@ -750,9 +750,8 @@ int check_ref_format(const char *ref)
 	}
 }
 
-const char *prettify_ref(const struct ref *ref)
+const char *prettify_refname(const char *name)
 {
-	const char *name = ref->name;
 	return name + (
 		!prefixcmp(name, "refs/heads/") ? 11 :
 		!prefixcmp(name, "refs/tags/") ? 10 :
diff --git a/refs.h b/refs.h
index 29d17a4..c11f6a6 100644
--- a/refs.h
+++ b/refs.h
@@ -80,7 +80,7 @@ extern int for_each_reflog(each_ref_fn, void *);
 #define CHECK_REF_FORMAT_WILDCARD (-3)
 extern int check_ref_format(const char *target);
 
-extern const char *prettify_ref(const struct ref *ref);
+extern const char *prettify_refname(const char *refname);
 extern char *shorten_unambiguous_ref(const char *ref, int strict);
 
 /** rename ref, return 0 on success **/
diff --git a/transport.c b/transport.c
index 3dfb03c..38c7f57 100644
--- a/transport.c
+++ b/transport.c
@@ -732,9 +732,9 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 {
 	fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
 	if (from)
-		fprintf(stderr, "%s -> %s", prettify_ref(from), prettify_ref(to));
+		fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
 	else
-		fputs(prettify_ref(to), stderr);
+		fputs(prettify_refname(to->name), stderr);
 	if (msg) {
 		fputs(" (", stderr);
 		fputs(msg, stderr);
-- 
1.6.3.1
