From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Teach git clean to use setup_standard_excludes()
Date: Wed, 14 Nov 2007 23:00:54 -0600
Message-ID: <1195102854310-git-send-email-shawn.bohrer@gmail.com>
Cc: madcoder@debian.org, palglowr@gmail.com, git@vger.kernel.org,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 15 06:00:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWq4-0006IG-1A
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 06:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbXKOFAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 00:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbXKOFAJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 00:00:09 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:2651 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbXKOFAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 00:00:07 -0500
Received: by an-out-0708.google.com with SMTP id b36so83380ana
        for <git@vger.kernel.org>; Wed, 14 Nov 2007 21:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=I+QE45odDeGQblUZljVvyxHyv1GrVyC7pL0lKQ5kQqc=;
        b=k9/VFN6CHWL/xuooxwULtErKIhhKM1RP/6HG3DsRC+lr1VzhgHZj+M9M73e187ZDefvlJeG9MCa829jo4i9ClQeH/JzEDMr8m2XR/DI0urBQu7cDtvAICan4xNHVY3mX9tmlX4Os2bQ1lCz5nWRABr3MUK4d84frbxoSxtnvh+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B/te9To5fqNL8qDecWtYFcq6wFSAPHTElp1Z/VLBzV2HCCb+WPX6IDmcSdAFnf4Vk8OTvV5YPBtib82EULdzav8T+ukN23FjYOnZ7BlaL1sToaituieO2dtHl46aXZT//aUZGkUxPXNRKQww6pZuQA3vb+oDUELaSNj7WhWPAro=
Received: by 10.100.119.17 with SMTP id r17mr271131anc.1195102805898;
        Wed, 14 Nov 2007 21:00:05 -0800 (PST)
Received: from mediacenter ( [70.112.149.232])
        by mx.google.com with ESMTPS id g9sm2152869wra.2007.11.14.21.00.03
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Nov 2007 21:00:04 -0800 (PST)
Received: by mediacenter (sSMTP sendmail emulation); Wed, 14 Nov 2007 23:00:54 -0600
X-Mailer: git-send-email 1.5.3.GIT
In-Reply-To: 7vsl39l0b7.fsf@gitster.siamese.dyndns.org
References: 7vsl39l0b7.fsf@gitster.siamese.dyndns.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65060>

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 builtin-clean.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 01fb887..dc6a21e 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -22,7 +22,7 @@ static int git_clean_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "clean.requireforce"))
 		force = !git_config_bool(var, value);
-	return 0;
+	return git_default_config(var, value);
 }
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
@@ -57,7 +57,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	memset(&dir, 0, sizeof(dir));
 	if (ignored_only) {
 		dir.show_ignored =1;
-		dir.exclude_per_dir = ".gitignore";
 	}
 
 	if (ignored && ignored_only)
@@ -70,11 +69,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	dir.show_other_directories = 1;
 
 	if (!ignored) {
-		dir.exclude_per_dir = ".gitignore";
-		if (!access(git_path("info/exclude"), F_OK)) {
-			char *exclude_path = git_path("info/exclude");
-			add_excludes_from_file(&dir, exclude_path);
-		}
+		setup_standard_excludes(&dir);
 	}
 
 	pathspec = get_pathspec(prefix, argv);
-- 
1.5.3.GIT
