From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 01/13] fast-export: avoid importing blob marks
Date: Wed, 28 Nov 2012 23:10:57 +0100
Message-ID: <1354140669-23533-2-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdprD-0002iy-R1
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab2K1WLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:11:31 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab2K1WL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:11:29 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=91wXcy231mI0WR2xFQNP+D5GlB7/KCnuqPOsVrge8B8=;
        b=zPkOfEi7LJ0EnG6n9Z4nThQMlwBVREy85saGobZzErFTUbHFeWjyGbh+lYpeKZA6sW
         lKA/YqtkUR9l+eq7ua6ZPlr5EnpG0t24oDYO3nytlExwS2Xw8Kv7fwJUlij2pb34mkvi
         vZoZhbfhJFQmB0mAUsaaQmbsNWK9Xz5xF3jN7cKC3+cN6VvTGRRLfSd2VFUNJAJaBTWu
         WJHNqXrMMGudxBq+jSAVvN1+TstJ/CFDTpLmF4kP2RYxAH6DUjYKKDdoEsaK/1rFHIHT
         jdfHZ+2gniAOwii/qSTmUroLZaR983lqIXW5L9eRiQhtTsVJrQjyfxfRHtv7p1UoEbtr
         DD2w==
Received: by 10.205.141.84 with SMTP id jd20mr460781bkc.69.1354140688261;
        Wed, 28 Nov 2012 14:11:28 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id go4sm13829893bkc.15.2012.11.28.14.11.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:27 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210787>

We want to be able to import, and then export, using the same marks, so
that we don't push things that the other side already received.

Unfortunately, fast-export doesn't store blobs in the marks, but
fast-import does. This creates a mismatch when fast export is reusing a
mark that was previously stored by fast-import.

There is no point in one tool saving blobs, and the other not, but for
now let's just check in fast-export that the objects are indeed commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.8.0.1
