From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Move JGit off JSch?
Date: Thu, 25 Jun 2009 11:14:28 -0700
Message-ID: <20090625181428.GM11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJtT4-0006Au-I2
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 20:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbZFYSO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 14:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbZFYSO0
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 14:14:26 -0400
Received: from george.spearce.org ([209.20.77.23]:53794 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbZFYSO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 14:14:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0DCA2381FD; Thu, 25 Jun 2009 18:14:28 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122227>

I'm fed up with JSch.

The remote.<name>.timeout stuff I added recently to JGit causes
JSch to throw NPE on timeout[1] and the original author seems to
think that's a reasonable thing to do[2].

MINA SSHD[3] contains a different client implementation, licensed
under the Apache License 2.0.  Its currently missing public key
support[4] but the library is actually a pretty solid library,
and the author seems to have a decent clue.

I'm really starting to consider adding the public key support the
client side of MINA SSHD, and then rewriting TransportGitSsh to use
it instead of JSch.  The downside is, that really increases our
dependency chain, and SSH key management under Eclipse becomes a
unique EGit problem as we can't piggy-back onto the existing JSch
key management already done by the workbench.

But, I just spent the last ~3 hours digging around JSch trying to
fix this NPE bug... and realized the code is very thread unsafe,
uses at least 2 threads per connection (your thread, and a thread
it spawns for you) so you have no choice but to use threads, and
the author seems to think random NPEs are OK (see [2] and all of
the NPE bugs on sourceforge).

[1] http://jira.source.android.com/jira/browse/GERRIT-233
[2] http://www.mail-archive.com/jsch-users@lists.sourceforge.net/msg00520.html
[3] http://mina.apache.org/sshd/
[4] https://issues.apache.org/jira/browse/SSHD-25

-- 
Shawn.
