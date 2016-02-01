From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] apply, ls-files: simplify "-z" parsing
Date: Mon, 01 Feb 2016 13:47:00 -0800
Message-ID: <xmqqzivkt86j.fsf@gitster.mtv.corp.google.com>
References: <20160131112215.GA4589@sigill.intra.peff.net>
	<20160131113546.GF5116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 22:47:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQMJS-0001Fi-Sg
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 22:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbcBAVrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 16:47:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932075AbcBAVrD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 16:47:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9F97416F8;
	Mon,  1 Feb 2016 16:47:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GSlCtznszYURyGPDDnyj9/gqYQs=; b=Z/Pf8N
	QVhDzfA8tMmBiazvuysFlMu+zIMSck3COhBce2m6LF+fBGyX37vZz12CHvUMMDDM
	eKYtkpSm4OdZYXbiFn1vmCXLjX3KxLLasJhzm5PKp4WvQyGRpT02WRrNlT3DScNP
	Jgz8P4aENrJI2Nak7ivm10xqG8p3mNQne71Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WdiR+So01BvlgPdgC9UvQnfMI+j8njjS
	NyKIrHGUYEQ4MxDv8GXVmXajlT0XMcMCFsOplsEjI9FJYe0vvpJ6lkGUaxETqSAK
	o17kr19sJWatptKQFSDxaBpipBQrkTIC4yOnljGDEdzckAheqP8svjF/vv1a3GnO
	ch1rj3m4wpg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C2605416F6;
	Mon,  1 Feb 2016 16:47:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3F669416F5;
	Mon,  1 Feb 2016 16:47:02 -0500 (EST)
In-Reply-To: <20160131113546.GF5116@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 31 Jan 2016 06:35:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53E2984E-C92D-11E5-9082-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285219>

Jeff King <peff@peff.net> writes:

> As a short option, we cannot handle negation. Thus a
> callback handling "unset" is overkill, and we can just use
> OPT_SET_INT instead to handle setting the option.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I left this one for last, because it's the most questionable. Unlike the
> previous "-z" case, we're setting the actual character, so the logic is
> inverted: turning on the option sets it to 0, and turning it off restore
> '\n'.
>
> This means OPT_SET_INT would do the wrong thing for the "unset" case, as
> it would put a "0" into the option. You can't trigger that now, but if
> somebody were to add a long option (e.g., "--nul"), then "--no-nul"
> would do the wrong thing.
>
> I'm on the fence on whether the simplification is worth it, or if we
> should leave the callbacks as future-proofing.

If done as two patch series where one does this and the other flips
polarity of the variable (!!line_termination === !nul_term_line),
would that make the result both simpler to read and future-proof?

Of course, a patch adding a "--nul" can be the one that does the
polarity flipping, so in that sense, this simplification is probably
OK, as long as there is some comment that warns a time-bomb you just
planted here ;-)

>  builtin/apply.c    | 15 ++-------------
>  builtin/ls-files.c | 13 ++-----------
>  2 files changed, 4 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index deb1364..565f3fd 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -4464,16 +4464,6 @@ static int option_parse_p(const struct option *opt,
>  	return 0;
>  }
>  
> -static int option_parse_z(const struct option *opt,
> -			  const char *arg, int unset)
> -{
> -	if (unset)
> -		line_termination = '\n';
> -	else
> -		line_termination = 0;
> -	return 0;
> -}
> -
>  static int option_parse_space_change(const struct option *opt,
>  			  const char *arg, int unset)
>  {
> @@ -4546,9 +4536,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>  			 N_( "attempt three-way merge if a patch does not apply")),
>  		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
>  			N_("build a temporary index based on embedded index information")),
> -		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
> -			N_("paths are separated with NUL character"),
> -			PARSE_OPT_NOARG, option_parse_z },
> +		OPT_SET_INT('z', NULL, &line_termination,
> +			N_("paths are separated with NUL character"), '\0'),
>  		OPT_INTEGER('C', NULL, &p_context,
>  				N_("ensure at least <n> lines of context match")),
>  		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index b6a7cb0..59bad9b 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -359,14 +359,6 @@ static const char * const ls_files_usage[] = {
>  	NULL
>  };
>  
> -static int option_parse_z(const struct option *opt,
> -			  const char *arg, int unset)
> -{
> -	line_terminator = unset ? '\n' : '\0';
> -
> -	return 0;
> -}
> -
>  static int option_parse_exclude(const struct option *opt,
>  				const char *arg, int unset)
>  {
> @@ -408,9 +400,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  	struct exclude_list *el;
>  	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
>  	struct option builtin_ls_files_options[] = {
> -		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
> -			N_("paths are separated with NUL character"),
> -			PARSE_OPT_NOARG, option_parse_z },
> +		OPT_SET_INT('z', NULL, &line_terminator,
> +			N_("paths are separated with NUL character"), '\0'),
>  		OPT_BOOL('t', NULL, &show_tag,
>  			N_("identify the file status with tags")),
>  		OPT_BOOL('v', NULL, &show_valid_bit,
