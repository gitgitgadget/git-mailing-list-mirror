From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: fix help.autocorrect after 57ea712 breaks it
Date: Tue, 26 Jan 2016 12:11:13 -0800
Message-ID: <xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 21:11:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO9xR-00033n-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 21:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbcAZULT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 15:11:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750925AbcAZULQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2016 15:11:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEB5E3F29D;
	Tue, 26 Jan 2016 15:11:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hJeNDAGEeedJ
	GoJ/TufeT5GgQvU=; b=Zolb7HMQsmY6h0CUfbP0K0Mfq3LEQVJ1p03b1e+U/Pbz
	WQx6Pl+J0W3U7vX2V6sfRqzzW+TIwkGBDtz/UXaH+9FUeCVuXhm0I1mF6iuF1Neb
	GY0UXrJ1Szq5Tu1syiswixkrKqfnUGB+zTtX+ViyjGvAGFAq4vahdSJqMGmW9lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wuRl6u
	QLSxDsSrTiB4Xvbq3wlcMFWPJAfQH5Tc3F/fy4nf1NpQlkdUsXFBw7Ph83dcZkA0
	2qUO3VULBuq8Ae13wbMR7gqNYmzuCkkCbSKOifawVLvSgC81wp7/8TOgAzw3cbvk
	tQss/WOetz6QBJbHMMKvipLgCeZ0AkDG+V6eU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5F9E3F29C;
	Tue, 26 Jan 2016 15:11:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 24AA43F298;
	Tue, 26 Jan 2016 15:11:15 -0500 (EST)
In-Reply-To: <1453814801-1925-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 26
 Jan 2016 20:26:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3DD20C2-C468-11E5-9834-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284851>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Commit 57ea712 (git.c: make sure we do not leak GIT_* to alias script=
s -
> 2015-12-20) does not realize that handle_alias() can be called multip=
le
> times because of the forever loop in run_argv(). The commit breaks al=
ias
> chains.
>
> Suppose you have an alias "abc" that resolves to another alias "def",
> which finally resolve to "git status". handle_alias() is called twice=
=2E
> save_env() and restore_env() are also called twice. But because of th=
e
> check save_env_before_alias in save_env(), we save once while trying =
to
> restore twice. Consequences are left for the reader's imagination.
>
> Fortunately, you cannot make an alias of another alias. At least not
> yet. Unfortunately it can still happen with help.autocorrect, where y=
our
> alias typo is treated as the first "alias", and it can be resolved to
> the second alias. Then boom.
>
> Make sure we call save_env() and restore_env() in pairs. While at the=
re,
> set orig_cwd to NULL after freeing it for hygiene.
>
> Reported-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

I spoke too soon, I am afraid.

The log message talks about "we save once while trying to restore
twice" being bad, and the fix is to make sure we save and restore in
pairs.  Before or after the patch, however, there is no change in
the callers of save_env_before_alias() and restore_env(), and it is
unclear how that is ensured.

It turns out that the callers are doing the right thing (assuming
that calling save and restore in pairs is the right solution), and
the culprit is in the save_env_before_alias() function that returns
without saving when we were called.  That is mentioned in the log,
but the description of last paragraph leaves the impression that it
was callers that needed fixing, which is misleading.

After the patch, we have "saved" and "saved_env_before_alias".

 - The former is a protection against committing similar programming
   errors in the future (i.e. glorified assert()).  Can we have it
   in a separate commit, perhaps on top of the real fix, to make the
   change for the real fix easier to understand?

 - Do we still need the latter?  saved_env_before_alias is set to 1
   if we called save_env_before_alias() even once, which happens
   always (and only) at the beginning of handle_alias(), so that is
   equivalent to saying "have we ever called handle_alias()?"

   And there is only one caller of handle_alias, in run_argv(), and
   it maintains yet another variable "done_alias" to keep track of
   the same information.

   The only code that cares about saved_env_before_alias is
   handle_builtin(), but it is a glorified no-op if
   saved_env_before_alias() is set.  And the only caller of this
   handle_builtin(), for which saved_env_before_alias matters, is
   the same run_argv().

