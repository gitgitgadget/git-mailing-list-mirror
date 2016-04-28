From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule--helper update-clone: abort gracefully on missing .gitmodules
Date: Thu, 28 Apr 2016 13:02:46 -0700
Message-ID: <1461873766-14703-2-git-send-email-sbeller@google.com>
References: <1461873766-14703-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 28 22:02:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avs9I-0005dx-9C
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 22:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbcD1UCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 16:02:52 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34168 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcD1UCv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 16:02:51 -0400
Received: by mail-pa0-f48.google.com with SMTP id r5so36555691pag.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GvU978TijkRtnZMeOvccDLJIUsDr/8bYP2UeGLPZ3vY=;
        b=ePDc20SbiBWasAGX/CNbCfm4bx5lv3VG6LaojghJ/Ao4zgzUhezx1+kvbvynEAVHpq
         GdktMNja0O4nLZYiuMab16EiVpO1hJht76NHjrewpnxqJunmC5sUfFN4m9AJUlhMrSMv
         szERX7pTRsMZ+Sn9Q62nVGGz1QRvKip1mK/Ee+E7oe3UC2/uFhHF85rIIVdvck8F2Joa
         aJ9bojqGLLoHaSMFhTFIw0o8LvnTFuW2rlsGEpUYFKpsG+CPCx5p6OiGMJ7LgJhMl/hT
         ku2xKxX3MVn6XbJXseHUuH+gqRisx7Zx0mztVNP/cWGMyEgYu0CxwdY7OFyiTPcFI4wo
         hScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GvU978TijkRtnZMeOvccDLJIUsDr/8bYP2UeGLPZ3vY=;
        b=LzBxBKg0TyB8AhHoMSmWJty/SlhZxLqSxIFKyQKDnwuFR46ZnNJvv8aSfa1V/T+KdF
         kWtYi4I68O9kkp6Sd4qBKfhjaC9PsiEV5B/tCMrZV5JWOfQXqnLuCeuqwsDjEviJ5LDZ
         xHWAJY0iFqd7hOlxGD1TWmItV551xO6BE9b+vfrKmYoIVUyM20Y+pKJ8snZNsallzY+/
         g2pzNYVQj14YVsdnI3GPEjD0nQYFiJ8fDMHHfWc8E22F41o5jzXpFwTvwnBt4LcGDenw
         kPbUml1lsfS+yzAg3S1KVZGPN6ZRa6o02LCUbq3pg5CSdxNQzXoeJ9BNtedhQhV5PBow
         tbWQ==
X-Gm-Message-State: AOPr4FV+cbHIOK9SD4AjA70cP7fAFy/8IDbgyD7ZtG1UMuWjJNWw5UYx9/t93U+PnijyyWgP
X-Received: by 10.66.251.132 with SMTP id zk4mr23481843pac.50.1461873770488;
        Thu, 28 Apr 2016 13:02:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fce0:3f2f:7f7d:8246])
        by smtp.gmail.com with ESMTPSA id kh2sm24264340pad.9.2016.04.28.13.02.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 13:02:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.28.ga4e36c9
In-Reply-To: <1461873766-14703-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292945>

When there is no .gitmodules file availabe to initialize a submodule
from, `submodule_from_path` just returns NULL. We need to check for
that and abort gracefully.

When `git submodule update` was implemented in shell, this error out
with the warning

    Submodule path '%s' not initialized
    Maybe you want to use 'update --init'?

Replicate that behavior for now instead of crashing.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 38 +++++++++++++++++++++++++-------------
 t/t7400-submodule-basic.sh  |  8 ++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ce9d11e..5d05393 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -593,6 +593,25 @@ struct submodule_update_clone {
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0}
 
+
+static void next_submodule_warn_missing(struct submodule_update_clone *suc,
+		struct strbuf *out, const char *displaypath)
+{
+	/*
+	 * Only mention uninitialized submodules when their
+	 * paths have been specified.
+	 */
+	if (suc->warn_if_uninitialized) {
+		strbuf_addf(out,
+			_("Submodule path '%s' not initialized"),
+			displaypath);
+		strbuf_addch(out, '\n');
+		strbuf_addstr(out,
+			_("Maybe you want to use 'update --init'?"));
+		strbuf_addch(out, '\n');
+	}
+}
+
 /**
  * Determine whether 'ce' needs to be cloned. If so, prepare the 'child' to
  * run the clone. Returns 1 if 'ce' needs to be cloned, 0 otherwise.
@@ -627,6 +646,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	else
 		displaypath = ce->name;
 
+	if (!sub) {
+		next_submodule_warn_missing(suc, out, displaypath);
+		goto cleanup;
+	}
+
 	if (suc->update.type == SM_UPDATE_NONE
 	    || (suc->update.type == SM_UPDATE_UNSPECIFIED
 		&& sub->update_strategy.type == SM_UPDATE_NONE)) {
@@ -644,19 +668,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	git_config_get_string(sb.buf, &url);
 	if (!url) {
-		/*
-		 * Only mention uninitialized submodules when their
-		 * path have been specified
-		 */
-		if (suc->warn_if_uninitialized) {
-			strbuf_addf(out,
-				_("Submodule path '%s' not initialized"),
-				displaypath);
-			strbuf_addch(out, '\n');
-			strbuf_addstr(out,
-				_("Maybe you want to use 'update --init'?"));
-			strbuf_addch(out, '\n');
-		}
+		next_submodule_warn_missing(suc, out, displaypath);
 		goto cleanup;
 	}
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index df6b4da..814ee63 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -26,6 +26,14 @@ test_expect_success 'submodule init aborts on missing .gitmodules file' '
 	test_i18ngrep "No url found for submodule path" actual
 '
 
+test_expect_success 'submodule update aborts on missing .gitmodules file' '
+	test_when_finished "git update-index --remove sub" &&
+	git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
+	# missing the .gitmodules file here
+	git submodule update sub 2>actual &&
+	test_i18ngrep "Submodule path .sub. not initialized" actual
+'
+
 test_expect_success 'configuration parsing' '
 	test_when_finished "rm -f .gitmodules" &&
 	cat >.gitmodules <<-\EOF &&
-- 
2.8.0.28.ga4e36c9
