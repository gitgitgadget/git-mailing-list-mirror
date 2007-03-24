From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-revert: Revert revert message to old behaviour
Date: Sat, 24 Mar 2007 02:54:02 -0700
Message-ID: <7v648rm0g5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703230805450.6730@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703231705150.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703230926380.6730@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703232013330.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 24 10:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV2x9-0007T8-7J
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 10:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbXCXJyH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 05:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbXCXJyH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 05:54:07 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:54489 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbXCXJyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 05:54:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070324095404.YNEH28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Mar 2007 05:54:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id eZu21W0011kojtg0000000; Sat, 24 Mar 2007 05:54:03 -0400
In-Reply-To: <Pine.LNX.4.63.0703232013330.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 23 Mar 2007 20:13:52 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42988>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> How about the empty line in between the message and the "This reverts 
>> commit "..
>> 
>> > +		add_to_msg("Revert \"");
>> >  		add_to_msg(oneline);
>> > -		add_to_msg("\nThis reverts commit ");
>> > +		add_to_msg("\"\nThis reverts commit ");
>> 
>> This should probably be
>> 
>> 	add_to_msg("\"\n\nThis reverts commit ");
>> 
>> with *two* \n's, no?
>
> Yes. Sorry.

Not only that.  

The older one had two, duplicated abbrev, and your fix reduces
it to once, but we do not want any abbrev there.

-- >8 --
[PATCH] git-revert: Revert revert message to old behaviour

When converting from the shell script, based on a misreading of the
sed invocation, the builtin included the abbreviated commit name,
and did _not_ include the quotes around the oneline message.

This fixes it.

[jc: with a fix for the typo/thinko spotted by Linus, and also
 removing the unwanted abbrev at the beginning.]

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-revert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index f3f3f5c..4ba0ee6 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -294,13 +294,13 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	oneline = get_oneline(message);
 
 	if (action == REVERT) {
+		char *oneline_body = strchr(oneline, ' ');
+
 		base = commit;
 		next = commit->parents->item;
-		add_to_msg("Revert ");
-		add_to_msg(find_unique_abbrev(commit->object.sha1,
-					DEFAULT_ABBREV));
-		add_to_msg(oneline);
-		add_to_msg("\nThis reverts commit ");
+		add_to_msg("Revert \"");
+		add_to_msg(oneline_body + 1);
+		add_to_msg("\"\n\nThis reverts commit ");
 		add_to_msg(sha1_to_hex(commit->object.sha1));
 		add_to_msg(".\n");
 	} else {
-- 
1.5.1.rc1.666.g2823
