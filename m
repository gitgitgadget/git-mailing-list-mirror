From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 11/11] for-each-ref: add '--contains' option
Date: Sun, 14 Jun 2015 01:48:26 +0530
Message-ID: <1434226706-3764-11-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
 <1434226706-3764-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 22:19:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rtd-0003Xu-Gd
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 22:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbbFMUTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 16:19:14 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36108 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbbFMUTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 16:19:09 -0400
Received: by pdjm12 with SMTP id m12so44869906pdj.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrJr8+wI33OIfpd1qjjwCwbWHPoNrdlv3SKBuit5Rmg=;
        b=uSuF95kFx7IeUsdi9oNMonHl6q13jEqAWGaMhYQucEjYuW4aoyMh+IFmHWMg4smG+c
         TPd/4AdXy40t8fieSn0585MhMXDxdiLx6hwM6gA9byMZYBicvOEGJHP3PvsOzmsEYviS
         +w/IiLhYIFkYTJqGgFAl/RzXs8I3kvLlN+X7g9UJPg2YQbRmPTtnf86wKNcHyUmBIewg
         e56bd0FFLn851ErmS+cspdJnJGAw0AdU6jEPtAm1EjLSEv8W5MKV1+V35zo8uoJ6pMGL
         QjnZnagrzd5GaE53fpy+tH9o48AanwAmkq8S6RCIHYpaEsvtshxq7VfmX+orQH8YfyUn
         //yQ==
X-Received: by 10.68.136.42 with SMTP id px10mr34693197pbb.19.1434226748751;
        Sat, 13 Jun 2015 13:19:08 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nw8sm7471590pdb.30.2015.06.13.13.19.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 13:19:08 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434226706-3764-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271586>

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
index 3ed97bd..17cf7b0 100644
--- a/t/t6301-for-each-ref-filter.sh
+++ b/t/t6301-for-each-ref-filter.sh
@@ -63,4 +63,17 @@ test_expect_success 'filtering with --no-merged' '
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
2.4.3.435.g2403634.dirty
