From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] git.c: two memory leak fixes
Date: Sun, 15 Mar 2015 00:43:33 +0600
Message-ID: <1426358613-30180-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 19:43:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWr2N-0005vj-Eh
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 19:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbbCNSnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 14:43:47 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35808 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbbCNSnq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 14:43:46 -0400
Received: by lbbfd7 with SMTP id fd7so8766909lbb.2
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uDfhI5rmveZpuydKXD1ycQaGP8DU8YD17X2irKLYTds=;
        b=Jn5AnZu+NiSoO75MzMqjvUXcPrZ0RgXjJmPnQIISsnm8HgbUUuoApr59bjGcFyre31
         HULbzgNk2BccPq7lnvdh5/bynDr94VpSaZ5VtmGBNqO5pQas9aUCHRUp7VGT0yOkwhlv
         AIl5sQkgC1v099FmCUnewHYyG8iA4SzZAxFM5lX5RV1Mk0OVqXNU9J8uSywXH1mKgCbm
         H2ZXgWmsAtEtCNp2dzoCPRlzc7agRxaE0VhBg8wqdHZW6AdPFvLkzYIz35mHLrjEjrCR
         l985f8BRt+3Ce2/UOivb6zJzbtjpnEbFHsOLTD3C7hZNq68lnm3Ulm7jEyXE1YQS8zxV
         PIog==
X-Received: by 10.112.181.41 with SMTP id dt9mr49510521lbc.56.1426358624913;
        Sat, 14 Mar 2015 11:43:44 -0700 (PDT)
Received: from localhost.localdomain ([147.30.80.185])
        by mx.google.com with ESMTPSA id v13sm1122995lal.4.2015.03.14.11.43.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Mar 2015 11:43:44 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.469.g69a3822.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265457>

This patch provides fixes for two minor memory leaks in the
handle_alias function:

1. We allocate memory for alias_argv with the xmalloc function call,
after run_command_v_opt function will be executed we no need in this
variable anymore, so let's free it.

2. Memory allocated for alias_string variable in the alias_lookup function,
need to free it.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 git.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git.c b/git.c
index 086fac1..501e5bd 100644
--- a/git.c
+++ b/git.c
@@ -252,6 +252,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			alias_argv[argc] = NULL;
 
 			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
+			free(alias_argv);
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
@@ -259,6 +260,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			    alias_command, alias_string + 1);
 		}
 		count = split_cmdline(alias_string, &new_argv);
+		free(alias_string);
 		if (count < 0)
 			die("Bad alias.%s string: %s", alias_command,
 			    split_cmdline_strerror(count));
-- 
2.3.3.469.g69a3822.dirty
