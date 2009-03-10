From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Improve "git branch --tracking" output
Date: Tue, 10 Mar 2009 01:20:42 -0700
Message-ID: <7v63ihbxgl.fsf_-_@gitster.siamese.dyndns.org>
References: <1236655610-14236-1-git-send-email-pknotz@sandia.gov>
 <1236659098-14400-1-git-send-email-pknotz@sandia.gov>
 <7vab7tbxo0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Pat Notz" <pknotz@sandia.gov>
X-From: git-owner@vger.kernel.org Tue Mar 10 09:22:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgxEU-0002eW-0k
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbZCJIUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 04:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbZCJIUx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 04:20:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbZCJIUv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 04:20:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F197A0F7B;
	Tue, 10 Mar 2009 04:20:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3ACB0A0F75; Tue,
 10 Mar 2009 04:20:43 -0400 (EDT)
In-Reply-To: <7vab7tbxo0.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 10 Mar 2009 01:16:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C61CF3E-0D4C-11DE-8230-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112792>

An earlier patch always spelled the full name of the ref that we track
(e.g. "refs/heads/frotz" instead of just "frotz" when we mean the branch
whose name is "frotz").  Worse yet, because we now use the true name of
the ref at the original repository when talk about a tracking branch that
copies from a remote, such a full name alone still does not give enough
information.

This reorganizes the verbose codepath to:

 - differentiate "refs/heads/something" and everything else; we say that
   the branch tracks "branch <something>" if it begins with "refs/heads/",
   and otherwise the branch tracks "ref refs/<someother>/<something>";

 - report the name of the remote when we talk about a tracking branch, by
   saying "branch frotz from origin";

 - not say "by merging" at the end; it is the default and is not worth
   reporting.

Signed-off-by: Junio C Hamano <junio@pobox.com>
---
 branch.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index d20fb04..5f889fe 100644
--- a/branch.c
+++ b/branch.c
@@ -65,12 +65,23 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 		git_config_set(key.buf, "true");
 	}
 
-	if (flag & BRANCH_CONFIG_VERBOSE)
-		printf("Branch %s set up to track %s branch %s %s.\n",
-		       local,
-		       origin ? "remote" : "local",
-		       remote,
-		       rebasing ? "by rebasing" : "by merging");
+	if (flag & BRANCH_CONFIG_VERBOSE) {
+		strbuf_reset(&key);
+
+		strbuf_addstr(&key, origin ? "remote" : "local");
+
+		/* Are we tracking a proper "branch"? */
+		if (!prefixcmp(remote, "refs/heads/")) {
+			strbuf_addf(&key, " branch %s", remote + 11);
+			if (origin)
+				strbuf_addf(&key, " from %s", origin);
+		}
+		else
+			strbuf_addf(&key, " ref %s", remote);
+		printf("Branch %s set up to track %s%s.\n",
+		       local, key.buf,
+		       rebasing ? " by rebasing" : "");
+	}
 	strbuf_release(&key);
 }
 
