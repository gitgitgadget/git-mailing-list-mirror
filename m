From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 1/5] refs: introduce pseudoref and per-worktree ref concepts
Date: Fri, 31 Jul 2015 02:06:17 -0400
Message-ID: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 08:06:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL3Sk-00029o-DX
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 08:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbbGaGGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 02:06:30 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35453 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbGaGG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 02:06:29 -0400
Received: by qgii95 with SMTP id i95so39535058qgi.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 23:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I2LzJ64tjzwI5cWzlKNHYB0Tfo5I49uT5x70MhAwbM4=;
        b=U5udT3csB7ZT96Ag09W8FT1YqV+nxS0rOj14RICgdkct/SMdwgyNlgbwbXvnukRAEa
         3v/d4MCCZRr9ZS+Mr2MbekATvyJTUaCOGSkjnjdIb2jSHms5+L+TwnUPT/zptyLoAHu0
         a334APsbQPojQVcOKYWSGdYNslLZsQ2fBtj3SSG6esnFthcuVz8Ar1oEDLTqGCZUlhXC
         Vx/qLO93i3BDZ6BAzcM7rBhlxjyfPWzRjm7dkAdHSgoY8+nFLXOKkxGBidaIc1uHpngi
         Laf7FRnTwijvO0EFGzpeySFSFG8HIt8jgZdKV0U4agOQO8nfHTAkGfYaZafjqoMg7/lu
         9NFA==
X-Gm-Message-State: ALoCoQm0yqegGjNd8EAeUIjG/gYUxdKdSsEpOt9Fmysmwlk/xEmSG1E6OFgz2VWb+t5MV43+mVdQ
X-Received: by 10.140.22.73 with SMTP id 67mr1599219qgm.42.1438322788804;
        Thu, 30 Jul 2015 23:06:28 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id c35sm1737073qgc.47.2015.07.30.23.06.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 23:06:27 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275036>

Add glossary entries for both concepts.

Pseudorefs and per-worktree refs do not yet have special handling,
because the files refs backend already handles them correctly.  Later,
we will make the LMDB backend call out to the files backend to handle
per-worktree refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---

This version squashes in Junio's glossary and capitalization
corrections, and corrects the spelling of pseudoref (thanks to Johan
Herland).

---

 Documentation/glossary-content.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index ab18f4b..8c6478b 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -411,6 +411,27 @@ exclude;;
 	core Git. Porcelains expose more of a <<def_SCM,SCM>>
 	interface than the <<def_plumbing,plumbing>>.
 
+[[def_per_worktree_ref]]per-worktree ref::
+	Refs that are per-<<def_working_tree,worktree>>, rather than
+	global.  This is presently only <<def_HEAD,HEAD>>, but might
+	later include other unusual refs.
+
+[[def_pseudoref]]pseudoref::
+	Pseudorefs are a class of files under `$GIT_DIR` which behave
+	like refs for the purposes of rev-parse, but which are treated
+	specially by git.  Pseudorefs both have names that are all-caps,
+	and always start with a line consisting of a
+	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
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
