Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009E4C4332F
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 21:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351030AbhLFVW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 16:22:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64782 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346328AbhLFVWr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 16:22:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4482A109B5D;
        Mon,  6 Dec 2021 16:19:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7XoIVeiiJeDS
        dIOEpor4K7Y115CDSNVY0P6dj7bI314=; b=faeAsIUPlKLzuL2mqm4A5clmnsqJ
        nsk3CVRgLIjAZtxh/SrE16VLh3n8IZIn89TMb9vafuji6coAyWmpnUVbWRwx5JbA
        LzafFJwgca0n03vEsCMkCl2Z8CRWk/ouHCSjVBHPRQShDrMZ9fTOe6A+Iof9XwFi
        X9MepxqcLWYxYvU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C323109B5C;
        Mon,  6 Dec 2021 16:19:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9B3D5109B5B;
        Mon,  6 Dec 2021 16:19:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] usage.c + gc: add and use a die_message_errno()
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
        <patch-3.4-8747afecdcd-20211206T165221Z-avarab@gmail.com>
Date:   Mon, 06 Dec 2021 13:19:13 -0800
In-Reply-To: <patch-3.4-8747afecdcd-20211206T165221Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Dec
 2021 17:55:52 +0100")
Message-ID: <xmqqo85te8j2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29D83CD4-56DA-11EC-84E1-C48D900A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change code the "error: " output when we exit with 128 due to gc.log
> errors to use a "fatal: " prefix instead. This adds a sibling function
> to the die_errno() added in a preceding commit.
>
> Since it returns 128 instead of -1 (like die_message()) we'll need to
> adjust report_last_gc_error().
>
> Let's adjust it while we're at it to not conflate the "should skip"
> and "exit with this non-zero code" conditions, as the caller is no
> longer hardcoding "128", but relying on die_errno() to return a
> nen-zero exit() status.
>
> Since we're touching this code let's also use "return ret" in place of
> an "exit(ret)". This is kinder to any cleanup our our "cmd_main()" in
> "git.c" might want to do.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/gc.c      | 21 ++++++++++++---------
>  git-compat-util.h |  1 +
>  usage.c           | 12 ++++++++++++
>  3 files changed, 25 insertions(+), 9 deletions(-)

The structure of the series makes sense here.

1 and 2 were structured to add new set of API functions in 1 and to
make use of them in 2 (which is also OK if done right; as pointed
out, a few changes need to be moved from 2 to 1 to make 1 complete).

