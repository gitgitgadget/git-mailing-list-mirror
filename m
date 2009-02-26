From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-am: make --abort less dangerous
Date: Thu, 26 Feb 2009 11:24:29 -0800
Message-ID: <7v8wntrogi.fsf@gitster.siamese.dyndns.org>
References: <7v8wnu2x67.fsf@gitster.siamese.dyndns.org>
 <1235641973-18307-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 20:26:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcls1-000795-HE
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 20:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbZBZTYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 14:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbZBZTYg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 14:24:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448AbZBZTYf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 14:24:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC4869D85E;
	Thu, 26 Feb 2009 14:24:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CA8099D85D; Thu,
 26 Feb 2009 14:24:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1915C10A-043B-11DE-B4C8-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111589>

When you are in the middle of "git rebase", "git am --abort" by mistake
would have referred to nonexistent ORIG_HEAD and barfed, or worse yet, used
a stale ORIG_HEAD and taken you to an unexpected commit.

Also the option parsing did not reject "git am --abort --skip".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * An independent fix but textually depends on your patch.

 git-am.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 351b4f8..d339075 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -221,6 +221,9 @@ then
 	resume=yes
 
 	case "$skip,$abort" in
+	t,t)
+		die "Please make up your mind. --skip or --abort?"
+		;;
 	t,)
 		git rerere clear
 		git read-tree --reset -u HEAD HEAD
@@ -229,6 +232,10 @@ then
 		git update-ref ORIG_HEAD $orig_head
 		;;
 	,t)
+		if test -f "$dotest/rebasing"
+		then
+			exec git rebase --abort
+		fi
 		git rerere clear
 		test -f "$dotest/dirtyindex" || {
 			git read-tree --reset -u HEAD ORIG_HEAD
