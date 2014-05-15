From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 38/44] refs.c: pack all refs before we start to rename a ref
Date: Thu, 15 May 2014 16:15:35 -0700
Message-ID: <1400195741-22996-39-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tH-0005pX-1Y
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246AbaEOXQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:26 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:54454 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so348673pbb.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q7i5g6UcnvODyUeN0R/wZ9S6iYF9iNtLN6BkBa2vlNQ=;
        b=ihg/+ogwgB6Zj3U/tlbydQZBvvHWQNE1U1RzyYZCejcQ0ytn6M+THYyjVgo+tx4RPr
         FfmZ/XkZeBHxK1OPG1JoqkHl7evwJTcW6BcvvneAJBApWuLTU/A3yxViSHAJ1HTVMZYq
         yAE0WldcB24VJVXWtZ+DMG5IiddKq6Cvb38Wt6dJFSl+S4OxfVe80zV3UN6RgcLu2nU2
         EfaTgjKbBNEZpSdPzHmMDuyv/+uP0lMv8cuh24nrvPlgfb2S5a7JYOZsL4cB2JLkeOg8
         UnC5+yH9wYzi/PSsIoRH1fGYgpvelAWsVsZFMs28arBho+mdcNzGMI+S7zHhgbHb58dF
         V3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q7i5g6UcnvODyUeN0R/wZ9S6iYF9iNtLN6BkBa2vlNQ=;
        b=R524wRYpMuloUOo2Y0Jv6sSyqVF6jHaVolAANSOj3u9Hre3D+Fi54FEokcmEkohJth
         KCj1QD2fCi/F+v7FZscaVu7xn0HTzPLvELnZuSLvydZWITXF6P15jGX+69H+s/nw/3eC
         8n3LXp9thPkNihezLlZAWlP1QGZaHevO6Y1iwfs10tY9+1Y/ZlZiKZ1lJitJI449JnPa
         lp8rfp7sEudYJ3+mrvnagfgbdokemh1Se8GzUl3vJZUE5yYYvdgwkssROEGG7p0MPSEC
         yLs2vOzeLaX1Rn6fq3iCJlIbPHsaVFnkYfmQ7SMA97h8b+9oAejzjVMaN2qqHS4Anty4
         oohw==
X-Gm-Message-State: ALoCoQluA+0a0f+R4O+YF8T0aEIA2ehgdc3EYlLZnrHMYoT45HDVGTNbSLboABzSsuxfnw/GshmU
X-Received: by 10.68.180.132 with SMTP id do4mr6513309pbc.4.1400195746335;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si318646yhk.4.2014.05.15.16.15.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2AE6831C1ED;
	Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 072E0E103B; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249237>

This means that most loose refs will no longer be present after the rename
which triggered a test failure since it assumes the file for an unrelated
ref would still be present after the rename.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 3 +++
 t/t3200-branch.sh | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e25345c..fb36cba 100644
--- a/refs.c
+++ b/refs.c
@@ -2635,6 +2635,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
+	if (pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE))
+		return error("unable to pack refs");
+
 	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ac31b71..fafd38a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -289,7 +289,7 @@ test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
 	git symbolic-ref refs/heads/master2 &&
-	test_path_is_file .git/refs/heads/master &&
+	test_path_is_missing .git/refs/heads/master &&
 	test_path_is_missing .git/refs/heads/master3
 '
 
-- 
2.0.0.rc3.477.gffe78a2
