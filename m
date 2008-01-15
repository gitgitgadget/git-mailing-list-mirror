From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Squelch bogus progress output from git-rebase--interactive
Date: Mon, 14 Jan 2008 20:04:31 -0800
Message-ID: <7v3aszivjk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 05:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEd3G-000638-1Q
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 05:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYAOEEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 23:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbYAOEEs
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 23:04:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYAOEEs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 23:04:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D9981CFA;
	Mon, 14 Jan 2008 23:04:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 81D551CF4;
	Mon, 14 Jan 2008 23:04:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70498>

The command repeats "Rebasing (1/1)" many times even when
there is only one task remaining, because mark_action_done() is
called to skip comment and empty lines in the TODO file.

This should fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index acdcc54..402ff37 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -73,14 +73,19 @@ comment_for_reflog () {
 	esac
 }
 
+last_count=
 mark_action_done () {
 	sed -e 1q < "$TODO" >> "$DONE"
 	sed -e 1d < "$TODO" >> "$TODO".new
 	mv -f "$TODO".new "$TODO"
 	count=$(($(grep -ve '^$' -e '^#' < "$DONE" | wc -l)))
 	total=$(($count+$(grep -ve '^$' -e '^#' < "$TODO" | wc -l)))
-	printf "Rebasing (%d/%d)\r" $count $total
-	test -z "$VERBOSE" || echo
+	if test "$last_count" != "$count"
+	then
+		last_count=$count
+		printf "Rebasing (%d/%d)\r" $count $total
+		test -z "$VERBOSE" || echo
+	fi
 }
 
 make_patch () {
-- 
1.5.4.rc3.10.g471a
