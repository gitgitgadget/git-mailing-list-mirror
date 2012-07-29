From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cleanup argument passing in submodule status command
Date: Sat, 28 Jul 2012 23:22:55 -0700
Message-ID: <7vtxwrw0g0.fsf@alter.siamese.dyndns.org>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com>
 <20120728102209.GA13370@book.hvoigt.net>
 <20120728121956.GA36429@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de,
	Stefan Zager <szager@google.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Jul 29 08:23:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvMul-00017x-3Z
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 08:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab2G2GW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 02:22:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab2G2GW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 02:22:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E1DD5F23;
	Sun, 29 Jul 2012 02:22:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=usECsFQv1Qm+dtCZuUj1bj7St0Y=; b=jSvj34
	c7kWudwDuZhC8dv+haYhf2aBmTbEaHPcKvOwtOsTbwvGo/jMlOZT3VbND8fUjFk2
	pq46Ie8rVIJzCJOiSSUMhlDGb6X8XrhgZLOqTRxtcXc5TZnVxsMmPXGLEg5hk6RY
	dH1uMigyK//RERYpzpJWqZ4PMnbkb5NGAiK/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OG8MHznQrm6mWec0EZ7cN1yw8mI8a5yK
	4HAcjZHZI2C/afTvLo+patSLPhEm/X+DSy2dl0uR4oOTIxJ5emZotdmipmmWOFA4
	QOd26oCz/uZwTYSBQAe3jZpOz9DZG7kbP3bz8norB/kciPIRN/NBNqIuE6OSs1he
	3zHZXQW4EdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B2FB5F22;
	Sun, 29 Jul 2012 02:22:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9110F5F21; Sun, 29 Jul 2012
 02:22:56 -0400 (EDT)
In-Reply-To: <20120728121956.GA36429@book.hvoigt.net> (Heiko Voigt's message
 of "Sat, 28 Jul 2012 14:19:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D61D23E6-D945-11E1-8CBD-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202470>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Note: This is a code cleanup and does not fix any bugs. As a side effect
> the variables containing the parsed flags to "git submodule status" are
> passed down recursively. So everything was already behaving as expected.

If that is the case, shouldn't we stop passing anything down, if we
want it to be a "clean-up only, no behaviour changes" patch?  While
at it, we may want to kill that code to accumulate the original
options in orig_flags because we haven't been using the variable.

We _know_ $orig_args has been empty, i.e. the code has been working
fine with only cmd_status there.  Nobody has tried what happens when
we pass the original arguments to cmd_status on that line.  The
patch changes the behaviour of the code; it makes the command line
parsing "while" loop to run again, and if the code that accumulates
original options in orig_flags have been buggy, now that bug will be
exposed.




> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index dba4d39..3a3f0a4 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -961,7 +961,7 @@ cmd_status()
>  				prefix="$displaypath/"
>  				clear_local_git_env
>  				cd "$sm_path" &&
> -				eval cmd_status "$orig_args"
> +				eval cmd_status "$orig_flags"
>  			) ||
>  			die "$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
>  		fi
