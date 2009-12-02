From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] General --quiet improvements
Date: Wed,  2 Dec 2009 23:28:40 +0200
Message-ID: <1259789320-31504-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 22:28:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFwko-0007E7-KG
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 22:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbZLBV2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 16:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbZLBV2n
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 16:28:43 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:46018 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbZLBV2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 16:28:42 -0500
Received: by bwz27 with SMTP id 27so619027bwz.21
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 13:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=CkXdEbAtLLMstU6UO1twpthxdCxu/7JJ2gPOj4DO9Gw=;
        b=crLnjhSgZTs7TRIxWE+dOdniwej5zF+4edAQOilSfjNCk9IndJvKLJ4pEyjidU0HkA
         jO03RNuqvMqjMvUewTyP/avC5V0tjVX23P0I7l0TDIUqAP63hTeGBkaFsvU1BXaaujxv
         asrrkosriyhNd5KbOw0HpYFry2gofKiiR2Gj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PjPaSRJ72w3h4GspdvA0lha6m93HlPqHnUdvxfJNsBvDMuAwy7z6MIFptoT8trOb+Y
         MEwy7g9nPAQwv6irqL2FYisiUh0hcNIXXS/oGFbBD6vaDJEGI/A5KXVZXYxUbNwSzsSM
         4MlX2gOKOm4LS6sl6GQeCXBUaTMImdZpiUWao=
Received: by 10.204.48.140 with SMTP id r12mr704033bkf.112.1259789327928;
        Wed, 02 Dec 2009 13:28:47 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 13sm436873bwz.6.2009.12.02.13.28.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 13:28:46 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.63.g0471c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134404>

'git reset' is missing --quiet, and 'git gc' is not using OPT__QUIET.
Let's fix that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-reset.txt |    1 +
 builtin-gc.c                |    2 +-
 builtin-reset.c             |    3 +--
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 2d27e40..9df6de2 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -62,6 +62,7 @@ This means that `git reset -p` is the opposite of `git add -p` (see
 linkgit:git-add[1]).
 
 -q::
+--quiet::
 	Be quiet, only report errors.
 
 <commit>::
diff --git a/builtin-gc.c b/builtin-gc.c
index 093517e..c304638 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -180,12 +180,12 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	char buf[80];
 
 	struct option builtin_gc_options[] = {
+		OPT__QUIET(&quiet),
 		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
 			"prune unreferenced objects",
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increased runtime)"),
 		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
-		OPT_BOOLEAN('q', "quiet", &quiet, "suppress progress reports"),
 		OPT_END()
 	};
 
diff --git a/builtin-reset.c b/builtin-reset.c
index 73e6022..25b38ce 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -202,6 +202,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	char *reflog_action, msg[1024];
 	const struct option options[] = {
+		OPT__QUIET(&quiet),
 		OPT_SET_INT(0, "mixed", &reset_type,
 						"reset HEAD and index", MIXED),
 		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
@@ -209,8 +210,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				"reset HEAD, index and working tree", HARD),
 		OPT_SET_INT(0, "merge", &reset_type,
 				"reset HEAD, index and working tree", MERGE),
-		OPT_BOOLEAN('q', NULL, &quiet,
-				"disable showing new HEAD in hard reset and progress message"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
 		OPT_END()
 	};
-- 
1.6.6.rc0.63.g0471c
