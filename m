From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: bash completion only provides revs, not paths
Date: Tue, 22 Apr 2008 21:52:36 -0400
Message-ID: <20080423015236.GM29771@spearce.org>
References: <20080422112129.GA30923@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Uwe Kleine-Knig <Uwe.Kleine-Koenig@digi.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 03:53:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoUAs-00034C-Jt
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 03:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758858AbYDWBwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 21:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758828AbYDWBwn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 21:52:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39506 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758729AbYDWBwm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 21:52:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JoU9q-0000ya-Mq; Tue, 22 Apr 2008 21:52:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E9B6420FBAE; Tue, 22 Apr 2008 21:52:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080422112129.GA30923@digi.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80181>

Uwe Kleine-Knig <Uwe.Kleine-Koenig@digi.com> wrote:
> currently autocompletion in 
> 
> 	ukleinek@zentaur:~/gsrc/linux-2.6 git log ar<tab>
> 
> only yields "armltd/" (i.e. the prefix of some remote tracking branches)
> but most of the time I want it to complete to "arch/".

Right.  It favors refs over paths.  Why?  Because I complete refs
more than I complete paths.
 
> I don't understand that autocompletion stuff, but probably to fix that
> several __git_complete_revlist should be replaced by a
> __git_complete_revlist_or_path.  The harder part is to implement the
> latter function.  An optimal implementation would only give back paths
> if there is a "--" somewhere before the cursor.

Its ugly, but if we only do path name completion after a -- then
we can just return "" as the options to bash, and it will go off
and do the path name completion itself.  If we do path names and
and refs at the same time, that's a disaster waiting to happen.
We would have to do the path name completion ourselves.

How is this?

--8<--
bash completion: Completely only path names after -- in options

If the user has inserted a -- before the current argument we are
being asked to complete they are most likely trying to force Git into
treating this argument as a path name, and not as a ref.  We should
allow bash to complete it as a path from the local working directory.

Suggested-by: Uwe Kleine-Knig <Uwe.Kleine-Koenig@digi.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0f5d30c..8d8405e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -308,7 +308,20 @@ __git_complete_file ()
 
 __git_complete_revlist ()
 {
-	local pfx cur="${COMP_WORDS[COMP_CWORD]}"
+	local c=1 pfx cur
+
+	while [ $c -lt $COMP_CWORD ]; do
+		cur="${COMP_WORDS[c]}"
+		case "$cur" in
+		--)
+			COMPREPLY=()
+			return
+			;;
+		esac
+		c=$((++c))
+	done
+
+	cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	*...*)
 		pfx="${cur%...*}..."
-- 
1.5.5.1.141.gd55b


-- 
Shawn.
