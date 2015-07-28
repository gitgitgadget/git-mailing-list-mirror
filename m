From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 3/6] refs: add ref_type function
Date: Tue, 28 Jul 2015 14:12:21 -0400
Message-ID: <1438107144-24293-4-git-send-email-dturner@twopensource.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Cc: mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 20:13:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9NX-0005AC-TM
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbbG1SNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:13:22 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36484 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbbG1SMq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:12:46 -0400
Received: by qkdv3 with SMTP id v3so54429027qkd.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Glnt6qqQh6u/CKke/DpEh28IBnswNT3H6AQdO4pdV88=;
        b=ZWfMEBnAwb0X+N/StX3df5vVagiqreTBYVfhpUu05Gb2j2bFBh7DVurJvuY3AfCA7f
         TbTLEMB6r8Q/Pf2uzbiz2c33jp05AfGX3ARW1smJXSmAFMF8PYh3EjYgJIT5VyFm6Q+v
         pA7mka+wUoek4wFRZm93AIC8T4yYZ6tLnyfwLL2s8Hi2RdKRrj8rD8lYC0qoAUbmpXz/
         jazhEk3UncOUXo4IkGnn0xlt1fEVOs4JesZ0tf3oLgcOgutS2OLjbwq4QxKpNZFizfC4
         LYKDEuQgojnSMZAXRldfs5HLpNbOhcQGgCgnejcoKPN4jlprAHg+Izf8aKJ6wr5qU1YF
         PprQ==
X-Gm-Message-State: ALoCoQkVS/VBZ5IPm6RWCXoX1t+u6ia1hxUcCp1G1/3ETgx6Iu7CgO+m1WhynI8qz16GtXOvc7Rf
X-Received: by 10.55.40.135 with SMTP id o7mr51669125qko.106.1438107166061;
        Tue, 28 Jul 2015 11:12:46 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm11653540qkz.38.2015.07.28.11.12.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 11:12:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274808>

Add a function ref_type, which categorizes refs as per-worktree,
pseudoref, or normal ref.

Later, we will use this in refs.c to treat pseudorefs specially.
Alternate ref backends may use it to treat both pseudorefs and
per-worktree refs differently.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 29 +++++++++++++++++++++++++++++
 refs.h |  8 ++++++++
 2 files changed, 37 insertions(+)

diff --git a/refs.c b/refs.c
index 0b96ece..553ae8b 100644
--- a/refs.c
+++ b/refs.c
@@ -2848,6 +2848,35 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
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
+	if (strchr(refname, '/'))
+		return 0;
+
+	for (c = refname; *c; ++c) {
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
