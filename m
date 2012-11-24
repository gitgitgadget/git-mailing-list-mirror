From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 01/14] fast-export: avoid importing blob marks
Date: Sat, 24 Nov 2012 04:17:01 +0100
Message-ID: <1353727034-24698-2-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:17:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Fa-0001mI-1m
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab2KXDRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:17:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab2KXDRb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:17:31 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EwG93t0qZ1gSj0G8aBxWiMr4G+K6Fl8gHr3eKXjXxsY=;
        b=i0+PCEj1ecSCMzTnqKqRT+PTlook6yZUaySFPN/B+2MGm3QhoyNe59VptkXU5DRbi3
         aGHKPjOK4diUYh86JIPA//T/nuDy1RkkzUOElb1j8um8GkUlZss12FybYuBKpg/iPJ+R
         GoYB/04533s55snPy9fs8IPHggyECToZY672TNk2TSZtqj7RAMVNok3VkSAjJQ+5ry8S
         PQyDHnI6e7x6s2ipNVcUj5L2JRntiI4STvXy7X4Jx7oVII7iAtXMvYothZTpORLZTHFa
         q98Z+mjW71f69uI/w8RYmh8QBEae46rnPKU10MEiRQFhcI/vnegiryGsN/ajOYV/fpLB
         BpCQ==
Received: by 10.204.147.22 with SMTP id j22mr1675808bkv.66.1353727050798;
        Fri, 23 Nov 2012 19:17:30 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id 1sm5466936bks.3.2012.11.23.19.17.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:17:29 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210286>

We want to be able to import, and then export, using the same marks, so
that we don't push things that the other side already received.

Unfortunately, fast-export doesn't store blobs in the marks, but
fast-import does. This creates a mismatch when fast export is reusing a
mark that was previously stored by fast-import.

There is no point in one tool saving blobs, and the other not, but for
now let's just check in fast-export that the objects are indeed commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c  |  4 ++++
 t/t9350-fast-export.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 12220ad..9b70ec1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -614,6 +614,10 @@ static void import_marks(char *input_file)
 		if (object->flags & SHOWN)
 			error("Object %s already has a mark", sha1_to_hex(sha1));
 
+		if (object->type != OBJ_COMMIT)
+			/* only commits */
+			continue;
+
 		mark_object(object, mark);
 		if (last_idnum < mark)
 			last_idnum = mark;
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 3e821f9..5948b65 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -440,4 +440,18 @@ test_expect_success 'fast-export quotes pathnames' '
 	)
 '
 
+test_expect_success 'test bidirectionality' '
+	>marks-cur &&
+	>marks-new &&
+	git init marks-test &&
+	git fast-export --export-marks=marks-cur --import-marks=marks-cur --branches | \
+	git --git-dir=marks-test/.git fast-import --export-marks=marks-new --import-marks=marks-new &&
+	(cd marks-test &&
+	git reset --hard &&
+	echo Wohlauf > file &&
+	git commit -a -m "back in time") &&
+	git --git-dir=marks-test/.git fast-export --export-marks=marks-new --import-marks=marks-new --branches | \
+	git fast-import --export-marks=marks-cur --import-marks=marks-cur
+'
+
 test_done
-- 
1.8.0
