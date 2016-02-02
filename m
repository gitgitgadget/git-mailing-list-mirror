From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] git: simplify environment save/restore logic
Date: Tue, 02 Feb 2016 15:48:55 -0800
Message-ID: <xmqqmvriptaw.fsf_-_@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DzHYpw3TT3i17W-8eiR9J9DOQUO6mkxffUEnGqT1u96Q@mail.gmail.com>
	<xmqqtwlz8c4w.fsf@gitster.mtv.corp.google.com>
	<xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:49:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQkgw-0001qX-Il
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 00:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166AbcBBXs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 18:48:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755157AbcBBXs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 18:48:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6AA03419C7;
	Tue,  2 Feb 2016 18:48:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KFBarSrolRaG77bTpNdgBTZsJRM=; b=eltYnV
	COss8+S/d0KFKZ0hQtk7p9qaJqI02cdqI+MufFY8RF5223puqUJzDqQplswITBlq
	3DHqZUtZySHx9Z79RRoq59n3qm//t5Zzzsd5v7qNboMpzTdXJpW+E3Y8x1iV2ezj
	Tyo9Cel0lMM1c0NTB2EF39/DMEkQ0xFucwfRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cvEJPGvCWQF5LCxKtC/7DQXvQNGzcy5x
	omnx2/R5ZQpXbBqQKbm06hri7RHWngH193n/CWqvHyMrnNez90zdatRfjU+FCHuQ
	PBhomegNy1qO9iOGyogJ5l5XlOE4Va6m2u7kPEwhUM4eDG5fvzCYBDXZbBtk81L4
	YfuMNi0cfog=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F53C419C5;
	Tue,  2 Feb 2016 18:48:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D5875419B7;
	Tue,  2 Feb 2016 18:48:56 -0500 (EST)
In-Reply-To: <xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Wed, 27 Jan 2016 15:18:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86260D60-CA07-11E5-B003-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285318>

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
 git.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/git.c b/git.c
index e39b972..1cbe267 100644
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
-- 
2.7.0-391-gcd29568
