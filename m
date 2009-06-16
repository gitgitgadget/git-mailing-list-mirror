From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 4/4] am, rebase: teach quiet option
Date: Mon, 15 Jun 2009 22:57:29 -0700
Message-ID: <7vbpoog1py.fsf@alter.siamese.dyndns.org>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
	<1245117905-19351-2-git-send-email-bebarino@gmail.com>
	<1245117905-19351-3-git-send-email-bebarino@gmail.com>
	<1245117905-19351-4-git-send-email-bebarino@gmail.com>
	<1245117905-19351-5-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Adam <thomas.adam22@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 08:01:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGRjK-000770-2F
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 08:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936563AbZFPF5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 01:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935591AbZFPF5a
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 01:57:30 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33345 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936562AbZFPF52 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 01:57:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090616055729.RQGZ20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 16 Jun 2009 01:57:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4VxV1c0074aMwMQ04VxVQN; Tue, 16 Jun 2009 01:57:29 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=HfqTPdwKAEAA:10 a=pGLkceISAAAA:8
 a=unZsplQpVa3h8eyx0lAA:9 a=iNqNWkjFE38j55sqc68A:7
 a=PDUhBmrVo2IK_FM3bubkNSuTG2cA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121656>

Stephen Boyd <bebarino@gmail.com> writes:

> git-rebase and git-am are talkative scripts. This option will quiet
> them and allow them to speak only when they fail or experience errors.
>
> Note that git-am with 3way will output errors when applying, even though
> the 3way will usually be successfull. We suppress these errors from
> git-apply because they are not "true" errors until the 3way has been
> attempted.

Thanks.

> @@ -498,11 +505,18 @@ do
> ...
>  	case "$resolved" in
>  	'')
> -		eval 'git apply '"$git_apply_opt"' --index "$dotest/patch"'
> +		if test "$threeway" = t && test -n "$GIT_QUIET"
> +		then
> +			eval 'git apply '"$git_apply_opt" \
> +			' --index "$dotest/patch" > /dev/null 2>&1'
> +		else
> +			eval 'git apply '"$git_apply_opt" \
> +			' --index "$dotest/patch"'
> +		fi
>  		apply_status=$?

Hmm, this long conditional body looks ugly, and I suspect it is harder to
maintain than necessary.  Can we do something about it?

	# When we are allowed to fall back to 3-way later, don't give
        # false errors during the initial attempt.
	squelch=
	if test "$threeway" = t && test -n "$GIT_QUIET"
	then
		squelch='>/dev/null 2>&1 '
	fi
        eval "git apply $squelch$git_apply_opt"' --index "$dotest/patch"'

> @@ -72,11 +72,20 @@ continue_merge () {
>  			echo "directly, but instead do one of the following: "
>  			die "$RESOLVEMSG"
>  		fi
> -		printf "Committed: %0${prec}d " $msgnum
> +		if test -z "$GIT_QUIET"
> +		then
> +			printf "Committed: %0${prec}d " $msgnum
> +		fi
>  	else
> -		printf "Already applied: %0${prec}d " $msgnum
> +		if test -z "$GIT_QUIET"
> +		then
> +			printf "Already applied: %0${prec}d " $msgnum
> +		fi
> +	fi
> +	if test -z "$GIT_QUIET"
> +	then
> +		git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'
>  	fi
> -	git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'

This is very good, because a straightforward translation is what we want
in this particular patch.

We however would want to update this using

	git show -s --oneline

or something, perhaps even with a custom --format='...', in a follow-up
patch.  This "rev-list --pretty=oneline" piped to sed looks very much
antiquated.

> @@ -445,15 +460,15 @@ then
>  	then
>  		# Lazily switch to the target branch if needed...
>  		test -z "$switch_to" || git checkout "$switch_to"
> -		echo >&2 "Current branch $branch_name is up to date."
> +		say >&2 "Current branch $branch_name is up to date."
>  		exit 0

Ah, I was blind.

While sending non-error messages to stderr is justifiable, I do not think
this one is, because all the other progress-y message in this program we
reviewed so far go to stdout.  I think we should drop >&2 here.

> @@ -471,7 +486,7 @@ fi
>  # we just fast forwarded.
>  if test "$mb" = "$branch"
>  then
> -	echo >&2 "Fast-forwarded $branch_name to $onto_name."
> +	say >&2 "Fast-forwarded $branch_name to $onto_name."

Ditto.

There is one more thing to think about in git-am, which I do not think you
addressed.  Consider this scenario.

    (1) Tell am to run quietly, feeding a four-patch series.

	$ git am -q -3 mbox

    (2) The first patch applies cleanly; the second one does not apply,
        even with -3, and leaves conflict (you did the right thing not to
        squelch the message when this happens).

    (3) You fix it up, and save the result from your editor, and tell it
        to continue.

	$ git am --resolved

Now, should the second invocation be also quiet, or talkative as default?

Note that the third and fourth patch are applied with -3 option in effect,
even though you did not say -3 when you restarted "am" with --resolved
(cf. ll.280-340 in git-am.sh).
