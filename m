From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Make git-pull give hints on what to do when there is no branch to merge from
Date: Tue, 18 Sep 2007 16:00:47 -0700
Message-ID: <7vsl5btw80.fsf@gitster.siamese.dyndns.org>
References: <1190077493.22387.54.camel@cacharro.xalalinux.org>
	<1190077948.22387.66.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Federico Mena Quintero <federico@novell.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:01:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXm3y-0003uE-A6
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 01:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbXIRXA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 19:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbXIRXA5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 19:00:57 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbXIRXA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 19:00:56 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4489A1379F3;
	Tue, 18 Sep 2007 19:01:13 -0400 (EDT)
In-Reply-To: <1190077948.22387.66.camel@cacharro.xalalinux.org> (Federico Mena
	Quintero's message of "Mon, 17 Sep 2007 20:12:28 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58655>

Federico Mena Quintero <federico@novell.com> writes:

> Signed-off-by: Federico Mena Quintero <federico@gnu.org>
> ---
>  git-pull.sh |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 5e96d1f..7beef4d 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -98,7 +98,11 @@ case "$merge_head" in
>  	curr_branch=${curr_branch#refs/heads/}
>  
>  	echo >&2 "Warning: No merge candidate found because value of config option
> -         \"branch.${curr_branch}.merge\" does not match any remote branch fetched."
> +         \"branch.${curr_branch}.merge\" does not match any remote branch fetched.
> +         This branch is not set up to track any other branches.  Please name which
> +         branch you want to merge from on the command line, or if you almost always
> +         want to merge from the same branch, then set this up with
> +         \"git branch --track\"."

This is a nice attempt, but can you use "git branch --track" to
set this?  What does the command line look like?

This error can come when branch.<foo>.merge does not match what
remote.<bar>.fetch says (where branch.<foo>.remote is <bar>),
but it is my understanding that the builtin-fetch work by Daniel
and Shawn would fetch branch.<foo>.merge as well to reduce this
error.  Another possibility is when the user does not have any
branch.<foo>.merge.

I am inclined to suggest rewording the message like this, and
make this condition an error (i.e. "exit 1"):

    You asked me to pull without telling me which branch you
    want to merge with, and 'branch.${curr_branch}.merge' in
    your configuration file does not tell me either.  Please
    name which branch you want to merge on the command line and
    try again.

    If you often merge with the same branch, you may want to
    configure the following variables in your configuration
    file:

	branch.${curr_branch}.remote = <nickname>
	branch.${curr_branch}.merge = <remote-ref>
        remote.<nickname>.url = <url>
        remote.<nickname>.fetch = <refspec>

    See git-config(1) for details.
