From: David Turner <dturner@twopensource.com>
Subject: [PATCH 1/5] refs: Introduce pseudoref and per-worktree ref concepts
Date: Mon, 27 Jul 2015 16:08:36 -0400
Message-ID: <1438027720-23074-2-git-send-email-dturner@twopensource.com>
References: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
X-From: git-owner@vger.kernel.org Mon Jul 27 22:08:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJohf-0003vP-BV
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 22:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbbG0UIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 16:08:48 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36822 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbbG0UIr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 16:08:47 -0400
Received: by qges31 with SMTP id s31so13651127qge.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 13:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T9Me+p5Y3m08Ct/4dTSkEL4oGbpgZi8vUejtwGABBr4=;
        b=Wwhmv49vNfiJflKrl/JVF3UbpCYezaYeZSS7NUSobqvFET0zC/IOon3AKzAOOSiK4J
         A54arfTUN33nmUW4EnSv7ZwBZH+uxRzBkCb5oUQYL39hxT36KSBFNy2OK3vyQ24+6jlA
         N7GoQ2TkunUXaYfpiFZeLRTP1ELklzuUWFqxstHdhdNnMUVaXud36yv75n0tW+0V/3Sf
         REnr8xQ29f+BV4hl2fg6AI38+P4/mGtxuFl/CHCR1GTxlx1868dWeJ1GwH2wSg/SHZS3
         u/jnM2e9ge31kFt3wTPSNfR5e5bXzLond6P3PkPdsXjt4+H4nJ01NWgOJv+0JNKC7QNN
         HuLQ==
X-Gm-Message-State: ALoCoQmd1IzsTZV8TjfDr0ruWx+tRYJmS2SSjilR9mxCofMunZfXctQgtDQ9gxPUbtFIoLqyiPUK
X-Received: by 10.140.107.101 with SMTP id g92mr42902278qgf.58.1438027726543;
        Mon, 27 Jul 2015 13:08:46 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm9893690qkz.38.2015.07.27.13.08.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 13:08:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274702>

Add glossary entries for both concepts.

Pseudorefs and per-worktree refs do not yet have special handling,
because the files refs backend already handles them correctly.  Later,
we will make the LMDB backend call out to the files backend to handle
per-worktree refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/glossary-content.txt | 21 +++++++++++++++++++++
 refs.c                             | 23 +++++++++++++++++++++++
 refs.h                             |  2 ++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index ab18f4b..67952f3 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -411,6 +411,27 @@ exclude;;
 	core Git. Porcelains expose more of a <<def_SCM,SCM>>
 	interface than the <<def_plumbing,plumbing>>.
 
+[[def_per_worktree_ref]]per-worktree ref::
+	Refs that are per-<<def_worktree,worktree>>, rather than
+	global.  This is presently only <<def_HEAD,HEAD>>, but might
+	later include other unusual refs.
+
+[[def_pseudoref]]pseudoref::
+	Pseudorefs are a class of files under `$GIT_DIR` which behave
+	like refs for the purposes of rev-parse, but which are treated
+	specially by git.  Psuedorefs both have names are all-caps,
+	and always start with a line consisting of a
+	<<def_sha1,SHA-1>> followed by whitespace.  So, HEAD is not a
+	pseudoref, because it is sometimes a symbolic ref.  They might
+	optionally some additional data.  `MERGE_HEAD` and
+	`CHERRY_PICK_HEAD` are examples.  Unlike
+	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
+	be symbolic refs, and never have reflogs.  They also cannot be
+	updated through the normal ref update machinery.  Instead,
+	they are updated by directly writing to the files.  However,
+	they can be read as if they were refs, so `git rev-parse
+	MERGE_HEAD` will work.
+
 [[def_pull]]pull::
 	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
 	<<def_merge,merge>> it.  See also linkgit:git-pull[1].
diff --git a/refs.c b/refs.c
index 0b96ece..0d10b7b 100644
--- a/refs.c
+++ b/refs.c
@@ -2848,6 +2848,29 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
+int is_per_worktree_ref(const char *refname)
+{
+	return !strcmp(refname, "HEAD");
+}
+
+static int is_pseudoref(const char *refname)
+{
+	const char *c;
+
+	if (strchr(refname, '/'))
+		return 0;
+
+	if (is_per_worktree_ref(refname))
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
 int delete_ref(const char *refname, const unsigned char *old_sha1,
 	       unsigned int flags)
 {
diff --git a/refs.h b/refs.h
index e4e46c3..bd5526e 100644
--- a/refs.h
+++ b/refs.h
@@ -445,6 +445,8 @@ extern int parse_hide_refs_config(const char *var, const char *value, const char
 
 extern int ref_is_hidden(const char *);
 
+int is_per_worktree_ref(const char *refname);
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-- 
2.0.4.315.gad8727a-twtrsrc
