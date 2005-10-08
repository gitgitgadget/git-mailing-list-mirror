From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Sat, 8 Oct 2005 13:30:32 +0000
Message-ID: <20051008133032.GA32079@localhost>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home> <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home> <7vachks7aq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 15:22:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOEdx-0003Rc-UU
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 15:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVJHNVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 09:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVJHNVZ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 09:21:25 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:20115 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S932119AbVJHNVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 09:21:24 -0400
Received: from [212.17.39.138] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.42)
	id 1EOEdU-0002Y9-Nw; Sat, 08 Oct 2005 14:21:12 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vachks7aq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.10i
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 7.5)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9837>

Instead of using //{LF}// and //{TAG}// to quote embedded tab and
linefeed characters in pathnames use URI quoting.

'\t' becomes %09
'\n' becomes %10
'%' becomes %25

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

> I am not married to this quoting syntax -- I think it *is* ugly,
> but as I said before, I'd prefer to have something ugly here.
> 
> I would easily be persuaded otherwise, though.  A working patch
> would probably be the most effective way of persuasion, but a
> mock output without the code to produce and/or parse it would
> also be fine as a starting point for discussion.

Using URI encoding might be an option it's not a ugly and more peopel
should under stand what it means.  Heres a posible patch against pu.

Robert


 apply.c       |   19 ++++++++++++-------
 diff.c        |   26 +++++++++++++++++---------
 git-status.sh |   10 ++++++----
 3 files changed, 35 insertions(+), 20 deletions(-)

applies-to: a9332b0c2bd80a182f946d22d4ec7511c32c55f4
8029a957cab1a912562696fdce8beea5fc2c11c4
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -75,21 +75,26 @@ static char *unmunge_name(char *name)
 
 	if (!name)
 		return name;
-	cp = strstr(name, "//");
+	cp = strstr(name, "%");
 	if (!cp)
 		return name;
 	ret_name = strdup(name);
 	for (cp = dp = ret_name; (ch = *cp); cp++) {
-		if (ch == '/' && cp[1] == '/' && cp[2] == '{') {
-			/* //{TAB}// or //{LF}// */
-			if (!strncmp(cp + 3, "TAB}//", 6)) {
+		if (ch == '%') {
+			/* %09 or %10 or %25 */
+			if (!strncmp(cp + 1, "09", 2)) {
 				*dp++ = '\t';
-				cp += 8;
+				cp += 2;
 				continue;
 			}
-			else if (!strncmp(cp + 3, "LF}//", 5)) {
+			else if (!strncmp(cp + 1, "10", 2)) {
 				*dp++ = '\n';
-				cp += 7;
+				cp += 2;
+				continue;
+			}
+			else if (!strncmp(cp + 1, "25", 2)) {
+				*dp++ = '%';
+				cp += 2;
 				continue;
 			}
 			error("malformed munged name '%s' (looking at %s)",
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -13,7 +13,7 @@ static const char *path_munge(const char
 {
 	const char *cp;
 	char *retpath, *dp;
-	int ch, munge_inter_name = 0, munge_line_term = 0;
+	int ch, munge_inter_name = 0, munge_line_term = 0, munge_quote = 0;
 
 	if (!path)
 		return path;
@@ -23,23 +23,31 @@ static const char *path_munge(const char
 			munge_inter_name++;
 		if (line_term && ch == '\n')
 			munge_line_term++;
+		if (ch == '%')
+			munge_quote++;
 	}
-	if (!(munge_inter_name + munge_line_term))
+	if (!(munge_inter_name + munge_line_term + munge_quote))
 		return path;
 
-	/* need //{TAB}// and //{LF}// */
+	/* need %09 and %10 and %25 */
 	retpath = xmalloc(cp - path +
-			  munge_inter_name * 8 +
-			  munge_line_term * 7 + 1);
+			  munge_inter_name * 3 +
+			  munge_line_term * 3 +
+			  munge_quote * 3 + 1);
 	for (cp = path, dp = retpath; (ch = *cp); cp++, dp++) {
 		if (inter_name && ch == '\t') {
-			memcpy(dp, "//{TAB}//", 9);
-			dp += 8;
+			memcpy(dp, "%09", 3);
+			dp += 2;
 			continue;
 		}
 		if (line_term && ch == '\n') {
-			memcpy(dp, "//{LF}//", 8);
-			dp += 7;
+			memcpy(dp, "%10", 3);
+			dp += 2;
+			continue;
+		}
+		if (ch == '%') {
+			memcpy(dp, "%25", 3);
+			dp += 2;
 			continue;
 		}
 		*dp = ch;
diff --git a/git-status.sh b/git-status.sh
--- a/git-status.sh
+++ b/git-status.sh
@@ -54,8 +54,9 @@ else
 	perl -e '$/ = "\0";
 		while (<>) {
 			chomp;
-			s|\t|//{TAB}//|g;
-			s|\n|//{LF}//|g;
+			s|%([^021][^059])|%25\1|g;
+			s|\t|%09|g;
+			s|\n|%10|g;
 			s/ /\\ /g;
 			s/^/A /;
 			print "$_\n";
@@ -84,8 +85,9 @@ perl -e '$/ = "\0";
 	my $shown = 0;
 	while (<>) {
 		chomp;
-		s|\t|//{TAB}//|g;
-		s|\n|//{LF}//|g;
+		s|%([^01][^09])|%25\1|g;
+		s|\t|%09|g;
+		s|\n|%10|g;
 		s/^/#	/;
 		if (!$shown) {
 			print "#\n# Ignored files:\n";
---
0.99.8.GIT
