From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fixes for option parsing
Date: Sun, 16 Apr 2006 17:29:13 -0700
Message-ID: <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 02:29:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVHcG-0005an-AX
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 02:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWDQA3R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 20:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWDQA3R
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 20:29:17 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:13032 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750870AbWDQA3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Apr 2006 20:29:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060417002915.HBBZ20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Apr 2006 20:29:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 16 Apr 2006 15:17:23 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18809>

Thanks for fixing this.  I've applied and merged it to the
"next" branch.

In the mid-term, I am hoping we can drop the generate_header()
callchain _and_ the custom code that formats commit log in-core,
found in cmd_log_wc().  rev->use_precomputed_header and perhaps
rev->header can be dropped and replaced with a call to a
function to print formatted log to stdout (or perhaps a FILE *,
because I want to reuse this to make output part of
"git-format-patch" internal) from log-tree.

For that, I'd need to define a new CMIT_FMT for the format-patch
output.  Another thing needed is to clean up the commit_prefix
local variable defined in cmd_log_wc() -- it should use
rev->header_prefix, but before that the part that rewrites
opt->header_prefix to have a blank line between commits, in
log-tree.c::do_diff_combined() and log_tree_commit() need to be
cleaned up.

For the header_prefix line, there also is a subtle difference
between the one-commit diff-tree and log.  The former lists
"this commit (from that commit)", which is perhaps useful for
cut and paste purposes.  The latter just says "this commit".

I wish this "diff-tree SHA1 (from ANOTHERSHA1)" format can be
dropped and replaced with "commit SHA1" format like "git log"
does uniformly, but it might be already depended upon by
Porcelains.

If the commit is not a merge, "commit SHA1" means the same thing
as "diff-tree SHA1 (from SHA1^)", and if it _is_ a merge, then
the merge parents are listed on the "Merge: " line anyway for
all formats other than --pretty=oneline, so unless this change
breaks an Porcelain, there is really no downside.
