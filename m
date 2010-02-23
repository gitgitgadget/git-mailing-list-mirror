From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 3/5] rev-parse: --local-env-vars option
Date: Wed, 24 Feb 2010 00:35:34 +0100
Message-ID: <1266968136-11129-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4IY-0001Ms-VO
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab0BWXf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:35:57 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43945 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab0BWXfy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:35:54 -0500
Received: by mail-wy0-f174.google.com with SMTP id 21so876637wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 15:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=le7q23VLv7h+mtwb+SwtkWb643lHAWwQgoyOIcNFW8E=;
        b=WNmCvNJ1Eh5fEqf5sCIq0orgAUuDjIbt1XWKlqIJRaQbmvW4WsDtlipei30gpLJsmz
         DQU3+tjRc3eXwHq0EG+jdp0RVdE8SIhZlfd212Yt4T4gxGsLW4D1PP2xwFb1ooZhL24I
         y0htbFlgwJiYnTgIdVhr5rrHrgoaH2USNyO88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cAMsxiZ1MmWqmYhpTomjDdskpceoGCDB/UT64ZY5vP+O8YLQyxe00LaquPoliX2CAX
         XIrBCJxS5CC4HtpGKGFU297mq3voekbGLyEZTbCXs/8urEW2nFf19Mj5DvBgztYer8Mb
         RcjfNSDbVp96mMG3bNJQzvfjSreXMtL/TliEA=
Received: by 10.216.89.193 with SMTP id c43mr2181573wef.221.1266968153406;
        Tue, 23 Feb 2010 15:35:53 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id i6sm20765003gve.20.2010.02.23.15.35.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 15:35:52 -0800 (PST)
X-Mailer: git-send-email 1.7.0.200.g5ba36.dirty
In-Reply-To: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140871>

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
1.7.0.200.g5ba36.dirty
