From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC/PATCH] format-patch: introduce branch.*.forkedFrom
Date: Wed,  8 Jan 2014 01:59:48 +0530
Message-ID: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gister@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 07 21:29:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0dHV-000557-V5
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 21:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbaAGU3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 15:29:42 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55369 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbaAGU3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 15:29:41 -0500
Received: by mail-pa0-f42.google.com with SMTP id lj1so858783pab.15
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 12:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VK7PkjpAhwYBSBWAml3aDxYsgcuTZk6wgxH6XTUWjNs=;
        b=fhhyX/l/jX8YOdRsZDHmhAUqITnF5D3QHKfCRUFL+URTiRyw2k87PjkXK+478pp24i
         EtJLu+RIBrJoT4mA/Ps/KgrYGqH8q7nyruOkudbCaQyM/7AExfRAi1zAogea6yFsly8o
         M6GZx1MnDOieEGnjwdI5DE7COmP7WK1eOyrE62glghHHUR6mGDX8MO7tExrfn1QMijR5
         z7KgmYDXt2ZMRqy647iNCdXXcugA9pY75HCeVZwe9o7bqG3/rz8AZ8u6a/P9/uLlJp7r
         jjJJqkzV6N9cr/5gG90Km+mOqlzv6njRxQk/YHbhvq4tAz6b3IrQiAPaDrKPpeckYVhO
         T4aQ==
X-Received: by 10.66.168.12 with SMTP id zs12mr7825452pab.122.1389126580465;
        Tue, 07 Jan 2014 12:29:40 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id sg1sm138155620pbb.16.2014.01.07.12.29.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jan 2014 12:29:39 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.234.gba2dde8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240144>

A very common workflow for preparing patches involves working off a
topic branch and generating patches against 'master' to send off to the
maintainer. However, a plain

  $ git format-patch -o outgoing

is a no-op on a topic branch, and the user has to remember to specify
'master' explicitly everytime. This problem is not unique to
format-patch; even a

  $ git rebase -i

is a no-op because the branch to rebase against isn't specified.

To tackle this problem, introduce branch.*.forkedFrom which can specify
the parent branch of a topic branch. Future patches will build
functionality around this new configuration variable.

Cc: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gister@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Since -M, -C, -D are left in the argc, checking argc < 2 isn't
 sufficient.

 I wanted to get an early reaction before wiring up checkout and
 rebase.

 But I wanted to discuss the overall idea of the patch.
 builtin/log.c           | 21 +++++++++++++++++++++
 t/t4014-format-patch.sh | 20 ++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index b97373d..525e696 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -674,6 +674,7 @@ static int thread;
 static int do_signoff;
 static const char *signature = git_version_string;
 static int config_cover_letter;
+static const char *config_base_branch;
 
 enum {
 	COVER_UNSET,
@@ -750,6 +751,22 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (starts_with(var, "branch.")) {
+		const char *name = var + 7;
+		const char *subkey = strrchr(name, '.');
+		struct strbuf buf = STRBUF_INIT;
+
+		if (!subkey)
+			return 0;
+		strbuf_add(&buf, name, subkey - name);
+		if (branch_get(buf.buf) != branch_get(NULL))
+			return 0;
+		strbuf_release(&buf);
+		if (!strcmp(subkey, ".forkedfrom")) {
+			if (git_config_string(&config_base_branch, var, value))
+				return -1;
+		}
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1324,6 +1341,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die (_("--subject-prefix and -k are mutually exclusive."));
 	rev.preserve_subject = keep_subject;
 
+	if (argc < 2 && config_base_branch) {
+		argv[1] = config_base_branch;
+		argc++;
+	}
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
 		die (_("unrecognized argument: %s"), argv[1]);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 73194b2..2ea94af 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1370,4 +1370,24 @@ test_expect_success 'cover letter auto user override' '
 	test_line_count = 2 list
 '
 
+test_expect_success 'branch.*.forkedFrom matches' '
+	mkdir -p tmp &&
+	test_when_finished "rm -rf tmp;
+		git config --unset branch.rebuild-1.forkedFrom" &&
+
+	git config branch.rebuild-1.forkedFrom master &&
+	git format-patch -o tmp >list &&
+	test_line_count = 2 list
+'
+
+test_expect_success 'branch.*.forkedFrom does not match' '
+	mkdir -p tmp &&
+	test_when_finished "rm -rf tmp;
+		git config --unset branch.foo.forkedFrom" &&
+
+	git config branch.foo.forkedFrom master &&
+	git format-patch -o tmp >list &&
+	test_line_count = 0 list
+'
+
 test_done
-- 
1.8.5.2.234.gba2dde8.dirty
