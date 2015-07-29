From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 2/5] refs: add ref_type function
Date: Wed, 29 Jul 2015 13:58:05 -0400
Message-ID: <1438192688-8048-3-git-send-email-dturner@twopensource.com>
References: <1438192688-8048-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 29 19:58:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKVcZ-0002ay-KK
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 19:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbbG2R6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 13:58:25 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35764 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbbG2R6X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 13:58:23 -0400
Received: by qgii95 with SMTP id i95so8220252qgi.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 10:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KCq3dVyz1camglJSDvGada4GbaXX9n++xAFZxxGGVo0=;
        b=N2o7Cqbr0udyEGG/LPw93Vc1fMz0PVSAAH/Tf20H+0xZYb2w5CfBFmWVgNG26a1CNU
         VxMEJZyqvXLTc6sb3WU/EBsxy0zN7NllP4Hhzh+IkzSDNHCdfZ+nb7CNLmFoRzKgFjRa
         S1cMJQqreDJHu72l+84lLfvm4aBRDXOuUynfSFWfsGQ3jT8GIuX7c9eueB6uDCwqVUbb
         QjMV1FaLTyfaFFQ+iKVYXCldiwZ9T7RaBow9TVhxM9Bd/eynL0Ot7ECJgA+7yl5ot0Nw
         JVMlawqjldNEmJnLVIeljBh0mMgyJ9l2mYBojXrOjUCpxzYPz8yq+NlWilYQizOu+FPd
         8Htw==
X-Gm-Message-State: ALoCoQmk9WTLsoMJNntWO9zJCj4twmoj1duwvn68ByL1UpjBoXrF/80piD+9i5k/TyiY8hx1b+u0
X-Received: by 10.140.104.236 with SMTP id a99mr64979494qgf.71.1438192703174;
        Wed, 29 Jul 2015 10:58:23 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id w68sm14275247qge.18.2015.07.29.10.58.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Jul 2015 10:58:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438192688-8048-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274928>

Add a function ref_type, which categorizes refs as per-worktree,
pseudoref, or normal ref.

Later, we will use this in refs.c to treat pseudorefs specially.
Alternate ref backends may use it to treat both pseudorefs and
per-worktree refs differently.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 26 ++++++++++++++++++++++++++
 refs.h |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/refs.c b/refs.c
index 0b96ece..0f87884 100644
--- a/refs.c
+++ b/refs.c
@@ -2848,6 +2848,32 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
+static int is_per_worktree_ref(const char *refname)
+{
+	return !strcmp(refname, "HEAD");
+}
+
+static int is_pseudoref_syntax(const char *refname)
+{
+	const char *c;
+
+	for (c = refname; *c; c++) {
+		if (!isupper(*c) && *c != '-' && *c != '_')
+			return 0;
+	}
+
+	return 1;
+}
+
+enum ref_type ref_type(const char *refname)
+{
+	if (is_per_worktree_ref(refname))
+		return REF_TYPE_PER_WORKTREE;
+	if (is_pseudoref_syntax(refname))
+		return REF_TYPE_PSEUDOREF;
+       return REF_TYPE_NORMAL;
+}
+
 int delete_ref(const char *refname, const unsigned char *old_sha1,
 	       unsigned int flags)
 {
diff --git a/refs.h b/refs.h
index e4e46c3..dca4fb5 100644
--- a/refs.h
+++ b/refs.h
@@ -445,6 +445,14 @@ extern int parse_hide_refs_config(const char *var, const char *value, const char
 
 extern int ref_is_hidden(const char *);
 
+enum ref_type {
+	REF_TYPE_PER_WORKTREE,
+	REF_TYPE_PSEUDOREF,
+	REF_TYPE_NORMAL,
+};
+
+enum ref_type ref_type(const char *refname);
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-- 
2.0.4.315.gad8727a-twtrsrc