This makes further addition and adds its uses at the same time.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index bcef6a4c8da..7b451dfeefc 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -472,19 +472,20 @@ static const char *lock_repo_for_gc(int force, pi=
d_t* ret_pid)
>   * gc should not proceed due to an error in the last run. Prints a
>   * message and returns -1 if an error occurred while reading gc.log
>   */
> -static int report_last_gc_error(void)
> +static int report_last_gc_error(int *skip)
>  {
>  	struct strbuf sb =3D STRBUF_INIT;
>  	int ret =3D 0;
>  	ssize_t len;
>  	struct stat st;
>  	char *gc_log_path =3D git_pathdup("gc.log");
> +	*skip =3D 0;
> =20
>  	if (stat(gc_log_path, &st)) {

Insert a new statement after the blank that separates the
declaration from the statements.

>  		if (errno =3D=3D ENOENT)
>  			goto done;
> =20
> -		ret =3D error_errno(_("cannot stat '%s'"), gc_log_path);
> +		ret =3D die_message_errno(_("cannot stat '%s'"), gc_log_path);
>  		goto done;
>  	}
> =20
> @@ -493,7 +494,7 @@ static int report_last_gc_error(void)
> =20
>  	len =3D strbuf_read_file(&sb, gc_log_path, 0);
>  	if (len < 0)
> -		ret =3D error_errno(_("cannot read '%s'"), gc_log_path);
> +		ret =3D die_message_errno(_("cannot read '%s'"), gc_log_path);
>  	else if (len > 0) {
>  		/*
>  		 * A previous gc failed.  Report the error, and don't
> @@ -507,7 +508,7 @@ static int report_last_gc_error(void)
>  			       "until the file is removed.\n\n"
>  			       "%s"),
>  			    gc_log_path, sb.buf);
> -		ret =3D 1;
> +		*skip =3D 1;
>  	}
>  	strbuf_release(&sb);
>  done:

Nobody called die() in here, so we always returned to the caller.
It feels a bit strange that we need, in addition to the existing
'ret' that becomes the return value, an extra out parameter *skip.

Let's see why the caller needs both.


> @@ -610,13 +611,15 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n")=
);
>  		}
>  		if (detach_auto) {
> -			int ret =3D report_last_gc_error();
> -			if (ret < 0)
> -				/* an I/O error occurred, already reported */
> -				exit(128);
> -			if (ret =3D=3D 1)
> +			int skip;
> +			int ret =3D report_last_gc_error(&skip);
> +
> +			if (skip)
>  				/* Last gc --auto failed. Skip this one. */
>  				return 0;
> +			if (ret)
> +				/* an I/O error occurred, already reported */
> +				return ret;

We used to use the fact that=20

 - negative return was from error_errno() to cuase exit(128) to
   emulate die.

 - return with 1 is from the "previous gc failed" block and declare
   we can safely return 0 (success).

 - return with 0 is sucess and nothing needed to be, and was, done.

So, I still do not see the point of this change to add an extra
error channel.  I do not find this argument

> ... as the caller is no
> longer hardcoding "128", but relying on die_errno() to return a
> nen-zero exit() status.

particularly a convincing one.  We are not obliged to assign the
value returned from die_message_errno() to 'ret' to begin with.
report_last_gc_error() can document what its return values mean
and the caller can react to it.

Indeed, if we assign -1 to 'ret' where we used to call error_errno(),
the caller needs no changes at all, no?

Something like this as a replacement for this part?

 builtin/gc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git c/builtin/gc.c w/builtin/gc.c
index f7270b26ea..2b54465608 100644
--- c/builtin/gc.c
+++ w/builtin/gc.c
@@ -477,47 +477,49 @@ static const char *lock_repo_for_gc(int force, pid_=
t* ret_pid)
 /*
  * Returns 0 if there was no previous error and gc can proceed, 1 if
  * gc should not proceed due to an error in the last run. Prints a
  * message and returns -1 if an error occurred while reading gc.log
  */
 static int report_last_gc_error(void)
 {
 	struct strbuf sb =3D STRBUF_INIT;
-	int ret =3D 0;
+	int ret =3D -1; /* a pessimist */
 	ssize_t len;
 	struct stat st;
 	char *gc_log_path =3D git_pathdup("gc.log");
=20
 	if (stat(gc_log_path, &st)) {
 		if (errno =3D=3D ENOENT)
 			goto done;
=20
-		ret =3D error_errno(_("cannot stat '%s'"), gc_log_path);
+		die_message_errno(_("cannot stat '%s'"), gc_log_path);
 		goto done;
 	}
=20
-	if (st.st_mtime < gc_log_expire_time)
+	if (st.st_mtime < gc_log_expire_time) {
+		ret =3D 0;
 		goto done;
+	}
=20
 	len =3D strbuf_read_file(&sb, gc_log_path, 0);
 	if (len < 0)
-		ret =3D error_errno(_("cannot read '%s'"), gc_log_path);
+		die_message_errno(_("cannot read '%s'"), gc_log_path);
 	else if (len > 0) {
 		/*
 		 * A previous gc failed.  Report the error, and don't
 		 * bother with an automatic gc run since it is likely
 		 * to fail in the same way.
 		 */
 		warning(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
 			       "and remove %s\n"
 			       "Automatic cleanup will not be performed "
 			       "until the file is removed.\n\n"
 			       "%s"),
 			    gc_log_path, sb.buf);
-		ret =3D 1;
+		ret =3D 0;
 	}
 	strbuf_release(&sb);
 done:
 	free(gc_log_path);
 	return ret;
 }
