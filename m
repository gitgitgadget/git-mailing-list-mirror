From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 07 Dec 2007 02:25:34 -0800
Message-ID: <7vwsrq3iox.fsf@gitster.siamese.dyndns.org>
References: <20071207093439.GA21896@elte.hu>
	<7v63za4yic.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Dec 07 11:26:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0aPO-0000Jp-PW
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 11:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbXLGKZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 05:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbXLGKZw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 05:25:52 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:43304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbXLGKZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 05:25:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 56B553A31;
	Fri,  7 Dec 2007 05:25:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 537E93A2B;
	Fri,  7 Dec 2007 05:25:42 -0500 (EST)
In-Reply-To: <7v63za4yic.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 07 Dec 2007 01:58:35 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67408>

Junio C Hamano <gitster@pobox.com> writes:

> Ingo Molnar <mingo@elte.hu> writes:
>
>> would be nice to have:
>>
>>  git-bisect diff
>>
>> that enables one to have a look at the currently open bisection window, 
>> in git-log -p format. This would often be much faster to analyze than 
>> looking at git-bisect visualize. (and it could also be used in non-GUI 
>> workflows)
>
> Hmm.  It is very unfortunate that "bisect log" is taken for something
> unrelated, so tentatively let's call it lumber.
>
> 	$ git bisect lumber [-p] [--stat]
>
> would give you the short-hand, hopefully.

More seriously...

-- >8 --
git-bisect visualize: work in non-windowed environments better

This teaches "git bisect visualize" to be more useful in non-windowed
environments.

 (1) When no option is given, and $DISPLAY is set, it continues to
     spawn gitk as before;

 (2) When no option is given, and $DISPLAY is unset, "git log" is run
     to show the range of commits between the bad one and the good ones;

 (3) If only "-flag" options are given, "git log <options>" is run.
     E.g. "git bisect visualize --stat"

 (4) Otherwise, all of the given options are taken as the initial part
     of the command line and the commit range expression is given to
     that command.  E.g. "git bisect visualize tig" will run "tig"
     history viewer to show between the bad one and the good ones.

As "visualize" is a bit too long to type, we also give it a shorter
synonym "view".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-bisect.sh |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 7a6521e..bb6fe84 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -324,8 +324,23 @@ bisect_next() {
 
 bisect_visualize() {
 	bisect_next_check fail
+
+	if test $# = 0
+	then
+		case "${DISPLAY+set}" in
+		'')	set git log ;;
+		set)	set gitk ;;
+		esac
+	else
+		case "$1" in
+		git*|tig) ;;
+		-*)	set git log "$@" ;;
+		*)	set git "$@" ;;
+		esac
+	fi
+
 	not=$(git for-each-ref --format='%(refname)' "refs/bisect/good-*")
-	eval gitk refs/bisect/bad --not $not -- $(cat "$GIT_DIR/BISECT_NAMES")
+	eval '"$@"' refs/bisect/bad --not $not -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
 bisect_reset() {
@@ -449,7 +464,7 @@ case "$#" in
     next)
         # Not sure we want "next" at the UI level anymore.
         bisect_next "$@" ;;
-    visualize)
+    visualize|view)
 	bisect_visualize "$@" ;;
     reset)
         bisect_reset "$@" ;;
