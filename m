From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] receive-pack: reject an attempt to update/delete a
 hidden ref
Date: Mon, 28 Jan 2013 16:13:32 -0800
Message-ID: <1359418412-26602-4-git-send-email-gitster@pobox.com>
References: <1359418412-26602-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 01:14:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzyq0-0005Uz-0E
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 01:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785Ab3A2ANo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 19:13:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab3A2ANn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 19:13:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A66CC7FD
	for <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Bsrj
	PVkiTfJwxPvbPH8eHwEiGGw=; b=o9PI7rlXbKMC1eUB9zLEYVtL5C3F35efQEd3
	6et6XRToH1M4ehQC8d+4pJsWGaV2bTM7B0Ir2dURo3aLO49hzOlAssjj7QjbzAfc
	jB3X2SNZuBh9Vv5d2g8FCBptvx1iy6rk20s6ypfqUUwPKgDbr2LDQIswhYJGS++W
	ODHFKuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vGZfdF
	KMBCr/yDvsfgNC9mm237WgwLgBXiqEbfMs1/pOwxaAnpJlaqvkPDWUM0LHQuhjKv
	iq7QBlUj/ULzMWhy0zDCZcTzjveNiN65fEOHsody0E69kT+wHQ0kJS2W4fmn3P0V
	GL4uVTaAvHJeD2roY+PSIpZdMlRIJ5Ta4gEn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F4CDC7FC
	for <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 961D0C7F8 for
 <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:41 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.548.g0e4986f
In-Reply-To: <1359418412-26602-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BCB93C34-69A8-11E2-A05B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214891>

An attempt to update or delete a ref that is hidden from "git push"
is rejected.  With this the server side can implement refs that are
only available for its own use, e.g. refs/pull/11/head used to hold
an incoming pull request at GitHub.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  3 ++-
 builtin/receive-pack.c   | 16 ++++++++++++++++
 t/t5516-fetch-push.sh    | 24 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8e2853e..b7b407b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2063,7 +2063,8 @@ transfer.hiderefs::
 	more than one transfer.hiderefs configuration variables to
 	specify multiple prefix strings. A ref that has one of these
 	strings as its prefix is excluded, and is hidden from
-	`git clone --mirror` and `git push :`.
+	`git clone --mirror` and `git push :`.  An attempt to update
+	or delete a hidden ref by `git push` is	rejected.
 
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5ed40be..a8248d9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -696,6 +696,20 @@ static int iterate_receive_command_list(void *cb_data, unsigned char sha1[20])
 	return -1; /* end of list */
 }
 
+static void reject_updates_to_hidden(struct command *commands)
+{
+	struct command *cmd;
+
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (cmd->error_string || !ref_is_hidden(cmd->ref_name))
+			continue;
+		if (is_null_sha1(cmd->new_sha1))
+			cmd->error_string = "deny deleting a hidden ref";
+		else
+			cmd->error_string = "deny updating a hidden ref";
+	}
+}
+
 static void execute_commands(struct command *commands, const char *unpacker_error)
 {
 	struct command *cmd;
@@ -712,6 +726,8 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 				       0, &cmd))
 		set_connectivity_errors(commands);
 
+	reject_updates_to_hidden(commands);
+
 	if (run_receive_hook(commands, pre_receive_hook, 0)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6009372..8e8287a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1037,4 +1037,28 @@ test_expect_success 'push --prune refspec' '
 	! check_push_result $the_first_commit tmp/foo tmp/bar
 '
 
+test_expect_success 'push to update a hidden ref' '
+	mk_test heads/master hidden/one hidden/two hidden/three &&
+	(
+		cd testrepo &&
+		git config transfer.hiderefs refs/hidden
+	) &&
+
+	# push to unhidden ref succeeds normally
+	git push testrepo master:refs/heads/master &&
+	check_push_result $the_commit heads/master &&
+
+	# push to update a hidden ref should fail
+	test_must_fail git push testrepo master:refs/hidden/one &&
+	check_push_result $the_first_commit hidden/one &&
+
+	# push to delete a hidden ref should fail
+	test_must_fail git push testrepo master:refs/hidden/two &&
+	check_push_result $the_first_commit hidden/two &&
+
+	# idempotent push to update a hidden ref should fail
+	test_must_fail git push testrepo $the_first_commit:refs/hidden/three &&
+	check_push_result $the_first_commit hidden/three
+'
+
 test_done
-- 
1.8.1.2.548.g0e4986f
