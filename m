From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Wed, 13 Jan 2016 14:03:08 -0800
Message-ID: <xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j6t@kdbg.org, peff@peff.net,
	jens.lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 23:03:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJTVf-0008Hm-55
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 23:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbcAMWDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 17:03:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754573AbcAMWDL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 17:03:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 614173B29E;
	Wed, 13 Jan 2016 17:03:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IyT8D8ASKFGGtYllHq4W5+VpfPs=; b=b2ZtNU
	YGLfbE62TQOrX9HsL+571I7a853mCE2OwEfwOKuKr6UjV54tINhfkcxAq2KPB0fS
	K87n8DvIbd4Kf2VKSvLNgBWD/bJCCarH3b8MQMSNlAf4W44ByqJNmzJmFWMvaWR5
	irKOEYutECzuazuU7A4aFr+cJxrt5Z+/2eSug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p2RYOzhz263pnKWnqXRdm/OjjUWhHQrL
	NvhqEsfbyd6a3DD69Q6ak65QqokXIf3/DGVxLR0WNQvgHL7BmkzAcI9lwFtBlkXE
	A2a0QYMha916+CJkEFXhkdI3yH0o3SHFIkDn3iF9zK1xWNI4YQ0/NBpRD8AdCAn+
	+8EYuwvinFA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 596B33B29D;
	Wed, 13 Jan 2016 17:03:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AD7383B29C;
	Wed, 13 Jan 2016 17:03:09 -0500 (EST)
In-Reply-To: <1452708927-9401-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 13 Jan 2016 10:15:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6EB893D0-BA41-11E5-81B5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283990>

Stefan Beller <sbeller@google.com> writes:

> Later on we want to deprecate the `git submodule init` command and make
> it implicit in other submodule commands.

I doubt there is a concensus for "deprecate" part to warrant the use
of "we want" here.  I tend to think that the latter half of the
sentence is uncontroversial, i.e. it is a good idea to make other
"submodule" subcommands internally call it when it makes sense, and
also make knobs available to other commands like "clone" and
possibly "checkout" so that the users do not have to do the
"submodule init" as a separate step, though.

> As I was porting the functionality I noticed some odds with the inputs.

I can parse but cannot quite grok.  You found some strange things in
the input?  Whose input, that comes from where given by whom?

> To fully understand the situation I added some logging to the function
> temporarily to capture all calls to the function throughout the test
> suite. Duplicates have been removed and all unique testing inputs have
> been recorded into t0060.

I can also parse this, but it is unclear what you did to the
temporary debugging help at the end.  If you left it, then that is
no longer a temporary but is part of the final product.  It is also
unclear what "Duplicates" you are talking about here.

Do you mean that you found some of the existing tests were odd, and
after examination with help from a temporary hack which does not
remain in this patch, you determined that some tests were duplicated,
which you removed, while adding new ones?

>  builtin/submodule--helper.c | 189 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  81 +------------------
>  t/t0060-path-utils.sh       |  42 ++++++++++
>  3 files changed, 235 insertions(+), 77 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4c3eff..3e58b5d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -9,6 +9,193 @@
>  #include "submodule-config.h"
>  #include "string-list.h"
>  #include "run-command.h"
> +#include "remote.h"
> +#include "refs.h"
> +#include "connect.h"
> +
> +static char *get_default_remote(void)
> +{
> +	char *dest = NULL, *ret;
> +	unsigned char sha1[20];
> +	int flag;
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
> +
> +	if (!refname)
> +		die("No such ref: HEAD");
> +
> +	refname = shorten_unambiguous_ref(refname, 0);
> +	strbuf_addf(&sb, "branch.%s.remote", refname);

Is it correct to use shorten_unambiguous_ref() here like this?  The
function is meant to be used when you want heads/frotz because you
have both refs/heads/frotz and refs/tags/frotz at the same time.  I
think you want to say branch.frotz.remote even in such a case.  IOW,
shouldn't it be skip_prefix() with refs/heads/, together with die()
if the prefix is something else?

> +	if (git_config_get_string(sb.buf, &dest))
> +		ret = xstrdup("origin");
> +	else
> +		ret = xstrdup(dest);
> +
> +	strbuf_release(&sb);
> +	return ret;
> +}
> +
> +static int starts_with_dot_slash(const char *str)
> +{
> +	return str[0] == '.' && is_dir_sep(str[1]);
> +}
> +
> +static int starts_with_dot_dot_slash(const char *str)
> +{
> +	return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
> +}
> +
> +static char *last_dir_separator(char *str)
> +{
> +	char* p = str + strlen(str);

Asterisk sticks to the variable, not the type.

> +	while (p-- != str)

It is preferable to use '>' not '!=' here, because you know p
approaches str from the larger side, for readability.

> +		if (is_dir_sep(*p))
> +			return p;
> +	return NULL;
> +}

