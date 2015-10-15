From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 22/26] refs.c: move should_autocreate_reflog to common code
Date: Thu, 15 Oct 2015 15:46:46 -0400
Message-ID: <1444938410-2345-23-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoV9-00074w-HB
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbbJOTrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:33 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36236 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbbJOTrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:32 -0400
Received: by qgx61 with SMTP id 61so80927459qgx.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yWbWBotmzy2KK7bzaNcjuXLvjPPhG+ih0b3kL2aN5Ts=;
        b=O9S2UdHJtXK7E29fJd3n7dru6q70+R94Om3EKN3GEfnganI0ldzNqDseFMwAiRjDUv
         nTWdAD5r+WYiJLZ/FCrnD/6QzTU/M7kEQyQypJmurXUXf8llx7vPlhu76lt8mD2ECxM0
         fyXxsmqLd05J3+O2HXOD6Ho/Gchb66LjCw3bYCSt0hdmt54lzHQrvTMHBBSJIFuiXvte
         v9Rd7o0OtNw5OUn+hjSr1C1Dedb+rcrU/LtgbHV8zfHklr5oQQqogctaGmtr9/LFGav9
         xMLg2xDo1dfrW0eMtKIL6yHum1OEGTcGvtQSURa6aoDbjyOpWclT6eZAjDUlzPFzQBuV
         Afjw==
X-Gm-Message-State: ALoCoQnChWalHbpsaYABSKToE6lDeOBKTZZ7rbwbmE+5PO5HhmEsKU8sZ69n9MGNDYezTZWDhsg4
X-Received: by 10.140.131.70 with SMTP id 67mr15565820qhd.70.1444938451534;
        Thu, 15 Oct 2015 12:47:31 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279694>

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 10 ----------
 refs.c          | 10 ++++++++++
 refs.h          |  2 ++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index ef600d8..7c39afa 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2601,16 +2601,6 @@ static int commit_ref(struct ref_lock *lock)
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
 int verify_refname_available(const char *newname, struct string_list *extra,
 			     struct string_list *skip, struct strbuf *err)
 {
diff --git a/refs.c b/refs.c
index e7f6c77..efc1c47 100644
--- a/refs.c
+++ b/refs.c
@@ -626,6 +626,16 @@ char *resolve_refdup(const char *refname, int resolve_flags,
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
index 3fb480b..3fce9c9 100644
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
