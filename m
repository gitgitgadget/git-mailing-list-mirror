From: Arnaud Fontaine <arnau@debian.org>
Subject: Re: [PATCH] Do not ignore merge options in interactive rebase
Date: Tue, 02 Jul 2013 17:05:13 +0900
Organization: Debian
Message-ID: <87sizx2xqe.fsf@duckcorp.org>
References: <87bo70dokb.fsf@duckcorp.org>
	<7vr4fvkxew.fsf@alter.siamese.dyndns.org>
	<87bo6wyn0z.fsf@duckcorp.org> <87ppvcx84r.fsf@duckcorp.org>
	<7v61x23yv9.fsf@alter.siamese.dyndns.org>
	<7v61x22av9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 10:05:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utvau-0004wl-DY
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 10:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254Ab3GBIFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 04:05:41 -0400
Received: from Orfeo.duckcorp.org ([193.17.192.211]:56240 "EHLO
	mx1.duckcorp.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152Ab3GBIFW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 04:05:22 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx1.duckcorp.org (Postfix) with ESMTPSA id 3bkyg04Q37z2J4q;
	Tue,  2 Jul 2013 10:05:16 +0200 (CEST)
X-URL: http://www.debian.org
X-Operating-System: Debian GNU/Linux
X-GnuPG-KeyID: 5E3619D3
X-PGP-Fingerprint: D792 B8A5 A567 B001 C342  2613 BDF2 A220 5E36 19D3
In-Reply-To: <7v61x22av9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 25 Jun 2013 13:28:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229373>

Hello,

Sorry for the late reply.

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> You should use ${var:+if_set_to_nonempty_use_this} here.
>> ...
>> So munging it manually with sloppy "sed" script is simply wrong.
>
> Perhaps something like this on top of your patch squashed in?
>
> The  eval magic  lets  the  shell to  split  $strategy_opts back  into
> individual words (e.g. "--subtree=My Project" is a single word), strip
> the leading "--",  and then uses "rev-parse --sq-quote"  again to turn
> them into "-X 'subtree=My Project'" (two words), which can be inserted
> into a string later to be eval'ed.
>
>  git-rebase--interactive.sh | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index e558397..ae2da7a 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -83,8 +83,13 @@ rewritten_pending="$state_dir"/rewritten-pending
>  strategy_args=
>  if test -n "$do_merge"
>  then
> -	strategy_args="${strategy+--strategy=$strategy}
> - $(echo $strategy_opts | sed "s/'--\([^']*\)'/-X\1/g")"
> +	strategy_args=${strategy:+--strategy=$strategy}
> +	eval '
> +		for strategy_opt in '"$strategy_opts"'
> +		do
> +			strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
> +		done
> +	'
>  fi
>  
>  GIT_CHERRY_PICK_HELP="$resolvemsg"
> @@ -246,7 +251,7 @@ pick_one () {
>  
>  	test -d "$rewritten" &&
>  		pick_one_preserving_merges "$@" && return
> -	output git cherry-pick $strategy_args $empty_args $ff "$@"
> +	output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
>  }
>  
>  pick_one_preserving_merges () {
> @@ -347,9 +352,8 @@ pick_one_preserving_merges () {
>  			msg_content="$(commit_message $sha1)"
>  			# No point in merging the first parent, that's HEAD
>  			new_parents=${new_parents# $first_parent}
> -			if ! do_with_author output \
> -				git merge --no-ff $strategy_args -m \
> -					"$msg_content" $new_parents
> +			if ! do_with_author output eval \
> +			'git merge --no-ff $strategy_args -m "$msg_content" $new_parents'
>  			then
>  				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
>  				die_with_patch $sha1 "Error redoing merge $sha1"
> @@ -357,7 +361,7 @@ pick_one_preserving_merges () {
>  			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
>  			;;
>  		*)
> -			output git cherry-pick $strategy_args "$@" ||
> +			output eval git cherry-pick "$strategy_args" "$@" ||
>  				die_with_patch $sha1 "Could not pick $sha1"
>  			;;
>  		esac

Indeed, this is much  better this way. Thank you very  much! I have just
squashed your patch into mine and ran successfully t3404 and t3421 tests
after rebasing my branch on top of current master.

I will send  the final patch in  another email. Of course,  feel free to
take authorship of the patch or add yourself as Signed-off-by.

Cheers,
-- 
Arnaud Fontaine
