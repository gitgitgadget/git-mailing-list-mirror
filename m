From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 12/27] refs: forbid cross-backend ref renames
Date: Thu, 18 Feb 2016 00:17:35 -0500
Message-ID: <1455772670-21142-13-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:20:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWH0W-0002IF-V9
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425014AbcBRFT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:19:58 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:32886 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424856AbcBRFSn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:43 -0500
Received: by mail-qk0-f177.google.com with SMTP id s5so14809806qkd.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YwyVXbJKuTL6uO0CRQl9awUUwb9MpoEZJ+Of+wJNZrE=;
        b=SHupdsvbr5NBtht12HpC/clrJvFj8wq1kdiI+cfuULicN3PhMMwnT4zyuJ0PfLQrMW
         Lkr5Aai8Q4oYWZBD4/XMVsgTOEQeLHMI3hImWxBL7UiMdVVQh85ytQRTLHl9Rz4Eplnr
         3BifvvBGt9NhYeuYLe5O4fW6GRfN9DwxnR4NyqdI1wPzhoZPK0bRFOQGfpxsf8JkGFE9
         AV8a6qoECKU/pFJAHYs4HNubhBj39oHcgYtvToO+d4+FlNXagyDCuixfbyj4WgN/B9CJ
         /7Xf2BsXEbdQfqel0ytiE8oYr0TOL1l+bh9r7g0cqOjv9isjaYCHKjJTw+Z1eANslzDg
         Ur9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YwyVXbJKuTL6uO0CRQl9awUUwb9MpoEZJ+Of+wJNZrE=;
        b=S5bb/mRaHG8bxFygUmW0rBJMiLK2hVccMZnozdXaazwzYkcZgyEOCrV8HsdASozUf4
         aLA9TxGdtzbcv75eLWzCvTFlFXt4TiseemejuJ6BystunG4AhiQlGYrsGgfKtib0hoq3
         q8EsKzAt1uk3E9oOhnfUUCriQfc3qRIbbpdkdAezpYNx4Wfro8xeaSE21q0yNUx46i3c
         54FpnlnnkA5icBzEJPb+AGY8D3kEXUsVf0otZEEAzXtNoYBSfOvjs+fURFsRF6/+40dd
         SvRWbIaxp//qvWn3DHLfE3hO7euQDc9ybvWL75SdKhk+oYj7gj5oW7kwE3pzi+az8wlE
         k+HA==
X-Gm-Message-State: AG10YOSFWuReREIiUk1jhCdYteQQYLi+CjRSWz+foSDrMKvHVWTHP/vCH9o6LzfjMktCFw==
X-Received: by 10.55.78.201 with SMTP id c192mr5668241qkb.9.1455772723330;
        Wed, 17 Feb 2016 21:18:43 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:42 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286594>

This would be pretty weird, but since it will break, we should prevent
it.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/refs.c b/refs.c
index f5754f2..8eb04da 100644
--- a/refs.c
+++ b/refs.c
@@ -1306,5 +1306,11 @@ int delete_refs(struct string_list *refnames)
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
+	if ((ref_type(oldref) == REF_TYPE_NORMAL) !=
+	    (ref_type(newref) == REF_TYPE_NORMAL)) {
+		error(_("Both ref arguments to rename_ref must be normal "
+			"(or both must be per-worktree/pseudorefs)"));
+		return -1;
+	}
 	return the_refs_backend->rename_ref(oldref, newref, logmsg);
 }
-- 
2.4.2.767.g62658d5-twtrsrc
