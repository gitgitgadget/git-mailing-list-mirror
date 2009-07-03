From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Allow the Unix epoch to be a valid commit date
Date: Thu, 2 Jul 2009 21:34:54 -0700
Message-ID: <20090703043454.GA20080@dcvr.yhbt.net>
References: <sbqo45dgejpcnt58cam2tfkeon4is2v4ur@4ax.com> <20090703042846.GA14767@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, esskov@oncable.dk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 06:35:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMaUM-00076F-8o
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 06:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbZGCEex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 00:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbZGCEew
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 00:34:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53955 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbZGCEev (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 00:34:51 -0400
Received: from localhost (user-118bg3p.cable.mindspring.com [66.133.192.121])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 665D41F84D;
	Fri,  3 Jul 2009 04:34:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090703042846.GA14767@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122680>

It is common practice to use the Unix epoch as a fallback date
when a suitable date is not available.  This is true of git svn
and possibly other importing tools that import non-git history
into git.

Instead of clobbering established strtoul() error reporting
semantics with our own, preserve the strtoul() error value
of ULONG_MAX for fsck.c to handle.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 commit.c |    6 +-----
 fsck.c   |    2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index aa3b35b..a47fb4d 100644
--- a/commit.c
+++ b/commit.c
@@ -50,7 +50,6 @@ struct commit *lookup_commit(const unsigned char *sha1)
 
 static unsigned long parse_commit_date(const char *buf, const char *tail)
 {
-	unsigned long date;
 	const char *dateptr;
 
 	if (buf + 6 >= tail)
@@ -73,10 +72,7 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 	if (buf >= tail)
 		return 0;
 	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
-	date = strtoul(dateptr, NULL, 10);
-	if (date == ULONG_MAX)
-		date = 0;
-	return date;
+	return strtoul(dateptr, NULL, 10);
 }
 
 static struct commit_graft **commit_graft;
diff --git a/fsck.c b/fsck.c
index 511b82c..89278c1 100644
--- a/fsck.c
+++ b/fsck.c
@@ -229,7 +229,7 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	struct commit_graft *graft;
 	int parents = 0;
 
-	if (!commit->date)
+	if (commit->date == ULONG_MAX)
 		return error_func(&commit->object, FSCK_ERROR, "invalid author/committer line");
 
 	if (memcmp(buffer, "tree ", 5))
-- 
Eric Wong
