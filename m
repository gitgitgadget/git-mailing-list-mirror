From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] New whitespace checking category 'trailing-blank-line'
Date: Sun, 26 Jul 2009 14:36:55 -0700
Message-ID: <7vbpn7p1mw.fsf@alter.siamese.dyndns.org>
References: <200907261145.38449.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 23:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVBP9-0007zi-RF
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 23:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbZGZVhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 17:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbZGZVhG
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 17:37:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbZGZVhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 17:37:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A63E312BF2;
	Sun, 26 Jul 2009 17:37:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5023212BF1; Sun, 26 Jul 2009
 17:36:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 74EC35E2-7A2C-11DE-A7C5-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124138>

Bruno Haible <bruno@clisp.org> writes:

> In some GNU projects, there are file types for which trailing spaces in a line
> ...
> Currently the user has to turn off the 'trailing-space' whitespace attribute
> in order for 'git diff --check' to not complain about such files. This has
> the drawback that trailing spaces are not detected.

Very good problem description.  Thanks.

> Here is a proposed patch, to allow people to turn the check against trailing
> blank lines independently from the whitespace-in-a-line checking. The default
> behavior is not changed.

The "default" for people who do not have configuration may not change, but
people who explicitly asked git to check the trailing blank lines by
specifying "whitespace=trail" attribute, and have been relying on it, will
now be unprotected. Such a regression/incompatibility should be noted here.

Better yet would be not to introduce such a regression, of course.

> From: Bruno Haible <bruno@clisp.org>
> Date: Sun, 26 Jul 2009 11:08:41 +0200
> Subject: [PATCH] New whitespace checking category 'trailing-blank-line'.

Have these three lines _before_ the proposed commit log message above, not
after it, if you want to set these differently from what your MUA gives to
your message; in this particular case I do not think they are necessary,
though.

> ---

And please sign-off your patch before the three-dash line.

> diff --git a/Documentation/RelNotes-1.6.4.txt b/Documentation/RelNotes-1.6.4.txt
> index b3c0346..9ebcc3a 100644
> --- a/Documentation/RelNotes-1.6.4.txt
> +++ b/Documentation/RelNotes-1.6.4.txt
> @@ -64,6 +64,12 @@ Updates since v1.6.3
> ...
> + * In the configuration variable core.whitespace and in a 'whitespace'
> +   attribute specified in .git/info/attributes or .gitattributes, a new
> +   category of whitespace checking is recognized: "trailing-blank-line".
> +   Previously this checking was part of "trailing-space"; now it can be
> +   turned on or off separately.
> +

I appreciate a hunk to update the release notes like this (the series
definitely is a post 1.6.4 material, though).

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6857d2f..e9221ba 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -411,6 +411,8 @@ core.whitespace::
>    part of the line terminator, i.e. with it, `trailing-space`
>    does not trigger if the character before such a carriage-return
>    is not a whitespace (not enabled by default).
> +* `trailing-blank-line` treats blank lines at the end of the file as
> +  an error (enabled by default).

I suspect this should be done in a similar way as cr-at-eol.  Keep the
behaviour for people who says trailing-space unchanged, but the error
check can be loosened if you include the new string in the config or
attribute value.

And name it not to begin with "trail", e.g. "blank-lines-at-eof", to avoid
breaking people who have abbrevated "trailing-space" to "trail" in their
config.

Another idea would be to:

    - introduce two new settings:

        blank-at-eol		: SP/HT at EOL is an error
        empty-lines-at-eof	: empty lines at the end of file is an error

    - make existing "trailing-space" a mere short-hand for "blank-at-eol"
      and "empty-lines-at-eof".

I think the way we handled cr-at-eol was suboptimal. We should be able to
link this to crlf attribute (and core.autocrlf configuration) and pretend
as if cr-at-eol was given if a file is subject to the crlf conversion
(iow,. cr-at-eol should be deprecated/removed as a mistake).

The "git diff" part looked reasonable from a quick glance, but I do not
think I saw anything that affects "git apply --whitespace=fix" in the
patch.
