From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/7] sha1_name: abstract upstream_mark() logic
Date: Thu, 23 May 2013 20:42:44 +0530
Message-ID: <1369321970-7759-2-git-send-email-artagnon@gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 23 17:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXB3-0003im-Ky
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 17:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759244Ab3EWPLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 11:11:16 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61486 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759133Ab3EWPLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 11:11:10 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so3069941pad.22
        for <git@vger.kernel.org>; Thu, 23 May 2013 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mxqRLktHf7dm45U1r0fkVxAR09wOBTxycRbGReZXHKE=;
        b=R2KN8u/FE+qUWoeSNPJIU2lT0D1AGyjhfFpQj1zVflRv/fetdosKF9bxBOUvLwrVn8
         04pbZvfmQ0a1FEhCOrMgBI0haE43cEVrSilrFZNRFRH7r+9K1lis195LO6Uovm7Zorci
         DjfAnwkr5z66Z8aqnRSjXVvXldykWRNq60tF/yUFrMEngVIWcANS0D1Z2l5QasX4cgUT
         2zWq1YYFYOrlJnUftYd3a+zIU7nxjPLn9ZLlRk8iTkDEArV9EvxvgH5bF68BdO4X1jmF
         vnT3flpwSNfP6XpKzXeWabkklZUmpNBmfdHZOkVdt4PN5uuNOfgDJfwGWEgpt7XsOYB7
         RbXw==
X-Received: by 10.66.165.73 with SMTP id yw9mr13989885pab.25.1369321869599;
        Thu, 23 May 2013 08:11:09 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vb8sm12099173pbc.11.2013.05.23.08.11.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 08:11:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225258>

Currently, the only non-numerical @{...} expression we support is
@{u[pstream]}.  Since we're slowly growing git to support triangular
workflows, it might make sense to have a @{p[ush]} and various other
special @{...} expressions in the future.  To prepare for this, abstract
out the upstream_mark() logic to accept any suffix, while preserving the
upstream_mark() interface.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 6928cc7..766e4e9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -23,6 +23,8 @@ struct disambiguate_state {
 	unsigned always_call_fn:1;
 };
 
+#define AT_KIND_UPSTREAM 0
+
 static void update_candidates(struct disambiguate_state *ds, const unsigned char *current)
 {
 	if (ds->always_call_fn) {
@@ -416,20 +418,40 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
-static inline int upstream_mark(const char *string, int len)
+static inline int at_mark(const char *string, int len, int *kind)
 {
-	const char *suffix[] = { "@{upstream}", "@{u}" };
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
-		int suffix_len = strlen(suffix[i]);
-		if (suffix_len <= len
-		    && !memcmp(string, suffix[i], suffix_len))
-			return suffix_len;
+	int i, j;
+
+	static struct {
+		int kind;
+		const char *suffix[2];
+	} at_form[] = {
+		{ AT_KIND_UPSTREAM, { "@{upstream}", "@{u}" } }
+	};
+
+	for (j = 0; j < ARRAY_SIZE(at_form); j++) {
+		for (i = 0; i < ARRAY_SIZE(at_form[j].suffix); i++) {
+			int suffix_len = strlen(at_form[j].suffix[i]);
+			if (suffix_len <= len
+				&& !memcmp(string, at_form[j].suffix[i], suffix_len)) {
+				if (kind)
+					*kind = at_form[j].kind;
+				return suffix_len;
+			}
+		}
 	}
 	return 0;
 }
 
+static inline int upstream_mark(const char *string, int len)
+{
+	int suffix_len, kind;
+	suffix_len = at_mark(string, len, &kind);
+	if (suffix_len && kind == AT_KIND_UPSTREAM)
+		return suffix_len;
+	return 0;
+}
+
 static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
-- 
1.8.3.rc3.17.gd95ec6c.dirty
