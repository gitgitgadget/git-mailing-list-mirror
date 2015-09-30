From: Renee Margaret McConahy <nepella@gmail.com>
Subject: [PATCH] am: configure gpg at startup
Date: Wed, 30 Sep 2015 13:49:44 -0400
Message-ID: <560c2efb.894f320a.d43ae.4338@mx.google.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 20:50:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhMSf-0005tD-3f
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 20:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbbI3Suh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 14:50:37 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34650 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481AbbI3Sug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 14:50:36 -0400
Received: by iow1 with SMTP id 1so21375299iow.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject:to:cc;
        bh=isKExD13euGiA15uBFrhgihlZyWVnYNUJJyFNzKifl8=;
        b=u/xvsFyklZ5yjZ1pLI52hTnRDKW0pJ8cH9RuBVyZr0iDwOepAxKZ3OAS6ZBfB568+7
         oaQ8sg+rSeRb9RQHVY8KOUlggspWcKFhxZFryvmYysHKvJcg4FwVmcd2x6dmHrohHTUk
         uPCbGl7Ao0+CN/YVvRIccytojuTm8yPYAe6zLN5KDMpwkwAeWKgxE+8k3sP/pItGT9AY
         e09AG/Mi2Vp7Zjqw1XqhiWCjuflad99Y70mHbCwk/eB411TmpIQVXuCgjik6SvSIyvN0
         Q8Fz5VT5g66tx9GpBBdVy5TFiHyLBLQY3BeLDwH24P/pcwjd3hWPX0hsmcWiSdxf/bVI
         GP3g==
X-Received: by 10.107.29.70 with SMTP id d67mr4633378iod.27.1443639035402;
        Wed, 30 Sep 2015 11:50:35 -0700 (PDT)
Received: from localhost (69-89-111-67.dhcp-elns.acd.net. [69.89.111.67])
        by smtp.gmail.com with ESMTPSA id j9sm13493095igx.3.2015.09.30.11.50.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2015 11:50:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278853>

The new builtin am ignores the user.signingkey variable: gpg is being
called with the committer details as the key ID, which may not be
correct. git_gpg_config is responsible for handling that variable and is
expected to be called on initialization by any modules that use gpg.

Perhaps git_gpg_config's functionality ought to be merged into
git_default_config, but this is simpler and in keeping with the current
practice.

Signed-off-by: Renee Margaret McConahy <nepella@gmail.com>
---
 builtin/am.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4f77e07..f0b0ffd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2208,6 +2208,18 @@ enum resume_mode {
 	RESUME_ABORT
 };
 
+static int git_am_config(const char *k, const char *v, void *cb)
+{
+	int *flags = cb;
+	int status;
+
+	status = git_gpg_config(k, v, NULL);
+	if (status)
+		return status;
+
+	return git_default_config(k, v, NULL);
+}
+
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
@@ -2308,7 +2320,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_am_config, NULL);
 
 	am_state_init(&state, git_path("rebase-apply"));
 
-- 
2.6.0
