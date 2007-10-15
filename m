From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git blame crashes with internal error
Date: Mon, 15 Oct 2007 08:39:23 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710150831410.6887@woody.linux-foundation.org>
References: <20071014143628.GA22568@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 18:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhS8H-0003tq-4M
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 17:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764362AbXJOPpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 11:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764379AbXJOPpR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 11:45:17 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49781 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764307AbXJOPpP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 11:45:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9FFdOjJ007921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Oct 2007 08:39:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9FFdNo4011473;
	Mon, 15 Oct 2007 08:39:24 -0700
In-Reply-To: <20071014143628.GA22568@atjola.homenet>
X-Spam-Status: No, hits=-2.417 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_22
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61008>



On Sun, 14 Oct 2007, Bj?rn Steinbrink wrote:
> 
> git blame just decided to crash on me, when I tried to use it while
> resolving a merge conflict.

Yes. What's going on is that "ce_mode = 0" is a magic marker for an 
unmerged entry (set up by things like diff-lib.c:do_diff_cache() and 
builtin-read-tree.c:read_tree_unmerged()) and the ce_match_stat_basic() 
function gets upset about this.

I'm not entirely sure that the whole "ce_mode = 0" case is a good idea to 
begin with, and maybe the right thing to do is to remove that horrid 
freakish special case, but removing the internal error seems to be the 
simplest fix for now.

		Linus

---
 read-cache.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 56202d1..3b11aa7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -149,6 +149,8 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 		else if (ce_compare_gitlink(ce))
 			changed |= DATA_CHANGED;
 		return changed;
+	case 0:		/* Special case: unmerged file in index */
+		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
 	default:
 		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
 	}
