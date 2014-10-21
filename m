From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 09/15] refs.c: only write reflog update if msg is non-NULL
Date: Tue, 21 Oct 2014 12:24:16 -0700
Message-ID: <1413919462-3458-10-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:31:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf9W-0003Zd-8o
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798AbaJUTb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:31:26 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:46097 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbaJUTbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:31:25 -0400
Received: by mail-yh0-f74.google.com with SMTP id a41so5602yho.5
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3TrshytTh+0tAmoTItNFalzokeE2GoUgiBXY34Yi0H4=;
        b=CJqWWd/jwM39LWtdmdiql4cCjEw6oDAym2CTjbYD+ifaoPNq4FT3//yCwxDFSs/NfT
         QZ8qUsqXcuubQZ/RfpRSg9aW1YoBwRbTQYzPYTgxBC/yfAQjqHTZm8krcEZoJmoq/yTo
         oKOwOmnwfDvaWSqLPK9x9c5bXG5Ko0kD+ZmW0b9F06B1XAA+WYInQWCtr7UB9Iqex8pG
         u4EeekrNxZMyVEvBCqXNswUnzRpjiDzG1UONibF4zwSM7wFeK5ExZ5/Li8K4EvZaqKH3
         8/FrWQ8vvasijvve1cX5GjsFJ3S7L5w+mscSiJk0yJPVxe29z+iulkawbVXur1j28c/a
         nkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3TrshytTh+0tAmoTItNFalzokeE2GoUgiBXY34Yi0H4=;
        b=irQKWhG59YioNKfKqeXVgBU7cl9teE0wSFBwvmNbf9GrsJVh3nhx1tdY4eYR/nGoSa
         0hgAkXwJveM40ZpeKrFPxSj0FFq1CshOJhxS4o12fBMhrL61LEKF3fv1Psb0O4taIIH/
         R2BwpXYJoD/z/5l/RZCgXhm8ZUUYRbzmRKVVCv9rf+EfsAlxu6kpwqqey0vxGT+DkGji
         Qs1FyWSkIpo9zo8/XjfmD9gWloCXE6ISW1lSQQPUOMM6T7lRi2/o2eJLajbbfoGMo1/0
         RqGNsdTltkEaB5c+IKNXGf+UM2/cgqCl2z3uqmYXIGlFNRgWMUl85w5g+P4Jc0boMDvm
         o3ow==
X-Gm-Message-State: ALoCoQkt80lUFHocn+Y4TmQ45X3MbZsnnfS8GLH4LNRA5eUSe2f7JaFyfHUiz++pPbJOhYlE4Uir
X-Received: by 10.236.25.208 with SMTP id z56mr23535594yhz.35.1413919475535;
        Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id s23si586019yhf.0.2014.10.21.12.24.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id AU2lxOEw.1; Tue, 21 Oct 2014 12:24:35 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 84221E1170; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 020ed65a12838bdead64bc3c5de249d3c8f5cfd8 upstream.

When performing a reflog transaction update, only write to the reflog iff
msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
an update that only truncates but does not write.

Change-Id: I44c89caa7e7c4960777b79cfb5d339a5aa3ddf7a
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 5 +++--
 refs.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index d54c3b9..f14b76e 100644
--- a/refs.c
+++ b/refs.c
@@ -3895,8 +3895,9 @@ int transaction_commit(struct transaction *transaction,
 				update->reflog_fd = -1;
 				continue;
 			}
-		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
-				     update->new_sha1,
+		if (update->msg &&
+		    log_ref_write_fd(update->reflog_fd,
+				     update->old_sha1, update->new_sha1,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
diff --git a/refs.h b/refs.h
index 5075073..bf96b36 100644
--- a/refs.h
+++ b/refs.h
@@ -337,6 +337,7 @@ int transaction_delete_ref(struct transaction *transaction,
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
+ * If msg is NULL no update will be written to the log.
  */
 int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
-- 
2.1.0.rc2.206.gedb03e5
