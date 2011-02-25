From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 27/73] gettextize: git-commit formatting messages
Date: Fri, 25 Feb 2011 10:46:35 -0800
Message-ID: <7vd3mgar5g.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-28-git-send-email-avarab@gmail.com>
 <20110225094342.GJ23037@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 19:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt2gn-0001lb-5H
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 19:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247Ab1BYSqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 13:46:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323Ab1BYSqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 13:46:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 189D845D3;
	Fri, 25 Feb 2011 13:48:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jy3wmIx7CGo5DPTqOES8vriTNZs=; b=jARcx0
	Xz3urw8ISXhGtPCOsX0gVzb10bV6yV0ZO+gGe8F6lfWo7m1ADvmsYnUhclHBNU+D
	RZhTGo150gkH2LCtqPIbLyhhOW9aCurXCdQmxJp2i5rjX47ZXmz/Q7IWB8CAX38r
	YXpU9jy0UMufKyjXsAhoAdjUkQKrbAH0C3RUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FXUyBr7HYksm3C+8TH7VvQvVzFFjhrsh
	p11gTLkJ7BI8RAKQusDTUzJVOlSnLpl7FJtgiRbl+kt31MWU0i/3xhmei2qSWOnq
	cMV7HtPm5ThELSIFJ33FCClhluh+FSj2CVGrxa8itNFvwHG1r90cyYHNMDpbmLwQ
	FPxNXgkjRew=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A96645D1;
	Fri, 25 Feb 2011 13:47:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 295D345CC; Fri, 25 Feb 2011
 13:47:52 -0500 (EST)
In-Reply-To: <20110225094342.GJ23037@elie> (Jonathan Nieder's message of
 "Fri\, 25 Feb 2011 03\:43\:43 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3C5E572-410F-11E0-B745-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167916>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/t/lib-commit-template.sh b/t/lib-commit-template.sh
> new file mode 100644
> index 0000000..80ec50c
> --- /dev/null
> +++ b/t/lib-commit-template.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +
> +# Messages such as
> +#
> +#      # It looks like you may be committing a MERGE.\n"
> +#
> +# are now translatable, even though the "# " part probably ought not
> +# to be.  Expect some tests to fail when GETTEXT_POISON is enabled.

We shouldn't mark "# " part as translatable to begin with.  Perhaps the
underlying code in wt-status.c needs to be changed even before we merge
the i18n _() patches to make it easier?

It might be a good idea to introduce status_print{,_ln,_more} wrapper
functions around color_vfprintf(), and change the existing callers to look
like this:

                const char *c = color(WT_STATUS_HEADER, s);

        -       color_fprintf_ln(s->fp, c, "# Unmerged paths:");
        +       status_printf_ln(s, c, "Unmerged paths:");
                if (!advice_status_hints)
                        return;
                if (s->in_merge)
                        ;
        ...

        -       color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
        +       status_printf(s, color(WT_STATUS_HEADER, s), "\t");
                switch (status) {
                case DIFF_STATUS_ADDED:
        -               color_fprintf(s->fp, c, "new file:   %s", one);
        +               status_printf_more(s, c, "new file:   %s", one);
                        break;

Possible semantics for the three wrappers are:

 * status_printf_ln() takes all the parameters necessary to produce a
   single line; it works just like color_fprintf_ln() but adds the "# "
   prefix itself.

 * status_printf_more() is just a synonym for color_fprintf_ln() in the
   above but is not necessary.

 * status_printf() would be like color_printf() but adds the "# " prefix
   itself.

I am Ok with naming "status-printf-more" to just "status-printf" and
renaming "status-printf" to "status-printf-bol", as long as we have two
functions, one that adds "# " and the other that does not.

The adding of "# " done by status_printf() and status_printf_ln() can and
probably should have a bit of twist to adjust to the _real_ contents that
are fed to them.

Ideally, status_printf_ln(s, color, "") should omit the trailing SP and
give "<COLOR>#</COLOR>\n", and status_printf(s, color, "\t") should should
give "<COLOR>#\t</COLOR>" to avoid SP-HT.

Doing this would have two advantages over the current code:

 - The obvious one is to force separation of the "#" from the translatable
   part of the message, which is the topic of this thread.

 - Another advantage is that this makes it easier for us to drop "#"
   prefix in "git status" output in later versions of git if we wanted to.

In "git commit" template, these lines need to be made into comments, but
there is no reason, other than that we are sooooo used to seeing these
lines prefixed with "# ", in "git status" output.
