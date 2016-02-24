From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 15/32] refs: handle non-normal ref renames
Date: Wed, 24 Feb 2016 17:58:47 -0500
Message-ID: <1456354744-8022-16-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:00:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQA-0004K3-C1
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759196AbcBXW7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:42 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34979 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759040AbcBXW7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:36 -0500
Received: by mail-qg0-f47.google.com with SMTP id y89so26981299qge.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCm90d8QT3JpvDxd3tzTI+uqjxKkovnXAlkGgmX80zs=;
        b=f5BRhlfyzK5EATR+vuP9WgmuEJgv5lNvu7QEDGkYAIi+/a15U8omK7KYlY/XgXrPDi
         080hU8hPwpaWbkQ1lO8ESpAHxZZuu3jE13HCjR7VncCnFzH9ZYB3Ra5vYKNAwovKzMjV
         nrJ4xZatbdhNI9QlY3groCFCM+BUWuYC/EJYmHSGhozASCudAzRDByowC0EanENk7Rnr
         6USBakSfvNzgrPJsUOB9uoeudw+eyAwZhIzivFt6eKi+FTZvzS1w5I0kiySK5i69xQ96
         YpAWR+y+tbpIMYgV7thb2u0ExYCn6q7eu1hZ/FzqdFOTdsJGYJWOWDcQOo+djG2UwGPm
         FFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCm90d8QT3JpvDxd3tzTI+uqjxKkovnXAlkGgmX80zs=;
        b=e4n9XGt53VbKZhKhUqGNFAqBoQBy0VmJjo5iBUPuTnz7Rxf6zUibyhiLM7DWg1R8y0
         /46djJ9wtnQ07BV1xkOpn6i8ENgyuu3uvcUcb6loZ4eCkCAH0j6xEWu5rmdcDJ8oHz6X
         DWKrBfetIfrX7D1RjXmh+6iQk3KkBoCrrQysGfY24ZBW5g/5FE4ACN6hu87N/UDsIxDw
         WvW9lCusnSdUS+ktnJ9p6AVqPH9HcY8nSjRMz/b96pAbX0+0B01VWt+n3+FjzF1MVBT3
         DhY3OoL7xVkmYxI70fTyZ8KmEUooodkDXSc3RphGkAq943PFzzlMVwuY740mTz/TmcOQ
         YNxw==
X-Gm-Message-State: AG10YORFDIgTzWzzAc3eHC8PsrUdWYRbco2jCWS3rVxCetlns2AFAPCSyGQXCfIskkl0Rw==
X-Received: by 10.140.94.50 with SMTP id f47mr52652300qge.0.1456354769956;
        Wed, 24 Feb 2016 14:59:29 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:28 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287259>

Forbid cross-backend ref renames.  This would be pretty weird, but
since it will break, we should prevent it.

Also make the files backend deal with all non-normal ref renames.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3a2ad5e..05b1b2a 100644
--- a/refs.c
+++ b/refs.c
@@ -1415,5 +1415,15 @@ int delete_refs(struct string_list *refnames)
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
-	return the_refs_backend->rename_ref(oldref, newref, logmsg);
+	if ((ref_type(oldref) == REF_TYPE_NORMAL) !=
+	    (ref_type(newref) == REF_TYPE_NORMAL)) {
+		return error(
+			_("Both ref arguments to rename_ref must be normal, "
+			  "or both must be per-worktree/pseudorefs"));
+	}
+	if (ref_type(oldref) == REF_TYPE_NORMAL)
+		/* The files backend always deals with non-normal refs */
+		return the_refs_backend->rename_ref(oldref, newref, logmsg);
+	else
+		return refs_be_files.rename_ref(oldref, newref, logmsg);
 }
-- 
2.4.2.767.g62658d5-twtrsrc
