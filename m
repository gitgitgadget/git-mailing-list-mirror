From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FFmpeg considering GIT
Date: Sat, 5 May 2007 10:26:12 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
References: <loom.20070502T111026-882@post.gmane.org>
 <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz>
 <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org>
 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Karl Hasselstr?m <kha@treskal.com>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 19:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkO1w-00046J-EE
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934088AbXEER02 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 13:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934087AbXEER02
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:26:28 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:54279 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934088AbXEER01 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2007 13:26:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l45HQD1A032453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 5 May 2007 10:26:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l45HQCDY004151;
	Sat, 5 May 2007 10:26:12 -0700
In-Reply-To: <20070505133543.GC3379@diana.vm.bytemark.co.uk>
X-Spam-Status: No, hits=-2.979 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46269>



On Sat, 5 May 2007, Karl Hasselstr?m wrote:
>
> On 2007-05-04 11:17:05 -0700, Carl Worth wrote: 
> > or by content of the patches themselves:
> >
> >       git log -p -S'snippet of interest'
> 
> Somewhat unrelated: how can I make gitk display these (and only these)
> commits? git-log is not bad, but in 95% of cases I find gitk easier to
> use.
> 
> I know that I can ask it to highlight commits that insert or remove
> "snippet of interest", but frequently the highlighted commits are ten
> out of ten thousand, and not that easy to find even when boldfaced.
> What I want is to make it display only those commits.

The "-S" thing doesn't really interact well with "gitk", because it 
doesn't rewrite the parent information (it is basically just a "hide 
commits that don't pass this criteria"). As such, gitk, which requires 
parent information to generate the graph, is not very amenable to using 
"-S" and such.

That said, you can apply this fairly trivial patch to "gitk" to make it 
parse the output of "git log" rather than "git rev-list", and that will 
actually get you working -S'xyz' parsing automatically. It's just that the 
commit history window will look like crap.

This patch may be worth applying regardless, since there is really no real 
reason to use "git rev-list". In fact, I really like the ability to say

	gitk --stat

and have the diffstat output visible in the commit window automatically ;)

We might want to teach people that "git rev-list" isn't really all that 
useful any more, at least with the fancy stuff (it's still useful for just 
generating a list of objects, and for doing things like

	git rev-list v2.6.21.. | wc -l

just to count commits).

Junio, Paul?

		Linus
---
 gitk |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index b1c65d7..bec7bb9 100755
--- a/gitk
+++ b/gitk
@@ -33,8 +33,8 @@ proc start_rev_list {view} {
 	set order "--date-order"
     }
     if {[catch {
-	set fd [open [concat | git rev-list --header $order \
-			  --parents --boundary --default HEAD $args] r]
+	set fd [open [concat | git log -z --pretty=raw $order \
+			  --parents --boundary $args] r]
     } err]} {
 	puts stderr "Error executing git rev-list: $err"
 	exit 1
@@ -129,7 +129,8 @@ proc getcommitlines {fd view}  {
 	set ok 0
 	set listed 1
 	if {$j >= 0} {
-	    set ids [string range $cmit 0 [expr {$j - 1}]]
+	    # start with 'commit '
+	    set ids [string range $cmit 6 [expr {$j - 1}]]
 	    if {[string range $ids 0 0] == "-"} {
 		set listed 0
 		set ids [string range $ids 1 end]
@@ -147,7 +148,7 @@ proc getcommitlines {fd view}  {
 	    if {[string length $shortcmit] > 80} {
 		set shortcmit "[string range $shortcmit 0 80]..."
 	    }
-	    error_popup "Can't parse git rev-list output: {$shortcmit}"
+	    error_popup "Can't parse git git log output: {$shortcmit}"
 	    exit 1
 	}
 	set id [lindex $ids 0]
