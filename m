From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: make -M -C mean the same as -C -M
Date: Fri, 23 Jan 2015 10:41:10 -0800
Message-ID: <xmqqr3ulqr09.fsf@gitster.dls.corp.google.com>
References: <1421978835-9921-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:41:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEjAc-0004uR-9E
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 19:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221AbbAWSlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 13:41:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755626AbbAWSlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 13:41:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6141431B6F;
	Fri, 23 Jan 2015 13:41:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SWJjFiDx8wdcfpyfKANx9kp5Sxg=; b=J4LkbG
	UoJoNqfpte5DTmyKuPhjbEIU0jJSOdY6gF+yN3RTxOtwDIQfRn44KH+ItG3kmA6D
	S8UUdKX26PUntzi+uRujbGSjnF83Vp4p7k1ceCn61ABf+GxnXZ5qrUdanQgv+rcY
	VWM3zASDkuIuVkObr9jag0WAY4GM3DDugS0Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vrcILXDT8VTtKv8X6/M77uYR/pF3SmMT
	dIELEo68bpFTF027zuby6X+CMd//m0tzJHakoG8SXsUggoHybqiHtL6V4JZwVuXk
	yAO/kOK1paXEoSApvP/K+SedBcFdpoHr9IoMjH3YwkqC8DI4082JtJJvso3K4D9A
	7D9kre35W/g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 588B331B6E;
	Fri, 23 Jan 2015 13:41:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 879EE31B62;
	Fri, 23 Jan 2015 13:41:12 -0500 (EST)
In-Reply-To: <1421978835-9921-1-git-send-email-mh@glandium.org> (Mike Hommey's
	message of "Fri, 23 Jan 2015 11:07:15 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 67A56106-A32F-11E4-BC44-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262943>

Mike Hommey <mh@glandium.org> writes:

> While -C implies -M, it is quite common to see both on example command lines
> here and there. The unintuitive thing is that if -M appears after -C, then
> copy detection is turned off because of how the command line arguments are
> handled.

This is deliberate, see below.

> Change this so that when both -C and -M appear, whatever their order, copy
> detection is on.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>
> Interestingly, I even found mentions of -C -M in this order for benchmarks,
> on this very list (see 6555655.XSJ9EnW4BY@mako).

Aside from the general warning against taking everything you see on
this list as true, I think you are looking at an orange and talking
about an apple.  $gmane/244581 is about "git blame", and "-M/-C"
over there mean completely different things.

Imagine you have a file a/b/c/d/e/f/g/h/, where each alphabet
represents a line with more meaningful contents than a single-liner,
and slash represents an end of line, and you have changed the
contents of the file to e/f/g/h/a/b/c/d/.

"blame -M" is to tell the command to notice that you moved the first
four lines to the end (i.e. you did not do anything original and
just moved lines).  Because this needs more processing to notice,
the feature is triggered by a "-M" option (you would see something
like "e/f/g/h/ came from the original and then a/b/c/d/ are newly
added" without the option).  "-M" in "blame" is about showing such
movement of lines within the same file [*1*].

On the other hand "-C" in "blame" is about noticing contents that
were copied from other files.

In the context of "git blame", "-C" and "-M" control orthogonal
concepts and it makes sense to use only one but not the other, or
both.

But "-M" given to "git diff" is not about such an orthogonal
concept.

Even though its source candidates are narrower than that of "-C" in
that "-M" chooses only from the set of files that disappeared while
"-C" also chooses from files that remain after the change, they are
both about "which file did the whole thing come from?", and it makes
sense to have progression of "-M" < "-C" < "-C -C".  You can think
of these as a short-hand for --rename-copy-level={0,1,2,3} option
(where the level 0 -- do not do anything -- corresponds to giving no
"-M/-C").  It can be argued both ways: either we take the maximum of
the values given to --rename-copy-level options (which corresponds
to what your patch attempts to do), or the last one wins.  We happen
to have implemented the latter long time ago and that is how
existing users expect things to work.

So, I dunno.  I am saying that the semantics the current code gives
is *not* the only possibly correct one, and I am not saying that
your alternative interpretation is *wrong*, but I am not sure if it
makes sense to switch the semantics this late in the game.


[Footnote]

*1* "diff" cannot do anything magical about such a change.  It can
only say that you removed the first four lines from the original,
and then added new four lines at the end (or it may say you added
new four lines at the beginning and removed four lines at the end).

There is no way for "diff" to say that these new four lines have any
relation to what you removed from the beginning of the file, with
any combination of options.  This is inherent in its output format,
which is limited to express only deletions and additions.

>  diff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index d1bd534..9081fd8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3670,7 +3670,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		 !strcmp(arg, "--find-renames")) {
>  		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
>  			return error("invalid argument to -M: %s", arg+2);
> -		options->detect_rename = DIFF_DETECT_RENAME;
> +		if (options->detect_rename != DIFF_DETECT_COPY)
> +			options->detect_rename = DIFF_DETECT_RENAME;
>  	}
>  	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
>  		options->irreversible_delete = 1;
