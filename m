From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] Add the possibility to specify a default help format
Date: Wed,  6 Jun 2012 12:56:37 +0000
Message-ID: <1338987397-7376-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 14:57:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScFo6-0001e0-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 14:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab2FFM5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 08:57:47 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:62448 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab2FFM5q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 08:57:46 -0400
Received: by wgbds11 with SMTP id ds11so59342wgb.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 05:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=BrJhYkl6nVDz9GFui3JfaipbXHQCxb13BJvEQXioQZg=;
        b=kZ+6OG/F2l0en5eluwoithmVi+epsFV/HyUfoplFAZPWnuSA14EMmjUiFKORwn3nWc
         GbGmdBLxVOXELCE0TxFcJeMjSAEOU25kRqdGtjKV/aLCZFOSxDKMygxWetqN85WoU/OH
         jwmZbsVpnzNQsh9Ihpfax63Kriixt4evf1wDFa0eeXprUEpKns7deZz79BF35mIxIvhX
         ceURMyryIEHAXb2sE5rKTqVg+VIr9u6Crh5/wq2dt0f5R3aJXdsKzuIWwfn8SQByoVUD
         gaIyOw3kicZ42t0Jlw0JOrRtvHSi15w8gmJq40KNDEJxvQ+M3NUXyECpE7i5HUgSv+hU
         6tnA==
Received: by 10.216.215.7 with SMTP id d7mr16857585wep.80.1338987464803;
        Wed, 06 Jun 2012 05:57:44 -0700 (PDT)
Received: from localhost (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id fm1sm2396822wib.10.2012.06.06.05.57.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 05:57:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
X-Gm-Message-State: ALoCoQmjiDxhszT/Zx/+zRxf0env65A5xQQUGdtHCoRwvewUW5tRlKgLkBZcOtcjY9VxjGrXOqa9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199320>

At the moment, the default help format (i.e. the format that is chosen if
'git help xxx' is called without a help format parameter) is defined by
the switch to be 'man'. However, on different platforms the preferred
format might differ. For example, on Windows there is no man viewer, so we
would prefer html.

This patch adds the possibility to choose a default help format on
compilation by defining DEFAULT_HELP_FORMAT. If it is not specified the
default is still 'man'.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 builtin/help.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 43d3c84..536d4fd 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -12,6 +12,10 @@
 #include "column.h"
 #include "help.h"
 
+#ifndef DEFAULT_HELP_FORMAT
+#define DEFAULT_HELP_FORMAT "man"
+#endif
+
 static struct man_viewer_list {
 	struct man_viewer_list *next;
 	char name[FLEX_ARRAY];
@@ -445,7 +449,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
 
-	if (parsed_help_format != HELP_FORMAT_NONE)
+	if (parsed_help_format == HELP_FORMAT_NONE)
+		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
+	else
 		help_format = parsed_help_format;
 
 	alias = alias_lookup(argv[0]);
-- 
1.7.9.msysgit.0
