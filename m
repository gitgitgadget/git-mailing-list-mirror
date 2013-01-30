From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/8] WIP: receive.allowupdatestohidden
Date: Wed, 30 Jan 2013 10:45:42 -0800
Message-ID: <1359571542-19852-9-git-send-email-gitster@pobox.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:46:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cg6-0004fU-W3
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab3A3SqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:46:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33825 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756686Ab3A3SqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:46:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5904EC41A;
	Wed, 30 Jan 2013 13:46:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QRyp
	cKthNIj7L9vD8UA46oe7vao=; b=c0GfaooSiaDzz7dfZeW4xiKfoJXbGXVbWWPz
	HgYP1ZdLd28esTkfglVy9gil5Zgq21i6kMJGzk4zeYk1H5KDarvQG9b5YN554a7B
	fURQfe9vhzMHZv13bLAs/J29ojjO5FyO7TSWZhM5taEMHn12rpYwYA4Hgo147z/x
	GBDYb4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	rnIlYIUqIu+Jg82cYHAvPIcAi2v978SXhn0fy+xs3G1UxyU9sSvaBA6uI27IIslj
	yfnsm1uTs5wTntSVXdZtczIBiCAdX9Y+j/T0gAQbaY1Ek7v25LECAt3wAkLqIaNU
	ucUfpkOahUNk5s8x3Adg4aCgFqv/NcWBk1BqkLoD0lc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49C90C419;
	Wed, 30 Jan 2013 13:46:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85DE0C418; Wed, 30 Jan 2013
 13:46:00 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.589.ga9b91ac
In-Reply-To: <1359571542-19852-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4AA43764-6B0D-11E2-97E9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215048>

This does not work yet, and for a good reason.  As the side that
pushes to a hidden ref never sees that the ref already exists, a
request to update such a ref will come in the form of "please
_create_ this ref and point it at this object", which will not pass
the compare-and-swap based anti-race safety at the receiving end.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  6 ++++++
 builtin/receive-pack.c   |  9 ++++++++-
 t/t5516-fetch-push.sh    | 24 ++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2dce021..8f13fc0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1849,6 +1849,12 @@ receive.updateserverinfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
 
+receive.allowupdatestohidden::
+	When `transfer.hiderefs` is in effect, allow `receive-pack`
+	to accept a push request that asks to update or delete a
+	hidden ref (by default, such a request is rejected).
+	see also `transfer.hiderefs`.
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a8248d9..88500e7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -41,6 +41,7 @@ static int auto_gc = 1;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
+static int allow_updates_to_hidden;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -119,6 +120,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.allowupdatestohidden") == 0) {
+		allow_updates_to_hidden = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -726,7 +732,8 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 				       0, &cmd))
 		set_connectivity_errors(commands);
 
-	reject_updates_to_hidden(commands);
+	if (!allow_updates_to_hidden)
+		reject_updates_to_hidden(commands);
 
 	if (run_receive_hook(commands, pre_receive_hook, 0)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 522056f..4c8aef9 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1095,4 +1095,28 @@ test_expect_success 'push to update a hidden ref' '
 	check_push_result $the_first_commit hidden/three
 '
 
+test_expect_failure 'allow push to update a hidden ref' '
+	mk_test heads/master hidden/one hidden/two hidden/three &&
+	(
+		cd testrepo &&
+		git config transfer.hiderefs refs/hidden &&
+		git config receive.allowupdatestohidden yes
+	) &&
+
+	# push to unhidden ref succeeds normally
+	git push testrepo master:refs/heads/master &&
+	check_push_result $the_commit heads/master &&
+
+	# push to update a hidden ref should succeed
+	git push testrepo master:refs/hidden/one &&
+	check_push_result $the_commit heads/master &&
+
+	# push to delete a hidden ref should succeed
+	git push testrepo :refs/hidden/two &&
+	(
+		cd testrepo &&
+		test_must_fail git show-ref -q refs/hidden/one
+	)
+'
+
 test_done
-- 
1.8.1.2.589.ga9b91ac
