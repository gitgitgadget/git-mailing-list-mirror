From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 3/3] ident: cleanup wrt ident's source
Date: Fri, 05 Feb 2016 11:05:19 -0800
Message-ID: <xmqqsi17c70w.fsf@gitster.mtv.corp.google.com>
References: <1454658148-3031-1-git-send-email-alonid@gmail.com>
	<1454658148-3031-4-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Dan Aloni <alonid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:05:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRlhD-0006uA-IF
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbcBETFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:05:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754604AbcBETFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:05:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB86F41BB5;
	Fri,  5 Feb 2016 14:05:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LZhmAbYLHbseINrDfD9kp1Ah3yk=; b=QLb7jy
	k4xjw4eeN0ShXnDZMmJuizG5n+fpEFx+jcqfgIxdo5UjporQC0xDd6rm66y5p42W
	sYUdtnbOQ54UcM/SBbfw3Oe//WGBrTXEHeYHnmOWiWwGFsB4Kd9DbLfc9JIe06op
	4DCC8YpLz+mvPUCzhCJnkUfMkJgd2MN7zlGf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o360/JWpdYWfrh7SYofyItfFpS5DrwVD
	VHonrXCQoTymwzTX7bnq3HI1sTtnyPB9t4K/p+IxP7zfbEQ6WIYGYPBSxbKLcYUI
	bUceZhE0Vk7ZkTGofXmLP/1N5IPyUDzCg8T4w3WROaD3ynows1zpJoFAUIVkCNEe
	XBBGO2kZsMQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B127041BB4;
	Fri,  5 Feb 2016 14:05:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C101841BB2;
	Fri,  5 Feb 2016 14:05:20 -0500 (EST)
