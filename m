From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFCv3 2/2] receive-pack: don't pass non-existent refs to
 post-{receive,update} hooks in push deletions
Date: Wed, 28 Sep 2011 23:39:35 +0800
Message-ID: <20110928153935.GA7800@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 17:42:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8wHL-0004vQ-8B
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 17:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab1I1Pma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 11:42:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51341 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab1I1Pm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 11:42:29 -0400
Received: by ywb5 with SMTP id 5so6504820ywb.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=Pm1sz92ERgDVufRkMhA0vnLqeTDRh2QR5H7X4rDIFA4=;
        b=oXFZJT1ls3P2M74pEQbu7l2dBxzu8dT7P3GgAZJ424IlIT9ZMud6aEqnYOoISnp96P
         FUARtMEBXK4lbFblGa2579m13baYVb6029QmmodqcztHYKIz2G4wnb//+63MicgGaQw0
         HqpnOKx0jmJPSvOcmun2gp/SnReG+OFI7lnVk=
Received: by 10.151.50.8 with SMTP id c8mr8590931ybk.370.1317224549051;
        Wed, 28 Sep 2011 08:42:29 -0700 (PDT)
Received: from localhost (bb220-255-108-97.singnet.com.sg. [220.255.108.97])
        by mx.google.com with ESMTPS id d9sm603395ybl.14.2011.09.28.08.42.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 08:42:24 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182336>

When a push specifies deletion of non-existent refs, the post post-receive and
post-update hooks receive as input/arguments the non-existent refs.

For instance, for the following push, where refs/heads/nonexistent is a ref
which does not exist on the remote side:

	git push origin :refs/heads/nonexistent

the post-receive hook receives from standard input:

	<null-sha1> SP <null-sha1> SP refs/heads/nonexistent

and the post-update hook receives as arguments:

	refs/heads/nonexistent

which does not make sense since it is a no-op.

Teach receive-pack to not pass non-existent refs as input / arguments to the
post-receive and post-update hooks in the event of a push involving
non-existent ref deletion.

Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
---
 builtin/receive-pack.c |   31 ++++++++-
 t/t5516-fetch-push.sh  |  170 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ae164da..8a0a9d2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -153,6 +153,26 @@ struct command {
 	char ref_name[FLEX_ARRAY]; /* more */
 };
 
+/* For invalid refs */
+static struct command **invalid_delete;
+static size_t invalid_delete_nr;
+static size_t invalid_delete_alloc;
+
+static void invalid_delete_append(struct command *cmd)
+{
+	ALLOC_GROW(invalid_delete, invalid_delete_nr + 1, invalid_delete_alloc);
+	invalid_delete[invalid_delete_nr++] = cmd;
+}
+
+static int is_invalid_delete(struct command *cmd)
+{
+	size_t i;
+	for (i = 0; i < invalid_delete_nr; i++)
+		if (invalid_delete[i] == cmd)
+			return 1;
+	return 0;
+}
+
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
@@ -215,7 +235,7 @@ static int run_receive_hook(struct command *commands, const char *hook_name)
 	int have_input = 0, code;
 
 	for (cmd = commands; !have_input && cmd; cmd = cmd->next) {
-		if (!cmd->error_string)
+		if (!cmd->error_string && !is_invalid_delete(cmd))
 			have_input = 1;
 	}
 
