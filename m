From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFCv2 2/2] run post-receive and post-update hooks with empty
 stdin/no args for invalid ref deletion
Date: Mon, 26 Sep 2011 01:37:34 +0800
Message-ID: <20110925173734.GA29256@myhost>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
 <1316927182-14212-3-git-send-email-pangyanhan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 19:40:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7sgt-0006hf-6M
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 19:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab1IYRkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 13:40:16 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38150 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab1IYRkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 13:40:15 -0400
Received: by ywb5 with SMTP id 5so3768571ywb.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8OBvkV+wdgVfwfKqyHro60LCc1tVwI+CfQLCOM6XmDM=;
        b=OxMEF3Ov81ItuVfK5NbVz8SEHK9D/v/a+QtN3o7mAgNb829q/22pQc8fxmcGNMXnDy
         UyUTrvRi7d0T5GZgSp4cezQSvzwBNngS1gQH+t1xvZHJN565VgdcE2q9d/zCLTA9NX/0
         NGvIrfGJed1iLfQq/QDA+Tl3sDDma5RSzih6I=
Received: by 10.68.29.228 with SMTP id n4mr24378859pbh.64.1316972414256;
        Sun, 25 Sep 2011 10:40:14 -0700 (PDT)
Received: from localhost (bb116-14-109-35.singnet.com.sg. [116.14.109.35])
        by mx.google.com with ESMTPS id i3sm64017612pbg.10.2011.09.25.10.40.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Sep 2011 10:40:13 -0700 (PDT)
Mail-Followup-To: Pang Yan Han <pangyanhan@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <1316927182-14212-3-git-send-email-pangyanhan@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182078>

The post-receive and post-update hooks are triggered with invalid input on
stdin and invalid args respectively during the deletion of corrupt or
non-existent refs during a push.

Teach receive-pack to run post-receive hook with empty stdin and post-update
hook with empty args in the event of an invalid ref deletion.

Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
---
This has been updated with the suggestions from Sitaram Chamarty, as stated in
http://thread.gmane.org/gmane.comp.version-control.git/182056/focus=182065

 builtin/receive-pack.c |   35 +++++++++++++-
 t/t5516-fetch-push.sh  |  118 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ae164da..28d0b09 100644
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
 
@@ -248,7 +268,8 @@ static int run_receive_hook(struct command *commands, const char *hook_name)
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string) {
+		/* Run with empty stdin for invalid ref deletion */
+		if (!cmd->error_string && !is_invalid_delete(cmd)) {
 			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
 				sha1_to_hex(cmd->old_sha1),
 				sha1_to_hex(cmd->new_sha1),
@@ -447,6 +468,7 @@ static const char *update(struct command *cmd)
 		if (!parse_object(old_sha1)) {
 			rp_warning("Allowing deletion of corrupt ref.");
 			old_sha1 = NULL;
+			invalid_delete_append(cmd);
 		}
 		if (delete_ref(namespaced_name, old_sha1, 0)) {
 			rp_error("failed to delete %s", name);
@@ -490,8 +512,14 @@ static void run_update_post_hook(struct command *commands)
 		char *p;
 		if (cmd->error_string)
 			continue;
-		p = xmalloc(strlen(cmd->ref_name) + 1);
-		strcpy(p, cmd->ref_name);
+		if (is_invalid_delete(cmd)) {
+			/* Run with empty args for invalid ref deletion */
+			p = xmalloc(1);
+			p[0] = '\0';
+		} else {
+			p = xmalloc(strlen(cmd->ref_name) + 1);
+			strcpy(p, cmd->ref_name);
+		}
 		argv[argc] = p;
 		argc++;
 	}
@@ -866,5 +894,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	}
 	if (use_sideband)
 		packet_flush(1);
+	free(invalid_delete);
 	return 0;
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3abb290..038a3b3 100755
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
@@ -559,6 +592,91 @@ test_expect_success 'allow deleting an invalid remote ref' '
 
 '
 
+test_expect_success 'pushing valid refs triggers post-receive and post-update hooks' '
+	mk_test_with_hooks heads/master &&
+	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
+	newmaster=$(git show-ref -s --verify refs/heads/master) &&
+	git push testrepo refs/heads/master:refs/heads/master :refs/heads/nonexistent &&
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
+
+EOF
+
+	test_cmp pre-receive.expect pre-receive.actual &&
+	test_cmp update.expect update.actual &&
+	test_cmp post-receive.expect post-receive.actual &&
+	test_cmp post-update.expect post-update.actual
+	)
+'
+
+test_expect_success 'deleting non-existent ref triggers post-receive and post-update hooks with empty args' '
+	mk_test_with_hooks heads/master &&
+	git push testrepo :refs/heads/nonexistent &&
+	(cd testrepo/.git &&
+	cat >pre-receive.expect <<'EOF' &&
+$_z40 $_z40 refs/heads/nonexistent
+EOF
+
+	cat >update.expect <<'EOF' &&
+refs/heads/nonexistent $_z40 $_z40
+EOF
+
+	cat >post-receive.expect <<'EOF' &&
+EOF
+
+	cat >post-update.expect <<'EOF' &&
+
+EOF
+
+	test_cmp pre-receive.expect pre-receive.actual &&
+	test_cmp update.expect update.actual &&
+	test_cmp post-receive.expect post-receive.actual &&
+	test_cmp post-update.expect post-update.actual
+	)
+'
+
+test_expect_success 'deleting invalid ref triggers post-receive and post-update hooks with empty args' '
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
+EOF
+
+	cat >post-update.expect <<'EOF' &&
+
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
1.7.7.rc3.2.gd706f.dirty
