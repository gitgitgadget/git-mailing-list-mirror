From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] New config push.default to decide default behavior
 for push
Date: Wed, 11 Mar 2009 17:48:13 -0700
Message-ID: <7vwsavlg6q.fsf@gitster.siamese.dyndns.org>
References: <20090311220144.GA6782@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 01:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhZ7n-0005H1-Je
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 01:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbZCLAsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 20:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbZCLAsV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 20:48:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbZCLAsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 20:48:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 61EE05880;
	Wed, 11 Mar 2009 20:48:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9BAB8587F; Wed,
 11 Mar 2009 20:48:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A67E848-0E9F-11DE-97C0-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112991>

Finn Arne Gangstad <finnag@pvv.org> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f5152c5..6fdf829 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1160,6 +1160,25 @@ pull.octopus::
>  pull.twohead::
>  	The default merge strategy to use when pulling a single branch.
>  
> +push.default::
> +	Defines the action git push should take if no refspec is given
> +	on the command line, no refspec is configured in the remote, and
> +	no refspec is implied by any of the options given on the command
> +	line.
> +
> +	The term `current remote` means the remote configured for the current
> +	branch, or `origin` if no remote is configured. `origin` is also used
> +	if you are not on any branch.
> +
> +	Possible values are:
> ++
> +* `nothing` do not push anything.
> +* `matching` push all matching branches to the current remote.
> +  All branches having the same name in both ends are considered to be
> +  matching. This is the current default value.
> +* `tracking` push the current branch to whatever it is tracking.
> +* `current` push the current branch to a branch of the same name.
> +

I thought I fixed asciidoc formatting around this part in the version I
queued in 'pu'; in any case, the second and subsequent paragraphs need
dedenting.

> +static void warn_unconfigured_push()
> +{

I think I also fixed this "old style declaration".

> +static void do_default_push(struct remote *remote)
> +{
> +	git_config(git_default_config, NULL);
> +	switch (push_default) {
> +	case PUSH_DEFAULT_UNSPECIFIED:
> +		warn_unconfigured_push();
> +		/* fallthrough */
> +
> +	case PUSH_DEFAULT_MATCHING:
> +		add_refspec(":");
> +		break;
> +
> +	case PUSH_DEFAULT_TRACKING:
> +		setup_push_tracking(remote);
> +		break;
> +
> +	case PUSH_DEFAULT_CURRENT:
> +		add_refspec("HEAD");
> +		break;
> +
> +	case PUSH_DEFAULT_NOTHING:
> +		die("Nothing to push, and push is configured to push nothing "
> +		    "by default.");
> +		break;
> +	}
> +}

This part looks good, provided if we were to go ahead and plan to change
the default in the future.

> +static void setup_push_tracking(struct remote *remote)
> +{
> +	int n;
> +	struct branch *branch = branch_get(NULL);
> +	if (!branch)
> +		die("You are not currently on a branch.");
> +	if (!branch->merge_nr)
> +		die("The current branch %s is not tracking anything.",
> +		    branch->name);
> +	if (branch->remote != remote)
> +		die("The current branch is tracking \"%s\", not \"%s\"!",
> +		    branch->remote->name, remote->name);
> +	for (n = 0; n < branch->merge_nr; n++) {
> +		struct strbuf rs = STRBUF_INIT;
> +		strbuf_addf(&rs, "%s:%s", branch->name, branch->merge[n]->src);
> +		add_refspec(rs.buf);
> +	}
> +}

If a branch is configured to merge from multiple places (e.g. testing
branch similar to the linux-next tree to integrate from multiple staging
trees), a sane default would be not to push it out to any of the branches
it pulls from---it is a consumer to the other branches, and it is meant to
be sent to somewhere else, not back to any of the originators.  Instead,
this code will push to all of them, which I would not see any sane use
case for.  It might make a bit sense if you refused unless merge_nr is
exactly one.

Also I am not sure if the check between the name of the remote makes much
practical sense.  Many people use two remotes to name the same one for
pushing over ssh and fetching over git.  Which name comes in which?  I
think with this logic you are trying to catch a mistake like:

    $ git push --tracking $there

when the current branch tracks a remote branch that did not come from the
remote repository $there but somewhere else, but if that is the motivation
behind it, does it help to forbid "push --tracking" to take any
destination repository to reduce such a confusion?
