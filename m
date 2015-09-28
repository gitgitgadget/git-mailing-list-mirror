From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 27/43] refs.c: move should_autocreate_reflog to common code
Date: Mon, 28 Sep 2015 18:02:02 -0400
Message-ID: <1443477738-32023-28-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWD-0000zo-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbbI1WD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:26 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36063 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbbI1WDY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:24 -0400
Received: by qgx61 with SMTP id 61so133699334qgx.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QqONjXvRILNuQhHYSz1Tce+3/ZtY8W+okCzaWcVXNU8=;
        b=ST6rbKR7SnGwzplT8JlV06PFhqVOoQ+Ev4nNS6f3rriNN4/93IUv75BfVnuZBayyEB
         srwdqlLpuDIZKFukhePTkfj4sDFDPOQiQOTAWKrh6nLlr2RnMaW2PF5QITQbQbiht71l
         loFShpqyXlyQjfojdw0sF6yiSx4RAIl/tKnL4jjRZjbhQjyz8+QEngKtErO487fs0SKg
         HveVKm9uHgmib0dCHKaoQiOBxBHEdEL+ZIY+hWHigqVkF5R3qeo9N/5MW+vL+gvuXaYA
         PKfSVKQcupqvLtoMqXhrQ7832Ni4tqS4otbloT3scFC90XvelcAwGbohEaeEfEI/12+q
         4c9g==
X-Gm-Message-State: ALoCoQkUcfE6i3EH7TmRWnG1zuWD7fpt5zpiT4KDsq9VgnPJY0oc43EP3WZRy98Wmh/kAWPrE0r0
X-Received: by 10.140.40.139 with SMTP id x11mr25393553qgx.41.1443477804308;
        Mon, 28 Sep 2015 15:03:24 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278766>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 10 ----------
 refs.c          | 10 ++++++++++
 refs.h          |  2 ++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 5971526..37e244a 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2631,16 +2631,6 @@ static int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-static int should_autocreate_reflog(const char *refname)
-{
-	if (!log_all_ref_updates)
-		return 0;
-	return starts_with(refname, "refs/heads/") ||
-		starts_with(refname, "refs/remotes/") ||
-		starts_with(refname, "refs/notes/") ||
-		!strcmp(refname, "HEAD");
-}
-
 static int files_verify_refname_available(const char *newname,
 					  struct string_list *extra,
 					  struct string_list *skip,
diff --git a/refs.c b/refs.c
index d13b854..769574d 100644
--- a/refs.c
+++ b/refs.c
@@ -685,6 +685,16 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 						  sha1, flags));
 }
 
+int should_autocreate_reflog(const char *refname)
+{
+	if (!log_all_ref_updates)
+		return 0;
+	return starts_with(refname, "refs/heads/") ||
+		starts_with(refname, "refs/remotes/") ||
+		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "HEAD");
+}
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
diff --git a/refs.h b/refs.h
index 60a98cf..0b407b2 100644
--- a/refs.h
+++ b/refs.h
@@ -58,6 +58,8 @@ extern const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 extern char *resolve_refdup(const char *refname, int resolve_flags,
 			    unsigned char *sha1, int *flags);
 
+extern int should_autocreate_reflog(const char *refname);
+
 extern int read_ref_full(const char *refname, int resolve_flags,
 			 unsigned char *sha1, int *flags);
 extern int read_ref(const char *refname, unsigned char *sha1);
-- 
2.4.2.644.g97b850b-twtrsrc
