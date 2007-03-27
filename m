From: Jeff King <peff@peff.net>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 19:35:52 -0400
Message-ID: <20070327233552.GA7186@coredump.intra.peff.net>
References: <17929.37382.984339.742025@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLCo-0003YU-Pm
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 01:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933594AbXC0Xfz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 19:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934303AbXC0Xfz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 19:35:55 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2714 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933594AbXC0Xfy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 19:35:54 -0400
Received: (qmail 6076 invoked from network); 27 Mar 2007 23:36:24 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 27 Mar 2007 23:36:24 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2007 19:35:52 -0400
Content-Disposition: inline
In-Reply-To: <17929.37382.984339.742025@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43322>

On Tue, Mar 27, 2007 at 03:52:06PM -0600, Bill Lear wrote:

> I'm sure the git developers grow tired of working with addle-brained
> users, but I sometimes forget what the contents of a topic branch are,
> how old it is, etc.  As to content, I can make better branch names,
> but I think it would be useful to be able to query git as to the
> creation time of all of my branches, perhaps sorted from newest to
> oldest.

I'm not sure you can always accurately get that information. If you have
reflogs turned on, you can look at the oldest reflog for the that ref;
however, the reflog may have been pruned. You can also try looking at
the commit graph, but then you need a reference branch ("when did I
branch from master"), and even that's not entirely useful. You have to
look at the latest merge-base, but that tells you the last time you
merged with master, not necessarily the first time.

That being said, something like this should work:

-- >8 --
#!/bin/sh

branch_date() {
  git-rev-list -g --pretty=format:'%ct %cd' $1 | tail -n 1
}

git-show-ref --heads |
  while read sha1 branch; do
    echo "$branch `branch_date $branch`"
  done |
  sort -k 2nr |
  while read branch timestamp date; do
    printf '%20s %s\n' ${branch#refs/heads/} "$date"
  done
-- >8 --

Unfortunately, there is a bug in git-rev-list; I've just posted a patch, but
the one-liner fix is:

diff --git a/commit.c b/commit.c
index 718e568..a92958c 100644
--- a/commit.c
+++ b/commit.c
@@ -760,7 +760,7 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	if (msg + start == ep)
 		return;
 
-	table[5].value = xstrndup(msg + start, ep - msg + start);
+	table[5].value = xstrndup(msg + start, ep - (msg + start));
 
 	/* parse tz */
 	for (start = ep - msg + 1; start < len && isspace(msg[start]); start++)

With that fix, the script above should hopefully produce what you want.

-Peff
