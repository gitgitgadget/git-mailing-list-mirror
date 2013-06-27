From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/5] git-remote-mediawiki: new git bin-wrapper for developement
Date: Thu, 27 Jun 2013 10:57:53 -0700
Message-ID: <7vr4fnsafy.fsf@alter.siamese.dyndns.org>
References: <1372354652-4147-1-git-send-email-benoit.person@ensimag.fr>
	<1372354652-4147-3-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Thu Jun 27 19:58:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsGSG-0001ou-FQ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631Ab3F0R54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 13:57:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab3F0R54 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 13:57:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6586D2A5AA;
	Thu, 27 Jun 2013 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=onp5O7I3rtdXN/vAWq8j2FwgudE=; b=O2SSNr
	aZN3Re0PujztQt/PLOKDK4Svz+NSLVGdCJ9Z/L/xZHxGRqnsYkKpafIDkRIGY9iU
	up4yUrlMyT6S1uorQoE71nQtxadMLzf5lngApVsKK6j5H9o7L5p7JJ51pzbdt+II
	77JoEKZEV5YiaXAX5hw8UDCCa+b0L10PxXjFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UhaW/xQjfuV+tvbY2CY6O+4p4U16BEOu
	jo29817XqI3uCWt4asY+eb6bR3Uv5NhP3Ktad2W6Wb+SNwevbTXjgyxBG49ggQRJ
	iQahJL1LNzZnv3vCX56beN0ktTuUE6qFzcnzKEsw56rNdoCSW6cRPYdhOIsL8cPD
	289e+mroblg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5979C2A5A9;
	Thu, 27 Jun 2013 17:57:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABB3C2A5A5;
	Thu, 27 Jun 2013 17:57:54 +0000 (UTC)
In-Reply-To: <1372354652-4147-3-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 27 Jun 2013 19:37:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17AEA910-DF53-11E2-B060-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229135>

benoit.person@ensimag.fr writes:

> diff --git a/contrib/mw-to-git/bin-wrapper/git b/contrib/mw-to-git/bin-wrapper/git
> new file mode 100755
> index 0000000..aa714a5
> --- /dev/null
> +++ b/contrib/mw-to-git/bin-wrapper/git
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +
> +# git executable wrapper script for Git-Mediawiki to run tests without
> +# installing all the scripts and perl packages.
> +
> +# based on $GIT_ROOT_DIR/wrap-for-bin.sh

I really do not like the smell of this.

As far as I can tell, the only real reason why you need this and
cannot use ../../bin-wrappers/git directly is because the GITPERLLIB
it gives you only points at ../../perl/blib/lib and not this
directory.

Two possible alternatives:

 - Is there a reason you would not want to "install" whatever Perl
   modules you want to "use" via GITPERLLIB mechanism to
   ../../perl/blib/lib?  Perhaps it will interfere with the real
   installation step in ../../perl/Makefile?  If that is the case,
   then it is not a good idea, but otherwise, that would let you use
   ../../bin-wrappers/git as-is.

 - Perhaps we could do:

	GITPERLLIB="${GPLEXTRA+$GPLEXTRA:}@@BUILD_DIR@@/perl/blib/lib"

   in wrap-for-bin.sh, so that your instruction can become

	GPLEXTRA=$(pwd) ../../bin-wrappers/git whatever-mw-thing

   and you do not have to have this file?  We would also need to
   "unset GPLEXTRA" at the beginning of test-lib.sh if we were to do
   this.

How does a developer (or user) use this script?  From your Makefile
(e.g. "make test")?  Manually following some written instruction?
In either case, the latter option feels a lot more sensible
alternative without having to maintain this extra copy of wrap-for-bin
that can easily go out of sync.

> +
> +
> +GIT_ROOT_DIR=../../..
> +GIT_EXEC_PATH=$(cd "$(dirname "$0")" && cd ${GIT_ROOT_DIR} && pwd)
> +
> +echo $GIT_EXEC_PATH
> +
> +if test -n "$NO_SET_GIT_TEMPLATE_DIR"
> +then
> +	unset GIT_TEMPLATE_DIR
> +else
> +	GIT_TEMPLATE_DIR="$GIT_EXEC_PATH"'/templates/blt'
> +	export GIT_TEMPLATE_DIR
> +fi
> +# Hack to make the `use lib` call works with multiple paths
> +GITPERLLIB="$GIT_EXEC_PATH"'/contrib/mw-to-git:'"$GIT_EXEC_PATH"'/perl/blib/lib'
> +GIT_TEXTDOMAINDIR="$GIT_EXEC_PATH"'/po/build/locale'
> +PATH="$GIT_EXEC_PATH"'/contrib/mw-to-git:'"$GIT_EXEC_PATH"'/bin-wrappers:'"$PATH"
> +export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
> +
> +exec "${GIT_EXEC_PATH}/git" "$@"
