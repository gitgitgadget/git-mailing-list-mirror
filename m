From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 11/44] refs.c: move read_ref, read_ref_full and ref_exists to the common code
Date: Mon, 12 Oct 2015 17:51:31 -0400
Message-ID: <1444686725-27660-12-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:54:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll36-0006DP-PN
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbbJLVyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:54:18 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33963 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbbJLVwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:25 -0400
Received: by qkdo1 with SMTP id o1so53970002qkd.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eCPef6m8paYuLL1MuZXHTNoT61K3OD/tJu2p67bhrhc=;
        b=Q+W8BiUHXHF/SlXYGWHd8rIL5s7z1MNNtir5aEKXpei95BdjaDb8ia/dUyOj9/N3E7
         aqPNIGXnwqMWpCPLwC6XRIp2O0lD9vRKOTo/PmXw2PWhMDHnNMyWA/ZU+GfKFlcMNX06
         /mXzvJlLsQag9JsoL3BAmK08K1kHHtyOZWCSrRDg01a+XVwoJdrMTsYReZjQvLI47Zc7
         LjOl9PfycXjvyJnUP51OimR86cdNrwOAUMo7jr33FWRF4WWQIi1ert47isy3io5LKdwb
         Qh4UMu/3ouzv4Z1xSB0L3DDq2bzm5cwSBqQSFglQXGgWk/4e/gG8uXtTjNh6Czu0SeyD
         yq4g==
X-Gm-Message-State: ALoCoQlhQA411idc1xfw2L0o0ai3mEhL0HYxKDD6rW4T5Tvjo3PRBAx/Aydoz+/UCdIkMEd3kxCP
X-Received: by 10.55.203.4 with SMTP id d4mr34570965qkj.47.1444686744760;
        Mon, 12 Oct 2015 14:52:24 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279460>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not depend on the backend implementation so we
move them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 18 ------------------
 refs.c          | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 7d82864..bd0dbb5 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1791,24 +1791,6 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
-{
-	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
-		return 0;
-	return -1;
-}
-
-int read_ref(const char *refname, unsigned char *sha1)
-{
-	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
-}
-
-int ref_exists(const char *refname)
-{
-	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
-}
-
 static int filter_refs(const char *refname, const struct object_id *oid,
 			   int flags, void *data)
 {
diff --git a/refs.c b/refs.c
index 24d5e28..242f66d 100644
--- a/refs.c
+++ b/refs.c
@@ -633,3 +633,21 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	data.msg_fmt = msg_fmt;
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
+
+int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
+{
+	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
+		return 0;
+	return -1;
+}
+
+int read_ref(const char *refname, unsigned char *sha1)
+{
+	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
+}
+
+int ref_exists(const char *refname)
+{
+	unsigned char sha1[20];
+	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
+}
-- 
2.4.2.644.g97b850b-twtrsrc
