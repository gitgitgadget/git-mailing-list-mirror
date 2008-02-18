From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Mon, 18 Feb 2008 12:59:13 -0800
Message-ID: <7vir0mnfq6.fsf@gitster.siamese.dyndns.org>
References: <1203342817-19653-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 22:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRD61-0004dk-6s
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 22:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbYBRU7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbYBRU7l
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:59:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbYBRU7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:59:39 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EF32796A;
	Mon, 18 Feb 2008 15:59:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 371187968; Mon, 18 Feb 2008 15:59:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74353>

Jay Soffian <jaysoffian@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index fb6dae0..f15fe0a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -378,11 +378,14 @@ apply.whitespace::
>  	as the '--whitespace' option. See linkgit:git-apply[1].
>  
>  branch.autosetupmerge::
> ...
> +	Tells `git-branch` and `git-checkout` to setup `branch.*.remote`
> +	and `branch.*.merge` for new branches so that linkgit:git-pull[1]
> +	will appropriately merge from that upstream branch. Note that even
> +	if this option is not set, this behavior can be chosen per-branch
> +	using the `--track`	and `--no-track` options. This option defaults

You have an unintended tab there.

> +	to true, which will setup tracking for remote branches. Set it to
> +	`always` to automatically setup the aforementioned options for local
> +	upstream branches as well.

I somehow find it easier to read if the default is always
described at the end of the paragraph, i.e. "Setting this to
value X does foo, Y does bar, Z does baz. Defaults to X.", but
that may be just me.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 7e8874a..ce2fc64 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -105,20 +105,20 @@ OPTIONS
>  	Display the full sha1s in output listing rather than abbreviating them.
>  
>  --track::
> ...
> +	Set up configuration so that git-pull will
> +	automatically retrieve data from the upstream branch.  Use this if
> +	you always pull from the same upstream branch into the new branch,
> +	or if you don't want to use "git pull <repository> <refspec>"
> +	explicitly. This behavior is the default for remote branches.
> +	Set the branch.autosetupmerge configuration variable to false if you
> +	want git-checkout and git-branch to always behave as if '--no-track'
> +	were given. Set it to 'always' if you want git-checkout and git-branch
> +	to always behave as if '--track' were given.

Re-wrapping the
paragraph at an unusual place.  It is Ok to do so if it is done
to keep the unchanged part intact to minimize the diff text, but
otherwise, please don't.

You reworded "remote branch" to "upstream branch" here and other
places.  I think that makes the intention easier to understand.
It is "the branch this new branch intends to build on top of",
so the earlier text should have said "remote tracking branch"
but the intention has always been to mean "on top of whom will I
be building".

This is not a flaw in your patch, but I suspect "or if you
don't want to" should have been "and if you don't want to".

"This behaviour is the default for remote branches" feels a bit
odd.  It confuses the first time reader as if you are saying "if
you are creating a remote branch with "git-branch" command, this
behaviour is the default", which is not what you are saying.  I
think "... the default when forking off of a remote tracking
branch" is what you meant.

>  --no-track::
> -	When a branch is created off a remote branch,
> -	set up configuration so that git-pull will not retrieve data
> -	from the remote branch, ignoring the branch.autosetupmerge
> -	configuration variable.
> +	Ignore the branch.autosetupmerge configuration variable. When
> +	using git pull with the new branch, a <refspec> will have to be
> +	given explicitly.

This rewrite probably has made the description easier to understand.

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index b4cfa04..ad2ab51 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -48,21 +48,20 @@ OPTIONS
>  	may restrict the characters allowed in a branch name.
>  
>  --track::
> ...
> +	When -b is given set up configuration so that git-pull will

s/given/&,/;

> +	automatically retrieve data from the upstream branch.  Use this if
> +	you always pull from the same upstream branch into the new branch,
> +	or if you don't want to use "git pull <repository> <refspec>"
> +	explicitly. This behavior is the default for remote branches.

The same comment on "or if you don't want to" applies.

> @@ -49,8 +49,12 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst = (char *)orig_ref;
>  	if (for_each_remote(find_tracked_branch, &tracking) ||
> -			!tracking.matches)
> -		return 1;
> +			!tracking.matches) {
> +		if (!always)
> +			return 1;
> +		tracking.matches = 1;
> +		tracking.src = xstrdup(orig_ref);
> +	}

I suspect this is a clever fallback to pretend as if you have
[remote "."] fetch=refs/*:refs/* when nothing else matches, but
I think it needs an explanation why this is a good idea and
would not break others.  Also I suspect this should be moved
after you see for-each-remote returns without error and did not
find any match.

> @@ -71,7 +76,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
>  
>  void create_branch(const char *head,
>  		   const char *name, const char *start_name,
> -		   int force, int reflog, int track)
> +		   int force, int reflog, enum branch_track track)
>  {
>  	struct ref_lock *lock;
>  	struct commit *commit;
> @@ -130,7 +135,7 @@ void create_branch(const char *head,
>  	   automatically merges from there.  So far, this is only done for
>  	   remotes registered via .git/config.  */
>  	if (real_ref && track)
> -		setup_tracking(name, real_ref);
> +		setup_tracking(name, real_ref, (track == BRANCH_TRACK_ALWAYS));

It probably is better to pass 'track' itself and have the
special case logic inside setup_tracking() instead.  Maybe we
would want to add new tracking mode that needs different
matching logic there later.

The move to default_config() is probably a good idea.

> diff --git a/cache.h b/cache.h
> index 2b59c44..90b3a9e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -393,6 +393,14 @@ enum safe_crlf {
>  
>  extern enum safe_crlf safe_crlf;
>  
> +enum branch_track {
> +	BRANCH_TRACK_REMOTES_FALSE = 0,
> +	BRANCH_TRACK_REMOTES_TRUE,
> +	BRANCH_TRACK_ALWAYS,
> +};

Perhaps BRANCH_TRACK_{NEVER,REMOTE,ALWAYS} would be easier
(although I cannot decide if s/NEVER/FALSE/ would be better)?
