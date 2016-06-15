From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] propagate --quiet to send-pack/receive-pack
Date: Sat, 30 Jul 2011 14:10:14 +0200
Message-ID: <20110730121014.GA899@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, jkeating@redhat.com,
	tmz@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 14:10:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn8N9-0004eH-A1
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 14:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870Ab1G3MKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 08:10:22 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:4698 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751453Ab1G3MKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 08:10:21 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 3BFC32C4006;
	Sat, 30 Jul 2011 14:10:15 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178190>

Currently, git push --quiet produces some non-error output, e.g.:

 $ git push --quiet
 Unpacking objects: 100% (3/3), done.

Add the --quiet option to send-pack/receive-pack and pass it to
unpack-objects in the receive-pack codepath and to receive-pack in
the push codepath.

This fixes a bug reported for the fedora git package:

 https://bugzilla.redhat.com/show_bug.cgi?id=725593

Reported-by: Jesse Keating <jkeating@redhat.com>
Cc: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Passing "receive-pack --quiet" to git_connect as a command string
is a little ugly. But git_connect does the same internally, and I
did not want to add receive-pack specific options to git_connect,
which is currently agnostic to such things.

Note that IIRC, the non-quiet output ("Unpacking objects...") goes
to stderr on purpose, not because it is an error, but because it
contains progress status information that we want to display even
if standard output is redirected to a file.

Clemens

 Documentation/git-receive-pack.txt |    5 ++++-
 Documentation/git-send-pack.txt    |    5 ++++-
 builtin/receive-pack.c             |   12 ++++++++++--
 builtin/send-pack.c                |   11 ++++++++++-
 remote-curl.c                      |    4 +++-
 transport.c                        |   10 +++++++---
 6 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 459c085..d7b68af 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -9,7 +9,7 @@ git-receive-pack - Receive what is pushed into the repository
 SYNOPSIS
 --------
 [verse]
-'git-receive-pack' <directory>
+'git-receive-pack' [--quiet] <directory>
 
 DESCRIPTION
 -----------
@@ -35,6 +35,9 @@ are not fast-forwards.
 
 OPTIONS
 -------
+--quiet::
+	Print only error messages.
+
 <directory>::
 	The repository to sync into.
 
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index bd3eaa6..bed9e1f 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -9,7 +9,7 @@ git-send-pack - Push objects over git protocol to another repository
 SYNOPSIS
 --------
 [verse]
-'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
+'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--quiet] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
 
 DESCRIPTION
 -----------
@@ -45,6 +45,9 @@ OPTIONS
 	the remote repository can lose commits; use it with
 	care.
 
+--quiet::
+	Print only error messages.
+
 --verbose::
 	Run verbosely.
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e1a687a..fca26fb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -636,7 +636,7 @@ static const char *parse_pack_header(struct pack_header *hdr)
 
 static const char *pack_lockfile;
 
-static const char *unpack(void)
+static const char *unpack(int quiet)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -653,6 +653,8 @@ static const char *unpack(void)
 		int code, i = 0;
 		const char *unpacker[4];
 		unpacker[i++] = "unpack-objects";
+		if (quiet)
+			unpacker[i++] = "-q";
 		if (receive_fsck_objects)
 			unpacker[i++] = "--strict";
 		unpacker[i++] = hdr_arg;
@@ -753,6 +755,7 @@ static void add_alternate_refs(void)
 
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
+	int quiet = 0;
 	int advertise_refs = 0;
 	int stateless_rpc = 0;
 	int i;
@@ -766,6 +769,11 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		const char *arg = *argv++;
 
 		if (*arg == '-') {
+			if (!strcmp(arg, "--quiet")) {
+				quiet = 1;
+				continue;
+			}
+
 			if (!strcmp(arg, "--advertise-refs")) {
 				advertise_refs = 1;
 				continue;
@@ -814,7 +822,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		const char *unpack_status = NULL;
 
 		if (!delete_only(commands))
-			unpack_status = unpack();
+			unpack_status = unpack(quiet);
 		execute_commands(commands, unpack_status);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index c1f6ddd..40a1675 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -439,6 +439,10 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				args.force_update = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--quiet")) {
+				args.quiet = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--verbose")) {
 				args.verbose = 1;
 				continue;
@@ -488,8 +492,13 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		conn = git_connect(fd, dest, receivepack,
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, receivepack);
+		if (args.quiet)
+			strbuf_addstr(&sb, " --quiet");
+		conn = git_connect(fd, dest, sb.buf,
 			args.verbose ? CONNECT_VERBOSE : 0);
+		strbuf_release(&sb);
 	}
 
 	memset(&extra_have, 0, sizeof(extra_have));
diff --git a/remote-curl.c b/remote-curl.c
index 69831e9..6d3aff6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -762,7 +762,9 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 		argv[argc++] = "--thin";
 	if (options.dry_run)
 		argv[argc++] = "--dry-run";
-	if (options.verbosity > 1)
+	if (options.verbosity < 0)
+		argv[argc++] = "--quiet";
+	else if (options.verbosity > 1)
 		argv[argc++] = "--verbose";
 	argv[argc++] = url;
 	for (i = 0; i < nr_spec; i++)
diff --git a/transport.c b/transport.c
index c9c8056..98c5778 100644
--- a/transport.c
+++ b/transport.c
@@ -482,14 +482,18 @@ static int set_git_option(struct git_transport_options *opts,
 static int connect_setup(struct transport *transport, int for_push, int verbose)
 {
 	struct git_transport_data *data = transport->data;
+	struct strbuf sb = STRBUF_INIT;
 
 	if (data->conn)
 		return 0;
 
-	data->conn = git_connect(data->fd, transport->url,
-				 for_push ? data->options.receivepack :
-				 data->options.uploadpack,
+	strbuf_addstr(&sb, for_push ? data->options.receivepack :
+				 data->options.uploadpack);
+	if (for_push && transport->verbose < 0)
+		strbuf_addstr(&sb, " --quiet");
+	data->conn = git_connect(data->fd, transport->url, sb.buf,
 				 verbose ? CONNECT_VERBOSE : 0);
+	strbuf_release(&sb);
 
 	return 0;
 }
-- 
1.7.3.1.105.g84915
