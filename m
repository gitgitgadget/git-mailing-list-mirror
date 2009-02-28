From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] "git init --remote=host:path"
Date: Sat, 28 Feb 2009 13:13:44 -0800
Message-ID: <7vocwme03b.fsf@gitster.siamese.dyndns.org>
References: <7vsklye05k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 22:15:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdWX7-0000u1-8j
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 22:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbZB1VN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 16:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755488AbZB1VN4
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 16:13:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbZB1VNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 16:13:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 207FF2280;
	Sat, 28 Feb 2009 16:13:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 61511227F; Sat,
 28 Feb 2009 16:13:51 -0500 (EST)
In-Reply-To: <7vsklye05k.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 28 Feb 2009 13:12:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B390A3C4-05DC-11DE-B8E7-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111793>

This implements the requesting side of the pair.

It probably should take the same --exec=init-serve parameter similar to
the way other programs like receive-pack and send-pack does, but I am too
lazy to add it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-init-db.c |   34 +++++++++++++++++++++++++++++++++-
 t/t0001-init.sh   |    7 +++++++
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index ee3911f..0b6da70 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "pkt-line.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -363,6 +364,33 @@ static int guess_repository_type(const char *git_dir)
 	return 1;
 }
 
+static int remote_init(const char *remote, int argc, const char **argv)
+{
+	struct child_process *child;
+	int fd[2], i, len, status;
+	char line[1000];
+
+	child = git_connect(fd, remote, "git init-serve", 0);
+	for (i = 1; i < argc; i++) {
+		fprintf(stderr, "writing %d (%s)\n", i, argv[i]);
+		packet_write(fd[1], argv[i]);
+	}
+	packet_flush(fd[1]);
+
+	status = 0;
+	len = packet_read_line(fd[0], line, sizeof(line));
+	if (len < 3 ||
+	    (memcmp(line, "ok ", 3) && memcmp(line, "ng ", 3)))
+		die("protocol error: %s\n", line);
+
+	if (line[0] != 'o') {
+		error("%s", line);
+		status = -1;
+	}
+	status |= finish_connect(child);
+	return status;
+}
+
 static const char init_db_usage[] =
 "git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]]";
 
@@ -394,7 +422,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			init_shared_repository = git_config_perm("arg", arg+9);
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
 			flags |= INIT_DB_QUIET;
-		else
+		else if (!prefixcmp(arg, "--remote=")) {
+			if (i != 1)
+				die("--remote option must be given first");
+			return remote_init(arg+9, argc-1, argv+1);
+		} else
 			usage(init_db_usage);
 	}
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5ac0a27..d1069ee 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -199,4 +199,11 @@ test_expect_success 'init honors global core.sharedRepository' '
 	x`git config -f shared-honor-global/.git/config core.sharedRepository`
 '
 
+test_expect_success 'init --remote' '
+	R="$(pwd)/test-of-remote" &&
+	git init --remote="$R" --bare &&
+	test -d "$R/objects/pack" &&
+	test_must_fail git init --remote="$R"
+'
+
 test_done
-- 
1.6.2.rc2.99.g9f3bb