I wonder if this would be better done as a multi-part series that
goes like this:

 [1/3] git: remove an early return from save_env_before_alias()

       whose description would be the first two paragraphs of your
       patch, with two line removal, i.e.

        diff --git a/git.c b/git.c
        index 98d4412..a57a4cb 100644
        --- a/git.c
        +++ b/git.c
        @@ -30,8 +30,6 @@ static int saved_env_before_alias;
         static void save_env_before_alias(void)
         {
                int i;
        -	if (saved_env_before_alias)
        -		return;
                saved_env_before_alias =3D 1;
                orig_cwd =3D xgetcwd();
                for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {

       that should be a sufficient "fix" to the issue.

 [2/3] git: protect against unbalanced calls to {save,restore}_env()

       We made sure that save_env_before_alias() does not skip
       saving the environment when asked to (which led to double
       free of orig_cwd in restore_env()) with the previous step.
       Protect against future breakage where somebody adds new
       callers of these functions in an unbalanced fashion.
      =20
        diff --git a/git.c b/git.c
        index a57a4cb..e39b972 100644
        --- a/git.c
        +++ b/git.c
        @@ -26,11 +26,15 @@ static const char *env_names[] =3D {
         };
         static char *orig_env[4];
         static int saved_env_before_alias;
        +static int save_restore_env_balance;

         static void save_env_before_alias(void)
         {
                int i;
                saved_env_before_alias =3D 1;
        +
        +	assert(save_restore_env_balance =3D=3D 0);
        +	save_restore_env_balance =3D 1;
                orig_cwd =3D xgetcwd();
                for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
                        orig_env[i] =3D getenv(env_names[i]);
        @@ -42,6 +46,9 @@ static void save_env_before_alias(void)
         static void restore_env(int external_alias)
         {
                int i;
        +
        +	assert(save_restore_env_balance =3D=3D 1);
        +	save_restore_env_balance =3D 0;
                if (!external_alias && orig_cwd && chdir(orig_cwd))
                        die_errno("could not move to %s", orig_cwd);
                free(orig_cwd);

 [3/3] git: simplify environment save/restore logic

       The only code that cares about the value of the global
       variable saved_env_before_alias after the previous fix is
       handle_builtin() that turns into a glorified no-op when the
       variable is true, so the logic could safely be lifted to its
       caller, i.e. the caller can refrain from calling it when the
       variable is set.

       This variable tells us if save_env_before_alias() was called
       (with or without matching restore_env()), but the sole caller
       of the function, handle_alias(), always calls it the first as
       thing, so it essentially keeps track of the fact that
       handle_alias() has ever been called.

       It turns out that handle_builtin() and handle_alias() are
       called only from one function in a way that the value of the
       variable matters, which is run_argv(), and it already keeps
       track of the fact that it called handle_alias().

       So we can simplify the whole thing by:

       - Change handle_builtin() to always make a direct call to the
         builtin implementation it finds, and make sure the caller
         refrains from calling it if handle_alias() has ever been
         called;

       - Remove saved_env_before_alias variable, and instead use the
         local "done_alias" variable maintained inside run_argv() to
         make the above decision.

 [4/3] git: plug leaks of saved environments

       I think orig_env[] members if save_env() is called twice are
       leaked, so they would need to be free'd just like orig_cwd is
       freed in restore_env().  Optionally, you can assign NULL to
       them and also to orig_cwd after freeing.



The patch text for [3/3] would look like this.

 git.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/git.c b/git.c
index e39b972..c8d7b56 100644
--- a/git.c
+++ b/git.c
@@ -25,13 +25,11 @@ static const char *env_names[] =3D {
 	GIT_PREFIX_ENVIRONMENT
 };
 static char *orig_env[4];
-static int saved_env_before_alias;
 static int save_restore_env_balance;
=20
 static void save_env_before_alias(void)
 {
 	int i;
-	saved_env_before_alias =3D 1;
=20
 	assert(save_restore_env_balance =3D=3D 0);
 	save_restore_env_balance =3D 1;
@@ -533,16 +531,8 @@ static void handle_builtin(int argc, const char **=
argv)
 	}
=20
 	builtin =3D get_builtin(cmd);
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
=20
 static void execv_dashed_external(const char **argv)
@@ -586,8 +576,17 @@ static int run_argv(int *argcp, const char ***argv=
)
 	int done_alias =3D 0;
=20
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
=20
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
@@ -598,9 +597,9 @@ static int run_argv(int *argcp, const char ***argv)
 		 */
 		if (done_alias)
 			break;
+		done_alias =3D 1;
 		if (!handle_alias(argcp, argv))
 			break;
-		done_alias =3D 1;
 	}
=20
 	return done_alias;
