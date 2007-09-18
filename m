From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] instaweb: added support Ruby's WEBrick server
Date: Tue, 18 Sep 2007 16:15:52 -0700
Message-ID: <7vodfztviv.fsf@gitster.siamese.dyndns.org>
References: <20070918121634.E8EFF814635@cyrano>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: mike@csa.net (mike dalessio)
X-From: git-owner@vger.kernel.org Wed Sep 19 01:16:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXmIV-0007dn-3R
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 01:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbXIRXP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 19:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbXIRXP6
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 19:15:58 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbXIRXP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 19:15:57 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FBC3137404;
	Tue, 18 Sep 2007 19:16:15 -0400 (EDT)
In-Reply-To: <20070918121634.E8EFF814635@cyrano> (mike dalessio's message of
	"Tue, 18 Sep 2007 08:16:34 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58657>

mike@csa.net (mike dalessio) writes:

> diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
> index cec60ee..914fc4c 100644
> --- a/Documentation/git-instaweb.txt
> +++ b/Documentation/git-instaweb.txt
> @@ -27,7 +27,8 @@ OPTIONS
>  	The HTTP daemon command-line that will be executed.
>  	Command-line options may be specified here, and the
>  	configuration file will be added at the end of the command-line.
> -	Currently, lighttpd and apache2 are the only supported servers.
> +	Currently, lighttpd, apache2 and webrick are the only supported
> +	servers.
>  	(Default: lighttpd)

Perhaps we can start thinking about rewording "are the only
suported servers" to "are supported".

> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index b79c6b6..803a754 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -37,7 +37,9 @@ start_httpd () {
>  	else
>  		# many httpds are installed in /usr/sbin or /usr/local/sbin
>  		# these days and those are not in most users $PATHs
> -		for i in /usr/local/sbin /usr/sbin
> +		# in addition, we may have generated a server script
> +		# in $fqgitdir/gitweb.
> +		for i in /usr/local/sbin /usr/sbin $fqgitdir/gitweb
>  		do
>  			if test -x "$i/$httpd_only"
>  			then

I do not think this hunk belongs to this patch.  It alone would
be a useful addition to the program even without the rest of
your patch, wouldn't it?  Imagine a case where I automatically
would reject all patches that have "Ruby" in it for some unknown
reason.  Do we want to drop this hunk in such a case?

> +	# generate a shell script to invoke the above ruby script,
> +	# which assumes _ruby_ is in the user's $PATH. that's _one_
> +	# portable way to run ruby, which could be installed anywhere,
> +	# really.

No games with env, type, nor which.  Good.

Just a few style things (-) and one concern (+):

> +	cat > "$fqgitdir/gitweb/$httpd" <<EOF
> +#! /bin/sh
> +ruby $fqgitdir/gitweb/$httpd.rb \$*
> +EOF

 - I do not like extra whitespace between she-bang #! and the
   path.  Looks very ugly.

 - I do not like extra whitespace between redirection > and
   redirected filename either.  Looks very ugly.

 - I prefer such wrapper to exec the command, like this:

	#!/bin/sh
        exec ruby ...

 + fqgitdir and httpd need to be shell quoted.  I do not think
   anybody is stupid enough to have his GIT_DIR set to something
   like "/opt/funny/; rm -f / nuke-me/.git/" but you would see
   spaces and single quotes in pathnames in odd environments.

I wonder how popular instaweb is and how widely it is used.
I've actually wondering if we should demote it to contrib/
somewhere, but it gets occasional updates so people must be
using it...
