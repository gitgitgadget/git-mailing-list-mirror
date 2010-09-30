From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v2 3/3] git-remote-ext
Date: Thu, 30 Sep 2010 14:52:59 +0300
Message-ID: <1285847579-21954-4-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 13:48:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1HcF-0003MB-K1
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 13:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab0I3Lrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 07:47:53 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:40014 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab0I3Lrw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 07:47:52 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 51B7713BAAD
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 14:47:51 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A07AF11E959; Thu, 30 Sep 2010 14:47:51 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 3A47941BED
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 14:47:50 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157643>

This remote helper invokes external command and passes raw smart transport
stream through it. This is useful for instance for invoking ssh with
one-off odd options, connecting to git services in unix domain
sockets, in abstract namespace, using TLS or other secure protocols,
etc...

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/git-remote-ext.txt |   87 ++++++++++++++++++++++++++++++++++++++
 Makefile                         |    1 +
 builtin.h                        |    1 +
 git.c                            |    1 +
 4 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-ext.txt

diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
new file mode 100644
index 0000000..e2d40d9
--- /dev/null
+++ b/Documentation/git-remote-ext.txt
@@ -0,0 +1,87 @@
+git-remote-ext(1)
+=================
+
+NAME
+----
+git-remote-ext - Bridge smart transport to external command.
+
+
+SYNOPSIS
+--------
+"ext::<command>[ <arguments>...]" (as URL)
+
+DESCRIPTION
+-----------
+This command uses specified command to connect to remote git server.
+
+Between <command> and <arguments> (if present) is space. Also space
+splits different arguments.
+
+The following sequences have special meaning:
+
+'\ '::
+	Don't interpret the space as command/argument separator.
+
+'\\'::
+	Literal backslash
+
+'\s' (as argument)::
+	Replaced by short name (receive-pack, upload-pack, upload-archive)
+	of service git wants to invoke.
+
+'\S' (as argument)::
+	Replaced by long name (git-receive-pack, git-upload-pack,
+	git-upload-archive) of service git wants to invoke.
+
+'\G<repository>' (as argument)::
+	This argument will not be passed to command. Instead, git will send
+	in-line git:// service request for <repository>. Default is not to
+	send in-line request.
+
+'\V<host>' (as argument)::
+	Set the vhost used in in-line git:// service request. Default is
+	to omit vhost.
+
+
+ENVIRONMENT VARIABLES:
+----------------------
+
+$GIT_EXT_SERVICE (passed to command)::
+	Initialzed to long name of service git wants to invoke.
+
+$GIT_EXT_SERVICE_NOPREFIX (passed to command)::
+	Initialzed to short name of service git wants to invoke.
+
+$GIT_TRANSLOOP_DEBUG (passed to git)::
+	If set, prints debugging information about various reads/writes.
+
+
+EXAMPLES:
+---------
+"ext::ssh -i /home/foo/.ssh/somekey user@host.example \S \'foo/repo'"::
+	Use  /home/foo/.ssh/somekey as key when connecting to host.example
+	and request repo foo/repo.
+
+"ext::socat -t3600 - ABSTRACT-CONNECT:/git-server \G/somerepo"::
+	Connect to git:// server named '/git-server' in abstract namespace
+	and request '/somerepo' from it.
+
+"ext::git-server-alias foo \G/repo"::
+	Connect to wherever 'git-server-alias foo' connects to and send
+	git:// request there for '/repo'.
+
+"ext::git-server-alias foo \G/repo \Vfoo"::
+	Connect to wherever 'git-server-alias foo' connects to and send
+	git:// request there for '/repo' using vhost 'foo'.
+
+"ext::git-ssl foo.example /bar"::
+	Connect to whatever repo 'git-ssl foo.example /bar' goes.
+
+
+Documentation
+--------------
+Documentation by Ilari Liusvaara.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 7da54d7..9909ca1 100644
--- a/Makefile
+++ b/Makefile
@@ -728,6 +728,7 @@ BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
+BUILTIN_OBJS += builtin/remote-ext.o
 BUILTIN_OBJS += builtin/remote-fd.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/rerere.o
diff --git a/builtin.h b/builtin.h
index 748cc13..b15b486 100644
--- a/builtin.h
+++ b/builtin.h
@@ -141,5 +141,6 @@ extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix);
 extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
+extern int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/git.c b/git.c
index 250ecc5..867d8cf 100644
--- a/git.c
+++ b/git.c
@@ -374,6 +374,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
+		{ "remote-ext", cmd_remote_ext, 0 },
 		{ "remote-fd", cmd_remote_fd, 0 },
 		{ "replace", cmd_replace, RUN_SETUP },
 		{ "repo-config", cmd_config, RUN_SETUP_GENTLY },
-- 
1.7.2.3.401.g919b6e
