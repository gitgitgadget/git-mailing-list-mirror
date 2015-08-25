From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] FIXUP submodule: implement `module_clone` as a builtin helper
Date: Tue, 25 Aug 2015 10:28:22 -0700
Message-ID: <1440523706-23041-2-git-send-email-sbeller@google.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Tue Aug 25 19:29:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUI1q-0006sM-Mp
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbbHYR2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 13:28:46 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34718 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758AbbHYR2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:28:31 -0400
Received: by pabzx8 with SMTP id zx8so39778633pab.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uyXouHnabs1vxLKR0wWjKK9MmjIpGBOEINt6hhXBktE=;
        b=ZQJlXpcjGsTVhdFrB5eOHjCNgUeRr40e4NB5CpLwaHBdfP5NXZRDV73h/Gu4J9ha1w
         a0jOyvNGXYdU80T6pNJ1Y7aLFKmyiuxorQC8/th2L4iLLrnVO+jlOPN1RDSkGorNWPuS
         6H1NpSDegejzjrZE/EAEvOrIoS09r25O3iwwXWSOABUlIf/MQG1EFMtFKcYkdL6mWlI2
         bX//TQO2CiuHEQA+D4CJZfyWZVx3X0ajS14s4FWHwjFAxyp/7TPSCxMpRsUnZ88rYN/t
         a4BMy1LY/CyC9gqHf/n+H8wYV5CedOMDlEdk0Q+4SxxMx2/0l9IwjPKr/paa8BeIIMIo
         Ce7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uyXouHnabs1vxLKR0wWjKK9MmjIpGBOEINt6hhXBktE=;
        b=WY9W1RCfCTsYlmxL4j4C5q8OHe8knYORci78ryL/o1t0v8QGrIPPDoqINXW+/PVCzB
         YuFArSO9QDg42EIF3Xosss36K1m6ieq5cV2Ns+nioVPqow3iaFqNe56dH8VtTROILzmK
         1IkbqM98CuNsYgCnT7ZKLAwruHw+hmtwb+HVTobu68ZuzchisQxNzGnqKn1QSzQpuzZK
         u5qRaQdpSo4jORLXmtEyGkvt1VW8Gq55a76lSXoQqb/B9ZPBccvdpZZ7P/ocjlQgP0ai
         elwr3Vl1faubbSpVwef1T0XtuPACwM0qUAsLNY/6JbxW4KKc++KLdOLATvJeWDvqToN9
         bWCA==
X-Gm-Message-State: ALoCoQknDnQ8tszP1VITrsH3x7vPa0ohiQ8XaJ/vUP9jNGNQVjT7dGcTak8d88n1lM0e39Em38x2
X-Received: by 10.66.219.227 with SMTP id pr3mr57820477pac.140.1440523711147;
        Tue, 25 Aug 2015 10:28:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:ccb:1c59:dd72:7a5c])
        by smtp.gmail.com with ESMTPSA id hb1sm21699733pbd.36.2015.08.25.10.28.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Aug 2015 10:28:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.400.gff86faf
In-Reply-To: <1440523706-23041-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276546>

This closes the memory leaks as pointed out by Jeff.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ae74b80..7e298b4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -220,7 +220,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
 	sm_gitdir = strbuf_detach(&sb, NULL);
-	strbuf_reset(&sb);
 
 	if (!file_exists(sm_gitdir)) {
 		safe_create_leading_directories_const(sm_gitdir);
@@ -259,12 +258,16 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	/* Redirect the worktree of the submodule in the superprojects config */
 	if (!is_absolute_path(sm_gitdir)) {
 		char *s = (char*)sm_gitdir;
-		strbuf_addf(&sb, "%s/%s", xgetcwd(), sm_gitdir);
+		if (strbuf_getcwd(&sb))
+			die_errno("unable to get current working directory");
+		strbuf_addf(&sb, "/%s", sm_gitdir);
 		sm_gitdir = strbuf_detach(&sb, NULL);
-		strbuf_reset(&sb);
 		free(s);
 	}
-	strbuf_addf(&sb, "%s/%s", xgetcwd(), path);
+
+	if (strbuf_getcwd(&sb))
+		die_errno("unable to get current working directory");
+	strbuf_addf(&sb, "/%s", path);
 
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
-- 
2.5.0.400.gff86faf
