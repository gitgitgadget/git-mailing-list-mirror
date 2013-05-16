From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] fetch: switch allow-local off by default
Date: Thu, 16 May 2013 02:31:13 -0500
Message-ID: <1368689474-28911-3-git-send-email-felipe.contreras@gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 09:32:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcsgJ-0007nw-Ri
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 09:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766Ab3EPHcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 03:32:52 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:64832 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab3EPHcu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 03:32:50 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so2999498obc.40
        for <git@vger.kernel.org>; Thu, 16 May 2013 00:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3qQAZDiclJ6AdB0LRhQzRnpQXckBMc57PfJk7u5/bfE=;
        b=wefN836Z8TefF26oZsS92aIAbFDVKlrV9MfIgZ+b9lyfhcCIZ4FCl5O0+ubk98j7wW
         zPEUQVJife+cSSvsin4YEpOHQ4HFBJZQKxP3NMUxSCebRUpBpwkO1lpNBUAyOkOFPpPM
         UltZBHYr259h+elmVZxSzGL+wp0/dnTI2xt/RvFJMJs452sxx1m76EWlu63Fx2kboCwx
         2wDR2b/firdNVL0I2a9OYHFVGd1w3yGsW97OVui8gsYyIplcUSyIK9+zOhlhQ0epC4ig
         NxA/27gKV3JR7/DI8NIOHkVyWexr7JSgec1dT3k1zEy11L+zBtv8x7bAnlpte/D+4aUT
         VQWw==
X-Received: by 10.60.42.237 with SMTP id r13mr2831983oel.61.1368689569644;
        Thu, 16 May 2013 00:32:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm6861109obc.0.2013.05.16.00.32.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 00:32:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224487>

And force it on in 'git push' to retain the old behavior.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fetch.c        |  2 +-
 git-pull.sh            |  2 +-
 t/t5513-fetch-track.sh | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2efbd7b..c65c75b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -39,7 +39,7 @@ static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
-static int allow_local = 1;
+static int allow_local = 0;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
diff --git a/git-pull.sh b/git-pull.sh
index 638aabb..18c3793 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -220,7 +220,7 @@ test true = "$rebase" && {
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
+git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok --allow-local "$@" || exit 1
 test -z "$dry_run" || exit 0
 
 curr_head=$(git rev-parse -q --verify HEAD)
diff --git a/t/t5513-fetch-track.sh b/t/t5513-fetch-track.sh
index 65d1e05..cb46747 100755
--- a/t/t5513-fetch-track.sh
+++ b/t/t5513-fetch-track.sh
@@ -27,4 +27,18 @@ test_expect_success fetch '
 	)
 '
 
+test_expect_success 'fetch no-local' '
+	(
+		test_create_repo another &&
+		cd another &&
+		git remote add origin .. &&
+		echo test > file &&
+		git add . &&
+		git commit -m test &&
+		git checkout -t -b local-tracking master &&
+		git fetch &&
+		git rev-parse --verify refs/remotes/origin/b/one
+	)
+'
+
 test_done
-- 
1.8.3.rc1.579.g184e698
