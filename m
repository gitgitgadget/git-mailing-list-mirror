From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gc: save log from daemonized gc --auto and print it next time
Date: Thu, 26 Mar 2015 10:13:25 -0700
Message-ID: <xmqqlhijznpm.fsf@gitster.dls.corp.google.com>
References: <1427199448-28278-1-git-send-email-pclouds@gmail.com>
	<1427367263-16004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 18:13:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbBLd-0002TJ-GZ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 18:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbbCZRNc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2015 13:13:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751615AbbCZRN3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2015 13:13:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 11B4342CE5;
	Thu, 26 Mar 2015 13:13:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Y31wNEtz5uvI
	U0z9HO9s6MxDQZ8=; b=qCkH1c/VFC+mzyM4hTMI0NUxq4hz7foAAO5WVhokbmoQ
	aukLsvIrUehHm4mNI50HZpYf/TGRZef1N7UCDhvVfFtZ6HLWUwMcb7Y7rWWG15cm
	CJKQlvB5qLmFB0lI+J09WpGDARROpAIZOngx/klV7VTLu2gOSMU2vefkWFf6r4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MDETrq
	Zmvjwqm0bWurZ37xAMAVRO2HIprCxG7F6m8rT1F+zMIL3VLAWhjUbMxMfxp3wa9g
	hhmKQq4gZwAfGdHkMXFn8+ssKV8YEH2KhAH4euo7o8xaZZPhAZBFEm8ngClmu6Ll
	ZXHgpDaqpIW6EQpqQh+yssqnhItg5/zKUe05c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0398742CE4;
	Thu, 26 Mar 2015 13:13:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 572AD42CE3;
	Thu, 26 Mar 2015 13:13:27 -0400 (EDT)
In-Reply-To: <1427367263-16004-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 26
 Mar 2015 17:54:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6AF4EDA4-D3DB-11E4-B57C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266338>

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
> Besides reverting 9f673f9 and looking at the problem from another
> angle, we could save the stderr in $GIT_DIR/gc.log. Next time, 'gc
> --auto' will print the saved warnings, delete gc.log and exit.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  The test is dropped. It does not feel good enough.. The rest of
>  changes is minor

I still wonder what this buys us if multiple auto-gc's are triggered,
because the user is running a long svn import or something similar.

I cannot tell what problem this is trying to solve.

 (1) If the error output from the previous "gc --auto" indicates a
     grave error condition that further re-running of "gc --auto" is
     pointless, why is it a good idea to blindly remove the log and
     "let the next one run as usual"?

 (2) If the problem it is trying to solve is that "gc --auto"
     sometimes gives a good suggestion but that is lost when
     daemonized, why not address that problem in a more direct way,
     e.g. introduce a new option "gc --probe-auto" that only checks
     and reports if "gc --auto" would spend actual cycles to do its
     work, and then run the daemonized version of "gc --auto" when
     necessary?  Either "gc --probe-auto" itself or the caller of
     "gc --probe-auto" can give the "you should do this to avoid
     repeated auto-gc" when this happens.

     Also the same issue I have with (1) above applies; I do not see
     much linkage with solving this issue with halving the frequency
     of running "gc --auto" which is what this patch does.

