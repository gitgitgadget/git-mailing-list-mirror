From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 01/14] fast-export: avoid importing blob marks
Date: Fri,  2 Nov 2012 03:02:05 +0100
Message-ID: <1351821738-17526-2-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:02:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6aw-0000Oj-4O
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762618Ab2KBCCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:02:34 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264Ab2KBCCd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:02:33 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GrXwnSQbCzFR8fdTEJDi1IqZh6OcvOYxLkBgJuv0sQ4=;
        b=dI1M+y2J+OfrLqh65Sgefq3NUW/4DEJLAwwFgGredeSylGo3UQvJvBQElK+bkBDJxr
         AFmien8c1TinlDOhB9nF3hSKUvIzju5GsbcPr9rvepgLsMzm/i6kS2+gut3kmTLJQDyi
         JXrN8KEb4PBgiiT+w/PB9tJjdL8/ZXC1PLDD8/IhFXcIDcRzKYZuyV4MePTgEmi9EwmJ
         VIGpX8F80j1iVi+cDcAmKpFjazpnz1F9+at0XHfi7erBL03ZO8zLNlPl0PLyTnvC9tho
         CmshwIE1lz2ixH+shvsRWRPeI48Dq1S1uiD8vs9dVouU8C3gSaoxOefMCf89RBYws00T
         Mcfw==
Received: by 10.204.11.209 with SMTP id u17mr23061bku.76.1351821752517;
        Thu, 01 Nov 2012 19:02:32 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id x13sm5796686bkv.16.2012.11.01.19.02.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:02:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208897>

We want to be able to import, and then export, using the same marks, so
that we don't push things that the other side already received.

Unfortunately, fast-export doesn't store blobs in the marks, but
fast-import does. This creates a mismatch when fast export is reusing a
mark that were previously stored by fast-import.

There is no point in one tool saving blobs, and the other not, but for
now let's just check in fast-export that the objects are indeed commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c  |  4 ++++
 t/t9350-fast-export.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 12220ad..a06fe10 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -614,6 +614,10 @@ static void import_marks(char *input_file)
 		if (object->flags & SHOWN)
 			error("Object %s already has a mark", sha1_to_hex(sha1));
 
+		if (object->type != 1)
+			/* only commits */
+			continue;
+
 		mark_object(object, mark);
 		if (last_idnum < mark)
 			last_idnum = mark;
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 3e821f9..0c8d828 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -440,4 +440,18 @@ test_expect_success 'fast-export quotes pathnames' '
 	)
 '
 
+test_expect_success 'test biridectionality' '
+	echo -n > marks-cur &&
+	echo -n > marks-new &&
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
