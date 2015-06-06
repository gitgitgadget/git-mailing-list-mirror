From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 6/9] for-each-ref: add '--merged' and '--no-merged' options
Date: Sun,  7 Jun 2015 01:34:09 +0530
Message-ID: <1433621052-5588-6-git-send-email-karthik.188@gmail.com>
References: <5573520A.90603@gmail.com>
 <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 22:04:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KKi-0002b1-Rp
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 22:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbbFFUEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 16:04:38 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34878 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbbFFUEd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 16:04:33 -0400
Received: by pdbnf5 with SMTP id nf5so74255693pdb.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8jnRNvaS7JrPzG8tx+DDJ/JJhFVzdRr8ohAAidzMV00=;
        b=hwnTLDYXXZbJjr9qJfgy1sz5qUTgT4+2JzBZZ0g/zPsgMbuL3cOFk2xn+scpeguMD2
         JA39dTavzgsm7kTyUAc3Sv8sXAg5xZoQH04eshC9Ra7BeIDte6HXjAtOpgIswj62DN88
         5MU7hmSDHGqhXWWvBqnhmkZCuckl3FIERs+uiUX6Q6vzpRC1xb/UmBYBzdeUFfisA8uu
         xzL4cgzhRKQdGLsvZCTkXV8/kHKf3BiZPKtqcihZwl5HtUCClWHZzX7o25ROYY262jNE
         aHGDzDbGGjTkWQv9dMW46+moi+MXviyVwyjOx4bIYSim7raZPKlKFPZCoGZN0e59QOhG
         R3mg==
X-Received: by 10.69.17.68 with SMTP id gc4mr16135678pbd.7.1433621073156;
        Sat, 06 Jun 2015 13:04:33 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id q5sm10333703pde.56.2015.06.06.13.04.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 13:04:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270950>

Add the '--merged' and '--no-merged' options provided by 'ref-filter'.
The '--merged' option lets the user to only list refs merged into the
named commit. The '--no-merged' option lets the user to only list refs
not merged into the named commit.

Add documentation for the same.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 10 +++++++++-
 builtin/for-each-ref.c             |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e9f6a8a..74f24f4 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
-		   [--points-at <object>]
+		   [--points-at <object>] [(--merged | --no-merged) <object>]
 
 DESCRIPTION
 -----------
@@ -66,6 +66,14 @@ OPTIONS
 --points-at <object>::
 	Only list tags of the given object.
 
+--merged [<commit>]::
+	Only list refs whose tips are reachable from the
+	specified commit (HEAD if not specified).
+
+--no-merged [<commit>]::
+	Only list refs whose tips are not reachable from the
+	specified commit (HEAD if not specified).
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b9d180a..82605ed 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,6 +8,7 @@
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
+	N_("git for-each-ref [(--merged | --no-merged) <object>]"),
 	NULL
 };
 
@@ -38,6 +39,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "points-at", &ref_cbdata.filter.points_at,
 			     N_("object"), N_("print only tags of the object"),
 			     parse_opt_points_at),
+		OPT_MERGED(&ref_cbdata.filter, N_("print only merged refs")),
+		OPT_NO_MERGED(&ref_cbdata.filter, N_("print only not merged refs")),
 		OPT_END(),
 	};
 
-- 
2.4.2
