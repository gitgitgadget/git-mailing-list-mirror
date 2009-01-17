From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 4/5] checkout: implement "-" abbreviation, add
 docs and tests
Date: Sat, 17 Jan 2009 11:57:44 -0800
Message-ID: <7vwsct66yv.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-2-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-4-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-5-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 17 20:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOHK9-0002cH-Mz
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 20:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbZAQT5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 14:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbZAQT5y
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 14:57:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbZAQT5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 14:57:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6ADAC911F6;
	Sat, 17 Jan 2009 14:57:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1CD5C911F5; Sat,
 17 Jan 2009 14:57:45 -0500 (EST)
In-Reply-To: <1232208597-29249-5-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Sat, 17 Jan 2009 17:09:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1FD3CB92-E4D1-11DD-B473-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106099>

Thomas Rast <trast@student.ethz.ch> writes:

> @@ -133,6 +133,10 @@ the conflicted merge in the specified paths.
>  +
>  When this parameter names a non-branch (but still a valid commit object),
>  your HEAD becomes 'detached'.
> ++
> +As a special case, the "`@\{-N\}`" syntax for the N-th last branch
> +checks out the branch (instead of detaching).  You may also specify
> +"`-`" which is synonymous with "`@\{-1\}`".

I mildly disagree with this wording.

The new syntax is supposed to be a new way to name a branch, not a random
non-branch committish that is special cased by "git checkout".  I would
further suggest that we should teach "git rev-parse --symbolic-full-name"
and "git rev-parse --symbolic" about the new syntax, so that scripts can
use the syntax to find out the same information.

The "-" thing deserves a mention here in the documentation.  That _is_ a
special case that only applies to the "git checkout" command.

> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index dc1de06..b0a101b 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -679,6 +679,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		arg = argv[0];
>  		has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
>  
> +		if (!strcmp(arg, "-"))
> +			arg = "@{-1}";
> +

This is not quite nice as it could be, but it probably is Ok.  If the
interpretation of @{-1} errors out, the user won't see an error message
that talks about "-" but instead the user will see "@{-1}".

Also it will look somewhat inconsistent to the end user who does not know
the internals for "-" claim to be a synonym for @{-1} but it really isn't.
For example, "git checkout -^0" does not work as "git checkout @{-1}^0".

To avoid such confusion, we could instead make "git checkout - <ENTER>" a
synonym for "git checkout @{-1} <ENTER>", without claiming to make "-" a
synonym for "@{-1}".  In other words, "git checkout -" can become a very
narrow, focused special case that does not allow anything else, such as
pathspecs, "--" separator, nor --force and other options.
