From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Thu, 16 Oct 2008 10:18:13 -0400
Message-ID: <20081016141812.GA30026@sigill.intra.peff.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net> <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl> <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net> <524C98C8-C3A5-4501-932A-2F0ACDE2886A@simplicidade.org> <3520b7a9009f072cfc3aeb82ae205e6b.squirrel@webmail.highteq.net> <48F7280C.3080205@viscovery.net> <8199b7ae4c441c4311045141ddaaa36f.squirrel@webmail.highteq.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Pedro Melo <melo@simplicidade.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Lars Hoss <lars@woeye.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 16:19:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqThT-0003Xe-GZ
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 16:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbYJPOSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 10:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbYJPOSS
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 10:18:18 -0400
Received: from peff.net ([208.65.91.99]:2559 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbYJPOSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 10:18:17 -0400
Received: (qmail 7617 invoked by uid 111); 16 Oct 2008 14:18:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 16 Oct 2008 10:18:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2008 10:18:13 -0400
Content-Disposition: inline
In-Reply-To: <8199b7ae4c441c4311045141ddaaa36f.squirrel@webmail.highteq.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98384>

On Thu, Oct 16, 2008 at 02:30:00PM +0200, Lars Hoss wrote:

> The commit was on Jun 5, 14:47:50 by Marius Storm-Olsen and the relevant
> file is wt-status.c.
> 
> Ok, I think I found the issue. I enabled showUntrackedFiles in my gitconfig:
> 
> status.showUntrackedFiles = all

Ah, OK. I see what is going on. All code paths call the read_directory
infrastructure to find untracked files. If status.showUntrackedFiles is
"normal", then we set dir.show_other_directories, to indicate that we
want to see the directories, but not their constituent files.

If status.showuntrackedfiles is set to "all", then we don't set the
show_other_directories flag, because we want each file. But the code in
dir.c:treat_directory uses the "show_other_directories" flag to say "oh,
we're just interested in untracked files" and decide whether to ignore
gitlinks.

Meaning that we must still filter the results of read_directory based on
the cache. And indeed, this is what "git ls-files -o" does, as explained
in 5698454e (Fix some "git ls-files -o" fallout from gitlinks). It's
also what the code in wt_status_print_untracked is _supposed_ to do, but
it was never updated to handle this case when git-ls-files was. Which is
probably my fault a long time ago for cutting and pasting the 5 lines of
"is this thing in the cache" when writing wt-status.c.

So the quick fix is to re-cut-and-paste the code:

diff --git a/wt-status.c b/wt-status.c
index d2eac36..792d5f1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -280,10 +280,14 @@ static void wt_status_print_untracked(struct wt_status *s)
 		/* check for matching entry, which is unmerged; lifted from
 		 * builtin-ls-files:show_other_files */
 		struct dir_entry *ent = dir.entries[i];
-		int pos = cache_name_pos(ent->name, ent->len);
+		int len, pos;
+		len = ent->len;
+		if (len && ent->name[len-1] == '/')
+			len--;
+		pos = cache_name_pos(ent->name, len);
 		struct cache_entry *ce;
 		if (0 <= pos)
-			die("bug in wt_status_print_untracked");
+			continue;
 		pos = -pos - 1;
 		if (pos < active_nr) {
 			ce = active_cache[pos];

But the right solution is to refactor this so the code isn't duplicated.
And I'll post a patch for that in a second.

I do have to wonder, though, whether an even better solution would be to
more explicitly tell read_directory "I'm interested only in 'other'
files" rather than relying on guessing based on
dir.show_other_directories. Then we could just avoid ever passing these
gitlinks back to ls-files and status in the first place.

-Peff
