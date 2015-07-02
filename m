From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 11/11] for-each-ref: add '--contains' option
Date: Thu,  2 Jul 2015 20:51:10 +0530
Message-ID: <1435850470-5175-11-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 17:22:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAgJs-0000Y7-Tx
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 17:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbbGBPW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 11:22:29 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35583 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbbGBPWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 11:22:17 -0400
Received: by pactm7 with SMTP id tm7so42021500pac.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AADAtSjVANCAGqGJCooU6jePsM1ke55M3cWTG5HJmLA=;
        b=M9AqXYLQq33lnnPDQHMdBdv8OjDsZFIyJReNPumY8YJOi/Dfo6j4I5xv+o3GVg6FvX
         1EFXJRtx6lLGqnNnNq8p3Qn5QpQ8kcH7aBVfMKRvmh7+FJmkUN6Nu2X1q1SWlXVMOtMJ
         OU+Z0yZmPkaXQoFFadDgPMXMd1ZqnWLUU8TxGszEu/Wu0Gke6gXTQe55sewvw97pXS4m
         3Dg+rRQJAdPdAjb2jaIhzSVEuvj7OV1maDE8gikW72B9AJB6MkllGNDl1Oz4mYsJiGBO
         nHvPVqpEZwmTNiXAE6ne6+UWOUSvDEARyYVg6TwHxj/MZtj8q+0g+p+haU30Rvze98EI
         4mlw==
X-Received: by 10.66.102.65 with SMTP id fm1mr66352175pab.25.1435850536691;
        Thu, 02 Jul 2015 08:22:16 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id fu2sm635208pdb.32.2015.07.02.08.22.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 08:22:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273243>

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
 t/t6302-for-each-ref-filter.sh     | 15 +++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index bf8b24a..f0b9dfb 100644
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
index 120b753..3493ede 100644
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
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 73dbf53..9969a08 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -60,4 +60,19 @@ test_expect_success 'filtering with --no-merged' '
 	test_cmp expect actual
 '
 
+test_expect_success 'filtering with --contains' '
+	cat >expect <<-\EOF &&
+	refs/heads/master
+	refs/heads/side
+	refs/odd/spot
+	refs/tags/double-tag
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
