From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 12:34:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509201224360.2553@g5.osdl.org>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz>
 <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> <20050919225422.GG18320@pasky.or.cz>
 <Pine.LNX.4.58.0509191746130.2553@g5.osdl.org> <20050920135735.GC1884@pasky.or.cz>
 <Pine.LNX.4.58.0509200734440.2553@g5.osdl.org> <20050920150719.GB1836@pasky.or.cz>
 <Pine.LNX.4.58.0509200906120.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	fonseca@diku.dk, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:36:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHntL-0007JD-Pu
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 21:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbVITTey (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 15:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVITTey
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 15:34:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965095AbVITTey (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 15:34:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8KJYJBo009522
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Sep 2005 12:34:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8KJYBOm001937;
	Tue, 20 Sep 2005 12:34:14 -0700
To: Petr Baudis <pasky@suse.cz>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0509200906120.2553@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9017>



On Tue, 20 Sep 2005, Linus Torvalds wrote:
> 
> (Side note: the "gitk" thing works really badly. gitk doesn't quote its 
> arguments to "git-rev-list", so something like
> 
> 	gitk --since="1 month ago"
> 
> does NOT work, while "--since=yesterday" does, because it has no spaces. 
> Gaah. "Obi-Paul Mackerras, you're our only hope")

Fixed thusly, I think.

There is 'eval' magic with pure lists. I'm getting convinced that tcl is 
evil after all - that's just _confusing_. A real language shouldn't have 
semantic differences from this change, but it clearly does.

However, getting gitk working also shows a problem with --topo-order
(which gitk uses) and the time limits. See

	[torvalds@g5 git]$ git-rev-list $(git-rev-parse --since="8 days ago" HEAD) | wc
	     80      80    3280
	[torvalds@g5 git]$ git-rev-list --topo-order $(git-rev-parse --since="8 days ago" HEAD) | wc
	     10      10     410

which is because when we sort things topologically, they won't be in date 
order any more (surprise surprise), so the whole date-cut-off logic 
doesn't actually work.

So I'm sad to say that

	gitk --since="5 days ago"

still doesn't do what you'd actually _want_ it to do with gitk. But at 
least gitk can now parse the arguments right.

		Linus

---
diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -33,8 +33,8 @@ proc getcommits {rargs} {
     set nextupdate [expr $startmsecs + 100]
     set ncmupdate 1
     if [catch {
-	set parse_args [concat --default HEAD $rargs]
-	set parsed_args [split [eval exec git-rev-parse $parse_args] "\n"]
+	set parse_cmd [concat git-rev-parse --default HEAD $rargs]
+	set parsed_args [split [eval exec $parse_cmd] "\n"]
     }] {
 	# if git-rev-parse failed for some reason...
 	if {$rargs == {}} {
