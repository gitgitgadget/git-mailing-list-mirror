From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] git: simplify environment save/restore logic
Date: Wed, 27 Jan 2016 15:22:11 -0800
Message-ID: <xmqqoac6621o.fsf_-_@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<xmqq37tja50t.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 00:22:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOZPm-0005Qb-DG
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 00:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbcA0XWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 18:22:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932245AbcA0XWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 18:22:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 634EA3F258;
	Wed, 27 Jan 2016 18:22:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s26m8EhMGycT5LY35jCDGZHVcTg=; b=sHAfig
	AJi08541V3qbyQ37bD5+y8td+jNXkb83oQGZNjOTm4mTkY5kEipCUK5H65L7IfYJ
	oyexWZ/r1vOm8+5JHYs46QQovaBLNLwROf5qKURwGST2StkizMJLkZEvXTPjiMUF
	7vJ4LybADYgwuDH9lhBAttCFFNAeuavkWCuEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JgBfLjV+08YcbuJs88nNpJg9mRpxikrZ
	ncwnjX9oQYs1fE8qyeS9lzUeVwNiEJ0nZrD+eCaulJnz3K+PtGyh5jkUOnrDF6nO
	gxIXMUHMtzD8zgsrn9AirafnO3V96H+Rep3ZHUUakLA9MJpBzm25qKSB8mThBUMr
	09e8UbN6dh4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B9B73F257;
	Wed, 27 Jan 2016 18:22:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D3F1A3F255;
	Wed, 27 Jan 2016 18:22:12 -0500 (EST)
In-Reply-To: <xmqq37tja50t.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Tue, 26 Jan 2016 22:52:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CB9B9424-C54C-11E5-99A5-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only code that cares about the value of the global variable
saved_env_before_alias after the previous fix is handle_builtin()
that turns into a glorified no-op when the variable is true, so the
logic could safely be lifted to its caller, i.e. the caller can
refrain from calling it when the variable is set.

This variable tells us if save_env_before_alias() was called (with
or without matching restore_env()), but the sole caller of the
function, handle_alias(), always calls it as the first thing, so we
can consider that the variable essentially keeps track of the fact
that handle_alias() has ever been called.

It turns out that handle_builtin() and handle_alias() are called
only from one function in a way that the value of the variable
matters, which is run_argv(), and it already keeps track of the
fact that it already called handle_alias().

So we can simplify the whole thing by:

- Change handle_builtin() to always make a direct call to the
  builtin implementation it finds, and make sure the caller
  refrains from calling it if handle_alias() has ever been
  called;

- Remove saved_env_before_alias variable, and instead use the
  local "done_alias" variable maintained inside run_argv() to
  make the same decision.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Patches 2 and 3 are with updated log messages; their patch text
   did not change.

 git.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/git.c b/git.c
index e39b972..c8d7b56 100644
--- a/git.c
+++ b/git.c
@@ -25,13 +25,11 @@ static const char *env_names[] = {
 	GIT_PREFIX_ENVIRONMENT
 };
 static char *orig_env[4];
-static int saved_env_before_alias;
 static int save_restore_env_balance;
 
 static void save_env_before_alias(void)
 {
 	int i;
-	saved_env_before_alias = 1;
 
 	assert(save_restore_env_balance == 0);
 	save_restore_env_balance = 1;
@@ -533,16 +531,8 @@ static void handle_builtin(int argc, const char **argv)
 	}
 
 	builtin = get_builtin(cmd);
-	if (builtin) {
-		/*
-		 * XXX: if we can figure out cases where it is _safe_
-		 * to do, we can avoid spawning a new process when
-		 * saved_env_before_alias is true
-		 * (i.e. setup_git_dir* has been run once)
-		 */
-		if (!saved_env_before_alias)
-			exit(run_builtin(builtin, argc, argv));
-	}
+	if (builtin)
+		exit(run_builtin(builtin, argc, argv));
 }
 
 static void execv_dashed_external(const char **argv)
@@ -586,8 +576,17 @@ static int run_argv(int *argcp, const char ***argv)
 	int done_alias = 0;
 
 	while (1) {
-		/* See if it's a builtin */
-		handle_builtin(*argcp, *argv);
+		/*
+		 * If we tried alias and futzed with our environment,
+		 * it no longer is safe to invoke builtins directly in
+		 * general.  We have to spawn them as dashed externals.
+		 *
+		 * NEEDSWORK: if we can figure out cases
+		 * where it is safe to do, we can avoid spawning a new
+		 * process.
+		 */
+		if (!done_alias)
+			handle_builtin(*argcp, *argv);
 
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
@@ -598,9 +597,9 @@ static int run_argv(int *argcp, const char ***argv)
 		 */
 		if (done_alias)
 			break;
+		done_alias = 1;
 		if (!handle_alias(argcp, argv))
 			break;
-		done_alias = 1;
 	}
 
 	return done_alias;
-- 
2.7.0-368-gb6e04f9
