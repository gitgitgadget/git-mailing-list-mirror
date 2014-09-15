From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 22/23] signed push: allow stale nonce in stateless mode
Date: Mon, 15 Sep 2014 15:24:23 -0700
Message-ID: <1410819864-22967-23-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:25:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeiB-0006b0-8L
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383AbaIOWZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:25:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54184 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758725AbaIOWZL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:25:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CD5A3B1DC;
	Mon, 15 Sep 2014 18:25:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=XbFh
	TwQU8LinUPUUTECiTpwJY2Y=; b=j6sXz0UpzEtWuC6yZ/3d0oQmVcYS1KvIx249
	Jr47fI3IvEfIkVnjglfpuTjkWCRh77SxE2lz1gjsn5fhxaZAHrEdxKiQTbhFiUf2
	1S5dktrsFjbNKSqnmVBGboZt38fd0zR4SgGkjXV62d25bjcv4hhocNLYZxVVlCUQ
	xNb6fMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BUr7gp
	Cj+NxNe7gdLcol90TFuf3o+VA7wTSD0HfWeViAcsYPL+XF7tiMlb/g66yTiqtyK1
	cLXDouNCyNu8ZDM98ex/zE3AFoawXzUinqGuyIw+/e7uymieNuYFHKtv2APWpti0
	dcSHnjxwnYvPzX0cTDwlBniXLXr5ls6EiKS08=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71EB63B1DB;
	Mon, 15 Sep 2014 18:25:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A92923B1DA;
	Mon, 15 Sep 2014 18:25:09 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 271A4728-3D27-11E4-B57C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257106>

When operating with the stateless RPC mode, we will receive a nonce
issued by another instance of us that advertised our capability and
refs some time ago.  Update the logic to check received nonce to
detect this case, compute how much time has passed since the nonce
was issued and report the status with a new environment variable
GIT_PUSH_CERT_NONCE_SLOP to the hooks.

GIT_PUSH_CERT_NONCE_STATUS will report "SLOP" in such a case.  The
hooks are free to decide how large a slop it is willing to accept.

Strictly speaking, the "nonce" is not really a "nonce" anymore in
the stateless RPC mode, as it will happily take any "nonce" issued
by it (which is protected by HMAC and its secret key) as long as it
is fresh enough.  The degree of this security degradation, relative
to the native protocol, is about the same as the "we make sure that
the 'git push' decided to update our refs with new objects based on
the freshest observation of our refs by making sure the values they
claim the original value of the refs they ask us to update exactly
match the current state" security is loosened to accomodate the
stateless RPC mode in the existing code without this series, so
there is no need for those who are already using smart HTTP to push
to their repositories to be alarmed any more than they already are.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-receive-pack.txt | 11 ++++++++
 builtin/receive-pack.c             | 57 ++++++++++++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 2d4b452..2e5131d 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -89,6 +89,17 @@ the following environment variables:
 	"git push --signed" sent a bogus nonce.
 `OK`;;
 	"git push --signed" sent the nonce we asked it to send.
+`SLOP`;;
+	"git push --signed" sent a nonce different from what we
+	asked it to send now, but in a previous session.  See
+	`GIT_PUSH_CERT_NONCE_SLOP` environment variable.
+
+`GIT_PUSH_CERT_NONCE_SLOP`::
+	"git push --signed" sent a nonce different from what we
+	asked it to send now, but in a different session whose
+	starting time is different by this many seconds from the
+	current session.  Only meaningful when
+	`GIT_PUSH_CERT_NONCE_STATUS` says `SLOP`.
 
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a1823e5..86fb5a4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -43,6 +43,8 @@ static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
 static int fix_thin = 1;
+static int stateless_rpc;
+static const char *service_dir;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
@@ -58,7 +60,9 @@ static const char *NONCE_UNSOLICITED = "UNSOLICITED";
 static const char *NONCE_BAD = "BAD";
 static const char *NONCE_MISSING = "MISSING";
 static const char *NONCE_OK = "OK";
+static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
+static long nonce_stamp_slop;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -359,6 +363,8 @@ static const char *find_header(const char *msg, size_t len, const char *key)
 static const char *check_nonce(const char *buf, size_t len)
 {
 	const char *nonce = find_header(buf, len, "nonce");
+	unsigned long stamp, ostamp;
+	char *bohmac, *expect;
 
 	if (!nonce)
 		return NONCE_MISSING;
@@ -368,7 +374,39 @@ static const char *check_nonce(const char *buf, size_t len)
 		return NONCE_OK;
 
 	/* returned nonce MUST match what we gave out earlier */
-	return NONCE_BAD;
+	if (!stateless_rpc)
+		return NONCE_BAD;
+
+	/*
+	 * In stateless mode, we may be receiving a nonce issued
+	 * by another instance of the server that serving the same
+	 * repository, and the timestamps may not match, but the
+	 * nonce-seed and dir should match, so we can recompute
+	 * and report the time slop.
+	 */
+
+	/* nonce is concat(<seconds-since-epoch>, "-", <hmac>) */
+	if (*nonce <= '0' || '9' < *nonce)
+		return NONCE_BAD;
+	stamp = strtoul(nonce, &bohmac, 10);
+	if (bohmac == nonce || bohmac[1] != '-')
+		return NONCE_BAD;
+
+	expect = prepare_push_cert_nonce(service_dir, stamp);
+	if (strcmp(expect, nonce)) {
+		free(expect);
+		return NONCE_BAD;
+	}
+	free(expect);
+
+	/*
+	 * By how many seconds is this nonce stale?  Negative
+	 * value would mean it was issued by another server
+	 * with its clock skewed in the future.
+	 */
+	ostamp = strtoul(push_cert_nonce, NULL, 10);
+	nonce_stamp_slop = (long)ostamp - (long)stamp;
+	return NONCE_SLOP;
 }
 
 static void prepare_push_cert_sha1(struct child_process *proc)
@@ -417,6 +455,9 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		if (push_cert_nonce) {
 			argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE=%s", push_cert_nonce);
 			argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE_STATUS=%s", nonce_status);
+			if (nonce_status == NONCE_SLOP)
+				argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE_SLOP=%ld",
+						 nonce_stamp_slop);
 		}
 		proc->env = env.argv;
 	}
@@ -1352,9 +1393,7 @@ static int delete_only(struct command *commands)
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
-	int stateless_rpc = 0;
 	int i;
-	const char *dir = NULL;
 	struct command *commands;
 	struct sha1_array shallow = SHA1_ARRAY_INIT;
 	struct sha1_array ref = SHA1_ARRAY_INIT;
@@ -1387,21 +1426,21 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 			usage(receive_pack_usage);
 		}
-		if (dir)
+		if (service_dir)
 			usage(receive_pack_usage);
-		dir = arg;
+		service_dir = arg;
 	}
-	if (!dir)
+	if (!service_dir)
 		usage(receive_pack_usage);
 
 	setup_path();
 
-	if (!enter_repo(dir, 0))
-		die("'%s' does not appear to be a git repository", dir);
+	if (!enter_repo(service_dir, 0))
+		die("'%s' does not appear to be a git repository", service_dir);
 
 	git_config(receive_pack_config, NULL);
 	if (cert_nonce_seed)
-		push_cert_nonce = prepare_push_cert_nonce(dir, time(NULL));
+		push_cert_nonce = prepare_push_cert_nonce(service_dir, time(NULL));
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
-- 
2.1.0-410-gd72dacd
