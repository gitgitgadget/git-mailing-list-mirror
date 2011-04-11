From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/11] revert: Catch incompatible command-line options
 early
Date: Mon, 11 Apr 2011 14:44:10 -0700
Message-ID: <7vfwpotqdx.fsf@alter.siamese.dyndns.org>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <1302448317-32387-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:44:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9OuN-0001sU-E8
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 23:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab1DKVo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 17:44:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab1DKVo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 17:44:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD6F84CC1;
	Mon, 11 Apr 2011 17:46:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=SqsCQM6VKf35wIAiRiQD2DE8fF4=; b=Py5yXWw3ZAedBH6XWbIl
	eLo6wX5pJkLHxnMU7lQkZpYpdPZfj0DQw2TgZuPZaeHe9wvPGXclsJl4GMb9sXhv
	J1zz5j/4RI9t0PH3PD64uoOqRX2NZPtFyiDC+bz2YWPTr3gyuOk7sNNNY2DYrof2
	DOjlC/5z0/eUJvAPzJriN5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=GlQl5S0t2Jt1G8diutmKD7zoKvOsRbrqtpxkgxeNfYqyxb
	DbmQg5pYhB4UTw5FJnZ5k2+sXnOXvHgesIdfpDhElb3sJcOZ+Jv5O5PcK+J8U3AH
	wROCFhPHPLB2rp4V4UURTwkMhB87T2Kz8Vq5R0vfJ1tRjTRIFwea80WGL2wtU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B0E54CBB;
	Mon, 11 Apr 2011 17:46:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E7AD14CB6; Mon, 11 Apr 2011
 17:46:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21669698-6485-11E0-A0CC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171362>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +static void die_opt_incompatible(const char *me, const char *base_opt,
> +				int nargs, int opt_bitarray[], ...)
> +{

This feels way overkill to use vararg.  This may be _one_ way to do what
you want to do, and while I don't think it is the best way, it may be Ok.

"opt_bitarray[]" is a horrible name, though.  It does not convey what
the variable is about (its "purpose").  It doesn't even correctly describe
the way that unspecified purpose happens to be implemented (claims to be
bitarray but it is just an array of ints and what matters is if any bit is
set in the array).

>  static void parse_args(int argc, const char **argv)
>  {
>  	const char * const * usage_str = revert_or_cherry_pick_usage();
> @@ -112,6 +130,13 @@ static void parse_args(int argc, const char **argv)
>  	if (cmd_opts.commit_argc < 2)
>  		usage_with_options(usage_str, options);
>  
> +	if (cmd_opts.allow_ff) {
> +		int opt_bitarray[] = {cmd_opts.signoff, cmd_opts.no_commit,
> +				      cmd_opts.no_replay, cmd_opts.edit};
> +		die_opt_incompatible(me, "--ff", 4, opt_bitarray, "--signoff",
> +				"--no-commit", "-x", "--edit");
> +	}

Why not do it like this instead?

	struct incompatible {
        	unsigned option_bit;
                const char *option_name;
	} incompatible[] = {
		{ opts->signoff, "--signoff" },
                { opts->no_commit, "--no-commit" },
                ...
	};
	verify_compatible("me", "--ff", incompatible, ARRAY_SIZE(incompatible));

Or if you are shooting for ease-of-use, it might make sense to do it like
this:

	verify_compatible("me", "--ff",
        		"--signoff", opts->signoff,
                        "--no-commit", opts->no_commit,
                        ...
                        NULL);

and make verify_compatible() a varargs function that takes two optional
arguments at a time, i.e. const char *, followed by an int.  Then there is
no need for extra "int opt_bitarray[]" or "struct incompatible".

That would justify use of varargs, I think.
