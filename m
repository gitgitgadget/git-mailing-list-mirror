From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit: if run with <file> arguments, include files removed through git rm
Date: Tue, 04 Sep 2007 09:00:13 -0700
Message-ID: <7vabs2pgj6.fsf@gitster.siamese.dyndns.org>
References: <20070904144304.5920.qmail@42e302a26078dc.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:00:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISapE-0003K1-70
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbXIDQAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbXIDQAU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:00:20 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbXIDQAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:00:19 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 47DA612E52F;
	Tue,  4 Sep 2007 12:00:37 -0400 (EDT)
In-Reply-To: <20070904144304.5920.qmail@42e302a26078dc.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Tue, 4 Sep 2007 14:43:04 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57603>

Gerrit Pape <pape@smarden.org> writes:

> This patch lets it additionally use git ls-tree to look for the files in
> the HEAD tree, but I guess there's a smarter way to fix this.

You raised a good issue, but this also needs other parts of the
system to be adjusted.

>  		commit_only=`git ls-files --error-unmatch -- "$@"` || exit
> +		commit_only="$commit_only "`git ls-tree -r --name-only HEAD -- "$@"` || exit

The arguments to git-commit are *NOT* "<file> arguments".  They
are file patterns and 'ls-files --error-unmatch -- "$@"' is
there to allow you to say something like:

	$ git commit 'p*/*.c'

Alas, ls-tree does not grok globbing yet.  Try this in git.git
repository (surrounding quotes are essential):

	$ git ls-files 'p*/*.c'
        $ git ls-tree -r HEAD 'p*/*.c'

Currently we have two semantics of "pathspec", and unifying
these semantics is one of the items with somewhat higher
priority on my TODO list for the 1.5.4 cycle (I started looking
at diff-tree and log last night):

 * ls-files, diff-files, diff-index and grep understand both
   "leading directory prefix" and "glob pattern"; you can say:

	$ git ls-files -- arm/ 'p*/*.c'
	$ git grep int -- arm/ 'p*/*.c'

   and they do what you would expect them to do.

 * diff-tree, log family and ls-tree understand only "leading
   directory prefix" and not "glob pattern"; you cannot say:

	$ git log -- 'p*/*.c'

So your patch is a definite improvement for normal ("non
pattern" but "exact pathname") case, but needs the updates to
pathspec semantics to be the correct fix.
