From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Fri, 11 Jan 2008 00:00:15 -0800
Message-ID: <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 09:01:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDEp1-0004ws-Ij
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 09:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbYAKIAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 03:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbYAKIAb
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 03:00:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbYAKIAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 03:00:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B924E5202;
	Fri, 11 Jan 2008 03:00:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A2CEC51FD;
	Fri, 11 Jan 2008 03:00:22 -0500 (EST)
In-Reply-To: <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> (Mark
	Levedahl's message of "Thu, 10 Jan 2008 22:29:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70136>

Mark Levedahl <mlevedahl@gmail.com> writes:

> This introduces a new configuration variable, remotes.default, that
> defines the name of the default remote to be used.

Does this mean "default" is now a new reserved word that cannot
be used as "git remote update default"?

> ... Traditionally, this
> is "origin", and could be overridden for a given branch. This change
> introduces a way to redefine the default as desired and have that honored
> regardless of the currently checked out head (e.g., remotes.default is
> used when on a detached head or any other non-tracking branch).

I'd 100% agree that being able to use anything not just
hardcoded 'origin' is much better than not being able to.  I do
not have much against that goal.

However, it is a bit hard to judge how much of inconvenience it
really is in your real life that the current behaviour does not
allow you to.

In your cover letter, you said:

>> As my project is distributed across multiple domains with
>> many firewalls and airgaps such that no single server is
>> available to all, we really need to use nicknames to refer
>> to different servers,...

If you need to access different repositories on different
machines from your submodules, you would of course need to
access different domains from your submodule repositories.  But
that does not mean each of them cannot be named 'origin'.  That
name is local to each of the submodule (and the toplevel) and
can point at different domains over different transfer channels.

> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 695a409..1b235e0 100755
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -56,8 +56,9 @@ get_remote_url () {
>  
>  get_default_remote () {
>  	curr_branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
> -	origin=$(git config --get "branch.$curr_branch.remote")
> -	echo ${origin:-origin}
> +	git config --get "branch.$curr_branch.remote" ||
> +	git config --get "remotes.default" ||
> +	echo origin

This sequence cascaded with || is much nicer than the original,
even if it did not change the behaviour.

> @@ -300,6 +305,10 @@ static void read_config(void)
>  			make_branch(head_ref + strlen("refs/heads/"), 0);
>  	}
>  	git_config(handle_config);
> +	if (!default_remote_name) {
> +			default_remote_name = remotes_default_name ?
> +				remotes_default_name : xstrdup("origin");
> +	}

Is this a bit too deep indentation?
