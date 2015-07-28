From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 1/6] refs: Introduce pseudoref and per-worktree ref concepts
Date: Tue, 28 Jul 2015 14:12:19 -0400
Message-ID: <1438107144-24293-2-git-send-email-dturner@twopensource.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Cc: mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 20:12:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9Mu-0004hL-Lu
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbbG1SMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:12:45 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35186 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbbG1SMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:12:44 -0400
Received: by qkbm65 with SMTP id m65so54391949qkb.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZBLPZotXsFkv3IkA9JjC2S83Hs8L5ac/ipMqNIUxspY=;
        b=Wo6XRV+G3oTfol9h7GM0wKO3MtQaAS/zVDNEYZTr5VE8uxoD+U0+LFBnuoRtGMRsGz
         rBiHRm5Rp95CcPFzv4QBhEX6qwxMrZ2VV6nc7W3y2WQsEKfQk18oQ5S1J4iGE8ojJFeC
         kt4UUBYmVVpDaadAtnjTVhtHREWmYIZ5xV+Ip3t0RG16uzwNMTlFflwHLzw3NO6iuWw7
         5lAz29DUyLbTUtoWChunNpgXgyFHvQ9zCOuYx+ph2aa+1RlzRuHX4Q2ba3BrYybObB0N
         GU6X29AGx9u5h5wnGuAcQ1TIumDhmmMGlSmIfUQS6+9ojGAkHLnfPrnyEQjCrl8FbJt6
         bzUw==
X-Gm-Message-State: ALoCoQml3tGyAx8GDskIcg8WKqIwP/PG8Z7UOupldAHMzNbogSZ9ZQOcK0RD5m/SsB3twoW1uU5Y
X-Received: by 10.55.27.92 with SMTP id b89mr51978339qkb.80.1438107163340;
        Tue, 28 Jul 2015 11:12:43 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm11653540qkz.38.2015.07.28.11.12.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 11:12:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274802>

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
