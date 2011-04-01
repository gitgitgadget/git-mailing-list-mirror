From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH 2/2] blame: honor core.abbrev
Date: Fri,  1 Apr 2011 10:54:56 +0900
Message-ID: <1301622896-5836-2-git-send-email-namhyung@gmail.com>
References: <1301622896-5836-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 03:55:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Ta2-00089g-PI
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 03:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab1DABzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 21:55:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38455 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab1DABzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 21:55:05 -0400
Received: by iwn34 with SMTP id 34so2995539iwn.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 18:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=pLAR86krLc+539McaMhReADmG7wqvrB3nEjHpZF+J4Y=;
        b=goKVRHOVOmjUWDJcM265ir9bWE+o3FdXFjstcZ761XQ/4NSg3tBjz8nDRimlR3I8d3
         55HHs4aWPI/7qS++W8M5hPyVDOx0j4h7lSMQ9XWBoQRPKp4UIN100/A18D3j221/TRFb
         kObqr2XRPd1pdi1PBbddsVFs5+B+OZ6LSmMbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hz15qzoLxRHdnnB0A77qSYV5Na/dfXHpMAcQj/LjuyyIxQ8oI9sd9+wRDs3MU+0gSb
         Mgdz4Lm+Qb+zXfM3rsFSYZHrjsFGDfh/Uk8CDq/1mAl7o9j4B9TzE3qP/5qcHkNh8J1X
         Y5lnat8kf0lJVAiquekXKLJkaVw4LKJQMlr0M=
Received: by 10.42.199.210 with SMTP id et18mr816609icb.38.1301622904775;
        Thu, 31 Mar 2011 18:55:04 -0700 (PDT)
Received: from localhost.localdomain ([118.176.72.144])
        by mx.google.com with ESMTPS id i26sm1101359iby.58.2011.03.31.18.55.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 18:55:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1301622896-5836-1-git-send-email-namhyung@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170550>

If user sets config.abbrev option, use it as if --abbrev was given.
We can't set abbrev to default_abbrev unconditionally IMHO, because
historically default abbrev length of the blame command is 8 and
DEFAULT_ABBREV is 7.

As you may see, this is the default value and user can use different
abbrev length by specifing --abbrev=N command line option.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 builtin/blame.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 253b480..93693d2 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2317,12 +2317,16 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	struct parse_opt_ctx_t ctx;
 	int cmd_is_annotate = !strcmp(argv[0], "annotate");
+	int orig_abbrev = DEFAULT_ABBREV;
 
 	git_config(git_blame_config, NULL);
 	init_revisions(&revs, NULL);
 	revs.date_mode = blame_date_mode;
 	DIFF_OPT_SET(&revs.diffopt, ALLOW_TEXTCONV);
 
+	/* if user sets config.abbrev, honor it */
+	if (orig_abbrev != default_abbrev)
+		abbrev = default_abbrev;
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
 
-- 
1.7.4
