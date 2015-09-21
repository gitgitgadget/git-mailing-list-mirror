From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] gc: save log from daemonized gc --auto and print it next time
Date: Mon, 21 Sep 2015 09:43:15 -0700
Message-ID: <xmqqtwqnbu58.fsf@gitster.mtv.corp.google.com>
References: <1442108202-25746-1-git-send-email-pclouds@gmail.com>
	<1442639603-25568-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 18:43:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze4BX-0005QD-DH
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 18:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbbIUQnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 12:43:18 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34600 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383AbbIUQnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 12:43:17 -0400
Received: by padhy16 with SMTP id hy16so121000291pad.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=vj8hQsPWbfhi+8nCMMw3F0LFetIITz/PlyojQnWmoIg=;
        b=h0lDwubwDz0gamJBfqunEKxT/wqA1BKn7MY/K9rbV6e+HRqVWZ5UpT+8TixB/iGchS
         VpCOquhbR42AnH7wNu25df1R3XbHYccrqFcBtcG6VkqZtnrgcvdeaVeHM8gd5q58yTRK
         sY2lixd15QA7ith2tJjMyCiO1AcdarQ/jAe4jitEMIwo27ZS7EB1HnvbNhHqM/UAX3lN
         2QfJATIiVt5OCEponfbqTwFBaOoT5CHlrQW0SicT2qZbL/IeQXt8DuDaHsiEcPucNvfC
         nVmQE/55vl9zcZgoxgDsmXlVURJJ8bxVMQvoSDIOGzvo/oecv2p4VTnxZkPRMXVe3Z34
         0JHw==
X-Received: by 10.68.68.233 with SMTP id z9mr25760618pbt.132.1442853796551;
        Mon, 21 Sep 2015 09:43:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id a17sm25429366pbu.55.2015.09.21.09.43.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 09:43:15 -0700 (PDT)
In-Reply-To: <1442639603-25568-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 19
 Sep 2015 12:13:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278307>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> While commit 9f673f9 (gc: config option for running --auto in
> background - 2014-02-08) helps reduce some complaints about 'gc
> --auto' hogging the terminal, it creates another set of problems.
>
> The latest in this set is, as the result of daemonizing, stderr is
> closed and all warnings are lost. This warning at the end of cmd_gc()
> is particularly important because it tells the user how to avoid "gc
> --auto" running repeatedly. Because stderr is closed, the user does
> not know, naturally they complain about 'gc --auto' wasting CPU.
>
> Daemonized gc now saves stderr to $GIT_DIR/gc.log. Following gc --aut=
o
> will not run and gc.log printed out until the user removes gc.log.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  This is the lock-based version. I'm sending an alternative that does
>  not need atexit() with comparison between the two.

I think Michael deserves to be CC'ed.

I am wondering if we need an audit of what our signal handlers do in
the same light as what led to 507d7804 (pager: don't use unsafe
functions in signal handlers, 2015-09-04).  lockfile API already
does removal in remove_lock_files_on_signal(), which may or may not
need further fixing.  And that is why I really hate to see us adding
custom signal handler if we can avoid it.

What you are gaining by having a custom signal handler here is
twofold, I think:

 * You have a chance to remove an empty log message upon signal, but
   if you follow Michael's idea of equating an empty and missing log
   file, that would not be a huge plus either way.

 * You can keep a non-empty log message that may be incomplete when
   you are killed yourself.  If you reused the lockfile API and let
   its signal handler clean it up, you obviously will lose that, but
   you do not even know if that incomplete non-empty log message is
   something you want to base the "stop auto-gc until an existing
   problem is resolved" decision on.  Your subprocess may have left
   that message only because you are getting killed, no?

Neither looks like a compelling enough reason to have it to me.

Wouldn't the logic be vastly simplified and be still correct, if you
let the lockfile API do its usual "unless you explicitly commit,
lockfiles are removed upon signal or exit"?

>  builtin/gc.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index bcc75d9..4e738fa 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -43,6 +43,7 @@ static struct argv_array prune_worktrees =3D ARGV_A=
RRAY_INIT;
>  static struct argv_array rerere =3D ARGV_ARRAY_INIT;
> =20
>  static char *pidfile;
> +static struct lock_file log_lock;
> =20
>  static void remove_pidfile(void)
>  {
> @@ -57,6 +58,28 @@ static void remove_pidfile_on_signal(int signo)
>  	raise(signo);
>  }
> =20
> +static void process_log_file(void)
> +{
> +	struct stat st;
> +	if (!fstat(log_lock.fd, &st) && st.st_size)
> +		commit_lock_file(&log_lock);
> +	else
> +		rollback_lock_file(&log_lock);
> +}
> +
> +static void process_log_file_at_exit(void)
> +{
> +	fflush(stderr);
> +	process_log_file();
> +}
> +
> +static void process_log_file_on_signal(int signo)
> +{
> +	process_log_file();
> +	sigchain_pop(signo);
> +	raise(signo);
> +}
> +
>  static void git_config_date_string(const char *key, const char **out=
put)
>  {
>  	if (git_config_get_string_const(key, output))
> @@ -253,6 +276,24 @@ static const char *lock_repo_for_gc(int force, p=
id_t* ret_pid)
>  	return NULL;
>  }
> =20
> +static int report_last_gc_error(void)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	int ret;
> +
> +	ret =3D strbuf_read_file(&sb, git_path("gc.log"), 0);
> +	if (ret > 0)
> +		return error(_("The last gc run reported the following. "
> +			       "Please correct the root cause\n"
> +			       "and remove %s.\n"
> +			       "Automatic cleanup will not be performed "
> +			       "until the file is removed.\n\n"
> +			       "%s"),
> +			     git_path("gc.log"), sb.buf);
> +	strbuf_release(&sb);
> +	return 0;
> +}
> +
>  static int gc_before_repack(void)
>  {
>  	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD)=
)
> @@ -274,6 +315,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
>  	int force =3D 0;
>  	const char *name;
>  	pid_t pid;
> +	int daemonized =3D 0;
> =20
>  	struct option builtin_gc_options[] =3D {
>  		OPT__QUIET(&quiet, N_("suppress progress reporting")),
> @@ -330,13 +372,16 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n=
"));
>  		}
>  		if (detach_auto) {
> +			if (report_last_gc_error())
> +				return -1;
> +
>  			if (gc_before_repack())
>  				return -1;
>  			/*
>  			 * failure to daemonize is ok, we'll continue
>  			 * in foreground
>  			 */
> -			daemonize();
> +			daemonized =3D !daemonize();
>  		}
>  	} else
>  		add_repack_all_option();
> @@ -349,6 +394,15 @@ int cmd_gc(int argc, const char **argv, const ch=
ar *prefix)
>  		    name, (uintmax_t)pid);
>  	}
> =20
> +	if (daemonized) {
> +		hold_lock_file_for_update(&log_lock,
> +					  git_path("gc.log"),
> +					  LOCK_DIE_ON_ERROR);
> +		dup2(log_lock.fd, 2);
> +		sigchain_push_common(process_log_file_on_signal);
> +		atexit(process_log_file_at_exit);
> +	}
> +
>  	if (gc_before_repack())
>  		return -1;