@@ -248,7 +268,7 @@ static int run_receive_hook(struct command *commands, const char *hook_name)
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string) {
+		if (!cmd->error_string && !is_invalid_delete(cmd)) {
 			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
 				sha1_to_hex(cmd->old_sha1),
 				sha1_to_hex(cmd->new_sha1),
@@ -447,6 +467,8 @@ static const char *update(struct command *cmd)
 		if (!parse_object(old_sha1)) {
 			rp_warning("Allowing deletion of corrupt ref.");
 			old_sha1 = NULL;
+			if (!ref_exists((char *) name))
+				invalid_delete_append(cmd);
 		}
 		if (delete_ref(namespaced_name, old_sha1, 0)) {
 			rp_error("failed to delete %s", name);
@@ -477,7 +499,7 @@ static void run_update_post_hook(struct command *commands)
 	struct child_process proc;
 
 	for (argc = 0, cmd = commands; cmd; cmd = cmd->next) {
-		if (cmd->error_string)
+		if (cmd->error_string || is_invalid_delete(cmd))
 			continue;
 		argc++;
 	}
@@ -488,7 +510,7 @@ static void run_update_post_hook(struct command *commands)
 
 	for (argc = 1, cmd = commands; cmd; cmd = cmd->next) {
 		char *p;
-		if (cmd->error_string)
+		if (cmd->error_string || is_invalid_delete(cmd))
 			continue;
 		p = xmalloc(strlen(cmd->ref_name) + 1);
 		strcpy(p, cmd->ref_name);
@@ -866,5 +888,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	}
 	if (use_sideband)
 		packet_flush(1);
+	free(invalid_delete);
 	return 0;
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3abb290..c0d8a0e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -40,6 +40,39 @@ mk_test () {
 	)
 }
 
+mk_test_with_hooks() {
+	mk_test "$@" &&
+	(
+	cd testrepo &&
+	mkdir .git/hooks &&
+	cd .git/hooks &&
+
+	cat >pre-receive <<'EOF' &&
+#!/bin/sh
+cat - >>pre-receive.actual
+EOF
+
+	cat >update <<'EOF' &&
+#!/bin/sh
+printf "%s %s %s\n" "$@" >>update.actual
+EOF
+	cat >post-receive <<'EOF' &&
+#!/bin/sh
+cat - >>post-receive.actual
+EOF
+
+	cat >post-update <<'EOF' &&
+#!/bin/sh
+for ref in "$@"
+do
+	printf "%s\n" "$ref" >>post-update.actual
+done
+EOF
+
+	chmod u+x pre-receive update post-receive post-update
+	)
+}
+
 mk_child() {
 	rm -rf "$1" &&
 	git clone testrepo "$1"
@@ -559,6 +592,143 @@ test_expect_success 'allow deleting an invalid remote ref' '
 
 '
 
+test_expect_success 'pushing valid refs triggers post-receive and post-update hooks' '
+	mk_test_with_hooks heads/master heads/next &&
+	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
+	newmaster=$(git show-ref -s --verify refs/heads/master) &&
+	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
+	newnext=$_z40 &&
+	git push testrepo refs/heads/master:refs/heads/master :refs/heads/next &&
+	(cd testrepo/.git &&
+	cat >pre-receive.expect <<'EOF' &&
+$orgmaster $newmaster refs/heads/master
+$orgnext $newnext refs/heads/next
+EOF
+
+	cat >update.expect <<'EOF' &&
+refs/heads/master $orgmaster $newmaster
+refs/heads/next $orgnext $newnext
+EOF
+
+	cat >post-receive.expect <<'EOF' &&
+$orgmaster $newmaster refs/heads/master
+$orgnext $newnext refs/heads/next
+EOF
+
+	cat >post-update.expect <<'EOF' &&
+refs/heads/master
+refs/heads/next
+EOF
+
+	test_cmp pre-receive.expect pre-receive.actual &&
+	test_cmp update.expect update.actual &&
+	test_cmp post-receive.expect post-receive.actual &&
+	test_cmp post-update.expect post-update.actual
+	)
+'
+
+test_expect_success 'deleting dangling ref triggers hooks with correct args' '
+	mk_test_with_hooks heads/master &&
+	rm -f testrepo/.git/objects/??/* &&
+	git push testrepo :refs/heads/master &&
+	(cd testrepo/.git &&
+	cat >pre-receive.expect <<'EOF' &&
+$_z40 $_z40 refs/heads/master
+EOF
+
+	cat >update.expect <<'EOF' &&
+refs/heads/master $_z40 $_z40
+EOF
+
+	cat >post-receive.expect <<'EOF' &&
+$_z40 $_z40 refs/heads/master
+EOF
+
+	cat >post-update.expect <<'EOF' &&
+refs/heads/master
+EOF
+
+	test_cmp pre-receive.expect pre-receive.actual &&
+	test_cmp update.expect update.actual &&
+	test_cmp post-receive.expect post-receive.actual &&
+	test_cmp post-update.expect post-update.actual
+	)
+'
+
+test_expect_success 'deleting non-existent ref does not trigger post-receive and post-update hooks' '
+	mk_test_with_hooks heads/master &&
+	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
+	newmaster=$(git show-ref -s --verify refs/heads/master) &&
+	git push testrepo master :refs/heads/nonexistent &&
+	(cd testrepo/.git &&
+	cat >pre-receive.expect <<'EOF' &&
+$orgmaster $newmaster refs/heads/master
+$_z40 $_z40 refs/heads/nonexistent
+EOF
+
+	cat >update.expect <<'EOF' &&
+refs/heads/master $orgmaster $newmaster
+refs/heads/nonexistent $_z40 $_z40
+EOF
+
+	cat >post-receive.expect <<'EOF' &&
+$orgmaster $newmaster refs/heads/master
+EOF
+
+	cat >post-update.expect <<'EOF' &&
+refs/heads/master
+EOF
+
+	test_cmp pre-receive.expect pre-receive.actual &&
+	test_cmp update.expect update.actual &&
+	test_cmp post-receive.expect post-receive.actual &&
+	test_cmp post-update.expect post-update.actual
+	)
+'
+
+test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks with correct input' '
+	mk_test_with_hooks heads/master heads/next heads/pu &&
+	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
+	newmaster=$(git show-ref -s --verify refs/heads/master) &&
+	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
+	newnext=$_z40 &&
+	orgpu=$(cd testrepo && git show-ref -s --verify refs/heads/pu) &&
+	newpu=$(git show-ref -s --verify refs/heads/master) &&
+	git push testrepo refs/heads/master:refs/heads/master refs/heads/master:refs/heads/pu :refs/heads/next :refs/heads/nonexistent &&
+	(cd testrepo/.git &&
+	cat >pre-receive.expect <<'EOF' &&
+$orgmaster $newmaster refs/heads/master
+$orgnext $newnext refs/heads/next
+$orgpu $newpu refs/heads/pu
+$_z40 $_z40 refs/heads/nonexistent
+EOF
+
+	cat >update.expect <<'EOF' &&
+refs/heads/master $orgmaster $newmaster
+refs/heads/next $orgnext $newnext
+refs/heads/pu $orgpu $newpu
+refs/heads/nonexistent $_z40 $_z40
+EOF
+
+	cat >post-receive.expect <<'EOF' &&
+$orgmaster $newmaster refs/heads/master
+$orgnext $newnext refs/heads/next
+$orgpu $newpu refs/heads/pu
+EOF
+
+	cat >post-update.expect <<'EOF' &&
+refs/heads/master
+refs/heads/next
+refs/heads/pu
+EOF
+
+	test_cmp pre-receive.expect pre-receive.actual &&
+	test_cmp update.expect update.actual &&
+	test_cmp post-receive.expect post-receive.actual &&
+	test_cmp post-update.expect post-update.actual
+	)
+'
+
 test_expect_success 'allow deleting a ref using --delete' '
 	mk_test heads/master &&
 	(cd testrepo && git config receive.denyDeleteCurrent warn) &&
-- 
1.7.7.rc3.2.g6bf07
