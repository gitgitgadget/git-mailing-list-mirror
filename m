From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attribute: whitespace set to true detects all errors known to git
Date: Sun, 21 Jun 2009 02:35:18 -0700
Message-ID: <7vr5xerktl.fsf_-_@alter.siamese.dyndns.org>
References: <20090619194253.6117@nanako3.lavabit.com>
	<7vvdmqrl06.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 11:35:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIJSS-0004Yu-82
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 11:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbZFUJfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 05:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZFUJfS
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 05:35:18 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:47896 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZFUJfR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 05:35:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621093520.HKYR18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jun 2009 05:35:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6ZbJ1c0094aMwMQ04ZbK12; Sun, 21 Jun 2009 05:35:19 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=0-xiNkvnMesA:10 a=ybZZDoGAAAAA:8
 a=kZKkjTB4YeCdfwc3sVgA:9 a=gcGGXwsdkg8QTynmEUB0_iamrD0A:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7vvdmqrl06.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 21 Jun 2009 02\:31\:21 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121978>

That is what the documentation says, but the code pretends as if all the
known whitespace error tokens were given.

Among the whitespace error tokens, there is one kind that loosens the rule
when set: cr-at-eol.  Which means that whitespace error token that is set
to true ignores a newly introduced CR at the end, which is inconsistent
with the documentation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I wish cr-at-eol were no-cr-at-eol instead, so that we didn't have to
   do this, but it is too late for that.  Oh well.

 ws.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/ws.c b/ws.c
index b1efcd9..819c797 100644
--- a/ws.c
+++ b/ws.c
@@ -10,11 +10,12 @@
 static struct whitespace_rule {
 	const char *rule_name;
 	unsigned rule_bits;
+	unsigned loosens_error;
 } whitespace_rule_names[] = {
-	{ "trailing-space", WS_TRAILING_SPACE },
-	{ "space-before-tab", WS_SPACE_BEFORE_TAB },
-	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB },
-	{ "cr-at-eol", WS_CR_AT_EOL },
+	{ "trailing-space", WS_TRAILING_SPACE, 0 },
+	{ "space-before-tab", WS_SPACE_BEFORE_TAB, 0 },
+	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB, 0 },
+	{ "cr-at-eol", WS_CR_AT_EOL, 1 },
 };
 
 unsigned parse_whitespace_rule(const char *string)
@@ -79,7 +80,8 @@ unsigned whitespace_rule(const char *pathname)
 			unsigned all_rule = 0;
 			int i;
 			for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++)
-				all_rule |= whitespace_rule_names[i].rule_bits;
+				if (!whitespace_rule_names[i].loosens_error)
+					all_rule |= whitespace_rule_names[i].rule_bits;
 			return all_rule;
 		} else if (ATTR_FALSE(value)) {
 			/* false (-whitespace) */