In-Reply-To: <1454658148-3031-4-git-send-email-alonid@gmail.com> (Dan Aloni's
	message of "Fri, 5 Feb 2016 09:42:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6702FB2E-CC3B-11E5-AADE-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285594>

Dan Aloni <alonid@gmail.com> writes:

> This change condenses the variables that tells where we got the user's
> ident into single enum, instead of a collection of booleans.
>
> In addtion, also have {committer,author}_ident_sufficiently_given
> directly probe the environment and the afformentioned enum instead of
> relying on git_{committer,author}_info to do so.
>
> Signed-off-by: Dan Aloni <alonid@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ident.c | 126 ++++++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 80 insertions(+), 46 deletions(-)

Peff what do you think?  I am asking you because personally I do not
find this particularly easier to read than the original, but since
you stared at the code around here recently much longer than I did
when doing the 1/3, I thought you may be a better judge than I am.

> diff --git a/ident.c b/ident.c
> index 9bd6ac69bfe8..9bb05912b59a 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -10,17 +10,19 @@
>  static struct strbuf git_default_name = STRBUF_INIT;
>  static struct strbuf git_default_email = STRBUF_INIT;
>  static struct strbuf git_default_date = STRBUF_INIT;
> -static int default_email_is_bogus;
> -static int default_name_is_bogus;
> +
> +enum ident_source {
> +	IDENT_SOURCE_UNKNOWN = 0,
> +	IDENT_SOURCE_CONFIG,
> +	IDENT_SOURCE_ENVIRONMENT,
> +	IDENT_SOURCE_GUESSED,
> +	IDENT_SOURCE_GUESSED_BOGUS
> +};
>  
>  static int ident_use_config_only;
>  
> -#define IDENT_NAME_GIVEN 01
> -#define IDENT_MAIL_GIVEN 02
> -#define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
> -static int committer_ident_explicitly_given;
> -static int author_ident_explicitly_given;
> -static int ident_config_given;
> +static enum ident_source source_of_default_email = IDENT_SOURCE_UNKNOWN;
> +static enum ident_source source_of_default_name = IDENT_SOURCE_UNKNOWN;
>  
>  #ifdef NO_GECOS_IN_PWENT
>  #define get_gecos(ignored) "&"
> @@ -28,7 +30,7 @@ static int ident_config_given;
>  #define get_gecos(struct_passwd) ((struct_passwd)->pw_gecos)
>  #endif
>  
> -static struct passwd *xgetpwuid_self(int *is_bogus)
> +static struct passwd *xgetpwuid_self(enum ident_source *source)
>  {
>  	struct passwd *pw;
>  
> @@ -41,9 +43,13 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
>  		fallback.pw_gecos = "Unknown";
>  #endif
>  		pw = &fallback;
> -		if (is_bogus)
> -			*is_bogus = 1;
> +		if (source)
> +			*source = IDENT_SOURCE_GUESSED_BOGUS;
> +	} else {
> +		if (source)
> +			*source = IDENT_SOURCE_GUESSED;
>  	}
> +
>  	return pw;
>  }
>  
> @@ -120,26 +126,26 @@ static int canonical_name(const char *host, struct strbuf *out)
>  	return status;
>  }
>  
> -static void add_domainname(struct strbuf *out, int *is_bogus)
> +static void add_domainname(struct strbuf *out, enum ident_source *source)
>  {
>  	char buf[1024];
>  
>  	if (gethostname(buf, sizeof(buf))) {
>  		warning("cannot get host name: %s", strerror(errno));
>  		strbuf_addstr(out, "(none)");
> -		*is_bogus = 1;
> +		*source = IDENT_SOURCE_GUESSED_BOGUS;
>  		return;
>  	}
>  	if (strchr(buf, '.'))
>  		strbuf_addstr(out, buf);
>  	else if (canonical_name(buf, out) < 0) {
>  		strbuf_addf(out, "%s.(none)", buf);
> -		*is_bogus = 1;
> +		*source = IDENT_SOURCE_GUESSED_BOGUS;
>  	}
>  }
>  
>  static void copy_email(const struct passwd *pw, struct strbuf *email,
> -		       int *is_bogus)
> +		       enum ident_source *source)
>  {
>  	/*
>  	 * Make up a fake email address
> @@ -150,13 +156,13 @@ static void copy_email(const struct passwd *pw, struct strbuf *email,
>  
>  	if (!add_mailname_host(email))
>  		return;	/* read from "/etc/mailname" (Debian) */
> -	add_domainname(email, is_bogus);
> +	add_domainname(email, source);
>  }
>  
>  const char *ident_default_name(void)
>  {
>  	if (!git_default_name.len) {
> -		copy_gecos(xgetpwuid_self(&default_name_is_bogus), &git_default_name);
> +		copy_gecos(xgetpwuid_self(&source_of_default_name), &git_default_name);
>  		strbuf_trim(&git_default_name);
>  	}
>  	return git_default_name.buf;
> @@ -169,11 +175,12 @@ const char *ident_default_email(void)
>  
>  		if (email && email[0]) {
>  			strbuf_addstr(&git_default_email, email);
> -			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> -			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> -		} else
> -			copy_email(xgetpwuid_self(&default_email_is_bogus),
> -				   &git_default_email, &default_email_is_bogus);
> +			source_of_default_email = IDENT_SOURCE_ENVIRONMENT;
> +		} else {
> +			copy_email(xgetpwuid_self(&source_of_default_email),
> +				   &git_default_email, &source_of_default_email);
> +		}
> +
>  		strbuf_trim(&git_default_email);
>  	}
>  	return git_default_email.buf;
> @@ -353,12 +360,13 @@ const char *fmt_ident(const char *name, const char *email,
>  		if (!name) {
>  			name = ident_default_name();
>  			using_default = 1;
> -			if (strict && default_name_is_bogus) {
> +			if (strict &&
> +			    source_of_default_name == IDENT_SOURCE_GUESSED_BOGUS) {
>  				fputs(env_hint, stderr);
>  				die("unable to auto-detect name (got '%s')", name);
>  			}
>  			if (strict && ident_use_config_only &&
> -			    !(ident_config_given & IDENT_NAME_GIVEN))
> +			    source_of_default_name != IDENT_SOURCE_CONFIG)
>  				die("user.useConfigOnly set but no name given");
>  		}
>  		if (!*name) {
> @@ -375,12 +383,12 @@ const char *fmt_ident(const char *name, const char *email,
>  
>  	if (!email) {
>  		email = ident_default_email();
> -		if (strict && default_email_is_bogus) {
> +		if (strict && source_of_default_email == IDENT_SOURCE_GUESSED_BOGUS) {
>  			fputs(env_hint, stderr);
>  			die("unable to auto-detect email address (got '%s')", email);
>  		}
> -		if (strict && ident_use_config_only
> -		    && !(ident_config_given & IDENT_MAIL_GIVEN))
> +		if (strict && ident_use_config_only &&
> +		    source_of_default_email != IDENT_SOURCE_CONFIG)
>  			die("user.useConfigOnly set but no mail given");
>  	}
>  
> @@ -412,10 +420,6 @@ const char *fmt_name(const char *name, const char *email)
>  
>  const char *git_author_info(int flag)
>  {
> -	if (getenv("GIT_AUTHOR_NAME"))
> -		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
> -	if (getenv("GIT_AUTHOR_EMAIL"))
> -		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
>  	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
>  			 getenv("GIT_AUTHOR_EMAIL"),
>  			 getenv("GIT_AUTHOR_DATE"),
> @@ -424,33 +428,67 @@ const char *git_author_info(int flag)
>  
>  const char *git_committer_info(int flag)
>  {
> -	if (getenv("GIT_COMMITTER_NAME"))
> -		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
> -	if (getenv("GIT_COMMITTER_EMAIL"))
> -		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
>  	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
>  			 getenv("GIT_COMMITTER_EMAIL"),
>  			 getenv("GIT_COMMITTER_DATE"),
>  			 flag);
>  }
>  
> -static int ident_is_sufficient(int user_ident_explicitly_given)
> +enum ident_person {
> +	IDENT_PERSON_COMMITTER,
> +	IDENT_PERSON_AUTHOR
> +};
> +
> +static int ident_source_is_sufficient(enum ident_source source)
> +{
> +	switch (source) {
> +	case IDENT_SOURCE_CONFIG:
> +	case IDENT_SOURCE_ENVIRONMENT:
> +		return 1;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ident_is_sufficient(enum ident_person person)
>  {
> +	const char *str_name, *str_email;
> +	int name, email;

Can we call this "name_ok" or something?

Also it feels strange to do the all name-related things in this
function even though we immediately discard.  The code in this patch
is still better than sprinkling more #ifdef to conditionally grab
names only on platforms that require names, but it may be an
indication of the design flaw of trying to squeeze this entire logic
into this single function.  Perhaps another little helper function
can clean it up?  e.g.

	ident_is_sufficient(committer_or_author?)
        {
	#ifdef WINDOWS
		if (!explicitly_given(committer_or_author?, NAME))
			return 0;
	#endif
        	return explicitly_given(committer_or_author?, EMAIL))
	}

or something?  I dunno.

> +
> +	switch (person) {
> +	case IDENT_PERSON_COMMITTER:
> +		str_name = getenv("GIT_COMMITTER_NAME");
> +		str_email = getenv("GIT_COMMITTER_EMAIL");
> +		break;
> +	case IDENT_PERSON_AUTHOR:
> +		str_name = getenv("GIT_AUTHOR_NAME");
> +		str_email = getenv("GIT_AUTHOR_EMAIL");
> +		break;
> +	default:
> +		die("invalid parameter to ident_is_sufficient()");
> +	}
> +
> +	name = !!str_name || ident_source_is_sufficient(source_of_default_name);
> +	email = !!str_email || ident_source_is_sufficient(source_of_default_email);
>  #ifndef WINDOWS
> -	return (user_ident_explicitly_given & IDENT_MAIL_GIVEN);
> +	(void)name;
> +	return email;
>  #else
> -	return (user_ident_explicitly_given == IDENT_ALL_GIVEN);
> +	return name && email;
>  #endif
>  }
