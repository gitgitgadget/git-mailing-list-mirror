From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/7] refactor run_receive_hook()
Date: Thu,  8 Sep 2011 13:01:41 -0700
Message-ID: <1315512102-19022-7-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 00:57:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nXJ-0005F6-L7
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab1IHW4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:56:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38549 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab1IHW4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:56:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18E5C4657
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=oGDh
	9eFEXo82FNfqcPO8991aStU=; b=dcKfQDMtdWIv/+xjBG8DwgaQCz7G04k3hBHn
	rZwu9zW1SL5Dq8NKkrxT1l2dL0/ShKVZqYChcIP6V4OVoTjegzuWaKmo7WiQTGq7
	a/ZJlzVl9Dv5lvXixCPJKQcZN8eRBNRkDnLBDB091F51CSFnvWDSBygWS4rlNvqz
	q5P9LkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=biyaGQ
	8XL7bV3vJo6SrN3FfmJwgC8D19V0qXyiG5UCkBFzjKxMcrkUDvBeNvgzfqifTKmF
	XVDeWC4qbcP2p+fJ7N1U7xHutARTPchG0JWZsNqt2MK2sal6Q5coZT25QlhtJjqb
	qV/RU9MoSZFrB7dU6qGBpfEtw8Q93Mu2a5kg0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F7A94656
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0BC24654 for
 <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315512102-19022-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 671AB304-DA55-11E0-B465-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180983>

Running a hook has to make complex set-up to establish web of
communication between child process and multiplexer, which is common
regardless of what kind of data is fed to the hook. Refactor the parts
that is specific to the data fed to the particular set of hooks from the
part that runs the hook, so that the code can be reused to drive hooks
that take different kind of data.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c |   71 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 344660e..939b867 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -212,21 +212,15 @@ static int copy_to_sideband(int in, int out, void *arg)
 	return 0;
 }
 
-static int run_receive_hook(struct command *commands, const char *hook_name)
+typedef int (*feed_fn)(void *, const char **, size_t *);
+static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_state)
 {
-	static char buf[sizeof(commands->old_sha1) * 2 + PATH_MAX + 4];
-	struct command *cmd;
 	struct child_process proc;
 	struct async muxer;
 	const char *argv[2];
-	int have_input = 0, code;
-
-	for (cmd = commands; !have_input && cmd; cmd = cmd->next) {
-		if (!cmd->error_string)
-			have_input = 1;
-	}
+	int code;
 
-	if (!have_input || access(hook_name, X_OK) < 0)
+	if (access(hook_name, X_OK) < 0)
 		return 0;
 
 	argv[0] = hook_name;
@@ -254,15 +248,13 @@ static int run_receive_hook(struct command *commands, const char *hook_name)
 		return code;
 	}
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string) {
-			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
-				sha1_to_hex(cmd->old_sha1),
-				sha1_to_hex(cmd->new_sha1),
-				cmd->ref_name);
-			if (write_in_full(proc.in, buf, n) != n)
-				break;
-		}
+	while (1) {
+		const char *buf;
+		size_t n;
+		if (feed(feed_state, &buf, &n))
+			break;
+		if (write_in_full(proc.in, buf, n) != n)
+			break;
 	}
 	close(proc.in);
 	if (use_sideband)
@@ -270,6 +262,47 @@ static int run_receive_hook(struct command *commands, const char *hook_name)
 	return finish_command(&proc);
 }
 
+struct receive_hook_feed_state {
+	struct command *cmd;
+	struct strbuf buf;
+};
+
+static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
+{
+	struct receive_hook_feed_state *state = state_;
+	struct command *cmd = state->cmd;
+
+	while (cmd && cmd->error_string)
+		cmd = cmd->next;
+	if (!cmd)
+		return -1; /* EOF */
+	strbuf_reset(&state->buf);
+	strbuf_addf(&state->buf, "%s %s %s\n",
+		    sha1_to_hex(cmd->old_sha1), sha1_to_hex(cmd->new_sha1),
+		    cmd->ref_name);
+	state->cmd = cmd->next;
+	if (bufp) {
+		*bufp = state->buf.buf;
+		*sizep = state->buf.len;
+	}
+	return 0;
+}
+
+static int run_receive_hook(struct command *commands, const char *hook_name)
+{
+	struct receive_hook_feed_state state;
+	int status;
+
+	strbuf_init(&state.buf, 0);
+	state.cmd = commands;
+	if (feed_receive_hook(&state, NULL, NULL))
+		return 0;
+	state.cmd = commands;
+	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
+	strbuf_release(&state.buf);
+	return status;
+}
+
 static int run_update_hook(struct command *cmd)
 {
 	static const char update_hook[] = "hooks/update";
-- 
1.7.7.rc0.188.g3793ac
