From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 11/11] for-each-ref: add '--contains' option
Date: Tue, 16 Jun 2015 19:50:57 +0530
Message-ID: <1434464457-10749-11-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 16:27:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4rpy-0008HW-16
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473AbbFPO10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 10:27:26 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36233 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbFPO1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:27:23 -0400
Received: by pabqy3 with SMTP id qy3so13809213pab.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p/rEDBIVaf7x+N0p8FT+xtq/l/OHKXexJl1AB4wKxGs=;
        b=sKB99P8ULn2E3q7KR4Bydd+IZDznxdUJEVQvTW0ID6maHrpYgzI8AagKEqV5iV0Mr1
         +pokK9xHMP0fpqtoAajG0Gv5wKBLg/grCA5Q0NVLpqvW7itin/ZXQMVqllLt9IAtJIVy
         EjRUqxgQfFMNVvy0MWlCW4tS+YkzOBAywDP//bmv5f2vPZut/5UN14axXtb+B5vLcIRq
         xATeeNh2XLPtcH+N3UzUVBG9q2idYZZOKu2pFleN/IdFd09ljCkuCLhn091wuM6Ab2M9
         vuvxqhxb9HttW3DAOnSF4KmXaK3Gq1TkTFfGSorDXiEW5yS32AoqnH3EIubdXde5qoxq
         ZEcQ==
X-Received: by 10.70.103.70 with SMTP id fu6mr1286469pdb.22.1434464843332;
        Tue, 16 Jun 2015 07:27:23 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm1594145pda.54.2015.06.16.07.27.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 07:27:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.436.g722e2ce.dirty
In-Reply-To: <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271765>

Add the '--contains' option provided by 'ref-filter'. The '--contains'
option lists only refs which are contain the mentioned commit (HEAD if
no commit is explicitly given).

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 +++++
 builtin/for-each-ref.c             |  2 ++
 t/t6301-for-each-ref-filter.sh     | 13 +++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d61a756..7a949f3 100644
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
index 00913f4..8ccbb1c 100644
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
index 593c3cb..ab7928c 100755
--- a/t/t6301-for-each-ref-filter.sh
+++ b/t/t6301-for-each-ref-filter.sh
@@ -64,4 +64,17 @@ test_expect_success 'filtering with --no-merged' '
 	test_cmp expect actual
 '
 
+test_expect_success 'filtering with --contains' '
+	cat >expect <<-\EOF &&
+	refs/heads/master
+	refs/heads/side
+	refs/odd/spot
+	refs/tags/four
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --contains=two >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.3.436.g722e2ce.dirty
