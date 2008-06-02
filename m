From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 2 Jun 2008 11:43:20 -0400
Message-ID: <20080602154320.GK12896@spearce.org>
References: <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806021545340.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:44:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3CCr-0005YW-1h
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 17:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbYFBPn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 11:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbYFBPn0
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 11:43:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41973 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbYFBPnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 11:43:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K3CBo-0004Cx-Bf; Mon, 02 Jun 2008 11:43:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6C35320FBAE; Mon,  2 Jun 2008 11:43:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806021545340.13507@racer.site.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83533>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> _However_, I still try to come up with some attic for deleted refs.  It is 
> not just a matter of moving the logs to a different namespace because of 
> D/F conflicts.

Record the delete at the end of the reflog so we have a date/time
record and the last SHA-1 value, just in case it doesn't match up
with the most recent reflog entry (e.g. user ran some legacy tool
that just redirect git-commit-tree output to the branch itself).

Take the SHA-1 hash of the reflog now that the final entry is
written.  Rename the file to .git/attic/$sha1 and call it a day.
I thought about compressing the file too, but its not worth saving
the disk space here and it would make tools that inspect the attic
expensive to run.

The attic can be easily cleaned out by looking at the timestamp of
the last record of each file.  Attic log files older than X days can
be removed.  This is better than reading the modification time of
the file as we don't have to worry about some copy tool not saving
the modification time if the user moves/copies the repository.

That's all the easy stuff.

The hard stuff is:

- Should the commits listed in attic reflogs be considered reachable
  when we pack, prune or fsck?  Commits in a reflog are, even if
  they aren't reachable from a transport perspective.

- What command gets the extra options to see what branches are in
  the attic and when they got there?

- What command gets the extra option to recover a branch from the
  attic?

- When we recover a branch from the attic is it sufficient to recover
  it to the name it had at time of deletion?  Should we allow you to
  recover it to a different name?

- Is it sufficient to make you recover the branch from the attic
  before you can access the rest of its reflog with porcelain?

- What do we do if we recover a branch with stale reflog entries
  and the attic is deemed to not be reachable (see above).

-- 
Shawn.
