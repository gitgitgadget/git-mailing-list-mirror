From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 1/5] refs: Introduce pseudoref and per-worktree ref concepts
Date: Wed, 29 Jul 2015 13:58:04 -0400
Message-ID: <1438192688-8048-2-git-send-email-dturner@twopensource.com>
References: <1438192688-8048-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 29 19:58:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKVca-0002ay-8I
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 19:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbbG2R6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 13:58:23 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33768 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbG2R6W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 13:58:22 -0400
Received: by qged69 with SMTP id d69so8238124qge.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 10:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZBLPZotXsFkv3IkA9JjC2S83Hs8L5ac/ipMqNIUxspY=;
        b=C/4x4I+2UYhuNpKFDn1Ku+nfYQdtI3KvcZqGyRV5wRdcQ4cQLvhCXRfnwfwCmBz4Gh
         IDN+8VG7A/dMg3qitbWW/tQ2IaePrjJB2ZkUY1O29M+60/0+uHh6+zCNZz/jwofsW3si
         mDUnHiOGIGbxkZRjvHBEIGs87bc01D3N02u9g+8k/QA9Ne4xRgdHeLTQFahZ75e0LWIX
         UDaxfLPVfGYGVsvDfuYSYy+bB2Cbmp+X/8yBnkHZSt3Ujwg19pjUwD9xZIVzQH0Kdrj3
         HRjUElKoNRH5CULa0CKfYTbo50f2elMKqgHFQ6GMkUNSsVtpKHASyDf+JdGIUX62fUX/
         pwWw==
X-Gm-Message-State: ALoCoQkWIWy/flQb74LZc5Y+eVEdnnzTsPP641hnlSVcZyO9MuCZA/oY9d46ibv+8VgOq2DCjgGG
X-Received: by 10.140.34.33 with SMTP id k30mr63316550qgk.56.1438192701954;
        Wed, 29 Jul 2015 10:58:21 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id w68sm14275247qge.18.2015.07.29.10.58.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Jul 2015 10:58:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438192688-8048-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274929>

Add glossary entries for both concepts.

Pseudorefs and per-worktree refs do not yet have special handling,
because the files refs backend already handles them correctly.  Later,
we will make the LMDB backend call out to the files backend to handle
per-worktree refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/glossary-content.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index ab18f4b..ff14079 100644
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
+	specially by git.  Psuedorefs both have names that are all-caps,
+	and always start with a line consisting of a
+	<<def_sha1,SHA-1>> followed by whitespace.  So, HEAD is not a
+	pseudoref, because it is sometimes a symbolic ref.  They might
+	optionally contain some additional data.  `MERGE_HEAD` and
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
-- 
2.0.4.315.gad8727a-twtrsrc
