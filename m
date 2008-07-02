From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git-branch -v: show the remote tracking statistics
Date: Wed, 02 Jul 2008 00:52:41 -0700
Message-ID: <7vhcb8en92.fsf@gitster.siamese.dyndns.org>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
 <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 02 09:54:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxA2-0004s1-MG
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 09:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbYGBHw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 03:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYGBHw6
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 03:52:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbYGBHw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 03:52:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 75AC4284BA;
	Wed,  2 Jul 2008 03:52:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 31286284B9; Wed,  2 Jul 2008 03:52:51 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2036AB4-480B-11DD-AAE4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87097>

This teaches "git branch -v" to insert the remote tracking statistics in
the form of [ours/theirs] just before the one-liner commit log message
for the branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
  ... which means that you would see something like this.

  * jc/report-tracking        41666f7 [3/117] git-branch -v: show the remo...

  I did not think we want to spend extra columns to show the name of
  remote branch each of them tracks, so I am showing only counts.

 builtin-branch.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index d279702..0e2bb52 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -310,6 +310,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	if (verbose) {
 		struct strbuf subject;
 		const char *sub = " **** invalid ref ****";
+		char stat[128];
 
 		strbuf_init(&subject, 0);
 
@@ -319,10 +320,19 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 					    &subject, 0, NULL, NULL, 0, 0);
 			sub = subject.buf;
 		}
-		printf("%c %s%-*s%s %s %s\n", c, branch_get_color(color),
+
+		stat[0] = '\0';
+		if (item->kind == REF_LOCAL_BRANCH) {
+			int ours, theirs;
+			struct branch *branch = branch_get(item->name);
+			if (stat_tracking_info(branch, &ours, &theirs))
+				sprintf(stat, "[%d/%d] ", ours, theirs);
+		}
+		printf("%c %s%-*s%s %s %s%s\n", c, branch_get_color(color),
 		       maxwidth, item->name,
 		       branch_get_color(COLOR_BRANCH_RESET),
-		       find_unique_abbrev(item->sha1, abbrev), sub);
+		       find_unique_abbrev(item->sha1, abbrev),
+		       stat, sub);
 		strbuf_release(&subject);
 	} else {
 		printf("%c %s%s%s\n", c, branch_get_color(color), item->name,
-- 
1.5.6.1.156.ge903b
