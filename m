From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC 2/5] make git_config_with_options() to use a configset
Date: Thu,  2 Oct 2014 06:24:49 -0700
Message-ID: <1412256292-4286-3-git-send-email-tanayabh@gmail.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 15:26:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZgOS-0006Nc-13
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 15:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbaJBN0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 09:26:00 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46324 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbaJBNZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 09:25:58 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so2416544pad.36
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hcrtKQ3wr6ZvCFcCUn0i8NhZLfUsJGKfVf65u89f6SY=;
        b=XYRq0tuDIEma8OWR3QgyD1R0ZdtKEI7vsqPBKzkCHZIJP50K4RoGAXz7MzPBoSSjGS
         3ayqyAuTM5tAIFOGUnqUOGwZU8rhLz5++D3ANn7l2+LtDY0/sGQ6mzgmhqWFIvTT6s01
         lyfV9v2PwSAzWEcgD7w5Cj6C0OfOFOBV2v+n7e5ZTNiBbrTmZkCPPpP0tbQDdN67iV3c
         /3pNFwo7+tnWfCH13Y+71E4gipQrfw+u2a1oIHzBe2ooX6rD17SpH87fZk6wJkjpYUNw
         JD3GrXJmCg3v3M9KiADLj05aEAmg8+9G4zri5cSylxGYJfuUd5NgatNKuFtjwSfkH9ZN
         zxgg==
X-Received: by 10.68.65.71 with SMTP id v7mr53090291pbs.6.1412256358468;
        Thu, 02 Oct 2014 06:25:58 -0700 (PDT)
Received: from localhost.localdomain ([182.67.148.232])
        by mx.google.com with ESMTPSA id qp9sm3612065pbc.31.2014.10.02.06.25.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Oct 2014 06:25:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257801>

Make git_config_with_options() to use a configset to feed values
in the callback function. This change gives us the power to filter
variables we feed to the callback using custom constraints.

A slight behaviour change, git_config_int() loses the ability to
print the file name of the invalid variable while dying.

Helped-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c               | 21 +++++++++++++++++++--
 t/t1300-repo-config.sh |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index cb474b2..09cf009 100644
--- a/config.c
+++ b/config.c
@@ -1214,7 +1214,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	return ret == 0 ? found : ret;
 }
 
-int git_config_with_options(config_fn_t fn, void *data,
+static int git_config_with_options_raw(config_fn_t fn, void *data,
 			    struct git_config_source *config_source,
 			    int respect_includes)
 {
@@ -1247,9 +1247,26 @@ int git_config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
+static int config_set_callback(const char *key, const char *value, void *cb);
+
+int git_config_with_options(config_fn_t fn, void *data,
+			    struct git_config_source *config_source,
+			    int respect_includes)
+{
+	int ret;
+	struct config_set options_config;
+	git_configset_init(&options_config);
+	ret = git_config_with_options_raw(config_set_callback, &options_config,
+					  config_source, respect_includes);
+	if (ret >= 0)
+		configset_iter(&options_config, fn, data);
+	git_configset_clear(&options_config);
+	return ret;
+}
+
 static void git_config_raw(config_fn_t fn, void *data)
 {
-	if (git_config_with_options(fn, data, NULL, 1) < 0)
+	if (git_config_with_options_raw(fn, data, NULL, 1) < 0)
 		/*
 		 * git_config_with_options() normally returns only
 		 * positive values, as most errors are fatal, and
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 938fc8b..ce5ea01 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -678,7 +678,7 @@ test_expect_success 'invalid unit' '
 	git config aninvalid.unit >actual &&
 	test_cmp expect actual &&
 	cat >expect <<-\EOF
-	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in .git/config: invalid unit
+	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'': invalid unit
 	EOF
 	test_must_fail git config --int --get aninvalid.unit 2>actual &&
 	test_i18ncmp expect actual
-- 
1.9.0.GIT
