From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 38/44] refs.c: pack all refs before we start to rename a ref
Date: Fri, 16 May 2014 10:37:26 -0700
Message-ID: <1400261852-31303-39-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5r-0000hO-JC
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758125AbaEPRip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:45 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:36603 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758037AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so519459pbc.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QQSLjofVkzoCWg/xEz8q31QIR23szVD2rHY8syR4wmY=;
        b=Eu+OeCNS4HOYynnwcx42yujQre4GRmvsMAZNb5IQ0KiyOP05BdJoaa0DzRSYxmw6+m
         Yxv7ZFJc47QEECRLPH+tLeLBifgzjtVDGw1zYbLvwaQs81+dLDqMgMBEif1ooAfOixEi
         khbKixeJna36tVIFA3PHBc9DC2womJNlvqK275ubewIK4s6XNjUXKwkNdyex4yApP2KE
         bZ2dRDRCTk4rC7VwBevll9gPFRh0ibnvdQ39jtxmi+nYkNywanm/VTBi5dm3olmW/njE
         sF5BozjlN3v130UZ+lef5Pall18byWcT1pqCGxqUV8mVNogMtihTN4z+kD0BRtu0PyNt
         FjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QQSLjofVkzoCWg/xEz8q31QIR23szVD2rHY8syR4wmY=;
        b=Nw2W6U1GALtTTKK2cEFem2g0+VJ53jL4ZAcMfu1IFY611A8aQcVOVmn+g90sUJcxaS
         /C4b9KpwHeuvVr6Ocxqzr3a+C4OYn5q5H7fXPUiS6ExATkHA4QVIHaUEAdHJjGXlRSDi
         hw05/pQ4kRN+39BaTxttCsjx2a/AoeQEszkcVT1IENmUIx9+8YgwBdUC3U+Ih+9UYx7S
         0jy0z1/Lil9zqbFplLSqPZUWfCSYVUDg3kQL//+IkhaSX3D/sn1TKdV47pSH8oIVva5D
         pS5P8zWEWeWEqWEf0phq/oSzWG7C7lEnG4zMBnzYI3V77DV7FQtOk0drfs+qq2XPz2f4
         uCIg==
X-Gm-Message-State: ALoCoQlHWiWARdAwW/x84XKlsU1LbTH5EYw6/j0sFulyJdtiNdLJeBfk4JnthgkD5nR/silmJUIZ
X-Received: by 10.66.232.38 with SMTP id tl6mr6618771pac.33.1400261858566;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si441762yhb.6.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5AD7231C211;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 36CFDE0F5D; Fri, 16 May 2014 10:37:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249372>

This means that most loose refs will no longer be present after the rename
which triggered a test failure since it assumes the file for an unrelated
ref would still be present after the rename.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 3 +++
 t/t3200-branch.sh | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1210345..f4899e0 100644
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
2.0.0.rc3.510.g20c254b
