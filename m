From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/10] submodule deinit: complain when given a file instead of a submodule
Date: Fri, 29 Apr 2016 17:40:45 -0700
Message-ID: <1461976845-18228-11-git-send-email-sbeller@google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>,
	Per Cederqvist <cederp@opera.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIyH-0006iW-Af
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbcD3AlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:41:12 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35228 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbcD3AlE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:41:04 -0400
Received: by mail-pf0-f179.google.com with SMTP id 77so21989322pfv.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6E9Su5n+oMaitWgd0WN4DtyLQ2+NubNtsKr1LtIzNic=;
        b=nCJSpriygpjLTqdWFFAYpQH+DPgGy3q0SXmAUWaXfXJqFK9EdzndxaXbMMKQU41rKT
         osAlHXgNkSGtZC9NxrQM7sxKMfK96kVoeSHCuVdz/1OdcRK0XqXPYZS3WpZ61CHXAhtF
         zYsuhaDvZeO21LNX85fVJjp7HG/vbjagOtUEkO+ddXJHpWmSjV8AArmNfzrHsY7Bjzn+
         6J+jnbVM/RdElt6S2Fc5IO4XFjVO9vmul4poqZ8OPFtFMOSeqkUKKjr5kHQ1H3n0GfgE
         Rv9GHWmqeI2R+ABtFDxsGhX+OYp7IdM8a8S7nJDTPStmA7cDiysqs7Q8ea4/S/WMJcuQ
         AiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6E9Su5n+oMaitWgd0WN4DtyLQ2+NubNtsKr1LtIzNic=;
        b=bbV3JkRgDwDhCXSXG1PBT2EwlrLtTk/HtNloFX7o+wkaMPjX2bcJHgF979PfTRtqQt
         1eToi9X3qzjDYW2A/k8TTZnn8P3s6h49JWThKuyKMU2KdrRX/RO3sE77LHBMtUy2m860
         CUCO+wwqswcrXu3/D9cNFUTLENEJ1J9N+FRUIwURc3m/SMBJpRjmQ+tPFjVZnc+Cdv1m
         POgm3PbH3+yJOdLfvN2Qh090anA2M/3oHBOCNwDQNkg76NYqEHkC9svagSTDnqecb9s9
         Lu9FfWDkvVmRJMRc67cByknH3DJc8i1BeEQlslLU3Ap0Bo0GXmBticstIDmM+k3IqEGN
         qsUA==
X-Gm-Message-State: AOPr4FUV3RvMJovBGxyqtbdtE/9agB84AM62hnpLTTWuASbyI5NSsdG1z69Mr8WV4ljKynDW
X-Received: by 10.98.73.23 with SMTP id w23mr33695824pfa.104.1461976863722;
        Fri, 29 Apr 2016 17:41:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id y3sm33517955par.2.2016.04.29.17.41.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:41:03 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461976845-18228-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293092>

This also improves performance for listing submodules, because
S_ISGITLINK is both faster as match_pathspec as well as expected to
be true in fewer cases, so putting it first in the condition will speed
up the loop to compute all submodules.

As this partially reverts 84ba959bbdf0 (submodule: fix regression for
deinit without submodules, 2016-03-22), this also disallows the use
of `git submodule deinit .` to deinit all submodules, when no
submodules are present. `deinit .` continues to work on repositories,
which have at least one submodule.

CC: Per Cederqvist <cederp@opera.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---


> Patch 10 is a controversial thing I'd assume as it breaks existing users.
> We should take it for the next major release (i.e. 3.0)
> I just want to put it out here now.

 builtin/submodule--helper.c |  6 +++---
 t/t7400-submodule-basic.sh  | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7f0941d..e41de3e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -242,9 +242,9 @@ static int module_list_compute(int argc, const char **argv,
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
-				    0, ps_matched, 1) ||
-		    !S_ISGITLINK(ce->ce_mode))
+		if (!S_ISGITLINK(ce->ce_mode) ||
+		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
+				    0, ps_matched, 1))
 			continue;
 
 		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 53644da..361e6f6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -915,7 +915,20 @@ test_expect_success 'submodule deinit works on repository without submodules' '
 		>file &&
 		git add file &&
 		git commit -m "repo should not be empty" &&
-		git submodule deinit .
+		git submodule deinit
+	)
+'
+
+test_expect_success 'submodule deinit refuses to deinit a file' '
+	test_when_finished "rm -rf newdirectory" &&
+	mkdir newdirectory &&
+	(
+		cd newdirectory &&
+		git init &&
+		>file &&
+		git add file &&
+		git commit -m "repo should not be empty" &&
+		test_must_fail git submodule deinit file
 	)
 '
 
-- 
2.8.0.32.g71f8beb.dirty
