From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch -v: Prevent garbage output on remote refs
Date: Sun, 06 Jul 2008 03:07:34 -0700
Message-ID: <7vhcb3fhqx.fsf@gitster.siamese.dyndns.org>
References: <1215336279-99480-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 12:08:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFRAe-0006nT-0Y
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 12:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbYGFKHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 06:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbYGFKHn
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 06:07:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbYGFKHm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 06:07:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 32E051E34F;
	Sun,  6 Jul 2008 06:07:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8B9971E34E; Sun,  6 Jul 2008 06:07:38 -0400 (EDT)
In-Reply-To: <1215336279-99480-1-git-send-email-benji@silverinsanity.com>
 (Brian Gernhardt's message of "Sun, 6 Jul 2008 05:24:39 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E89D20A-4B43-11DD-BE5E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87513>

Thanks, but I have pushed out a slightly different change.

-- >8 --
branch -r -v: do not spit out garbage

The codepath to emit relationship between the branch and what it tracks
forgot to initialize a string buffer stat[] to empty when showing a
tracking branch.  This moves the emptying so that the buffer starts as
empty and stays so when no information is added to fix this issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
 builtin-branch.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index e9423d1..ff71f3d 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -287,10 +287,8 @@ static void fill_tracking_info(char *stat, const char *branch_name)
 	int ours, theirs;
 	struct branch *branch = branch_get(branch_name);
 
-	if (!stat_tracking_info(branch, &ours, &theirs) || (!ours && !theirs)) {
-		stat[0] = '\0';
+	if (!stat_tracking_info(branch, &ours, &theirs) || (!ours && !theirs))
 		return;
-	}
 	if (!ours)
 		sprintf(stat, "[behind %d] ", theirs);
 	else if (!theirs)
@@ -330,6 +328,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		char stat[128];
 
 		strbuf_init(&subject, 0);
+		stat[0] = '\0';
 
 		commit = lookup_commit(item->sha1);
 		if (commit && !parse_commit(commit)) {
