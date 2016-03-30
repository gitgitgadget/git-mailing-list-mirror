From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/4] bundle: don't leak an fd in case of early return
Date: Wed, 30 Mar 2016 10:05:17 -0700
Message-ID: <1459357518-14913-4-git-send-email-sbeller@google.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: sunshine@sunshineco.com, peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 19:05:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJYt-00029r-Ia
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694AbcC3RFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:05:40 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35304 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbcC3RF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:05:28 -0400
Received: by mail-pa0-f53.google.com with SMTP id td3so45067700pab.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tcW14EXRqkjx5FueWQg05KLXOx6JsadTitq+nipXtG8=;
        b=AF5J4+N4a74oRP2BvbeQDABNGvbZK5vby5T3N5e2D7mJsyvM/gDZHRp9y+XePWnhQB
         O3YrH1JSf0UWPT/Ft5VDhCn3eyJuiPCaEb5E46w1rM6qEXN96ndlUqmDFpiHHWrZFbip
         A3N1uuEQttge9WVYFt2kXifWPWn3BZHmEL3cl2ISGImgklabCnWmzWZ5R4PKca5Z3gam
         C/T4juowvxUrrCpU/pR77X6oqZYg+nZsoHdJSKeejCgimiVc4skgMwU2uNZakI9P4o3i
         j69KOpG7mRiyE7Q/+gKKH2+0nZS4nCoHELCrlhkHvT4k06V3vMPlJqDWEaP03WDDWqQ/
         KbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tcW14EXRqkjx5FueWQg05KLXOx6JsadTitq+nipXtG8=;
        b=gGeyRFP+L2EaVir7Ofp/r1RL9qEEdCQNVo+EtoJEMMZjr1uy/8TIlq0LOVz9ftVLh0
         vp3G7cxiVQ8KdSx5bC5fiOsJWzg429YQfK6IUVpq6rosys9rLbWXItw5I4KE2F+skwVV
         3p+rcJwYbioYDRSfQbAIMFiyoy7ZVzdkU5SmN0QscidW2dme349Tt16pp32LrWyVn3fM
         epke04vGo8pzCUhVOpnm/Qun3M6I6dWeKt5+m88OxHfxm5kQ9g9fP65kbsmB8B0qJO09
         N08a33ZSdJQpGJnFOGBkZdELqnOdjVTc6TuBBmmsu5hhydEZXt2EC1zg0KvwQiqaI4ks
         nrhA==
X-Gm-Message-State: AD7BkJIlEH5ru01oBEFYslZsEI38AgDT2UsxJna2YmHia9CiSdnacKXfEGZeJp0CmoIGppnm
X-Received: by 10.66.66.234 with SMTP id i10mr15068543pat.114.1459357527141;
        Wed, 30 Mar 2016 10:05:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id dg1sm7271929pad.18.2016.03.30.10.05.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 10:05:26 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
In-Reply-To: <1459357518-14913-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290314>

In successful operation `write_pack_data` will close the `bundle_fd`,
but when we exit early, we need to take care of the file descriptor
as well as the lock file ourselves. The lock file may be deleted at the
end of running the program, but we are in library code, so we should
not rely on that.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 bundle.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/bundle.c b/bundle.c
index 506ac49..fbc8593 100644
--- a/bundle.c
+++ b/bundle.c
@@ -407,6 +407,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	int bundle_to_stdout;
 	int ref_count = 0;
 	struct rev_info revs;
+	int ret = -1;
 
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
@@ -435,30 +436,40 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* write prerequisites */
 	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
-		return -1;
+		goto err;
 
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
-	if (argc > 1)
-		return error(_("unrecognized argument: %s"), argv[1]);
+	if (argc > 1) {
+		ret = error(_("unrecognized argument: %s"), argv[1]);
+		goto err;
+	}
 
 	object_array_remove_duplicates(&revs.pending);
 
 	ref_count = write_bundle_refs(bundle_fd, &revs);
 	if (!ref_count)
 		die(_("Refusing to create empty bundle."));
-	else if (ref_count < 0)
-		return -1;
+	else if (ref_count < 0) {
+		if (!bundle_to_stdout)
+			close(bundle_fd);
+		goto err;
+	}
 
 	/* write pack */
 	if (write_pack_data(bundle_fd, &revs))
-		return -1;
+		goto err;
 
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
 			die_errno(_("cannot create '%s'"), path);
 	}
 	return 0;
+err:
+	if (!bundle_to_stdout)
+		close(bundle_fd);
+	rollback_lock_file(&lock);
+	return ret;
 }
 
 int unbundle(struct bundle_header *header, int bundle_fd, int flags)
-- 
2.8.0.2.gb331331
