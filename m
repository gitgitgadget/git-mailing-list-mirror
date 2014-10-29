From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-imap-send: use libcurl for implementation
Date: Wed, 29 Oct 2014 13:56:14 -0700
Message-ID: <xmqqzjcewq6p.fsf@gitster.dls.corp.google.com>
References: <53FD0CD1.7030801@raz.or.at>
	<xmqqoav5etnb.fsf@gitster.dls.corp.google.com>
	<545134D5.3030308@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, 434599@bugs.debian.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Tony Finch <dot@dotat.at>, Tanay Abhra <tanayabh@gmail.com>,
	Dan Albert <danalbert@google.com>,
	Jeremy Huddleston <jeremyhu@apple.com>,
	David Aguilar <davvid@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Oswald Buddenhagen <ossi@kde.org>
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Wed Oct 29 21:58:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjaJj-0000Kr-AA
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 21:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974AbaJ2U6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 16:58:03 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755671AbaJ2U6C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 16:58:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5803B19960;
	Wed, 29 Oct 2014 16:58:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j/0a13sMdvHYyCKuAwvZXZDyvEw=; b=Sd9yG4
	7LkAtdJbtkrQIAusuvf0EJKFv44Q46fTLaJ34BjahjYIuI0RkQ8mqCaHkSqMZkrO
	vldJlBHKhClz51nWeGM0Upx/BpJXd+uFKs5XM9JD7jW7+YnNHsmAD2/Mdn6VEAPv
	iEm0TuHyPMoTo3OZfiKVlI7q0shnPL40oWnWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jUQ2ei3Kxs/0FU8FTJN7OdHBdKFG9Z6m
	L7Sels4UajMNx/gx/CKHQmv7URe/fBY957qtm23jBbFHFQR84F8ViVleBcTJuVIv
	i8/NRdiN6XNHejzq8RIt4L3qF+ZL/yNxRRfm7YU0U/8897d+XYw0a0Yl+2OZiVTY
	4/GZAZx8ySs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3770B1995F;
	Wed, 29 Oct 2014 16:58:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DCDA19907;
	Wed, 29 Oct 2014 16:56:16 -0400 (EDT)
In-Reply-To: <545134D5.3030308@raz.or.at> (Bernhard Reiter's message of "Wed,
	29 Oct 2014 19:41:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 067805A6-5FAE-11E4-ABBC-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bernhard Reiter <ockham@raz.or.at> writes:

> Resending this once more, as indicated by <xmqqbnp4hu8g.fsf@gitster.dls.corp.google.com>
> Hope my formatting and posting style is now conformant. Sorry for the noise.

Thanks.

The patch does not apply for me (please send a trial message to
yourself and then try to apply it out of your mailbox to avoid such
an incident in the future), unfortunately.  I'll comment on the
patch from just code inspection without applying it, though.

> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
> index 7d991d9..1c24e1f 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -9,7 +9,7 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
>  SYNOPSIS
>  --------
>  [verse]
> -'git imap-send'
> +'git imap-send' [-v] [-q] --[no-]curl
>    DESCRIPTION
> @@ ...

The hunk header says that the original and the updated both starts
at line #9 and they both should have 7 lines, but I count only 5
lines.  Where did you lose two lines of the post-context?

> diff --git a/Makefile b/Makefile
> index f34a2d4..69b2fbf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -992,6 +992,9 @@ ifdef HAVE_ALLOCA_H
>  	BASIC_CFLAGS += -DHAVE_ALLOCA_H
>  endif
>  +IMAP_SEND_BUILDDEPS =
> +IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
> +

Here the patch looks funny as well.  I guess "IMAP_SEND_BUILDDEPS ="
is an added line prefixed with "+", but where does the SP before the
plus sign come from?

I won't point out other patch breakages in the remainder of this
message.

> diff --git a/imap-send.c b/imap-send.c
> index 70bcc7a..9cc80ae 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -26,11 +26,31 @@
>  #include "credential.h"
>  #include "exec_cmd.h"
>  #include "run-command.h"
> +#include "parse-options.h"
>  #ifdef NO_OPENSSL
>  typedef void *SSL;
>  #endif
> +#ifdef USE_CURL_FOR_IMAP_SEND
> +#include "http.h"
> +#endif
>  -static const char imap_send_usage[] = "git imap-send < <mbox>";
> +static int Verbose, Quiet;

Yikes.  I know this is not a new problem, but please do not name
variables Capitalized.  Also what would it mean to set both Verbose
and Quiet at the same time?

I think we would want to use OPT__VERBOSITY with a single variable
"verbosity" (see hits from "git grep OPT__VERBOSITY" for examples).
Such a change should probably come before this change to use libcurl
as a separate preparatory clean-up patch.

> +#ifdef USE_CURL_FOR_IMAP_SEND
> +static int use_curl = 1; // on by default; set later by parse_options
> +#else
> +static int use_curl = 0; // not available
> +#endif

Please don't use // comments.  Besides, I think this should be
initialized to -1 to mean "unspecified by the user" in both cases
(i.e. no need for #ifdef/#endif).

> +static struct option imap_send_options[] = {
> +#ifdef USE_CURL_FOR_IMAP_SEND
> +	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
> +#endif

And lose the ifdef here (i.e. take "--use-curl" even on a build that
does not support it).

> +int main(int argc, char **argv)
> +{
> +	struct strbuf all_msgs = STRBUF_INIT;
> +	int total;
>  	int nongit_ok;
>   	git_extract_argv0_path(argv[0]);
>  -	git_setup_gettext();
> +	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
>  -	if (argc != 1)
> -		usage(imap_send_usage);
> +	git_setup_gettext();
>   	setup_git_directory_gently(&nongit_ok);
>  	git_imap_config();

Usually we read config and then parse options, so that people can
set configuration variables for their usual use pattern and override
what is configured from the command line option as needed.

For example, you may want to add

	[imap]
        	useCurl = true

in the configuration file and run "git imap-send" without "--curl"
option on the command line almost always, but in some specific
occasion, "git imap-send --no-curl" to countermand the
configuration.

Was there a specific reason why you had to add parse_options()
before git_imap_config()?

With "use_curl" initialized to "-1 (unspecified)", the final code
structure may look more like this:

		...
                git_imap_config();
                parse_options();

        #ifndef USE_CURL_FOR_IMAP_SEND
                if (use_curl < 0)
                        use_curl = 0;
                if (use_curl) {
                        warning("--use-curl not supported in this build");
                        use_curl = 0;
                }
        #else
                if (use_curl < 0) /* default to enable libcurl */
                        use_curl = 1;
        #endif        

although I think it is also OK to make this feature strictly optional
by defaulting to "use_curl = 0" in the #else part above.  Initializing
the static variable to 0 would make the result even shorter if we
were to go that route, i.e.

	static int use_curl; /* strictly opt in */
        ...
	main()
        {
		...
		git_imap_config();
	        parse_options();
	#ifndef USE_CURL_FOR_IMAP_SEND
        	if (use_curl) {
			warning(...);
			use_curl = 0;
		}
	#endif
