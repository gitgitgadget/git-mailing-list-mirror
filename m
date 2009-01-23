From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Thu, 22 Jan 2009 16:14:58 -0800
Message-ID: <7vljt26fp9.fsf@gitster.siamese.dyndns.org>
References: <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 01:16:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ9iq-0004NX-R8
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 01:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443AbZAWAPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 19:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756162AbZAWAPH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 19:15:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808AbZAWAPG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 19:15:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BD4F31D124;
	Thu, 22 Jan 2009 19:15:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B77501D122; Thu,
 22 Jan 2009 19:14:59 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E248573C-E8E2-11DD-8689-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106806>

Christian MICHON <christian.michon@gmail.com> writes:

> I'd like to force the commit date to match the info/date from the time
> I received the email (and therefore always get back the right
> sha1sums).
>
> is this possible ?

"am" being a tool to accept patches written in some past to faithfully
record both author timestamp and committer timestamp, what you seem to
want is outside of the current scope of the tool.

A patch to butcher "git-am" to copy GIT_COMMITTER_DATE from
GIT_AUTHOR_DATE and export it should be trivial to implement, though.

Perhaps something like this totally untested patch.



 git-am.sh     |   13 ++++++++++++-
 t/t4150-am.sh |   20 ++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git c/git-am.sh w/git-am.sh
index e20dd88..e96071d 100755
--- c/git-am.sh
+++ w/git-am.sh
@@ -23,6 +23,7 @@ resolvemsg=     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
 skip            skip the current patch
 abort           restore the original branch and abort the patching operation.
+committer-date-is-author-date    lie about committer date
 rebasing        (internal use for git-rebase)"
 
 . git-sh-setup
@@ -133,6 +134,7 @@ dotest="$GIT_DIR/rebase-apply"
 sign= utf8=t keep= skip= interactive= resolved= rebasing= abort=
 resolvemsg= resume=
 git_apply_opt=
+committer_date_is_author_date=
 
 while test $# != 0
 do
@@ -168,6 +170,8 @@ do
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
+	--committer-date-is-author-date)
+		committer_date_is_author_date=t ;;
 	--)
 		shift; break ;;
 	*)
@@ -521,7 +525,14 @@ do
 
 	tree=$(git write-tree) &&
 	parent=$(git rev-parse --verify HEAD) &&
-	commit=$(git commit-tree $tree -p $parent <"$dotest/final-commit") &&
+	commit=$(
+		if test -n "$committer_date_is_author_date"
+		then
+			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
+			export GIT_COMMITTER_DATE
+		fi &&
+		git commit-tree $tree -p $parent <"$dotest/final-commit"
+	) &&
 	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
 
diff --git c/t/t4150-am.sh w/t/t4150-am.sh
index 796f795..8d3fb00 100755
--- c/t/t4150-am.sh
+++ w/t/t4150-am.sh
@@ -257,4 +257,24 @@ test_expect_success 'am works from file (absolute path given) in subdirectory' '
 	test -z "$(git diff second)"
 '
 
+test_expect_success 'am --committer-date-is-author-date' '
+	git checkout first &&
+	test_tick &&
+	git am --committer-date-is-author-date patch1 &&
+	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
+	at=$(sed -ne "/^author /s/.*> //p" head1) &&
+	ct=$(sed -ne "/^committer /s/.*> //p" head1) &&
+	test "$at" = "$ct"
+'
+
+test_expect_success 'am without --committer-date-is-author-date' '
+	git checkout first &&
+	test_tick &&
+	git am patch1 &&
+	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
+	at=$(sed -ne "/^author /s/.*> //p" head1) &&
+	ct=$(sed -ne "/^committer /s/.*> //p" head1) &&
+	test "$at" != "$ct"
+'
+
 test_done
