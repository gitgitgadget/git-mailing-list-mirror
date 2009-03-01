From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] "git init --remote=host:path"
Date: Sat, 28 Feb 2009 16:03:42 -0800
Message-ID: <1235865822-14625-4-git-send-email-gitster@pobox.com>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
 <1235865822-14625-2-git-send-email-gitster@pobox.com>
 <1235865822-14625-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 01:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdZBs-000803-0C
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 01:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbZCAAD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 19:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755054AbZCAAD4
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 19:03:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001AbZCAADy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 19:03:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FD9128A6
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 19:03:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CB15228A4 for
 <git@vger.kernel.org>; Sat, 28 Feb 2009 19:03:51 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.99.g9f3bb
In-Reply-To: <1235865822-14625-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 72E02D78-05F4-11DE-A1CF-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111802>

This implements the requesting side of the pair.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-init-db.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 t/t0001-init.sh   |   12 ++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 9628803..18754d7 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "pkt-line.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -363,6 +364,37 @@ static int guess_repository_type(const char *git_dir)
 	return 1;
 }
 
+static int remote_init(const char *remote, const char *init_serve,
+		       int argc, const char **argv)
+{
+	struct child_process *child;
+	int fd[2], i, len, status;
+	char line[1000];
+
+	if (!init_serve)
+		init_serve = "git init-serve";
+	child = git_connect(fd, remote, init_serve, 0);
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!prefixcmp(arg, "--remote=") ||
+		    !prefixcmp(arg, "--exec="))
+			continue;
+		packet_write(fd[1], "arg %s\n", argv[i]);
+	}
+	packet_flush(fd[1]);
+
+	status = 0;
+	len = packet_read_line(fd[0], line, sizeof(line));
+	if (len < 3 ||
+	    (memcmp(line, "ok ", 3) && memcmp(line, "ng ", 3)))
+		die("protocol error: %s\n", line);
+
+	if (line[0] != 'o')
+		status = error("%s", line);
+	status |= finish_connect(child);
+	return status;
+}
+
 static const char init_db_usage[] =
 "git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]]";
 
@@ -378,6 +410,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
 	const char *shared_given = NULL;
+	const char *remote_given = NULL;
+	const char *exec_given = NULL;
 	int bare_given = 0;
 	int i;
 
@@ -394,10 +428,20 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			shared_given = arg + 9;
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
 			flags |= INIT_DB_QUIET;
+		else if (!prefixcmp(arg, "--remote="))
+			remote_given = arg + 9;
+		else if (!prefixcmp(arg, "--exec="))
+			exec_given = arg + 7;
 		else
 			usage(init_db_usage);
 	}
 
+	if (remote_given || exec_given) {
+		if (!remote_given)
+			die("--exec= without --remote=?");
+		return remote_init(remote_given, exec_given, argc, argv);
+	}
+
 	if (bare_given) {
 		static char git_dir[PATH_MAX+1];
 		is_bare_repository_cfg = 1;
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5ac0a27..6f47930 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -199,4 +199,16 @@ test_expect_success 'init honors global core.sharedRepository' '
 	x`git config -f shared-honor-global/.git/config core.sharedRepository`
 '
 
+test_expect_success 'init --remote' '
+	R="$(pwd)/test-of-remote" &&
+	test_must_fail git init --remote="$R" --bare --template=frotz &&
+	git init --remote="$R" --bare &&
+	test -d "$R/objects/pack" &&
+	test_must_fail git init --remote="$R" &&
+	rm -fr "$R" &&
+	test_must_fail git init --remote="$R" --exec="false is not git" &&
+	git init --remote="$R" --exec="$TEST_DIRECTORY/../git-init-serve" &&
+	test -d "$R/.git/objects/pack"
+'
+
 test_done
-- 
1.6.2.rc2.99.g9f3bb
