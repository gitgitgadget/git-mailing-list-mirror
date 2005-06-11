From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] apply.c: tolerate diff from a dirty but unchanged path
Date: Sat, 11 Jun 2005 16:27:25 -0700
Message-ID: <7vpsusqxsy.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 01:23:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhFJu-0004Eo-97
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 01:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVFKX1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 19:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVFKX1h
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 19:27:37 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:4563 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261663AbVFKX11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 19:27:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611232725.INFS20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Jun 2005 19:27:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 29 May 2005 11:53:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I just noticed a problem with empty "diff --git" header a dirty
but otherwise unmodified path spits out.  The problem is related
to an old topic:

    Re: [PATCH] Do not show empty diff in diff-cache uncached.
    >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

    LT> On Sat, 28 May 2005, Junio C Hamano wrote:
    >> Recent diff-cache produces "diff --git" header internally before
    >> calling the "diff" command, which results in an empty diff for
    >> such a file, cluttering the output.  This patch fixes this.

    LT> I actually _expect_ that "git-diff-files" will show
    LT> files that don't match the index, even if they happen to
    LT> have the exact content that the index points to. It's
    LT> how I know whether the index is up-to-date or not.

I now agree with the reasoning and think showing an empty "diff
--git" header is a good thing.  I had something like this, while
fixing a rename/copy bug:

    ...
     #endif

     static void diff_resolve_rename_copy(void)
    diff --git a/diffcore-break.c b/diffcore-break.c
    diff --git a/diffcore-rename.c b/diffcore-rename.c
    --- a/diffcore-rename.c
    +++ b/diffcore-rename.c
    @@ -249,8 +249,12 @@ void diffcore_rename(int detect_rename, 
    ...

I touched diffcore-break.c and decided I should not change it so
I reverted, which is why the empty "diff --git" for that file
shows that the cache is dirty.  The problem is that currently,
"git-apply --stat" seems to barf reading such a patch.

Here is a proposed fix.

------------
apply.c: tolerate diff from a dirty but otherwise unchanged cache.

For such an entry, "diff --git" line without anything else is
output, but the next "diff --git" header is not really treated
as an unrecognized diff.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -343,7 +343,7 @@ static int gitdiff_dissimilarity(const c
  */
 static int gitdiff_unrecognized(const char *line, struct patch *patch)
 {
-	return -1;
+	return -2;
 }
 
 static char *git_header_name(char *line)
@@ -453,8 +453,12 @@ static int parse_git_header(char *line, 
 			int oplen = strlen(p->str);
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
-			if (p->fn(line + oplen, patch) < 0)
+			switch (p->fn(line + oplen, patch)) {
+			case -1:
 				return offset;
+			case -2:
+				return -1;
+			}
 			break;
 		}
 	}

