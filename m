From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 11/11] for-each-ref: add '--contains' option
Date: Tue,  7 Jul 2015 21:36:17 +0530
Message-ID: <1436285177-12279-11-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
 <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 18:08:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVPk-0001w7-AU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758050AbbGGQH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:07:56 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35193 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbGGQHv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:07:51 -0400
Received: by pdbci14 with SMTP id ci14so128180654pdb.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKaEhbmTNvXifNOK41FWbaEBY2FWNsep1qIQSdhIVeE=;
        b=jBlMx8X3x75tHlDoYWHSfpu1I7bRFDA78nzzp5LErZj0/wAw4OkPL9R/VRRTbz7C1d
         ClWvbZtBX416Wjkq5bIa5HeEvtu/c8UISO0FObvQFgyCwmePN4OozXRttYEuW5f20ff+
         nz3ki0bznV7WDLg6ydj6zB/ZzTb2G5gfkRy85Yr87QcIp32SOoMQPaWc5cw52Ec7932A
         7hlGdhN6lN0SXI6gV0uDNBagfhlOfL0GSC/iBLtTOyG9BaL4h3o9UVjqeTo5Q0pCHqqd
         fmCvJCXn2INnr1nMlFSA7wPqti6QI2INl15hQIiJCyMJcdp5uoE87OTiS/GHBFISqJkF
         w3fw==
X-Received: by 10.70.90.133 with SMTP id bw5mr10418860pdb.85.1436285270831;
        Tue, 07 Jul 2015 09:07:50 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nt6sm22295515pbc.18.2015.07.07.09.07.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 09:07:49 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273579>

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
index 2842195..e49d578 100644
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
index 7521850..40f343b 100644
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
2.4.5
