From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 11/19] for-each-ref: add '--contains' option
Date: Mon, 22 Jun 2015 02:18:25 +0530
Message-ID: <1434919705-4884-11-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 22:49:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6mBL-0005nD-6A
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbbFUUtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:49:32 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34075 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891AbbFUUta (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:49:30 -0400
Received: by pdbki1 with SMTP id ki1so124845260pdb.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+achg6dU3/xeUL5C+dMmawqU8YLZehmRNTWrTrp5lh0=;
        b=HtJaTaGjePFCyfpP0BkvpHHs9VsMdW9oIc023JwdUw0Qg2xuQAlkFVoaD9TUOY5wpj
         u161RNkMpMBNul6xpFjKCajxMF2jeno5ibDB2C3krbDf/XoLCWLA/QLw6ZVclzFtN3gZ
         7CeGemCxhSnbmAFbgZ8JsISir71kkLFB87Y2kyo0lF9q1Npol/yccSMQtoZV2eGn1/As
         iwgJ2t1X/DAsqxEd+Zgw7E2z58TalWR1krE3CB48a1Q2IizzwLHBvp5PbxYcRFxsdgXs
         mU+jMLhu8FvbOCnuF4LOMdkSnZi2wnAMaBUd/7PE+LF3IiE87pPJnbzzTd5w+LulStMA
         WfpQ==
X-Received: by 10.70.36.102 with SMTP id p6mr52131966pdj.18.1434919769152;
        Sun, 21 Jun 2015 13:49:29 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm17519488pda.54.2015.06.21.13.49.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jun 2015 13:49:28 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272297>

Add the '--contains' option provided by 'ref-filter'. The '--contains'
option lists only refs which contain the mentioned commit (HEAD if no
commit is explicitly given).

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 +++++
 builtin/for-each-ref.c             |  2 ++
 t/t6301-for-each-ref-filter.sh     | 14 ++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c6dcd99..42d53fc 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
 		   [--points-at <object>] [(--merged | --no-merged) <object>]
+		   [--contains <object>]
 
 DESCRIPTION
 -----------
@@ -74,6 +75,10 @@ OPTIONS
 	Only list refs whose tips are not reachable from the
 	specified commit (HEAD if not specified).
 
+--contains [<commit>]::
+	Only list tags which contain the specified commit (HEAD if not
+	specified).
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 09d48da..6819f39 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,6 +9,7 @@ static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
 	N_("git for-each-ref [(--merged | --no-merged) <object>]"),
+	N_("git for-each-ref [--contains <object>]"),
 	NULL
 };
 
@@ -41,6 +42,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 			     parse_opt_object_name),
 		OPT_MERGED(&filter, N_("print only refs that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
+		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
 		OPT_END(),
 	};
 
diff --git a/t/t6301-for-each-ref-filter.sh b/t/t6301-for-each-ref-filter.sh
index 5b5cf04..d143fba 100755
--- a/t/t6301-for-each-ref-filter.sh
+++ b/t/t6301-for-each-ref-filter.sh
@@ -48,4 +48,18 @@ test_expect_success 'filtering with --no-merged' '
 	test_cmp expect actual
 '
 
+test_expect_success 'filtering with --contains' '
+	cat >expect <<-\EOF &&
+	refs/heads/master
+	refs/heads/side
+	refs/odd/spot
+	refs/tags/four
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --contains=two >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.3.439.gfea0c2a.dirty
