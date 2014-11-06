From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send: use libcurl for implementation
Date: Thu, 06 Nov 2014 10:25:09 -0800
Message-ID: <xmqqzjc4gpa2.fsf@gitster.dls.corp.google.com>
References: <545B5D5D.5040904@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Thu Nov 06 19:25:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmRkK-0002uJ-L7
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 19:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbaKFSZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2014 13:25:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751069AbaKFSZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 13:25:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5B771B82C;
	Thu,  6 Nov 2014 13:25:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+hqwTvswfe8qVIb10IudjPbC/Ns=; b=A+fzNx
	mhv7jCFBdsI4Lk/GwjwNaEaZvWYzZYJau0f+NnuydjEgI4UfT8MssQiym55MVmR/
	gEe8IiMZOjM+1gIDX3MCKWQx4HDdLUt8TkRE52EmEFvqAeoMgNRwJAkZFUMYlgwf
	rUVWpy9gszS2bWeGtpEsLPqsMJ5fEX5h+ARDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wg9qTUyb8rbRmr7QImlYFEKxe6BhgIlB
	ubmtuZq0D8schTh7gHUJEF4DbMiUI6coEr/XHcMypsjNZwbzZ1F6uMVdBLSgvSLU
	3nDK3Jr8uBZ4zA9e4kdZD4I5s2rzCqDq770r2c1kxwAJ7u2/5Va0H+MMVH0cbN1H
	Rkk5mBw3xk0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC83D1B829;
	Thu,  6 Nov 2014 13:25:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 294D51B80A;
	Thu,  6 Nov 2014 13:25:11 -0500 (EST)
In-Reply-To: <545B5D5D.5040904@raz.or.at> (Bernhard Reiter's message of "Thu,
	06 Nov 2014 12:37:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3E653DC8-65E2-11E4-8420-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bernhard Reiter <ockham@raz.or.at> writes:

> @@ -25,7 +25,6 @@ Typical usage is something like:
>  
>  git format-patch --signoff --stdout --attach origin | git imap-send
>  
> -
>  OPTIONS

Why?

> @@ -37,6 +36,17 @@ OPTIONS
>  --quiet::
>  	Be quiet.
>  
> +--curl::
> +	Use libcurl to communicate with the IMAP server, unless tunneling
> +	into it.  Only available if git was built with the
> +	USE_CURL_FOR_IMAP_SEND option set, in which case this is the
> +	default behavior.
> +
> +--no-curl::
> +	Talk to the IMAP server using git's own IMAP routines instead of
> +	using libcurl.  Only available git was built with the
> +	USE_CURL_FOR_IMAP_SEND option set; implicitly assumed otherwise.
> +

I think we tend to spell "Git" not "git" when we refer to the
software suite as a whole.

More importantly, the description on these two items are no longer
in line with the implementation, aren't they?  We accept these
options but warn and a build without libcurl ignores --curl with a
warning, and --curl is not default in any build.

> @@ -87,7 +97,9 @@ imap.preformattedHTML::
>  
>  imap.authMethod::
>  	Specify authenticate method for authentication with IMAP server.
> -	Current supported method is 'CRAM-MD5' only. If this is not set
> +	If git was built with the NO_CURL option, or if your curl version is
> +	< 7.34.0, or if you're running git-imap-send with the --no-curl

s/< /older than /;

Also quote --no-curl inside bq-pair, i.e. `--no-curl`, as that is
something the user will type as-is.

> +	option, the only supported method is 'CRAM-MD5'. If this is not set
>  	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
>  
>  Examples
> diff --git a/INSTALL b/INSTALL
> index 6ec7a24..ffb071e 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -108,18 +108,21 @@ Issues of note:
>  	  so you might need to install additional packages other than Perl
>  	  itself, e.g. Time::HiRes.
>  
> -	- "openssl" library is used by git-imap-send to use IMAP over SSL.
> -	  If you don't need it, use NO_OPENSSL.
> +	- git-imap-send needs the OpenSSL library to talk IMAP over SSL if
> +	  you are using libcurl older than 7.34.0.  Otherwise you can use
> +	  NO_OPENSSL without losing git-imap-send.

OK.

> +	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
> +	  the curl version >= 7.34.0, for git-imap-send.  You might also
> +	  want the "curl" executable for debugging purposes. If you do not
> +	  use http:// or https:// repositories, and do not want to put
> +	  patches into an IMAP mailbox, you do not have to have them
> +	  (use NO_CURL).

OK.

> diff --git a/imap-send.c b/imap-send.c
> index 7f9d30e..01ce175 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -30,13 +30,18 @@
>  #ifdef NO_OPENSSL
>  typedef void *SSL;
>  #endif
> +#ifdef USE_CURL_FOR_IMAP_SEND
> +#include "http.h"
> +#endif
>  
>  static int verbosity;
> +static int use_curl; /* strictly opt in */
>  
> -static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] < <mbox>", NULL };
> +static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
>  
>  static struct option imap_send_options[] = {
>  	OPT__VERBOSITY(&verbosity),
> +	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
>  	OPT_END()
>  };
>  
> @@ -1344,14 +1349,138 @@ static void git_imap_config(void)
>  	git_config_get_string("imap.authmethod", &server.auth_method);
>  }
>  
> -int main(int argc, char **argv)
> -{
> -	struct strbuf all_msgs = STRBUF_INIT;
> +static int append_msgs_to_imap(struct imap_server_conf *server, struct strbuf* all_msgs, int total) {

The opening brace sits on its own line by itself, so

> +#ifdef USE_CURL_FOR_IMAP_SEND
> +static CURL *setup_curl(struct imap_server_conf *srvc)
> +{
> +	CURL *curl;
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf auth = STRBUF_INIT;
> +
> +	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
> +		die("curl_global_init failed");
> +
> +	curl = curl_easy_init();
> +
> +	if (!curl)
> +		die("curl_easy_init failed");
> +
> +	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
> +	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
> +
> +	strbuf_addstr(&path, server.host);
> +	if (!path.len || path.buf[path.len - 1] != '/')
> +		strbuf_addch(&path, '/');
> +	strbuf_addstr(&path, server.folder);
> +
> +	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
> +	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
> +
> +	if (server.auth_method) {
> +		strbuf_addstr(&auth, "AUTH=");
> +		strbuf_addstr(&auth, server.auth_method);
> +		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
> +	}

Are path.buf and auth.buf leaked here, or does CURL *curl take
possession of them by curl_easy_setopt() and not freeing them
ourselves is the right thing to do?  Assuming that is the case,
perhaps we would want to use strbuf_detach() on &path and &auth
to make it clear that is what is going on?

> +int main(int argc, char **argv)
> +{
> +	struct strbuf all_msgs = STRBUF_INIT;
> +	int total;
>  	int nongit_ok;
>  
>  	git_extract_argv0_path(argv[0]);
> @@ -1360,12 +1489,18 @@ int main(int argc, char **argv)
>  
>  	setup_git_directory_gently(&nongit_ok);
>  	git_imap_config();
> -
>  	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);

Why?


Thanks.
