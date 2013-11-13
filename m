From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 3/3] for-each-ref: introduce %(color:...) for color
Date: Wed, 13 Nov 2013 15:06:46 +0530
Message-ID: <1384335406-16332-4-git-send-email-artagnon@gmail.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 13 10:46:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgX1P-0000bc-EO
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 10:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759185Ab3KMJp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 04:45:57 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:35496 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759131Ab3KMJpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 04:45:54 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so161542pbc.40
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g+lfTXsTXM4N7SkT5uq27wpTcvHlAeyMKFL6KeG0/Rs=;
        b=COXfvp7kOEFltUTWOAy0Y8tWaNRNP7CURgl3ttgfd6oggaP6KiEcneKOlUGlOB63lh
         VxYtOdiLzKsgJ7loGKh0xtprmxo3YmbLrIenT2CeyZDu7YJjETtL6QDav+Ul9caRrDie
         Af5Q7nEhHm8k8Uho6LBTn3wb0XapKOxsFYz2pJS3O2dJFFWCQ1CL0L4YrzYYeX8xhyhX
         TVy60Awpc+pA3SRGMXMkrbmE0npJNs1ITBX7W1tlbp/yc1GogK89mnYoTIkSc82lMKUi
         OKgumcMkke5D822BD6sKsuyHSuc4KFN7SM9/ty5eVIxZJur+BSt1Ezpi4OlV9v6tsYBA
         pZDA==
X-Received: by 10.66.188.203 with SMTP id gc11mr40346102pac.63.1384335951257;
        Wed, 13 Nov 2013 01:45:51 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id ed3sm43211477pbc.6.2013.11.13.01.45.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2013 01:45:50 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.3.g914176d.dirty
In-Reply-To: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237785>

Enhance 'git for-each-ref' with color formatting options.  You can now
use the following format in for-each-ref:

  %(color:green)%(refname:short)%(color:reset)

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/for-each-ref.c             | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c9b192e..2f3ac22 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -101,6 +101,10 @@ HEAD::
 	Used to indicate the currently checked out branch.  Is '*' if
 	HEAD points to the current ref, and ' ' otherwise.
 
+color::
+	Used to change color of output.  Followed by `:<colorname>`,
+	where names are described in `color.branch.*`.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index ed81407..c59fffe 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "remote.h"
+#include "color.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -76,6 +77,7 @@ static struct {
 	{ "symref" },
 	{ "flag" },
 	{ "HEAD" },
+	{ "color" },
 };
 
 /*
@@ -662,8 +664,9 @@ static void populate_value(struct refinfo *ref)
 			    !branch->merge[0]->dst)
 				continue;
 			refname = branch->merge[0]->dst;
-		}
-		else if (!strcmp(name, "flag")) {
+		} else if (!prefixcmp(name, "color")) {
+			;
+		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
 			if (ref->flag & REF_ISSYMREF)
 				cp = copy_advance(cp, ",symref");
@@ -729,6 +732,12 @@ static void populate_value(struct refinfo *ref)
 				else
 					v->s = "<>";
 				continue;
+			} else if (!prefixcmp(name, "color")) {
+				char color[COLOR_MAXLEN] = "";
+
+				color_parse(formatp, "--format", color);
+				v->s = xstrdup(color);
+				continue;
 			} else
 				die("unknown %.*s format %s",
 				    (int)(formatp - name), name, formatp);
-- 
1.8.5.rc0.3.g914176d.dirty
