From: David Turner <dturner@twopensource.com>
Subject: [PATCH 1/9] refs:  Introduce pseudoref and per-worktree ref concepts
Date: Fri, 24 Jul 2015 00:45:21 -0400
Message-ID: <1437713129-19373-2-git-send-email-dturner@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jul 24 06:45:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUru-0003mj-8t
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbbGXEpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:45:52 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:32973 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbbGXEpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:45:50 -0400
Received: by qkdl129 with SMTP id l129so8260478qkd.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ml4g78qBY5ctiTpztztmfylu/gaeYICmAkx3Rm0iHg=;
        b=FqoG0vlMm37vrRLgh49Ttl9yOeeR0RPMa+AthFh4LwhRLXV+5VbKVU+yLHauCwsyJ7
         HnN5A5oNnVJEGvtgHnbt8pKwZHxeNvh7MQTBvhmyQ+5nUUNKHkR6C190Xl8dMEqWcIs8
         xMzL14rVbw+sfHnj1A1r1k3f2ZdmDgGsfIRXyH3xeEMIqXrTBMzL/30O+1wr9CK7xSbQ
         hL6dDHg8b7Ek5Ox9n/rQK06ekq3UkcnMBtlIzPYGZT2A4g06UY1lQ48tO1ni0EVI78zu
         P7m4iDlcJ71BWvvC1V+yh6d7ZNtwdZS9rua92FvFL5ip3I/XHDkbKGp4GVrr+2thpzQv
         BsTg==
X-Gm-Message-State: ALoCoQmDSZXoGxWh9LrczgHy39b6HEmWk8IkUt7eue62Nq2vmLSw/D1923VCO83cA//4MnYLKQ6S
X-Received: by 10.140.216.20 with SMTP id m20mr18453967qhb.37.1437713149263;
        Thu, 23 Jul 2015 21:45:49 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p74sm3541579qkp.11.2015.07.23.21.45.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:45:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274544>

Add glossary entries for both concepts.

Pseudorefs and per-worktree refs do not yet have special handling,
because the files refs backend already handles them correctly.  Later,
we will make the LMDB backend call out to the files backend to handle
per-worktree refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/glossary-content.txt | 17 +++++++++++++++++
 refs.c                             | 23 +++++++++++++++++++++++
 refs.h                             |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index ab18f4b..d04819e 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -411,6 +411,23 @@ exclude;;
 	core Git. Porcelains expose more of a <<def_SCM,SCM>>
 	interface than the <<def_plumbing,plumbing>>.
 
+[[def_per_worktree_ref]]per-worktree ref::
+	Refs that are per-<<def_worktree,worktree>>, rather than
+	global.  This is presently only <<def_HEAD,HEAD>>, but might
+	later include other unsuual refs.
+
+[[def_pseudoref]]pseudoref::
+	Files under `$GIT_DIR` whose names are all-caps, and that
+	contain a line consisting of a <<def_sha1,SHA-1>> followed by
+	a newline, and optionally some additional data.  `MERGE_HEAD`
+	and `CHERRY_PICK_HEAD` are examples.  Unlike
+	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
+	be symbolic refs, and never not have reflogs.  They also
+	cannot be updated through the normal ref update machinery.
+	Instead, they are updated by directly writing to the files.
+	However, they can be read as if they were refs, so `git
+	rev-parse MERGE_HEAD` will work.
+
 [[def_pull]]pull::
 	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
 	<<def_merge,merge>> it.  See also linkgit:git-pull[1].
diff --git a/refs.c b/refs.c
index 0b96ece..d31ca42 100644
--- a/refs.c
+++ b/refs.c
@@ -3857,6 +3857,29 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
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
 static struct ref_update *add_update(struct ref_transaction *transaction,
 				     const char *refname)
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
