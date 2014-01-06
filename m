From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon,  6 Jan 2014 22:48:52 +0530
Message-ID: <1389028732-27760-3-git-send-email-artagnon@gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
Cc: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:19:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0DpS-0000Vo-Co
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854AbaAFRS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:18:57 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:54722 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259AbaAFRSz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:18:55 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so18321601pdj.17
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 09:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ymNRlRgNwMBhuwEMkHX+xloPoFkOSzT3g6ybvz3+Uts=;
        b=SG6QRXjtJJg2KK4stvAt+R/9Btp24Q/jfgBBaDlAeorVFDmHqWIqosGypdV1Wwi6CO
         LXMGPOIVIpDAf1GVkFue/ZFgvgXR115vytoRZpupiTe7UpOZxdA4unlwKH2lOx1a+UfF
         c4C32fSMLYz+F//JsEmzPb1JWadnaHH8CSHrEEj0cxytWPU4acjZ7GWekYDjZFBJxBTN
         4kfJNF1Y9tw9yfA357tdLDg8B3tbmN85ot5fWJ2fVEaVSPd/FlmixgJ+247RAIfMoBwH
         MWzj2gEtQdSCQcOXammBLhCmBb0WubPm2YtW4gWqMVM2oZNoyngLJz0NU9zcpgo/EKGe
         1IOQ==
X-Received: by 10.68.65.168 with SMTP id y8mr127634291pbs.89.1389028734634;
        Mon, 06 Jan 2014 09:18:54 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id jk16sm130131323pbb.34.2014.01.06.09.18.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jan 2014 09:18:52 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.229.g4448466.dirty
In-Reply-To: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240031>

A very common workflow for preparing patches involves working off a
topic branch and generating patches against 'master' to send off to the
maintainer. However, a plain

  $ git format-patch -o outgoing

is a no-op on a topic branch, and the user has to remember to specify
'master' explicitly everytime. Save the user the extra keystrokes by
introducing format.defaultTo which can contain the name of a branch
against which to base patches.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt               |  4 ++++
 builtin/log.c                          |  7 +++++++
 contrib/completion/git-completion.bash |  1 +
 t/t4014-format-patch.sh                | 10 ++++++++++
 4 files changed, 22 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a405806..b90abd1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1135,6 +1135,10 @@ format.coverLetter::
 	format-patch is invoked, but in addition can be set to "auto", to
 	generate a cover-letter only when there's more than one patch.
 
+format.defaultTo::
+	The name of a branch against which to generate patches by
+	default. You'd usually want this to be 'master'.
+
 filter.<driver>.clean::
 	The command which is used to convert the content of a worktree
 	file to a blob upon checkin.  See linkgit:gitattributes[5] for
diff --git a/builtin/log.c b/builtin/log.c
index b97373d..ebc419e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -674,6 +674,7 @@ static int thread;
 static int do_signoff;
 static const char *signature = git_version_string;
 static int config_cover_letter;
+static const char *config_defaultto;
 
 enum {
 	COVER_UNSET,
@@ -750,6 +751,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (!strcmp(var, "format.defaultto"))
+		return git_config_string(&config_defaultto, var, value);
 
 	return git_log_config(var, value, cb);
 }
@@ -1324,6 +1327,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die (_("--subject-prefix and -k are mutually exclusive."));
 	rev.preserve_subject = keep_subject;
 
+	if (argc < 2 && config_defaultto) {
+		argv[1] = config_defaultto;
+		argc++;
+	}
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
 		die (_("unrecognized argument: %s"), argv[1]);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 39b81f7..75699d4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1992,6 +1992,7 @@ _git_config ()
 		format.attach
 		format.cc
 		format.coverLetter
+		format.defaultTo
 		format.headers
 		format.numbered
 		format.pretty
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 73194b2..46c0337 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1370,4 +1370,14 @@ test_expect_success 'cover letter auto user override' '
 	test_line_count = 2 list
 '
 
+test_expect_success 'defaultTo side' '
+	mkdir -p tmp &&
+	test_when_finished "rm -rf tmp;
+		git config --unset format.defaultTo" &&
+
+	git config format.defaultTo side &&
+	git format-patch -o tmp >list &&
+	test_line_count = 3 list
+'
+
 test_done
-- 
1.8.5.2.229.g4448466.dirty
