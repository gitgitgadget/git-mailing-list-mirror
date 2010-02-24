From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 2/5] rev-parse: --local-env-vars option
Date: Thu, 25 Feb 2010 00:34:15 +0100
Message-ID: <1267054458-11877-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1267054458-11877-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 00:35:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkQlN-0003Cd-Go
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758566Ab0BXXed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 18:34:33 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61827 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758565Ab0BXXeb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 18:34:31 -0500
Received: by mail-ww0-f46.google.com with SMTP id 26so1593994wwf.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 15:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=D6Rfv5zTYjjxSdF1CA9sMPIBeXrBMPTYqG3t03w2Heo=;
        b=WD0/UtHjbVm7VJmaW709HVrjs2VBiaRbqBRBYZ8KLw2YpBOHTUsjJ46CghmzPiKK3h
         qu+4rmSWnKb/t/qMym4yn3HHnubPdpzMHh6pIL63hxLFB+WRPIXQ+Ezt768Pm4ny6fJA
         lEoOEzd1DDuHdZeapU/3WzE8TqssvmLUYHsbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QgbPAXUbzU+k6VC6ytE6syaKDli8zkhpFzCsWRjdbPX5zC0AjdJO3Kw4xWZR4nVKcQ
         GnbEsxjOh6fwumJSwPLYvlpI+fSF65DpsyOIyY6vGFkGs9G1yp3bKOPTAVF35T7/Xz+H
         yCX2ecLioS5zCr76TRdPJhMtqmBlLK+B96ads=
Received: by 10.216.91.18 with SMTP id g18mr220024wef.203.1267054470771;
        Wed, 24 Feb 2010 15:34:30 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id i6sm23895998gve.5.2010.02.24.15.34.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 15:34:29 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g5b851b.dirty
In-Reply-To: <1267054458-11877-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141007>

This prints the list of repo-local environment variables.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-rev-parse.txt |    6 ++++++
 builtin-rev-parse.c             |    8 ++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 1a613aa..8db600f 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -148,6 +148,12 @@ shown.  If the pattern does not contain a globbing character (`?`,
 --is-bare-repository::
 	When the repository is bare print "true", otherwise "false".
 
+--local-env-vars::
+	List the GIT_* environment variables that are local to the
+	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
+	Only the names of the variables are listed, not their value,
+	even if they are set.
+
 --short::
 --short=number::
 	Instead of outputting the full SHA1 values of object names try to
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a8c5043..ab7b520 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -455,7 +455,15 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	if (argc > 1 && !strcmp("--sq-quote", argv[1]))
 		return cmd_sq_quote(argc - 2, argv + 2);
 
+	if (argc > 0 && !strcmp("--local-env-vars", argv[1])) {
+		unsigned int i = 0;
+		const char *var;
+		while (var = local_repo_env[i++])
+			printf("%s\n", var);
+		return 0;
+	}
 	if (argc > 1 && !strcmp("-h", argv[1]))
+
 		usage(builtin_rev_parse_usage);
 
 	prefix = setup_git_directory();
-- 
1.7.0.212.g5b851b.dirty
