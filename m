From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Fixed git archive for bare repos
Date: Wed, 22 Oct 2008 22:47:03 +0100
Message-ID: <1224712023-5280-1-git-send-email-charles@hashpling.org>
References: <20081022210913.GB22541@hashpling.org>
Cc: Deskin Miller <deskinm@umich.edu>,
	kenneth johansson <ken@kenjo.org>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 23:48:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KslZ1-0004IA-6I
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 23:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbYJVVrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 17:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbYJVVrJ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 17:47:09 -0400
Received: from fhw-relay07.plus.net ([212.159.14.148]:34418 "EHLO
	fhw-relay07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYJVVrI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 17:47:08 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1KslXk-0004PB-Hq; Wed, 22 Oct 2008 22:47:04 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9MLl4uc005304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Oct 2008 22:47:04 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m9MLl388005303;
	Wed, 22 Oct 2008 22:47:03 +0100
X-Mailer: git-send-email 1.6.0.2.534.g5ab59
In-Reply-To: <20081022210913.GB22541@hashpling.org>
X-Plusnet-Relay: 40599c28652f5ec4314dc00cf076e32d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98916>

This moves the call to git config to a place where it doesn't break the
logic for using git archive in a bare repository but retains the fix to
make git archive respect core.autocrlf.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

OK, I've had a chance to have a quick look at this issue and I have an
altenative patch.

This is an alternative fix to the current git archive in a bare
repository issue.

It's been lightly tested and doesn't re-break the zip / autocrlf issue
that the previous introduction of git_config was designed to fix.

 archive.c         |    2 ++
 builtin-archive.c |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index 849eed5..9ac455d 100644
--- a/archive.c
+++ b/archive.c
@@ -336,5 +336,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	parse_treeish_arg(argv, &args, prefix);
 	parse_pathspec_arg(argv + 1, &args);
 
+	git_config(git_default_config, NULL);
+
 	return ar->write_archive(&args);
 }
diff --git a/builtin-archive.c b/builtin-archive.c
index 432ce2a..5ceec43 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -111,8 +111,6 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 {
 	const char *remote = NULL;
 
-	git_config(git_default_config, NULL);
-
 	remote = extract_remote_arg(&argc, argv);
 	if (remote)
 		return run_remote_archiver(remote, argc, argv);
-- 
1.6.0.2.534.g5ab59
