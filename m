From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-imap-send: use libcurl for implementation
Date: Wed, 27 Aug 2014 10:20:40 -0700
Message-ID: <xmqqoav5etnb.fsf@gitster.dls.corp.google.com>
References: <53FD0CD1.7030801@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Wed Aug 27 19:22:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMgvE-0007IZ-Px
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 19:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935602AbaH0RVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 13:21:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64432 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934674AbaH0RU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 13:20:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9266634F64;
	Wed, 27 Aug 2014 13:20:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CKa9DT6UlTmE5UawpynKdF1ph9Y=; b=C0Z5E2
	KmBO8RHQORhlmPag88f7hwnD1j3UlZALMJw7GX6rBNj/5X7sqWjhvrVMPxwaZU03
	piZhh6xqoL9g/pw90ygssx+eBRBU9lEcO3A0UJLXqDzstILtMQT9eV3I95hB+87Q
	YZuVVs2rdVY2n62/1J5YRB9mfuesHlg5iWug0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LLv5s4RHC2yBlo0wXFJZ0qHgZYL8JTqK
	OKGX19X4ydH/qWKN/5emK+OkN3fgn7MU7huhhKyRvpoq7fjIjHvjbH8TDfono92b
	Exs2ZOlfj6e41RSkOnIGINTe3yzsZnj3HMep4UuvUf8SVWe+JGKy7Mt6SYpTKHvg
	VFv3gxWFeeE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 867BF34F62;
	Wed, 27 Aug 2014 13:20:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4B11C34F58;
	Wed, 27 Aug 2014 13:20:42 -0400 (EDT)
