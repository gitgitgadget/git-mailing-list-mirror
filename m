From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] fix push --quiet: add 'quiet' capability to receive-pack
Date: Wed, 5 Oct 2011 08:31:36 +0200
Message-ID: <20111005063136.GB1403@ecki>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 08:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBL0b-0007ny-JC
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 08:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655Ab1JEGbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 02:31:08 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:60616 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753992Ab1JEGbG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 02:31:06 -0400
Received: from localhost (p5B22F0BC.dip.t-dialin.net [91.34.240.188])
	by bsmtp.bon.at (Postfix) with ESMTP id DF339130059;
	Wed,  5 Oct 2011 08:30:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182827>

Hi Junio,

Since 1.7.7 is out now, maybe you would like to pick this up again.

Cheers,
Clemens

On Wed, Sep 21, 2011 at 10:04:28PM -0700, Junio C Hamano wrote:
> 
> * cb/maint-quiet-push (2011-09-05) 4 commits
>  . t5541: avoid TAP test miscounting
>  . push: old receive-pack does not understand --quiet
>  . fix push --quiet via http
>  . tests for push --quiet
> 
> Dropped for rerolling after 1.7.7 cycle.

This is the re-rolled version based on current master, without the
backwards incompatible receive-pack --quiet option.

I squashed the tests in and added your unpack(void) fixup.

I have not added Michael's "t5541: avoid TAP test miscounting"
since I cannot reproduce the error:

 http://mid.gmane.org/e4e82f1267da3edfc600361de0041f618c31e30c.1315232475.git.git@drmicha.warpmail.net

And there is also this related patch "server_supports(): parse
feature list more carefully", which looked good to me:

 http://mid.gmane.org/7vmxejy9od.fsf@alter.siamese.dyndns.org

Does it need more work?

Clemens

--o<--
Currently, git push --quiet produces some non-error output, e.g.:

 $ git push --quiet
 Unpacking objects: 100% (3/3), done.

This fixes a bug reported for the fedora git package:

 https://bugzilla.redhat.com/show_bug.cgi?id=725593

Commit 90a6c7d4 (propagate --quiet to send-pack/receive-pack)
introduced the --quiet option to receive-pack and made send-pack
pass that option. Older versions of receive-pack do not recognize
the option, however, and terminate immediately. The commit was
therefore reverted.

This change instead adds a 'quiet' capability to receive-pack,
which is a backwards compatible.

In addition, this fixes push --quiet via http: A verbosity of 0
means quiet for remote helpers.

Reported-by: Jesse Keating <jkeating@redhat.com>
Reported-by: Tobias Ulmer <tobiasu@tmux.org>
Cc: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin/receive-pack.c   |   14 ++++++++++++--
 builtin/send-pack.c      |   13 ++++++++++---
 remote-curl.c            |    4 +++-
 t/t5523-push-upstream.sh |    7 +++++++
 t/t5541-http-push.sh     |    8 ++++++++
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ae164da..4419323 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -31,6 +31,7 @@ static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
+static int quiet;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
@@ -114,7 +115,7 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
 	else
 		packet_write(1, "%s %s%c%s%s\n",
 			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k",
+			     " report-status delete-refs side-band-64k quiet",
 			     prefer_ofs_delta ? " ofs-delta" : "");
 	sent_capabilities = 1;
 	return 0;
@@ -636,6 +637,8 @@ static struct command *read_head_info(void)
 				report_status = 1;
 			if (strstr(refname + reflen + 1, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
+			if (strstr(refname + reflen + 1, "quiet"))
+				quiet = 1;
 		}
 		cmd = xcalloc(1, sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
@@ -684,8 +687,10 @@ static const char *unpack(void)
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		int code, i = 0;
-		const char *unpacker[4];
+		const char *unpacker[5];
 		unpacker[i++] = "unpack-objects";
+		if (quiet)
+			unpacker[i++] = "-q";
 		if (receive_fsck_objects)
 			unpacker[i++] = "--strict";
 		unpacker[i++] = hdr_arg;
@@ -799,6 +804,11 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
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
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index c1f6ddd..a8d6b4c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -263,6 +263,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_ofs_delta = 1;
 	if (server_supports("side-band-64k"))
 		use_sideband = 1;
+	if (!server_supports("quiet"))
+		args->quiet = 0;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -301,11 +303,12 @@ int send_pack(struct send_pack_args *args,
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 
-			if (!cmds_sent && (status_report || use_sideband)) {
-				packet_buf_write(&req_buf, "%s %s %s%c%s%s",
+			if (!cmds_sent && (status_report || use_sideband || args->quiet)) {
+				packet_buf_write(&req_buf, "%s %s %s%c%s%s%s",
 					old_hex, new_hex, ref->name, 0,
 					status_report ? " report-status" : "",
-					use_sideband ? " side-band-64k" : "");
+					use_sideband ? " side-band-64k" : "",
+					args->quiet ? " quiet" : "");
 			}
 			else
 				packet_buf_write(&req_buf, "%s %s %s",
@@ -439,6 +442,10 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
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
diff --git a/remote-curl.c b/remote-curl.c
index b8cf45a..2341106 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -762,7 +762,9 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 		argv[argc++] = "--thin";
 	if (options.dry_run)
 		argv[argc++] = "--dry-run";
-	if (options.verbosity > 1)
+	if (options.verbosity == 0)
+		argv[argc++] = "--quiet";
+	else if (options.verbosity > 1)
 		argv[argc++] = "--verbose";
 	argv[argc++] = url;
 	for (i = 0; i < nr_spec; i++)
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index c229fe6..9ee52cf 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -108,4 +108,11 @@ test_expect_failure TTY 'push --no-progress suppresses progress' '
 	! grep "Writing objects" err
 '
 
+test_expect_success TTY 'quiet push' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push --quiet --no-progress upstream master 2>&1 | tee output &&
+	test_cmp /dev/null output
+'
+
 test_done
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index a73c826..e756a08 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -5,6 +5,7 @@
 
 test_description='test smart pushing over http via http-backend'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 if test -n "$NO_CURL"; then
 	skip_all='skipping test, git built without http support'
@@ -154,5 +155,12 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_success TTY 'quiet push' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	test_commit quiet &&
+	test_terminal git push --quiet --no-progress 2>&1 | tee output &&
+	test_cmp /dev/null output
+'
+
 stop_httpd
 test_done
-- 
1.7.6.1

