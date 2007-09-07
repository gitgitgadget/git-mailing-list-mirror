From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone: better error message if curl program is missing
Date: Fri, 07 Sep 2007 14:19:32 -0700
Message-ID: <7vtzq62mxn.fsf@gitster.siamese.dyndns.org>
References: <20070907171400.28590.qmail@d780fac1e27de6.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 23:19:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITlEq-00047B-1f
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 23:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758420AbXIGVTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 17:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758530AbXIGVTe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 17:19:34 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47793 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758420AbXIGVTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 17:19:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070907211934.CMWK20651.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 7 Sep 2007 17:19:34 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id lZKZ1X0011gtr5g0000000; Fri, 07 Sep 2007 17:19:33 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58077>

Gerrit Pape <pape@smarden.org> writes:

> If the curl program is not available, and git clone is started to clone a
> repository through http, this is the output
>
>  Initialized empty Git repository in /tmp/puppet/.git/
>  /usr/bin/git-clone: line 37: curl: command not found

Perhaps we should die at this point so that...

>  Cannot get remote repository information.
>  Perhaps git-update-server-info needs to be run there?

the user does not have to see this.

In other words, instead of this:

>  http_fetch () {
>  	# $1 = Remote, $2 = Local
> +	type curl >/dev/null 2>&1 ||
> +	    die "The curl program is not available"
>  	curl -nsfL $curl_extra_args "$1" >"$2"
>  }

something like this, perhaps:

	http_fetch () {
        	# $1 = remote, $2 = local
               	curl -nsfL $curl_extra_args "$1" >"$2" || exit
	}

Then the shell would say "curl: command not found" and we would
stop.

I am just hestating to use "type" there (yeah, I know mergetool
has one but that one is not as close to the core of the workflow
as git-fetch is).

BTW, isn't it a packaging bug not to depend git-fetch on curl?
