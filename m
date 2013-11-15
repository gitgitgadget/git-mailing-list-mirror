From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 5/6] for-each-ref: introduce %(color:...) for color
Date: Fri, 15 Nov 2013 16:29:07 +0530
Message-ID: <1384513148-22633-6-git-send-email-artagnon@gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 12:08:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhHGG-0007Px-Aw
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 12:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339Ab3KOLIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 06:08:22 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:42851 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758295Ab3KOLIN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 06:08:13 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so1242084pde.21
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 03:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0cg2lVc57ZrKjmpLAduI2Wxp2kYrmoQXRvfKE3WiKLo=;
        b=msxITjuqv1EK2VzgRkQjJYhjxTitSwYQeMDDZk7PPY/qPcfIM/rK4CAMftAA7YjXah
         91uz6bV5cZOtTZsW8uEmjn26rxzBEyHTL4KF0j5Uu2/EN0NUnWDomaJyEas+sANdSVzj
         SJTGsnZTMUUpObSeyPuDPr9pDSftJyNFTrNT5PWvXCANV0j9A/dn0FRbnvncyRfJydUk
         v996E+05QGfRoKvKlL+P7eR1StNXeqbMEnJwYhW7hff/lJUBzHsLEaCkO998RqbK5kzz
         NdDyd3XJDvP4hSHngxut8+u7l2n5I8Jxk1FtawGUK2iR37FsHdl8PadSGhO4Vk9Sd8nG
         0XWw==
X-Received: by 10.67.23.164 with SMTP id ib4mr6409354pad.42.1384513692598;
        Fri, 15 Nov 2013 03:08:12 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id tu6sm3761840pbc.41.2013.11.15.03.08.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2013 03:08:12 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.6.gfd75b41
In-Reply-To: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237904>

Enhance 'git for-each-ref' with color formatting options.  You can now
use the following format in for-each-ref:

  %(color:green)%(refname:short)%(color:reset)

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/for-each-ref.c             | 11 +++++++++--
 t/t6300-for-each-ref.sh            | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

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
index ed81407..2ff4e54 100644
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
@@ -662,8 +664,13 @@ static void populate_value(struct refinfo *ref)
 			    !branch->merge[0]->dst)
 				continue;
 			refname = branch->merge[0]->dst;
-		}
-		else if (!strcmp(name, "flag")) {
+		} else if (!prefixcmp(name, "color:")) {
+			char color[COLOR_MAXLEN] = "";
+
+			color_parse(name + 6, "--format", color);
+			v->s = xstrdup(color);
+			continue;
+		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
 			if (ref->flag & REF_ISSYMREF)
 				cp = copy_advance(cp, ",symref");
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9d874fd..35ca991 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -338,6 +338,20 @@ test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
 
+get_color ()
+{
+	git config --get-color no.such.slot "$1"
+}
+
+cat >expected <<EOF
+$(get_color red)$(git rev-parse --short HEAD)$(get_color reset) origin/master
+EOF
+
+test_expect_success 'Check %(color:...) ' '
+	git for-each-ref --format="%(color:red)%(objectname:short)%(color:reset) %(upstream:short)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 heads/master
 tags/master
-- 
1.8.5.rc0.6.gfd75b41
