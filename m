From: larsxschneider@gmail.com
Subject: [PATCH v1 1/2] git-p4: print stderr if P4 read_pipe operation fails
Date: Mon,  7 Sep 2015 14:42:02 +0200
Message-ID: <1441629723-90604-2-git-send-email-larsxschneider@gmail.com>
References: <1441629723-90604-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:42:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvka-0002lH-41
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbbIGMmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 08:42:16 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35205 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbbIGMmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:42:13 -0400
Received: by wicge5 with SMTP id ge5so82749642wic.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SS62xkk1KxWjE6zJjoXTnMGKFmWyjENgooCiXDDOmxw=;
        b=rmLsZpFLm6RG4XhxmF3kWKfeY05VqSWsHwgdK765yev0X9rctQRyY12jB+vO0Z1qGz
         fSuU0qqpDE3KZWAGup4tHcEa7bUVas7VkW06CPO23lPrhUR2poWN4sSMXiifcImJXaUM
         tH/rSxUcE0LYtnBJhKAAJTgwG1lGgrjO7MapPs19YkOUV8ZOrHuWSNQnJA61NkTe3xAi
         zlx00rcoIyKNWs5a+j8/3VshPDiEqGGIHR6oNutPgr2N3K3giwK2ILG6bLolvOmW2MUn
         MB7Lvch1LUxUnJptKXNe8LwcNVRM4vPf9uTs/OBj7vdZS04KoxrkX/Hv+m6W/pDSO4fp
         pWVg==
X-Received: by 10.180.105.33 with SMTP id gj1mr25428222wib.90.1441629732104;
        Mon, 07 Sep 2015 05:42:12 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id ul1sm19891852wjc.30.2015.09.07.05.42.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 05:42:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441629723-90604-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277459>

From: Lars Schneider <larsxschneider@gmail.com>

If read_pipe crashes then the caller can inspect the error and handle
it appropriately.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 073f87b..36a4bcb 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -134,11 +134,11 @@ def read_pipe(c, ignore_error=False):
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
     expand = isinstance(c,basestring)
-    p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
+    p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     pipe = p.stdout
     val = pipe.read()
     if p.wait() and not ignore_error:
-        die('Command failed: %s' % str(c))
+        die('Command failed: %s\nError: %s' % (str(c), p.stderr.read()))
 
     return val
 
-- 
2.5.1