In-Reply-To: <53FD0CD1.7030801@raz.or.at> (Bernhard Reiter's message of "Wed,
	27 Aug 2014 00:40:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 790BAE78-2E0E-11E4-AFDD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256013>

Bernhard Reiter <ockham@raz.or.at> writes:

> Use libcurl's high-level API functions to implement git-imap-send
> instead of the previous low-level OpenSSL-based functions.
>
> Since version 7.30.0, libcurl's API has been able to communicate with
> IMAP servers. Using those high-level functions instead of the current
> ones would reduce imap-send.c by some 1200 lines of code. For now,
> the old ones are wrapped in #ifdefs, and the new functions are enabled
> by make if curl's version is >= 7.35.0, from which version on curl's
> CURLOPT_LOGIN_OPTIONS (enabling IMAP authentication) parameter has been
> available.

https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions
says that this was introduced as of 7.34.0, though.

> As I don't have access to that many IMAP servers, I haven't been able to
> test the new code with a wide variety of parameter combinations. I did
> test both secure and insecure (imaps:// and imap://) connections and
> values of "PLAIN" and "LOGIN" for the authMethod.

Perhaps CC'ing those who have touched git-imap-send code over the
years and asking for their help testing might help?

> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
> ---
> I rebased the patch on the pu branch, hope that was the right thing to do.

Usually I would appreciate a patch for a new feature not meant for
the maintenance tracks to be based on 'master', so that it can go to
the next release without having to wait other changes that may
conflict with it and that may not yet be ready.

I will try to apply this one to 'pu', rebase it on 'master' to make
sure the result does not depend on the other topics in flight, and
then merge it back to 'pu'.

Thanks; some comments below.

>  Documentation/git-imap-send.txt |   3 +-
>  INSTALL                         |  15 ++--
>  Makefile                        |  16 +++-
>  git.spec.in                     |   5 +-
>  imap-send.c                     | 165 +++++++++++++++++++++++++++++++++-------
>  5 files changed, 167 insertions(+), 37 deletions(-)
>
> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
> index 7d991d9..9d244c4 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -75,7 +75,8 @@ imap.preformattedHTML::
>  
>  imap.authMethod::
>  	Specify authenticate method for authentication with IMAP server.
> -	Current supported method is 'CRAM-MD5' only. If this is not set
> +	If you compiled git with the NO_CURL option or if your curl version is
> +	< 7.35.0, the only supported method is 'CRAM-MD5'. If this is not set
>  	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.

Hmph, so there is no option that lets me say "I know my libcurl is
new enough but I have some reason not to want to use the new code to
interact with my imap server", at compile time or (more preferrably)
at runtime?

> diff --git a/INSTALL b/INSTALL
> index 6ec7a24..e2770a0 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -108,18 +108,21 @@ Issues of note:
>  	  so you might need to install additional packages other than Perl
>  	  itself, e.g. Time::HiRes.
>  
> -	- "openssl" library is used by git-imap-send to use IMAP over SSL.
> -	  If you don't need it, use NO_OPENSSL.
> +	- "openssl" library is used by git-imap-send to use IMAP over SSL,
> +	  unless you're using curl >= 7.35.0, in which case that will be
> +	  used. If you don't need git-imap-send, you can use NO_OPENSSL.

The last sentence makes it unclear which of the following is true:

 - I have sufficiently new libcurl.  I cannot say NO_OPENSSL because
   I do need git-imap-send.

 - I have sufficiently new libcurl, so "openssl" is not used by
   git-imap send for me.  I can say NO_OPENSSL.

Perhaps

 - git-imap-send needs the OpenSSL library to talk IMAP over SSL if
   you are using libCurl older than 7.35.0.  Otherwise you can use
   NO_OPENSSL without losing git-imap-send.

> diff --git a/git.spec.in b/git.spec.in
> index d61d537..9535cc3 100644
> --- a/git.spec.in
> +++ b/git.spec.in
> @@ -8,7 +8,7 @@ License: 	GPL
>  Group: 		Development/Tools
>  URL: 		http://kernel.org/pub/software/scm/git/
>  Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
> -BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
> +BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel >= 7.35.0, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}

This is very iffy.  It incompatible with the body of the patch where
you allow older curl library and because you depend on openssl-devel
you wouldn't lose imap-send.

> @@ -1391,29 +1518,13 @@ int main(int argc, char **argv)
>  	}
>  
>  	/* write it to the imap server */
> -	ctx = imap_open_store(&server, server.folder);
> -	if (!ctx) {
> -		fprintf(stderr, "failed to open store\n");
> -		return 1;
> -	}
> -
> -	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
> -	while (1) {
> -		unsigned percent = n * 100 / total;
> -
> -		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
> -		if (!split_msg(&all_msgs, &msg, &ofs))
> -			break;
> -		if (server.use_html)
> -			wrap_in_html(&msg);
> -		r = imap_store_msg(ctx, &msg);
> -		if (r != DRV_OK)
> -			break;
> -		n++;
> -	}
> -	fprintf(stderr, "\n");
>  
> -	imap_close_store(ctx);
> +	if (server.tunnel)
> +		return append_msgs_to_imap(&server, &all_msgs, total);
>  
> -	return 0;
> +#ifndef USE_CURL_FOR_IMAP_SEND
> +	return append_msgs_to_imap(&server, &all_msgs, total);
> +#else
> +	return curl_append_msgs_to_imap(&server, &all_msgs, total);
> +#endif
>  }

Much more nicely done.  It appears that you could already turn these
#ifndef/#else/#endif into a runtime conditional, allowing:

 - At compile-time, can be built with the four combinations

   (1) USE_CURL_FOR_IMAP_SEND=Yes    NO_OPENSSL=No
   (2) USE_CURL_FOR_IMAP_SEND=Yes    NO_OPENSSL=Yes
   (3) USE_CURL_FOR_IMAP_SEND=No     NO_OPENSSL=No
   (4) USE_CURL_FOR_IMAP_SEND=No     NO_OPENSSL=Yes

 - The first two variants can support --with-curl/--without-curl and
   choose between curl_append/append.  When run --without-curl, it
   may lose some auth-methods and for variant (1) SSL is not
   supported.

or am I mis-reading the patch?
   