In other words, I would understand what the change is trying to
achieve if it were to always stop, instruct the user to take
corrective action, and never remove the .log file itself (naturally,
the corrective action would include "remove the .log when you are
done").  I do not necessarily agree that it would be a good change
for the overall system, but at least such a change is internally
consistent between its perception of a problem and its approach to
solve it.

I would also understand, and I suspect I would prefer it if I see
the result, if the change were to allow "gc --auto" to report
severity of its findings (i.e. "nothing wrong in your repository but
you should do X to avoid triggering me too often" vs "no point
running me again and again"), do something similar to what this
patch does and after showing the message and (1) stop without
removing the log but give instruction when the situation is grave,
or (2) show the message, remove the .log, and continue to go ahead
with "gc --auto" when the situation is *not* grave.

But the approach taken by this patch looks very confused about its
own purpose to me and I cannot quite tell what it is trying to
solve.

>   diff --git a/builtin/gc.c b/builtin/gc.c
>   index 07769a9..3886937 100644
>   --- a/builtin/gc.c
>   +++ b/builtin/gc.c
>   @@ -32,8 +32,6 @@ static int aggressive_window =3D 250;
>    static int gc_auto_threshold =3D 6700;
>    static int gc_auto_pack_limit =3D 50;
>    static int detach_auto =3D 1;
>   -static struct strbuf log_filename =3D STRBUF_INIT;
>   -static int daemonized;
>    static const char *prune_expire =3D "2.weeks.ago";
>   =20
>    static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
>   @@ -43,6 +41,8 @@ static struct argv_array prune =3D ARGV_ARRAY_INI=
T;
>    static struct argv_array rerere =3D ARGV_ARRAY_INIT;
>   =20
>    static char *pidfile;
>   +static struct strbuf log_filename =3D STRBUF_INIT;
>   +static int daemonized;
>   =20
>    static void remove_pidfile(void)
>    {
>   @@ -338,7 +338,7 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
>    			struct strbuf sb =3D STRBUF_INIT;
>   =20
>    			if (strbuf_read_file(&sb, git_path("gc.log"), 0) > 0) {
>   -				warning(_("Last gc run reported the following, gc skipped"));
>   +				warning(_("skipping gc; last gc reported:"));
>    				fputs(sb.buf, stderr);
>    				strbuf_release(&sb);
>    				/* let the next gc --auto run as usual */
>   @@ -352,8 +352,7 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
>    			 * failure to daemonize is ok, we'll continue
>    			 * in foreground
>    			 */
>   -			if (!daemonize())
>   -				daemonized =3D 1;
>   +			daemonized =3D !daemonize();
>    		}
>    	} else
>    		add_repack_all_option();
>
>  builtin/gc.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 5c634af..3886937 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -41,9 +41,20 @@ static struct argv_array prune =3D ARGV_ARRAY_INIT=
;
>  static struct argv_array rerere =3D ARGV_ARRAY_INIT;
> =20
>  static char *pidfile;
> +static struct strbuf log_filename =3D STRBUF_INIT;
> +static int daemonized;
> =20
>  static void remove_pidfile(void)
>  {
> +	if (daemonized && log_filename.len) {
> +		struct stat st;
> +
> +		close(2);
> +		if (stat(log_filename.buf, &st) ||
> +		    !st.st_size ||
> +		    rename(log_filename.buf, git_path("gc.log")))
> +			unlink(log_filename.buf);
> +	}
>  	if (pidfile)
>  		unlink(pidfile);
>  }
> @@ -324,13 +335,24 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n=
"));
>  		}
>  		if (detach_auto) {
> +			struct strbuf sb =3D STRBUF_INIT;
> +
> +			if (strbuf_read_file(&sb, git_path("gc.log"), 0) > 0) {
> +				warning(_("skipping gc; last gc reported:"));
> +				fputs(sb.buf, stderr);
> +				strbuf_release(&sb);
> +				/* let the next gc --auto run as usual */
> +				unlink(git_path("gc.log"));
> +				return 0;
> +			}
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
> @@ -343,6 +365,18 @@ int cmd_gc(int argc, const char **argv, const ch=
ar *prefix)
>  		    name, (uintmax_t)pid);
>  	}
> =20
> +	if (daemonized) {
> +		int fd;
> +
> +		strbuf_addstr(&log_filename, git_path("gc.log_XXXXXX"));
> +		fd =3D xmkstemp(log_filename.buf);
> +		if (fd >=3D 0) {
> +			dup2(fd, 2);
> +			close(fd);
> +		} else
> +			strbuf_release(&log_filename);
> +	}
> +
>  	if (gc_before_repack())
>  		return -1;