(a useless comment) This is one of the rare places where I wish
there were a version of strcspn() that scans from the right.

> +static char *relative_url(const char *remote_url,
> +				const char *url,
> +				const char *up_path)
> +{
> +	int is_relative = 0;
> +	int colonsep = 0;
> +	char *out;
> +	char *remoteurl = xstrdup(remote_url);
> +	struct strbuf sb = STRBUF_INIT;
> +	size_t len;
> +
> +	len = strlen(remoteurl);

Nothing wrong here, but it looked somewhat inconsistent to see this
assignment, while remoteurl is done as an initialization [*1*]


[Footnote]

*1* as a personal preference, I tend to prefer seeing only simple
operations in initialization and heavyweight ones as a separate
assignment to an otherwise uninitialized variable, and strlen() is
lighter-weight than xstrdup() in my dictionary.



> +	if (is_dir_sep(remoteurl[len]))
> +		remoteurl[len] = '\0';
> +
> +	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
> +		is_relative = 0;
> +	else {
> +		is_relative = 1;
> +
> +		/* Prepend a './' to ensure all relative remoteurls start
> +		 * with './' or '../'. */

Adjust the style, and perhaps remove the final full-stop to make the
last string literal easier to see?  I.e.

	/*
         * Prepend a './' to ensure all relative remoteurls
         * start with './' or '../'
         */

would be easier to see what it is said.

> +		if (!starts_with_dot_slash(remoteurl) &&
> +		    !starts_with_dot_dot_slash(remoteurl)) {
> +			strbuf_reset(&sb);
> +			strbuf_addf(&sb, "./%s", remoteurl);
> +			free(remoteurl);
> +			remoteurl = strbuf_detach(&sb, NULL);
> +		}
> +	}
> +	/* When the url starts with '../', remove that and the
> +	 * last directory in remoteurl. */

Style.

> +	while (url) {
> +		if (starts_with_dot_dot_slash(url)) {
> +			char *rfind;
> +			url += 3;
> +
> +			rfind = last_dir_separator(remoteurl);
> +			if (rfind)
> +				*rfind = '\0';
> +			else {
> +				rfind = strrchr(remoteurl, ':');
> +				if (rfind) {
> +					*rfind = '\0';
> +					colonsep = 1;
> +				} else {
> +					if (is_relative || !strcmp(".", remoteurl))
> +						die(_("cannot strip one component off url '%s'"), remoteurl);
> +					else
> +						remoteurl = xstrdup(".");
> +				}
> +			}

It is somewhat hard to see how this avoids stripping one (or both)
slashes just after "http:" in remoteurl="http://site/path/", leaving
just "http:/" (or "http:").

This codepath has overly deep nesting levels.  Is this the simplest
we can do?

The final else { if .. else } can be made into else if .. else to
dedent the overlong die() by one level, but I am wondering if the
deep nesting is just a symptom of logic being unnecessarily complex.

> +		} else if (starts_with_dot_slash(url)) {
> +			url += 2;
> +		} else
> +			break;
> +	}
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
> +
> +	if (starts_with_dot_slash(sb.buf))
> +		out = xstrdup(sb.buf + 2);
> +	else
> +		out = xstrdup(sb.buf);
> +	strbuf_reset(&sb);
> +
> +	free(remoteurl);
> +	if (!up_path || !is_relative)
> +		return out;
> +
> +	strbuf_addf(&sb, "%s%s", up_path, out);
> +	free(out);
> +	return strbuf_detach(&sb, NULL);
> +}

Thanks.
