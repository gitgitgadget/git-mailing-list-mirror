From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull: warn if only fetching tags with the -t switch
Date: Thu, 27 Dec 2007 22:37:42 -0800
Message-ID: <7vve6je349.fsf@gitster.siamese.dyndns.org>
References: <20071221124400.20725.qmail@db93e79e204cd8.315fe32.mid.smarden.org>
	<7v8x3oatvi.fsf@gitster.siamese.dyndns.org>
	<20071227093016.18337.qmail@e6d9fb481b7087.315fe32.mid.smarden.org>
	<7vwsr0ifqi.fsf@gitster.siamese.dyndns.org>
	<20071227144618.32373.qmail@5b51609f839e87.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 07:38:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J88rK-000412-Jp
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 07:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbXL1Ghw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 01:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbXL1Ghw
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 01:37:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbXL1Ghv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 01:37:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8942A7688;
	Fri, 28 Dec 2007 01:37:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 998B67687;
	Fri, 28 Dec 2007 01:37:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69276>

Gerrit Pape <pape@smarden.org> writes:

> Subject: [PATCH] git-pull: warn if only fetching tags with the -t switch
>
> git-pull -t|--tags isn't supposed to be run, remove that option from
> fetch-options.txt, and explicitely add it to git-fetch.txt.  Have git pull
> still fetch tags with the -t switch, but warn afterwards to better use
> git fetch --tags, and error out.
> ---
>
> How about this?

Thanks.

We coulc go with this for the time being for 1.5.4, but I am not
absolutely confident that ...

> +	# warn if only tags have been fetched
> +	not_for_merge=$(sed -e '/	not-for-merge	tag/d' \
> +			"$GIT_DIR"/FETCH_HEAD)
> +	if test "$not_for_merge" = ''; then

... FETCH_HEAD having nothing but not-for-merge tags would
happen _only_ when "pull --tags" is done.  If there are (bogus)
command line other than "pull --tags" that results in this
situation, we would be issuing a wrong error message.

A trivial example.  If you misconfigure your .git/config like
this:

        [remote "origin"]
                url = ...
                fetch = refs/head/*:refs/remotes/origin/*

and say:

	git pull

without even "--tags", then the resulting .git/FETCH_HEAD would
be empty, and the above test will trigger, even though the
correct diagnosis is the error message we currently give the
user.

So in that sense, the patch is a regression as it is.

Come to think of it, "git pull <anything>" is "git fetch
<anything>" followed by "git merge <something>", and what is
fetched by the first step "git fetch" and what is used by the
second step "git merge" are determined by what that <anything>
is.  The rules for the case where <anything> is empty are
clearly defined in the documentation for "git pull" (partly
because it was clear what should happen if <anything> was not
empty back when the documentation was written).

It appears that the explicit case also needs documentation.

The refs fetched are:

 + Having --tags on the command line is the same as replacing
   remote.$remote.fetch with refs/tags/*:refs/tags/* in the
   configuration.

 + If refspecs are explicitly given from the command line, they
   will be the ones that are fetched, and remotes.$remote.fetch
   is consulted unless they come from the above --tags.

 * Otherwise, remotes.$remote.fetch (and its equivalent in
   .git/remotes/$remote) are the ones that are fetched.

 * In addition, if branch.$current_branch.merge is specified but
   is not covered by the above, it also is fetched.

The refs merged are:

 + If refspecs are explicitly given from the command line, they
   will be the ones that are merged (nothing else is merged).

 * Otherwise branch.$current_branch.merge, if exists, is what is
   merged;

 * Otherwise,

   * globbing refspecs are ignored;

   * the first refspec from the configuration (or the equivalent
     from .git/remotes/$remote) is what is merged.

"git pull --tags" tells "git fetch" to fetch tags (and nothing
else -- because there is no explicit refspecs from the command
line, remotes.$remote.fetch which was replaced with the globbing
"grab all tags" is used), and as a result, there will not be
anything that is explicitly specified to be merged.  Because the
user initiated such a "pull", he deserves to be told about the
"mistake".

So (technically) there is no bug but PEBCAK here.  

HOWEVER.

It probably makes sense to change "git fetch [$remote] --tags"
to fetch tags _in addition to_ what are configured to be fetched
by default, instead of replacing as we currently do.  We could
call the current behaviour of --tags a misfeature that invites
the user "mistake".

Such a change will make "--tags" more transparent to the second
"git merge" phase of "git pull".  "git pull --tags [$remote]"
would become equivalent to "git pull [$remote]", except that as
an unrelated side effect it also fetches all tags.  I suspect
that would match the user expectation better.  Daniel, Shawn,
what do you think?

This is a bit more involved change than I would want to have
during -rc freeze.
