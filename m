From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git bugs
Date: Wed, 11 Jun 2008 23:17:23 -0400
Message-ID: <20080612031723.GJ11793@spearce.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ben Lynn <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 05:18:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6dKr-0003ux-Qo
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 05:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbYFLDR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 23:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbYFLDR2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 23:17:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45363 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYFLDR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 23:17:27 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K6dJI-0002s5-MV; Wed, 11 Jun 2008 23:17:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BD04720FBAE; Wed, 11 Jun 2008 23:17:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84693>

Ben Lynn <benlynn@gmail.com> wrote:
> 1. The import/export language poorly handles distinct initial commits
> on the same branch, because given two commits with same branch name,
> it assumes the latter is the descendant of the former (if there are no
> "from" commands).
> 
> Normally this is what you want. But if your project, like git, ever
> merges distinct initial commits, then all but the first will
> unexpectedly gain parents, corrupting all their descendants' hashes.
...
> As a workaround, I have a custom importer that knows that
> git-fast-export omits the "from" command in initial commits. But there
> should be a command to specify that the current commit is an initial
> commit, allowing reliable export of projects such as git.

fast-export is wrong, and is using the language wrong.  fast-import
is correct.  Because I said so.  :-)

No, seriously, fast-import came along first and can describe what
you are referring to as the many initial root commits in git.git.
The issue is fast-export is not generating commands to say as much.

Its quite easily fixable.

When we output a commit in handle_commit() we just need to reset
the branch if we have no parents.  That simple.  This is totally
untested, but I think it fixes it.


diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 1dfc01e..d0a462f 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -188,6 +188,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	mark_object(&commit->object);
 	if (!is_encoding_utf8(encoding))
 		reencoded = reencode_string(message, "UTF-8", encoding);
+	if (!commit->parents)
+		printf("reset %s\n", (const char*)commit->util);
 	printf("commit %s\nmark :%d\n%.*s\n%.*s\ndata %u\n%s",
 	       (const char *)commit->util, last_idnum,
 	       (int)(author_end - author), author,

-- 
Shawn.
