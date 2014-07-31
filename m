From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 2/2] add variable name to `git_config_*()` error message
Date: Thu, 31 Jul 2014 06:42:06 -0700
Message-ID: <1406814126-10457-2-git-send-email-tanayabh@gmail.com>
References: <1406814126-10457-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 15:44:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCqer-0005Ml-TO
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 15:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbaGaNoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 09:44:34 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:44646 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaGaNob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 09:44:31 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so3671571pac.31
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Bp2c4rdK9BQYIgTqDuUzlAVV60Nll8PY5UUTMCe5KM=;
        b=IUrdKZ1yd7DGdrVJhWL1K2VAbmg8CT5LCNZ7D4oN72UnyWpnJvbwT/z77yu7RHz3U7
         DA/pBtGgn/AQ6DHAu54ssPSCoNQWR1DMlqV/NbRysqfPts7N/0lE+XGlHNu3cJj2PvvS
         uNnGTKxXYibIzZA89nhXDPy322ZCrZIGX7+nufIXrlco/6oKmDJiB5PDXyU33tUxSgPH
         D+DkjcxF/JWLzgBkQE5HQSoPP8GAtN2iie0+zUFnvIoH34qDm6ACEmblUyix/JWNsNN8
         KeCzwkvA7vRYRNjuPbt+vZymdNk9RD5p4MxnX/x3fO3tMzIFWOoa3qDZEmUrdKcXY+sz
         LmCQ==
X-Received: by 10.68.197.40 with SMTP id ir8mr4437997pbc.139.1406814270170;
        Thu, 31 Jul 2014 06:44:30 -0700 (PDT)
Received: from localhost.localdomain ([223.229.21.143])
        by mx.google.com with ESMTPSA id i10sm19346556pat.36.2014.07.31.06.44.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 06:44:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406814126-10457-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254575>

Whenever a callback returns a negative value, the functions
of `git_config_*()` family die printing the line number and
file name. In addition to them, add the variable name to the
error message.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c                | 4 ++--
 t/t4055-diff-context.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 7330789..77407da 100644
--- a/config.c
+++ b/config.c
@@ -442,9 +442,9 @@ static int git_parse_source(config_fn_t fn, void *data)
 			break;
 	}
 	if (cf->die_on_error)
-		die(_("bad config file line %d in %s"), cf->linenr, cf->name);
+		die(_("bad config variable '%s' at file line %d in %s"), var->buf, cf->linenr, cf->name);
 	else
-		return error(_("bad config file line %d in %s"), cf->linenr, cf->name);
+		return error(_("bad config variable '%s' at file line %d in %s"), var->buf, cf->linenr, cf->name);
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index cd04543..741e080 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -79,7 +79,7 @@ test_expect_success 'non-integer config parsing' '
 test_expect_success 'negative integer config parsing' '
 	git config diff.context -1 &&
 	test_must_fail git diff 2>output &&
-	test_i18ngrep "bad config file" output
+	test_i18ngrep "bad config variable" output
 '
 
 test_expect_success '-U0 is valid, so is diff.context=0' '
-- 
1.9.0.GIT
