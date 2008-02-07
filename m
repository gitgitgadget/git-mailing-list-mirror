From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH (repost)] Improve bash prompt to detect merge / rebase in progress
Date: Thu, 7 Feb 2008 01:23:42 +0100
Message-ID: <200802070123.43109.robin.rosenberg.lists@dewire.com>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com> <200802062314.39440.robin.rosenberg.lists@dewire.com> <7vodatu37m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 01:30:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMuf5-0005ra-2R
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 01:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933831AbYBGAaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 19:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933829AbYBGAaI
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 19:30:08 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12682 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932971AbYBGAaC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 19:30:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BDFCA800697;
	Thu,  7 Feb 2008 01:29:59 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zAvJbIueDY0; Thu,  7 Feb 2008 01:29:59 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id A2AF9800690;
	Thu,  7 Feb 2008 01:29:53 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7vodatu37m.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72881>

onsdagen den 6 februari 2008 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> > I'm not sure whether you didn't like it or not or just lost it. Here
> > is the vastly enhanced prompt again, rebased.
> 
> Most likely "lost", and I appreciate a reminder like this.
> 
> > From 76aa8bae8491c1ffbd6e3f5c99ab014ef87794c8 Mon Sep 17 00:00:00 2001
> > From: Shawn O. Pearce <spearce@spearce.org>
> > Date: Tue, 4 Sep 2007 03:13:01 -0400
> > Subject: 
> >
> > This patch makes the git prompt (when enabled) show if a merge or a
> > rebase is unfinished. It also detects if a bisect is being done as
> > well as detached checkouts.
> >
> > Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> 
> But this looks funny, without Subject: and also S-o-b by the
> original author (if Shawn is indeed the original author).  It
> appears that the patch originally was from Shawn and after
> discussion petered out around Oct 1st 2007 there wasn't a resend
> for inclusion.  Is this improved/revised in any way from the one
> in the thread?
No.

I sent a patch and Shawn modified it somewhat and posted the full modified
patch. Here is the same patch again (to make sure you get the right one). It
has a better comment than the one I sent recently.

-- robin

>From 82a5b8d5b043ffc7c1950b391ec7ae69d575640b Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sun, 30 Sep 2007 02:20:45 +0200
Subject: [PATCH] Improve bash prompt to detect various states like an unfinished merge

This patch makes the git prompt (when enabled) show if a merge or a
rebase is unfinished. It also detects if a bisect is being done as
well as detached checkouts.

An uncompleted git-am cannot be distinguised from a rebase (the
non-interactive version). Instead of having an even longer prompt
we simply ignore that and hope the power users that use git-am knows
the difference.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 contrib/completion/git-completion.bash |   37 ++++++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0d33f9a..4ea727b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -64,12 +64,41 @@ __gitdir ()
 
 __git_ps1 ()
 {
-	local b="$(git symbolic-ref HEAD 2>/dev/null)"
-	if [ -n "$b" ]; then
+	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	if [ -n "$g" ]; then
+		local r
+		local b
+		if [ -d "$g/../.dotest" ]
+		then
+			r="|AM/REBASE"
+			b="$(git symbolic-ref HEAD 2>/dev/null)"
+		elif [ -f "$g/.dotest-merge/interactive" ]
+		then
+			r="|REBASE-i"
+			b="$(cat $g/.dotest-merge/head-name)"
+		elif [ -d "$g/.dotest-merge" ]
+		then
+			r="|REBASE-m"
+			b="$(cat $g/.dotest-merge/head-name)"
+		elif [ -f "$g/MERGE_HEAD" ]
+		then
+			r="|MERGING"
+			b="$(git symbolic-ref HEAD 2>/dev/null)"
+		else
+			if [ -f $g/BISECT_LOG ]
+			then
+				r="|BISECTING"
+			fi
+			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
+			then
+				b="$(cut -c1-7 $g/HEAD)..."
+			fi
+		fi
+
 		if [ -n "$1" ]; then
-			printf "$1" "${b##refs/heads/}"
+			printf "$1" "${b##refs/heads/}$r"
 		else
-			printf " (%s)" "${b##refs/heads/}"
+			printf " (%s)" "${b##refs/heads/}$r"
 		fi
 	fi
 }
-- 
1.5.4.rc4.25.g81cc
