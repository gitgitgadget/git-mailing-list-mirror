From: Mark Wooding <mdw@distorted.org.uk>
Subject: On merging strategies, fast forward and index merge
Date: Sat, 18 Mar 2006 10:17:26 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne1nnhm.fr9.mdw@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Sat Mar 18 11:17:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKYV6-0003Kd-Dq
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 11:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWCRKRd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 05:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWCRKRd
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 05:17:33 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:36077 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932363AbWCRKRc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 05:17:32 -0500
Received: (qmail 8815 invoked by uid 110); 18 Mar 2006 10:17:26 -0000
To: git@vger.kernel.org
Received: (qmail 8802 invoked by uid 9); 18 Mar 2006 10:17:26 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1142677046 8800 172.29.199.2 (18 Mar 2006 10:17:26 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sat, 18 Mar 2006 10:17:26 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17693>

I recently read Junio's description of how to dig oneself out of a hole
using `git merge -s ours' (I'm learning to use the space...), and I've
realised there's a problem here.

The `ours' merge strategy is meant to create a merge commit whose tree
is in every way identical to that of the starting commit.  But `git
merge' won't always do this, because it doesn't always invoke the
strategy program.

Consider the command `git merge -s ours MESSAGE MASTER FAILED'.

  * If we've not actually messed with our MASTER since the FAILED branch
    departed, then MASTER is actually an ancestor of FAILED, and `git
    merge' will unhelpfully fast-forward us to the tip of the FAILED
    branch.  Instead of leaving the merge result like MASTER, it's made
    it entirely the wrong thing!

  * If both MASTER and FAILED have made changes, but to different files,
    then `git merge' will try an index-level merge, find that it
    succeeds, and leave us with a mixture of MASTER and FAILED files.
    Which is (in this case) entirely what we didn't want.

Additionally, it occurs to me that the fast-forwarding behaviour isn't
always what I want anyway.  Consider a merge of a topic branch:

  `git merge MESSAGE MASTER TOPIC'

If I allow fast-forward, I lose information about where the topic
started and ended.  This is a shame, particularly if I find other places
I want to apply those changes (either as a string of similar commits, or
squidged into a single one) onto other branches.

Because code speaks louder, I'll follow-up this article with a suggested
patch.

-- [mdw]
