From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Associating tags with changelogs
Date: Mon, 5 May 2008 00:06:46 -0400
Message-ID: <20080505040646.GK29038@spearce.org>
References: <218b69370805042040h66d02979jac6bd64456a9d304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Zack Brown <zacharyb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 06:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsrzH-0004Fg-KV
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 06:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbYEEEGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 00:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbYEEEGu
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 00:06:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44056 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbYEEEGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 00:06:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JsryG-00063n-9a; Mon, 05 May 2008 00:06:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9DC0620FBAE; Mon,  5 May 2008 00:06:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <218b69370805042040h66d02979jac6bd64456a9d304@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81225>

Zack Brown <zacharyb@gmail.com> wrote:
> I'm using git to extract changelog entries into a MySQL database, and
> I want to be able to associate each changelog with the official
> release in which it first appears. [...]
> 
> My script keeps track of the most recent changelog entry that it has
> processed into the MySQL database, so the next time it runs, it picks
> up from that entry, using "`git-log sha1string.. --pretty=fuller", and
> inserts only the changelogs since that entry into the database.
...
> Is there a command to do that? I don't see anything in the man pages for it.

No, not really.  The way to do this is either invoke
`git describe --contains $sha1` for each commit, or to
keep track of it yourself in the script.

The algorithm is really simple, especially if you have something like
Math::BigInt in Perl.  Make a list of all tags, assign a bit to each
tag, make a hash of commits to BigInt (bitset of tags that contain the
commit).

Then run `git rev-list --all --parents --not sha1string` (where
sha1string is the last commit you added to the database) and copy
the bits of each commit onto its parents until the end of input.

Later loop through those commits again.  If a commit's parent has
a color for a tag but the commit doesn't have that tag, then that
tag is the first time the commit appeared in a tag.

-- 
Shawn.
