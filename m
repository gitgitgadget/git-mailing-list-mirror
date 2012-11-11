From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 01/15] fast-export: avoid importing blob marks
Date: Sun, 11 Nov 2012 14:59:38 +0100
Message-ID: <1352642392-28387-2-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
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
X-From: git-owner@vger.kernel.org Sun Nov 11 15:00:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY5e-0007Zj-HJ
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab2KKOAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:00:32 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab2KKOAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:00:31 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=orhMZfsPY2NvU/bwKcxIon1Z9U8sFT60aQ5ZpDpIRCI=;
        b=ju5ftSdVUpKgCHadJuvy+CioqUCav9Pa32tI4JIxeU9LK/3le+6uPZdZ5mCN40ap/4
         XNWDm69/Yw9NF5/jhK+LRytU4EWR5qqE5GvCLduliCKu68/kuwfkFdFK/naee+rCLlqw
         d2YMH+/5k2eXbVPndIcIJCeiXxm9Gi8Q/HjasjspDFO+W+QRshSgtp0z+Z14CLDfPy6X
         U+LhOB4DSvAsX50f/g3HfAMbqBNe++85IBJaoQ6mk/DP3yLm0sr6XoztDay1MrGDxtas
         4vGTU5AfqGnxnfkODBBhUCt9hcnzyLP4xGIwT7O0tr7v3omwnG9yRdyxIyz0MQ0lFyw8
         Jo1g==
Received: by 10.204.13.20 with SMTP id z20mr5839324bkz.75.1352642430958;
        Sun, 11 Nov 2012 06:00:30 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id e3sm1490118bks.7.2012.11.11.06.00.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:00:30 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209356>

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
