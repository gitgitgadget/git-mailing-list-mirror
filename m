From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle - bundle objects and references for disconnected
 transfer.
Date: Wed, 14 Feb 2007 22:58:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:58:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHS91-0002A9-90
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbXBNV6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbXBNV6T
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:58:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:38300 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932665AbXBNV6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:58:17 -0500
Received: (qmail invoked by alias); 14 Feb 2007 21:58:15 -0000
X-Provags-ID: V01U2FsdGVkX1+OCboegkOORaA3yS+xwnOdi7qKpbYzRIOE8p8XsA
	JrDw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <11714622292295-git-send-email-mdl123@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39761>

Hi,

On Wed, 14 Feb 2007, Mark Levedahl wrote:

> +bfile=bundle.zip
> +for arg in $myargs ; do
> +	case "$arg" in
> +		--bare)
> +			export GIT_DIR=.;;

This is not necessary. You should do this instead:

	. git-sh-setup

It should autodetect if you are running in a bare repo. Also, it gives you 
the nice die and help functions.

> +		-h|--h|--he|--hel|--help)
> +			echo "$USAGE"
> +			exit;;
> +		--output=*)
> +			bfile=${arg##--output=};;

Throughout git, we seem to do both "--output=<bla>" _and_ "--output <bla>" 
forms, or just the latter.

> +GIT_DIR=$(git-rev-parse --git-dir) || die "Not in a git directory"

Again, this is done by git-sh-setup

> +git-show-ref $refs > .gitBundleReferences

Would it not be better to say explicitely which refs are expected to be 
present already (they start with "^" in the output of `git-rev-parse`, but 
you would need to do a bit more work, since you cannot just take the 
symbolic names).

Some general remarks:

It would be so much nicer if you worked without temporary files (you could 
do that by starting the file with the refs, then have an empty line, and 
then just pipe the pack after that).

IMHO reliance on $(git fsck | grep ^missing) is not good. The file check 
might take very, very long, or use much memory. And you _can_ do better 
[*1*].

Also, your use of shallow is incorrect. If the boundary commits are 
present, you might just leave them as-are, but if they are not present, 
you have to mark them as shallow. Otherwise, you end up with a corrupt 
(not shallow) repository.

Ciao,
Dscho

[*1*] Instead of providing a list "<hash> <refname>" with just the refs to 
be updated, append a list "<hash> ^<refname>" with the refs which _have_ 
to be present in order to succeed. You get this list by

	gitrevnotargs=$(git-rev-parse --symbolic --revs-only --not $*)
	git show-ref $gitrevnotargs | sed 's/^\(.\{41\}\)/&^/'
