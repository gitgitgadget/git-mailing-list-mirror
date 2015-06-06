From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 9/9] for-each-ref: add '--contains' option
Date: Sun,  7 Jun 2015 01:34:12 +0530
Message-ID: <1433621052-5588-9-git-send-email-karthik.188@gmail.com>
References: <5573520A.90603@gmail.com>
 <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 22:04:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KKo-0002fF-Ci
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 22:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbbFFUEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 16:04:46 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34203 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbbFFUEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 16:04:42 -0400
Received: by pdbki1 with SMTP id ki1so74087297pdb.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=asXl897h8bxZvbu3ybnANU4BKZ48NSGiPQZLIDviGuY=;
        b=ieWDVQYuEjTJiIEMUWXD1iyB+mRpgneO36g0PSknhMjqJZTO7O697K0g4pkIBSyG/2
         mSTETf7lAwpGMmDQuNERRIXEYrawCunzjYzU6RXaBh+YDrkCLQgQnJD+ezO+yGFopFyT
         770lkccOBxypZ3uJwxK4MxgAbOZIGoUpUOmTXmb8dy4h+s32uXlxVzHWvcpKtdIE3wb+
         /mUxRWPgaVvaHns4yc9B10rb0wY3NTvDTGRVIADKKS7gTTcyOufRwuGPj2/crSs6vaLg
         cChbMhUlRDL7CdtTxTuLBCGAELkK8vqvYS6XedVmtv9NtMUNeh/3cxpH1+MlIYLEZ+I3
         zXMQ==
X-Received: by 10.66.250.131 with SMTP id zc3mr16329272pac.136.1433621081399;
        Sat, 06 Jun 2015 13:04:41 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id q5sm10333703pde.56.2015.06.06.13.04.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 13:04:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270947>

Add the '--contains' option provided by 'ref-filter'. The '--contains'
lists only refs which are contain the specific commit (HEAD of the
branch if no commit give).

Add documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 5 +++++
 builtin/for-each-ref.c             | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 74f24f4..7ac64ea 100644
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
index 82605ed..44e1467 100644
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
 			     parse_opt_points_at),
 		OPT_MERGED(&ref_cbdata.filter, N_("print only merged refs")),
 		OPT_NO_MERGED(&ref_cbdata.filter, N_("print only not merged refs")),
+		OPT_CONTAINS(&ref_cbdata.filter.with_commit, N_("print only refs which contain the commit")),
 		OPT_END(),
 	};
 
-- 
2.4.2
