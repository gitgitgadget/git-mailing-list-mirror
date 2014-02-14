From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: git_config_from_file(): handle "-" filename as stdin
Date: Fri, 14 Feb 2014 12:35:19 -0800
Message-ID: <xmqqzjlth1q0.fsf@gitster.dls.corp.google.com>
References: <1392384878-7080-1-git-send-email-kirill@shutemov.name>
	<xmqqlhxdim80.fsf@gitster.dls.corp.google.com>
	<20140214200435.GA13633@node.dhcp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Fri Feb 14 21:35:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEPTw-0001sd-I7
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 21:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaBNUf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 15:35:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbaBNUf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 15:35:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADC326C1D6;
	Fri, 14 Feb 2014 15:35:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O9mlztsFzSdLDQGLLop17wWyfxA=; b=RrR8b+
	ck0vN7hSMjw69t3/+9sTPQXFmsA+DcC1JzSJ65JjM5SoKdpqhaa189dYVrCC8HC7
	hc2IqG54kE1ogIoIcgnA3OIy7iM+XqmX7gr6adsd0/gHlHZUC7qvrhJdKy7dFVq1
	90Rx6AK3+/i+Agjfyx+MxcTvQk6Gbj180bKT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xwrsQNnFBhx3yaNociShm+roIJHR9buY
	7fFhfb0KRdAK9kC3EZrx3qn9JbqK9F923B5X8LgtLujRYpt+HSgVDF8/3jZt1vvl
	dHKrJSqqktCx7cOfXDe1S/IYddsRQmnhWlq9kFl9YjR0mHzE3m9dXXecqFFhD6XP
	+mD9Tw5ITD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 546976C1D4;
	Fri, 14 Feb 2014 15:35:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F7566C1CA;
	Fri, 14 Feb 2014 15:35:24 -0500 (EST)
In-Reply-To: <20140214200435.GA13633@node.dhcp.inet.fi> (Kirill A. Shutemov's
	message of "Fri, 14 Feb 2014 22:04:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 87E46CEA-95B7-11E3-8713-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242143>

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> On Fri, Feb 14, 2014 at 10:27:11AM -0800, Junio C Hamano wrote:
> ...
>> I recall that an earlier implementation of "git diff --no-index"
>> that made "-" read one side to be compared from the standard input
>> had exactly the same issue of comparing filename with "-", which we
>> had to fix with code reorganization recently.  I'd prefer to see
>> this update to "git config --file -" done the right way from the
>> start.
>
> Okay, reworked version is below. It's slightly more invasive then the
> original.

Thanks.

It looks more invasive mostly because you renamed check_blob_write()
to check_write().  While I think that rename is a right thing to do
(it used to be "if we are attempting to write to blob, signal an
error", but we could have called it check_write(), meaning "we are
attempting to write; error out if that should not be allowed"), it
would have been much easier to review and comment if this were done
as a separate clean-up preparatory patch.  It wouldn't have had to
touch this many lines, I would think.

And "clean-up existing code as a separate step, without changing the
behaviour, before starting to work on a new feature" is actively
encouraged around here.

> From 199e6a995bb5228578e66189ef586421a4d8d9ba Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill@shutemov.name>
> Date: Fri, 14 Feb 2014 21:59:39 +0200
> Subject: [PATCH] config: teach "git config --file -" to read from the standard
>  input

I do not see a need for these four lines in your e-mail.  All the
necessary information is already in your e-mail header.  Please drop
them, perhaps except for the "Subject:" in-body header.

If you are going to have a discussion and then your proposed patch,
please do it this way (without the 8-space indentation I added for
illustration) using the "-- >8 --" scissors line:

        ...
        Okay, reworked version is below.

        -- >8 --
        Subject: config: teach "git config --file -" to read from the standard input

        Extend "git config --file" interface to allow reading from
        the standard input

        Editing or setting value is an error.

        Signed-off-by: ...
        ---
         diffstat and patch here
        
The in-body header "Subject: " is there to let you retitle the
commit.

> Editing stdin or setting value in stdin is an error.

Good thinking.  Even comes with tests to cover these cases.  Good.

> diff --git a/builtin/config.c b/builtin/config.c
> index 92ebf23f0a9a..625f914c44a0 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -21,6 +21,7 @@ static char key_delim = ' ';
>  static char term = '\n';
>  
>  static int use_global_config, use_system_config, use_local_config;
> +static int use_stdin;
>  static const char *given_config_file;
>  static const char *given_config_blob;

If we are changing the function signature of git_config_with_options()
anyway, would it be even a better idea to introduce something like:

	struct config_source {
        	int use_stdin;
                const char *config_file;
                const char *config_blob;
	};

        static struct config_source given_config_source;

and have one _fewer_ parameter to the function, instead of adding
one extra parameter?

> diff --git a/config.c b/config.c
> index d969a5aefc2b..53dd39f0b9ef 100644
> --- a/config.c
> +++ b/config.c
> @@ -1030,24 +1030,34 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
>  	return ret;
>  }
>  
> -int git_config_from_file(config_fn_t fn, const char *filename, void *data)
> +static int do_config_from_file(config_fn_t fn, const char *filename, FILE *f,
> +			       void *data)
>  {
> -	int ret;
> -	FILE *f = fopen(filename, "r");
> +	struct config_source top;
>  
> -	ret = -1;
> -	if (f) {
> -		struct config_source top;
> +	top.u.file = f;
> +	top.name = filename;
> +	top.die_on_error = 1;
> +	top.do_fgetc = config_file_fgetc;
> +	top.do_ungetc = config_file_ungetc;
> +	top.do_ftell = config_file_ftell;
> +
> +	return do_config_from(&top, fn, data);
> +}
>  
> -		top.u.file = f;
> -		top.name = filename;
> -		top.die_on_error = 1;
> -		top.do_fgetc = config_file_fgetc;
> -		top.do_ungetc = config_file_ungetc;
> -		top.do_ftell = config_file_ftell;
> +static int git_config_from_stdin(config_fn_t fn, void *data)
> +{
> +	return do_config_from_file(fn, "<stdin>", stdin, data);
> +}

So the above callchain will set top.name to the string "<stdin>".
How would that interact with the code in handle_path_include() that
makes sure that relative config includes are only allowed in file
with known location?

Other than that, I didn't spot any issue in this round looks.  It
seems to be almost there.

Thanks.
