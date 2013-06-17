From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Fix checkout-dash to work with rebase
Date: Mon, 17 Jun 2013 10:56:13 -0700
Message-ID: <7vk3lsei4i.fsf@alter.siamese.dyndns.org>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
	<7v1u81ibjp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 19:56:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UodfH-000247-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 19:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab3FQR4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 13:56:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754539Ab3FQR4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 13:56:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04FAA281D7;
	Mon, 17 Jun 2013 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=br92DOTGI2NFXcxGVgBE07oKVsk=; b=GJZEqRNgfa/gElq4ksCK
	rvfz3A/sclgu0R5tXwJL+0vsdfFCpxCPdeeCpy5dba/rbhqJOVfWuJk3EZSb4Pls
	luO5wz690yCK/oLCJiFiuQm0/QDzp4q08eSeAPhqU+/GiWUcA+CeAzZc70mT3tdY
	Ss7hdalCABnqWdC2gyJWgqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=R3cMbpdsGNeRZJWi5EnnXNsnZ2uwnot4c2Tbs9DXYn/uV2
	eHeoixKUybYcg+vOpiZ6rnLyhjtFkQII7LGou/UaZr30f1USnR1z//IOVggjnIT5
	s76NoYz/QqZEbKEiAF0tJkaI69b//zLaD9AsiOPq5wwNSmhurgHqoXTtun3hs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB376281D5;
	Mon, 17 Jun 2013 17:56:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FE75281B8;
	Mon, 17 Jun 2013 17:56:14 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 342970AE-D777-11E2-92B3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228092>

Junio C Hamano <gitster@pobox.com> writes:

> In other words, the order I was anticipating to see after the
> discussion (this is different from saying "A series that is not
> ordered like this is unacceptable") was:
>
>>   wt-status: remove unused field in grab_1st_switch_cbdata
>
> This is an unrelated clean-up, and can be done before anything else.
>
>>   t/checkout-last: checkout - doesn't work after rebase
>
> This spells out what we want to happen at the end and marks the
> current breakage.
>
>>   status: do not depend on rebase reflog messages
>
> This compensates for fallouts from the next change.
>
>>   checkout: respect GIT_REFLOG_ACTION
>
> And this is the fix, the most important step.
>
>>   rebase: prepare to write reflog message for checkout
>>   rebase -i: prepare to write reflog message for checkout
>
> And these are icing on the cake, but that cannot be done before
> status is fixed.

I actually tried to reorder the patches and they seem to work OK as
expected.  And I think it makes sense to order them the way I've
been suggesting, so I'll tentatively queue the result of reordering
on 'rr/rebase-checkout-reflog' and push it out as a part of 'pu'.

Please check to see if I introduced a new bug while doing so.

Regardless of the ordering, however, I suspect two patches that
change the message recorded in reflog in "rebase" need further
fixing.

For example, the one in "git reabse" does this:

    GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
    git checkout -q "$onto^0" || die "could not detach HEAD"
    git update-ref ORIG_HEAD $orig_head
    ...
    run_specific_rebase

But the specific rebase, e.g. git-rebase--interactive, does this:

	case $head_name in
	refs/*)
		message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&
		git update-ref -m "$message" $head_name $newhead $orig_head &&
		git symbolic-ref \
		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
		  HEAD $head_name
		;;
	esac && {

I think the message you added to "git reabse" is only meant for that
specific "checkout $onto", but it is set globally.  Wouldn't it
affect later use, which expected it to be "rebase" and nothing else?

Perhaps something like this on top of the entire series may be
sufficient (which will be queued as "SQUASH???" at the tip).

Hint for anybody (not limited to Ram):

There also are other 'git checkout' invocations in git-rebase\*.sh
that are not yet covered by these "nicer reflog message" patches,
which may want to be fixed up before these two icing-on-cake patches
become ready to be merged; see output of

	git grep -C2 'git checkout' -- git-rebase\*.sh

Thanks.

 git-rebase--interactive.sh    | 15 ++++++++++-----
 git-rebase.sh                 |  4 ++--
 t/t3404-rebase-interactive.sh | 15 +++++++++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a05a6e4..f21ff7c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -837,9 +837,11 @@ comment_for_reflog start
 
 if test ! -z "$switch_to"
 then
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-	output git checkout "$switch_to" -- ||
-		die "Could not checkout $switch_to"
+	(
+		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
+		export GIT_REFLOG_ACTION
+		output git checkout "$switch_to" --
+	) || die "Could not checkout $switch_to"
 fi
 
 orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
@@ -981,7 +983,10 @@ has_action "$todo" ||
 
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
-GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
-output git checkout $onto || die_abort "could not detach HEAD"
+(
+	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
+	export GIT_REFLOG_ACTION
+	output git checkout $onto
+) || die_abort "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 do_rest
diff --git a/git-rebase.sh b/git-rebase.sh
index 7d55372..2344eef 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -523,8 +523,8 @@ test "$type" = interactive && run_specific_rebase
 # Detach HEAD and reset the tree
 say "$(gettext "First, rewinding head to replay your work on top of it...")"
 
-GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
-git checkout -q "$onto^0" || die "could not detach HEAD"
+GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
+	git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 
 # If the $onto is a proper descendant of the tip of the branch, then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a58406d..c175ef1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -934,6 +934,21 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
 	test L = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+test_expect_success 'rebase -i produces readable reflog' '
+	git reset --hard &&
+	git branch -f branch1 H &&
+	git rebase -i --onto I F branch1 &&
+	cat >expect <<-\EOF &&
+	rebase -i (start): checkout I
+	rebase -i (pick): G
+	rebase -i (pick): H
+	rebase -i (finish): returning to refs/heads/branch1
+	EOF
+	tail -n 4 .git/logs/HEAD |
+	sed -e "s/.*	//" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase -i respects core.commentchar' '
 	git reset --hard &&
 	git checkout E^0 &&
