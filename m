From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-1.5 and bare repos
Date: Tue, 13 Mar 2007 10:03:41 -0700
Message-ID: <7vbqixjcsy.fsf@assigned-by-dhcp.cox.net>
References: <20070313160950.GA14163@dudweiler.stuttgart.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian La Roche <laroche@redhat.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 18:03:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRAPa-000056-IY
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 18:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030801AbXCMRDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 13:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030802AbXCMRDm
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 13:03:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48070 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030801AbXCMRDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 13:03:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070313170342.ODZP748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Mar 2007 13:03:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aH3h1W00A1kojtg0000000; Tue, 13 Mar 2007 13:03:41 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42136>

Florian La Roche <laroche@redhat.com> writes:

> Here a patch to correctly allow also bare
> repositories.
>
> ...
>
> --- git-sh-setup.sh	2007-03-05 03:15:33.000000000 +0100
> +++ git-sh-setup	2007-03-13 17:08:22.000000000 +0100
> @@ -49,8 +49,8 @@
>  
>  require_work_tree () {
>  	test $(is_bare_repository) = false &&
> -	test $(git-rev-parse --is-inside-git-dir) = false ||
> -	die "fatal: $0 cannot be used without a working tree."
> +	{ test $(git-rev-parse --is-inside-git-dir) = false ||
> +	  die "fatal: $0 cannot be used without a working tree."; }
>  }
>  
>  if [ -z "$LONG_USAGE" ]

Changing the meaning of the function and call the change "to
correctly allow" needs a bit more explanation.  The function is
supposed to be called by certain operations to make sure that
they are not run from anywhere other than inside a working tree
associated with the repository, and that is why it says "we are
happy when the repository is not bare and we are not inside .git
directory --- otherwise we are unhappy".

I suspect that you found a command that calls this function,
when it should also be usable in a bare repository.  If that is
the case, the caller needs to be fixed, perhaps not to call this
function at all, or perhaps call it only before performing an
operation that _needs_ working tree (I do not think of an
example offhand, but it is conceivable that a command can work
fine in a bare repository under an option but requires a working
tree with a different option).  Changing the meaning of this
function so that it is always happy with bare repository means
you are breaking the assumption of other callers.

For example, git-fetch in a bare repository is fine.  It is an
operation to update the object database and (optionally) advance
the refs used to track the other side.  On the other hand,
git-pull, git-reset nor git-checkout are not.  As they are meant
to update the working tree from the repository, running them in
a bare repository, which lacks the working tree by definition,
does not make sense.  That is why they use this function.
