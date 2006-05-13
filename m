From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tracking branch history
Date: Fri, 12 May 2006 17:03:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605121656350.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
 <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 02:04:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fehca-00021W-LQ
	for gcvg-git@gmane.org; Sat, 13 May 2006 02:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWEMAEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 May 2006 20:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWEMAEK
	(ORCPT <rfc822;git-outgoing>); Fri, 12 May 2006 20:04:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932320AbWEMAD5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 May 2006 20:03:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4D03stH008091
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 May 2006 17:03:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4D03rZu000921;
	Fri, 12 May 2006 17:03:53 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19922>



On Fri, 12 May 2006, Linus Torvalds wrote:
> 
> IOW, a good (?) way to do it is to literally have a commit hook that 
> basically just does
> 
> 	echo $new >> .git/$branch-commit-history
> 
> possibly together with a datestamp thing (ie it could be something like
> "echo $new "$USER" $(date)" rather than just the commit SHA1).

Btw, the real problem with this is how to use it.

The only really valid use I see is to use it for date-based things, ie if 
given a date, look up the most recent commit ID that is older than the 
date in question. No other op seems to really make sense, but that one 
does.

Now, the one other operation that is semantically sensible is to use the 
list of commits to figure out a "path" through the commit space. However, 
that path won't actually even be well-defined (a fast-forward pull/merge 
can and often /will/ update the history in a way where it's impossible to 
select one particular path to the previous commit listed in the commit 
log).

The other thing that makes the "path" thing hard is that it's just 
fundamentally a pretty hard thing to calculate, even when it would result 
in one unambiguous path. I _believe_ that it comes close to what "git 
bisect" does, and that the bisect algorithm could probably be used to 
always create _a_ path between each commit (is just pick successive 
half-way-points - the commit list _should_ always have a direct dominance 
relationship, but the bisection algorithm should do something half-way 
sane even if you "jump about" by "git reset" or something).

It might be interesting to see if it's somethign that can be done 
reasonably efficiently.

			Linus
