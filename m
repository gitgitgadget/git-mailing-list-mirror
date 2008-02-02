From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix "git checkout -b foo ':/substring'"
Date: Fri, 01 Feb 2008 19:06:56 -0800
Message-ID: <7v1w7w6oq7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 04:07:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL8jK-0001Dz-P0
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 04:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbYBBDHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 22:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbYBBDHN
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 22:07:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbYBBDHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 22:07:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B8AE13DAE;
	Fri,  1 Feb 2008 22:07:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D0423DAD;
	Fri,  1 Feb 2008 22:07:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72215>

Because ':/substring' extended SHA1 expression cannot take
postfix modifiers such as ^{tree} and ^{commit}, we would need
to do it in multiple steps.  With the patch, you can start a new
branch from a randomly-picked commit whose message has the named
string in it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As we advertize that ":/string" syntax is usable for any
   command that wnats to take a commit object name in the
   Release Notes, we might want to put this in 1.5.4 final.  It
   looks simple and safe enough.

diff --git a/git-checkout.sh b/git-checkout.sh
index 5621c69..bd74d70 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -71,7 +71,8 @@ while test $# != 0; do
 done
 
 arg="$1"
-if rev=$(git rev-parse --verify "$arg^0" 2>/dev/null)
+rev=$(git rev-parse --verify "$arg" 2>/dev/null)
+if rev=$(git rev-parse --verify "$rev^0" 2>/dev/null)
 then
 	[ -z "$rev" ] && die "unknown flag $arg"
 	new_name="$arg"
@@ -82,11 +83,11 @@ then
 	fi
 	new="$rev"
 	shift
-elif rev=$(git rev-parse --verify "$arg^{tree}" 2>/dev/null)
+elif rev=$(git rev-parse --verify "$rev^{tree}" 2>/dev/null)
 then
 	# checking out selected paths from a tree-ish.
 	new="$rev"
-	new_name="$arg^{tree}"
+	new_name="$rev^{tree}"
 	shift
 fi
 [ "$1" = "--" ] && shift
