From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 11/11] for-each-ref: add '--contains' option
Date: Thu, 25 Jun 2015 01:23:52 +0530
Message-ID: <1435175632-27803-11-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTbXCRFx6xEv+cB7DQhu92=ePb_MJ5zeEjsr_-=HPAU6g@mail.gmail.com>
 <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 21:54:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qks-00089x-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbbFXTyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:54:36 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35541 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbbFXTy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:54:28 -0400
Received: by pdbci14 with SMTP id ci14so37065167pdb.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZSXfyA5cf2uovN3fL9ICL89hwBtAXdeX8efZc/6SUIQ=;
        b=PSexOS6I28L7x3WQFYz7QfdYLHgo57wuRYWZap8d3LCkLloK3/iYpjFxsQDfbeOpDu
         LDHoNEWUd7w9KPHe2h8Mwnzr/W/gbdbE1LRbO7pgey5fjk7IqHybc6+ZEfN+ISVnRgLh
         0tLdrVTSJ2GQLqsAJVksor/waSrue9MC1LkHtODSXH2SdDCBSjrNep8bc5s8+MB4OAl5
         VzWuXRDNwqX3u+qDgZMSQT8D87M38FRxdOMZjSLL9zSgzYXr7Rc5HV8UXPUeN4VjWihA
         YCIxvM86XSceb5Iaw+hCp6TnWCKFYXMOpCT09nBbUWqBnie5k7VNkOcIGNgc7qN6H92y
         dN0w==
X-Received: by 10.70.88.98 with SMTP id bf2mr83563191pdb.46.1435175667734;
        Wed, 24 Jun 2015 12:54:27 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id zx1sm27583483pbb.73.2015.06.24.12.54.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:54:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272602>

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
index 290a5c1..94bb5bd 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
 		   [--points-at <object>] [(--merged | --no-merged) [<object>]]
+		   [--contains [<object>]]
 
 DESCRIPTION
 -----------
@@ -74,6 +75,10 @@ OPTIONS
 	Only list refs whose tips are not reachable from the
 	specified commit (HEAD if not specified).
 
+--contains [<object>]::
+	Only list tags which contain the specified commit (HEAD if not
+	specified).
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index ba70798..5868c48 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,6 +9,7 @@ static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
 	N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
+	N_("git for-each-ref [--contains [<object>]]"),
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
index f5ccfb9..50ee115 100755
--- a/t/t6301-for-each-ref-filter.sh
+++ b/t/t6301-for-each-ref-filter.sh
@@ -58,4 +58,18 @@ test_expect_success 'filtering with --no-merged' '
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
2.4.4
