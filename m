From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] branch: honor core.abbrev
Date: Fri,  1 Jul 2011 01:02:42 +0900
Message-ID: <1309449762-10476-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 18:02:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcJhd-00052d-8s
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 18:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122Ab1F3QCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 12:02:48 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37522 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab1F3QCs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 12:02:48 -0400
Received: by qyk9 with SMTP id 9so1373056qyk.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=C0/c9auX4gU9GfNKlWIYVoH/nXvAAs52pQ+j7p8dhkE=;
        b=X5TXSG6pyDKGjA/KPtrMyd+wUYYhGcdzRixZaVHKOI6ufLSB+oDdLEjzBLd6KNWDqq
         rmFK23W95QUm1/M9MMihsz23dn3dap5ty8X15CmNFsNAvYDG7fbprf9sNAbcUKg1gR9r
         1OjewJEOSKQnZDBxON+J4Mp7GmtJVy51YTOIs=
Received: by 10.224.219.10 with SMTP id hs10mr1695156qab.80.1309449767245;
        Thu, 30 Jun 2011 09:02:47 -0700 (PDT)
Received: from localhost.localdomain ([118.176.76.64])
        by mx.google.com with ESMTPS id t21sm1821462qcs.26.2011.06.30.09.02.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 09:02:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176489>

Honor 'core.abbrev' configuration unless user specifies the
length on command line. In order to do that, we need to set
'abbrev' to DEFAULT_ABBREV after config and command line
parsing done.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 Documentation/git-branch.txt |    1 +
 builtin/branch.c             |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c50f189..906cccc 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -114,6 +114,7 @@ OPTIONS
 --abbrev=<length>::
 	Alter the sha1's minimum display length in the output listing.
 	The default value is 7.
+	(and can be overrided by the `core.abbrev` config option).
 
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
