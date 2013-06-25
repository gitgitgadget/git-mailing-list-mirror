From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not ignore merge options in interactive rebase
Date: Tue, 25 Jun 2013 13:28:42 -0700
Message-ID: <7v61x22av9.fsf@alter.siamese.dyndns.org>
References: <87bo70dokb.fsf@duckcorp.org>
	<7vr4fvkxew.fsf@alter.siamese.dyndns.org>
	<87bo6wyn0z.fsf@duckcorp.org> <87ppvcx84r.fsf@duckcorp.org>
	<7v61x23yv9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Arnaud Fontaine <arnau@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 22:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrZrD-0006yE-M3
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 22:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab3FYU2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 16:28:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59227 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab3FYU2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 16:28:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3B512BF1F;
	Tue, 25 Jun 2013 20:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=AILXVXRKtue+OqaDcQgYt8EtWOM=; b=lLiFGVTbbc2LMNuYh5J7
	Qrcvev7KOhM8OvqfaAdPFAba2MlBKj/ULxZ1qUT7AM6MXTkIXG1Kk+T1y3LFtsJD
	y9iPoS3gmNl9E9JPuKrRpRxWhmQfUTXXyNgVMlepQ7C1LXJHCbDrfdeUWVCdVdyX
	Wrv5bZdQc2PNfQBwH1vJt6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HgkG9bdgME6D8591RkzWUz0FAZ/3nZF4qSRA/lp8VJNd7G
	zL4aiv+1OAkstebdRbcfDrNXAkZ5DK8ZfEY14PUtXbZ/3MXSEmoh+XmVfYmOLjyD
	LQJdK9pY7xOPQjXCKaI5iGFVqjLyQ2w77/4+fD3B+W10OaPHsAdeNWF1EQYZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7D532BF1E;
	Tue, 25 Jun 2013 20:28:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 435402BF1C;
	Tue, 25 Jun 2013 20:28:44 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4D1E5CC-DDD5-11E2-B5AC-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228988>

Junio C Hamano <gitster@pobox.com> writes:

> You should use ${var:+if_set_to_nonempty_use_this} here.
> ...
> So munging it manually with sloppy "sed" script is simply wrong.

Perhaps something like this on top of your patch squashed in?

The eval magic lets the shell to split $strategy_opts back into
individual words (e.g. "--subtree=My Project" is a single word),
strip the leading "--", and then uses "rev-parse --sq-quote" again
to turn them into "-X 'subtree=My Project'" (two words), which can
be inserted into a string later to be eval'ed.

 git-rebase--interactive.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e558397..ae2da7a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -83,8 +83,13 @@ rewritten_pending="$state_dir"/rewritten-pending
 strategy_args=
 if test -n "$do_merge"
 then
-	strategy_args="${strategy+--strategy=$strategy}
- $(echo $strategy_opts | sed "s/'--\([^']*\)'/-X\1/g")"
+	strategy_args=${strategy:+--strategy=$strategy}
+	eval '
+		for strategy_opt in '"$strategy_opts"'
+		do
+			strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
+		done
+	'
 fi
 
 GIT_CHERRY_PICK_HELP="$resolvemsg"
@@ -246,7 +251,7 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output git cherry-pick $strategy_args $empty_args $ff "$@"
+	output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -347,9 +352,8 @@ pick_one_preserving_merges () {
 			msg_content="$(commit_message $sha1)"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
-			if ! do_with_author output \
-				git merge --no-ff $strategy_args -m \
-					"$msg_content" $new_parents
+			if ! do_with_author output eval \
+			'git merge --no-ff $strategy_args -m "$msg_content" $new_parents'
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
@@ -357,7 +361,7 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output git cherry-pick $strategy_args "$@" ||
+			output eval git cherry-pick "$strategy_args" "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
