From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 12/26] refs.c: move resolve_refdup to common
Date: Thu, 15 Oct 2015 15:46:36 -0400
Message-ID: <1444938410-2345-13-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:47:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoUu-0006tn-HA
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbbJOTrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:22 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36030 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbbJOTrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:20 -0400
Received: by qgx61 with SMTP id 61so80922522qgx.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iejmRKvHmKtX1YAZQOKUY39vxsiqOMEbY2+PoJAzNcg=;
        b=Te735atT8Xmlbedx+TESlqTK1MeB7lBq/SeYG+Q+30BZrahFY8DTNwi7qR6EMdy16B
         sK63/O+RhQhLIqL2qC3DdgEhJb7lLNK/bWcky7+63QKMrmsSik3FNklUpmsE+j5ctPcV
         PD5sQDJq8oC0uMgfjGE4iyFAA19yu+34XhgD9BInTmV48kbN2RDU9gQaSytvsxs39WcM
         B2clxr25MGecT8Eue20XKtJ1AUbsq8p7MSqip+o4N3Hvj1islZAFVAHHPbCoUxPzozEr
         KprYbYWFydPE1ndj9j81DEf2ILc91E1FrB7jXhJJjJDW0QWj+whuqZCjyEHW0gJL+I6x
         2Pnw==
X-Gm-Message-State: ALoCoQmRaee8/DtnIPfdxSd1moK+ld3TMOXu4nK0cSc7bz5+hY6B6w2QKNDypMmzsH2s/B6i/fMg
X-Received: by 10.140.96.71 with SMTP id j65mr14160035qge.92.1444938439684;
        Thu, 15 Oct 2015 12:47:19 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279686>

From: Ronnie Sahlberg <sahlberg@google.com>

This function can be shared across all refs backends so move it
to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 7 -------
 refs.c          | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 728751a..589e10d 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1777,13 +1777,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return ret;
 }
 
-char *resolve_refdup(const char *refname, int resolve_flags,
-		     unsigned char *sha1, int *flags)
-{
-	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
-						  sha1, flags));
-}
-
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
diff --git a/refs.c b/refs.c
index 8a619a6..fcd5ddd 100644
--- a/refs.c
+++ b/refs.c
@@ -616,3 +616,10 @@ int ref_exists(const char *refname)
 	unsigned char sha1[20];
 	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
 }
+
+char *resolve_refdup(const char *refname, int resolve_flags,
+		     unsigned char *sha1, int *flags)
+{
+	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
+						  sha1, flags));
+}
-- 
2.4.2.644.g97b850b-twtrsrc
