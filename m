From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 3/6] rev-parse: --local-env-vars option
Date: Wed, 24 Feb 2010 08:23:13 +0100
Message-ID: <1266996196-25978-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:23:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBb7-0003WY-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab0BXHXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 02:23:42 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49322 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab0BXHXk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 02:23:40 -0500
Received: by wya21 with SMTP id 21so1021590wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 23:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Q3AJuRqJjNzxup9iWct1D+XUvjtEiSHzVIWH0j9EgWY=;
        b=a95QiFKm8qECTwaWwM+5sRvO/VehaYNOke0EfD44YF3gSDKmT4lkS3GTl6I1hK1mHl
         9vdTTe9mWv+BNBKK71I6alwA1L3WQ/4+sKkdg+V+ks/bSutQ+1c2cJFZCMnPEGjJ//FB
         ORdhkdWpPT9XsouaP2XkaYdC6jCw7ZQTKBxes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WBW3MPGfI8lqIE+YBUChFKQPfygxsQPR91WZYeAdnG11AKMQ+C4ioDjdgI6vnE3O0y
         ix7I5nNmCTiGn7ZEiyxQkNpSsRlIRkx8QBwX8c9RathbeSuN0w8v+qqoSIIbFrE/wRxu
         1gjOPDFyFcrdlt/8rG9cnMsFAEykBx8bV85o4=
Received: by 10.216.165.203 with SMTP id e53mr1588031wel.68.1266996219561;
        Tue, 23 Feb 2010 23:23:39 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id q9sm21438552gve.19.2010.02.23.23.23.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 23:23:38 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g4e217.dirty
In-Reply-To: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140911>

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
1.7.0.212.g4e217.dirty
