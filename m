From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Thu, 17 Mar 2011 13:50:10 -0700
Message-ID: <7vhbb1320t.fsf@alter.siamese.dyndns.org>
References: <4D81C1AA.5010008@morey-chaisemartin.com>
 <7v1v254ma7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 21:50:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0K9J-0002dZ-GS
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 21:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab1CQUuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 16:50:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab1CQUuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 16:50:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D0994281;
	Thu, 17 Mar 2011 16:51:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m5PHvCvN59W6yLTwCcPsC+3GUak=; b=wSrZR4
	mzwCT+rNYpC4zKr4plOTCbIvCDfuqmfu+YknlwoBz9ce8iSGKy8/KJdINiGJEXqn
	B0A8i9Kb4oHyiVSqtR59JdZ9juFxlXU1Dqpe6Q8TFp5JytKQ1rDjySJWrl5rQezO
	CQXLPVRRQYURVdkCz5PVPdS2QN9a/eaTIR8+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xPjUh6BqdIvn1mT51dtQSml1YDYKjMvY
	OpWJhUiu3xK2Y+hH0ynYEc/P4oG4DFRgYuKbYbEaN1BYbs33YkgsP4v/PBk1A0iR
	58xCYctAuc9YSYqrRDrwQJe8LT9Psok/DxNLUdW+jb0+E345GE9M7IT3/kf+WkOY
	fFRkUztyuJs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5697D427F;
	Thu, 17 Mar 2011 16:51:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0D1C2427B; Thu, 17 Mar 2011
 16:51:46 -0400 (EDT)
In-Reply-To: <7v1v254ma7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 17 Mar 2011 11:47:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61A8AF72-50D8-11E0-A701-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169275>

Junio C Hamano <gitster@pobox.com> writes:

> Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> writes:
>
>> During a merge with conflict on a submodule, the submodule appears 3
>> times in git ls-files (stage 1,2,3) which causes the submodule to be
>> used 3 times in git submodule update or status command.  This patch
>> filters the results of git ls-files and only shows submodule in stage 0
>> or 1 thus removing the duplicates.
>
> That is a wrong thing to do.  What if both sides added a submodule at the
> same directory after forked from an ancestor that did not have it?  You
> will have only stage #2 and stage #3, no?

It is not very friendly to say a solution is wrong without hinting what
the right thing to do, so let's try.

There are 5 callers of module_list; they all read (mode, sha1, stage,
path) tuple, and most of them care only about path.  As a first level
approximation, it should be Ok (in the sense that it does not make things
worse than it currently is) to filter the duplicate paths from module_list
output.

But a bigger question is, shouldn't some callers _care_ when the
superproject is still unmerged?  What does it mean to say "submodule
update" when your superproject is unmerged, you haven't resolved it so you
don't know if you are going to take the commit your branch points at, or
the commit their branch points at, or a commit completely different from
either?  If submodule.$name.update is set to detach and checkout the
commit registred at the superproject, which stage do you want to get the
commit to update the submodule with?  If it is set to "rebase" or "merge",
which stage do you take the commit to rebase/merge your history onto?

I think "update" should not touch the submodule repository in such a case.
"status" might want to recurse into the submodule repository, but there is
no information at the superproject level to compare the submodule status
against, so we should at least skip that part for submodule entries that
are unmerged in the superproject.

Perhaps something along the lines of (as usual, totally untested, just to
illustrate the concept) the attached patch?

The idea is to notice the higher-stage entries, and emit only one record
from module_list, but while doing so, mark the entry with "U" (not [0-3])
in $stage field and null out the SHA-1 part, as the object name for the
lowest stage does not give any useful information to the caller, and this
way any caller that uses the object name would hopefully barf.

Fine points:

 - The command called by foreach may want to do whatever it wants to do by
   noticing the merged status in the superproject itself, so I made no
   change to the function;

 - Init is an unlikely thing to do, but as long as a submodule is there in
   $path, there is no point skipping it. It might however want to take the
   merged status of .gitmodules into account, but that is outside of the
   scope of this topic;

 - Update should refrain from touching the submodule itself. It may want
   to recurse into the submodule of the unmerged one, but people involved
   in submodule work should think things through;

 - Status does not have anything to report for an unmerged submodule. It
   may want to recurse into the submodule of the unmerged one, but people
   involved in submodule work should think things through; and

 - Sync should be Ok for the same reason as Init.



 git-submodule.sh |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3a13397..8ecd311 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -72,7 +72,24 @@ resolve_relative_url ()
 #
 module_list()
 {
-	git ls-files --error-unmatch --stage -- "$@" | sane_grep '^160000 '
+	git ls-files --error-unmatch --stage -- "$@" |
+	perl -e '
+	my %unmerged = ();
+	my ($null_sha1) = ("0" x 40);
+	while (<STDIN>) {
+		chomp;
+		my ($mode, $sha1, $stage, $path) =
+			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
+		next unless $mode eq "160000";
+		if ($stage ne "0") {
+			if (!$unmerged{$path}++) {
+				print "$mode $null_sha1 U\t$path\n";
+			}
+			next;
+		}
+		print "$_\n";
+	}
+	'
 }
 
 #
@@ -427,6 +444,11 @@ cmd_update()
 	module_list "$@" |
 	while read mode sha1 stage path
 	do
+		if test "$stage" = U
+		then
+			echo >&2 "Skipping unmerged submodule $path"
+			continue
+		fi
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
 		update_module=$(git config submodule."$name".update)
@@ -767,6 +789,11 @@ cmd_status()
 	module_list "$@" |
 	while read mode sha1 stage path
 	do
+		if test "$stage" = U
+		then
+			echo >&2 "Skipping unmerged submodule $path"
+			continue
+		fi
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath="$prefix$path"
