From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/3] bisect: use a detached HEAD to bisect
Date: Sat, 24 May 2008 09:14:21 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805240842360.3081@woody.linux-foundation.org>
References: <20080523012857.acce6457.chriscool@tuxfamily.org> <7v3ao9twfa.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0805230823330.3081@woody.linux-foundation.org> <18487.62245.59892.442935@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat May 24 18:15:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzwP7-0001pu-HN
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 18:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbYEXQOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 12:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756071AbYEXQOm
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 12:14:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57354 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756006AbYEXQOl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 May 2008 12:14:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4OGENuc027299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 24 May 2008 09:14:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4OGELTM015142;
	Sat, 24 May 2008 09:14:22 -0700
In-Reply-To: <18487.62245.59892.442935@cargo.ozlabs.ibm.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.906 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82819>



On Sat, 24 May 2008, Paul Mackerras wrote:
> 
> I could make it show "HEAD" in a green box for a detached head easily
> enough.  That could be ambiguous if you had a branch called HEAD, I
> suppose, but having a branch called HEAD would be deeply confusing
> anyway. :)  Do you have any alternative suggestion for how to display
> a detached head?

Well, it would be really nice if the "active commit" was always visible 
some way.

Of course, _usually_ it's just the top commit, and it's obvious that way 
which one is the checked-out one, but if you do "gitk --all" or just 
generally have multiple branches, right now it's hard to see what commit 
is the checked-out one, regardless of whether it's detached or not.

I think "HEAD" in a green box would solve that too, but on the other hand, 
we have a *lot* of boxes already. For people who mainly just track another 
repo, you already have one box saying "master", and another one saying 
"remotes/origin/master", and adding yet *another* box saying HEAD that 
just points to the same commit will work, but do we really want that?

I actually like the red circle for "Local uncommitted changes". Maybe we 
can use a similar visual clue for "currently checked out". You already 
picked green for the "added to the index" case, so we have the three 
primary RGB colors already used, but we could make it just be a deep 
yellow.

Of course, maybe people hate lots of colos already, and something more 
akin to the text background thing that we use for the selected commit 
would be better.

I dunno. There's so many options.

Here's a "make it yellow" patch.

		Linus
----
 gitk-git/gitk |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9ab6dba..94ca826 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4841,7 +4841,8 @@ proc drawcmittext {id row col} {
     global cmitlisted commitinfo rowidlist parentlist
     global rowtextx idpos idtags idheads idotherrefs
     global linehtag linentag linedtag selectedline
-    global canvxmax boldrows boldnamerows fgcolor nullid nullid2
+    global canvxmax boldrows boldnamerows fgcolor
+    global HEAD nullid nullid2
 
     # listed is 0 for boundary, 1 for normal, 2 for negative, 3 for left, 4 for right
     set listed $cmitlisted($curview,$id)
@@ -4849,6 +4850,8 @@ proc drawcmittext {id row col} {
 	set ofill red
     } elseif {$id eq $nullid2} {
 	set ofill green
+    } elseif {$id eq $HEAD} {
+	set ofill yellow
     } else {
 	set ofill [expr {$listed != 0 ? $listed == 2 ? "gray" : "blue" : "white"}]
     }
@@ -9886,6 +9889,8 @@ set viewperm(0) 0
 set viewargs(0) {}
 set viewargscmd(0) {}
 
+set HEAD [exec git rev-parse HEAD]
+
 set numcommits 0
 set loginstance 0
 set cmdlineok 0
