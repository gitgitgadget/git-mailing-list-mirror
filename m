From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git: simplify environment save/restore logic
Date: Tue, 26 Jan 2016 22:52:02 -0800
Message-ID: <xmqq37tja50t.fsf_-_@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 07:52:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOJxa-0002Vl-Cu
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 07:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbcA0GwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 01:52:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753647AbcA0GwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 01:52:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A4397324AF;
	Wed, 27 Jan 2016 01:52:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QnxyrRg02m8fR+gIEHxEm2Xhnb4=; b=xR4A1h
	L0iBEzHJJCL0jv70X4kPXRmZDdr/0GZEP7gXdCJUuKc3TT9r31d1BUcXi2mAiJpv
	t8pIahn4uqG+Fyxc2YePE9Q0t1uTNNZyq/pW9ibd+AckXFOFiLcTTVt8wJ96mmWd
	Rukce8f3NLIH5BzI0dx7Hs3DYXLAz+o+8tbrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AFoq8CQmXsTS98EfB0Vgs75FbEXIKBbB
	WlYew1eTeYTn0dUEyiaEmEGVA7KO7PKD87ttqcw5Bs0vQzi1eqmH/pb6VT/BtlLp
	hol8AQ807kpsnEx8NH0Sy+Bu8g80WNrrqmQ726y+w4DOurAWvAny3Yk6y5PvQtiN
	hJZEV2vzlqc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9AC8C324AD;
	Wed, 27 Jan 2016 01:52:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 13B79324AB;
	Wed, 27 Jan 2016 01:52:04 -0500 (EST)
In-Reply-To: <xmqqbn87a54v.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 26 Jan 2016 22:49:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 793663A6-C4C2-11E5-BAEB-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284874>

The only code that cares about the value of the global variable
saved_env_before_alias after the previous fix is handle_builtin()
that turns into a glorified no-op when the variable is true, so the
logic could safely be lifted to its caller, i.e. the caller can
refrain from calling it when the variable is set.

This variable tells us if save_env_before_alias() was called (with
or without matching restore_env()), but the sole caller of the
function, handle_alias(), always calls it the first as thing, so it
essentially keeps track of the fact that handle_alias() has ever
been called.

It turns out that handle_builtin() and handle_alias() are called
only from one function in a way that the value of the variable
matters, which is run_argv(), and it already keeps track of the fact
that it called handle_alias().

So we can simplify the whole thing by:

- Change handle_builtin() to always make a direct call to the
  builtin implementation it finds, and make sure the caller
  refrains from calling it if handle_alias() has ever been
  called;

- Remove saved_env_before_alias variable, and instead use the
  local "done_alias" variable maintained inside run_argv() to
  make the above decision.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I do not mean to say that it is unnecessary to plug the leak,
   which should be the fourth patch in this three-patch series, but
   it should rather be obvious to implement, so I omitted from this
   series, which is primarily meant to be "how about doing it this
   way" illustration.

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
2.7.0-368-g4610598
