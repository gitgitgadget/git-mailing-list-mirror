From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: getting a list of changes I commited
Date: Thu, 15 Sep 2005 12:54:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509151241140.26803@g5.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F04662735@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 21:57:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFzpA-0004Es-Im
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 21:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbVIOTzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 15:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbVIOTzI
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 15:55:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965281AbVIOTzG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 15:55:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FJsxBo014188
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 12:55:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FJstbL021090;
	Thu, 15 Sep 2005 12:54:57 -0700
To: "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F04662735@scsmsx401.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8635>



On Thu, 15 Sep 2005, Luck, Tony wrote:
> 
> I can add the "^linus", but I think that with my workflow it
> will never make a difference.  Any commits that got into your
> tree with a committer line by me will already be in my "oldhead"
> (how else did you get them?).  So "^oldhead ^linus" should always
> be identical to "^oldhead".

No. "oldhead" has to be the point where you did the last email thing.

So any time you merge from me, next time your email cron-job (or whatever)  
hits, ^linus _will_ make a difference. Without it, you'd email out all the 
stuff that came through my tree.

> Great ... I suspected that everything I needed was already there
> (after all, all GIT problems are solvable with the right arguments to
> git-rev-list!)

Good man.

> But "git-shortlog" doesn't like the output from this, so I need
> a script (or another tip on arguments to git commands).

Ehh. This is getting ugly, but hey, that's my middle name.

	git-rev-list --header newhead ^oldhead |
		grep -z "committer .*tony\.luck" |
		tr '\0' '\n' |
		git-shortlog


and btw, this depends on "git-shortlog" also understanding non-pretty log 
messages, with a patch like below.

Junio?

		Linus "ugly" Torvalds

---
Subject: Teach git-shortlog about raw log format too

This teaches "git-shortlog" to understand the non-prettified author format 
too, so you can use it with "--pretty=raw" or "--header" output too.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-shortlog.perl b/git-shortlog.perl
--- a/git-shortlog.perl
+++ b/git-shortlog.perl
@@ -108,7 +108,7 @@ sub changelog_input {
 		if ($pstate == 1) {
 			my ($email);
 
-			next unless /^Author: (.*)<(.*)>.*$/;
+			next unless /^Author: (.*)<(.*)>.*$/ || /^author (.*)<(.*)>.*$/;
 	
 			$n_records++;
 	
