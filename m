From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH v2] branch: honor core.abbrev
Date: Fri,  1 Jul 2011 15:06:08 +0900
Message-ID: <1309500368-3729-1-git-send-email-namhyung@gmail.com>
References: <20110630181020.GA1128@elie>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 08:06:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcWrr-0003nx-E8
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 08:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab1GAGGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 02:06:14 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43922 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab1GAGGO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 02:06:14 -0400
Received: by yia27 with SMTP id 27so1188543yia.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 23:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WySWFoVWLwi+5QfVF5F2qgHYDJD7rWEys+aYnGK+FP4=;
        b=uZ4EdAoWjeLMx2EHouQ5zIH1rjCR8yE4TCqp2HlH/wHTaSMnXPLnbj+zWZcFH49T0P
         FoZ7znlZNvqmK9b8zoOb+wJuXqzE5PrEm14JiEe4Yk071dMkeggWWJ4C5daedgIZx6SI
         vqFm7Jl9bpUyT2ECGSN4yjgSDyqF48T7LtIVo=
Received: by 10.236.179.106 with SMTP id g70mr3528804yhm.372.1309500373445;
        Thu, 30 Jun 2011 23:06:13 -0700 (PDT)
Received: from localhost.localdomain ([118.176.76.64])
        by mx.google.com with ESMTPS id c63sm2193992yhe.32.2011.06.30.23.06.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 23:06:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <20110630181020.GA1128@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176516>

Honor 'core.abbrev' configuration unless user specifies the
length on command line. In order to do that, we need to set
'abbrev' to DEFAULT_ABBREV after config and command line
parsing done.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
Sorry for my bad English and thanks for pointing this out. :)

 Documentation/git-branch.txt |    3 ++-
 builtin/branch.c             |    5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c50f189..507b8d0 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -113,7 +113,8 @@ OPTIONS
 
 --abbrev=<length>::
 	Alter the sha1's minimum display length in the output listing.
-	The default value is 7.
+	The default value is 7 and can be overridden by the `core.abbrev`
+	config option.
 
 --no-abbrev::
 	Display the full sha1s in the output listing rather than abbreviating them.
diff --git a/builtin/branch.c b/builtin/branch.c
index d6ab93b..5a15022 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -613,7 +613,7 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
-	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
+	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
@@ -696,6 +696,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!!delete + !!rename + !!force_create > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (abbrev == -1)
+		abbrev = DEFAULT_ABBREV;
+
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (argc == 0)
-- 
1.7.6
