From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] rev-list: honor --abbrev=<n> when doing --pretty=oneline
Date: Thu, 6 Apr 2006 17:44:55 -0700
Message-ID: <20060407004455.GF15743@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 07 02:45:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRf5v-0002RR-7l
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 02:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWDGAo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 20:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWDGAo4
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 20:44:56 -0400
Received: from hand.yhbt.net ([66.150.188.102]:15497 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932250AbWDGAo4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 20:44:56 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 8CEBA2DC036; Thu,  6 Apr 2006 17:44:55 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18488>

This should make --pretty=oneline a whole lot more readable for
people using 80-column terminals.

Note that --abbrev=DEFAULT_ABBREV was on by default before, but
it only affected the printing of the Merge: header).  Let me
know if anybody doesn't want the default behavior to change.
Also note that --abbrev without arguments is not supported by
rev-list, but --no-abbrev is supported if you want the old
behavior.

Originally I made abbrev affect the commit sha1 output
regardless of the pretty setting, but that broke some tests and
I figured it's most/only useful for --pretty=oneline (at least
that's why *I* want it :)

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 rev-list.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

c4da073e8256499950e25e2c20ea0b3ec4c29b46
diff --git a/rev-list.c b/rev-list.c
index 22141e2..392209d 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -52,7 +52,10 @@ static void show_commit(struct commit *c
 		fputs(commit_prefix, stdout);
 	if (commit->object.flags & BOUNDARY)
 		putchar('-');
-	fputs(sha1_to_hex(commit->object.sha1), stdout);
+	if (abbrev && commit_format == CMIT_FMT_ONELINE)
+		fputs(find_unique_abbrev(commit->object.sha1, abbrev), stdout);
+	else
+		fputs(sha1_to_hex(commit->object.sha1), stdout);
 	if (revs.parents) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
-- 
1.3.0.rc2.g454a-dirty
