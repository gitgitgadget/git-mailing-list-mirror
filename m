From: Junio C Hamano <gitster@pobox.com>
Subject: Subject: [PATCH] Push to create
Date: Mon, 02 Mar 2009 22:50:46 -0800
Message-ID: <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
 <1235865822-14625-2-git-send-email-gitster@pobox.com>
 <1235865822-14625-3-git-send-email-gitster@pobox.com>
 <20090301031609.GA30384@coredump.intra.peff.net>
 <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
 <20090301100039.GD4146@coredump.intra.peff.net>
 <20090301170436.GA14365@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 07:52:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeOUL-0002KA-4j
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 07:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbZCCGu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 01:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbZCCGu5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 01:50:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbZCCGu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 01:50:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 77AC43EFB;
	Tue,  3 Mar 2009 01:50:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8127E3EFA; Tue, 
 3 Mar 2009 01:50:48 -0500 (EST)
In-Reply-To: <20090301170436.GA14365@spearce.org> (Shawn O. Pearce's message
 of "Sun, 1 Mar 2009 09:04:36 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A453F2AA-07BF-11DE-B603-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112003>

This teaches receive-pack to create a new directory as a bare repository
when a user tries to push into a directory that does not exist.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 "Shawn O. Pearce" <spearce@spearce.org> writes:

 > But I think that's only true for situations where you are likely the
 > owner of the repository in your own home directory, such as ~you
 > on kernel.org.  For "hosted repositories" like any of the systems
 > you described above, there is a lot more to the creation than just
 > executing "git init" somewhere.
 > .
 > For the usage of
 > creating a new repository in your own home directory on some remote
 > server, why isn't this just an option to git push?

 I am not at all convinced that the use case people would for whatever
 reason do not want to "ssh-in, create and then push from here" is limited
 to "your own playpen in your $HOME", but it certainly limits the
 complexity and the scope of the damage.

 builtin-receive-pack.c |   29 ++++++++++++++++++++++++++++-
 t/t5541-push-create.sh |   20 ++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletions(-)
 create mode 100755 t/t5541-push-create.sh

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 849f1fe..2f2831c 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -652,6 +652,33 @@ static void add_alternate_refs(void)
 	foreach_alt_odb(add_refs_from_alternate, NULL);
 }
 
+static char *create_new_repo(char *dir)
+{
+	struct child_process child;
+	const char *argv[20];
+	int argc;
+
+	if (mkdir(dir, 0777)) {
+		error("cannot mkdir '%s': %s", dir, strerror(errno));
+		return NULL;
+	}
+	argc = 0;
+	argv[argc++] = "init";
+	argv[argc++] = "--bare";
+	argv[argc++] = NULL;
+	child.argv = argv;
+	if (run_command_v_opt_cd_env(argv,
+				     RUN_COMMAND_NO_STDIN |
+				     RUN_COMMAND_STDOUT_TO_STDERR |
+				     RUN_GIT_CMD,
+				     dir,
+				     NULL)) {
+		error("cannot run git init");
+		return NULL;
+	}
+	return enter_repo(dir, 0);
+}
+
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -674,7 +701,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 	setup_path();
 
-	if (!enter_repo(dir, 0))
+	if (!enter_repo(dir, 0) && !create_new_repo(dir))
 		die("'%s': unable to chdir or not a git archive", dir);
 
 	if (is_repository_shallow())
diff --git a/t/t5541-push-create.sh b/t/t5541-push-create.sh
new file mode 100755
index 0000000..52558a5
--- /dev/null
+++ b/t/t5541-push-create.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='push into nonexisting repository'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	test_commit C
+'
+
+test_expect_success 'push into nonexisting repository' '
+	this=$(git rev-parse B) &&
+	git push "file://$(pwd)/not-here.git" B:refs/heads/master &&
+	that=$(GIT_DIR=not-here.git git rev-parse HEAD) &&
+	test "$this" = "$that"
+'
+
+test_done
-- 
1.6.2.rc2.123.gab4478
