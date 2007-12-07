From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 07 Dec 2007 01:58:35 -0800
Message-ID: <7v63za4yic.fsf@gitster.siamese.dyndns.org>
References: <20071207093439.GA21896@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Dec 07 10:59:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ZzY-0000OU-8d
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 10:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXLGJ6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 04:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbXLGJ6w
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 04:58:52 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:42746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbXLGJ6v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 04:58:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B2BB37AA;
	Fri,  7 Dec 2007 04:58:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 681AF37A7;
	Fri,  7 Dec 2007 04:58:42 -0500 (EST)
In-Reply-To: <20071207093439.GA21896@elte.hu> (Ingo Molnar's message of "Fri,
	7 Dec 2007 10:34:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67406>


Ingo Molnar <mingo@elte.hu> writes:

> would be nice to have:
>
>  git-bisect diff
>
> that enables one to have a look at the currently open bisection window, 
> in git-log -p format. This would often be much faster to analyze than 
> looking at git-bisect visualize. (and it could also be used in non-GUI 
> workflows)

Hmm.  It is very unfortunate that "bisect log" is taken for something
unrelated, so tentatively let's call it lumber.

	$ git bisect lumber [-p] [--stat]

would give you the short-hand, hopefully.

---

 git-bisect.sh |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 7a6521e..ee26624 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[start|bad|good|skip|next|reset|visualize|replay|log|run]'
+USAGE='[start|bad|good|skip|next|reset|visualize|log|replay|lumber|run]'
 LONG_USAGE='git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
         reset bisect state and start bisection.
 git bisect bad [<rev>]
@@ -15,6 +15,8 @@ git bisect reset [<branch>]
         finish bisection search and go back to branch.
 git bisect visualize
         show bisect status in gitk.
+git bisect lumber
+        show bisect status in git log.
 git bisect replay <logfile>
         replay bisection log.
 git bisect log
@@ -328,6 +330,12 @@ bisect_visualize() {
 	eval gitk refs/bisect/bad --not $not -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
+bisect_lumber() {
+	bisect_next_check fail
+	not=$(git for-each-ref --format='%(refname)' "refs/bisect/good-*")
+	eval git log "$@" refs/bisect/bad --not $not -- $(cat "$GIT_DIR/BISECT_NAMES")
+}
+
 bisect_reset() {
 	test -f "$GIT_DIR/BISECT_NAMES" || {
 		echo "We are not bisecting."
@@ -451,6 +459,8 @@ case "$#" in
         bisect_next "$@" ;;
     visualize)
 	bisect_visualize "$@" ;;
+    lumber)
+	bisect_lumber "$@" ;;
     reset)
         bisect_reset "$@" ;;
     replay)
