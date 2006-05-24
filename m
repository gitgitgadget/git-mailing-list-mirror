From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slow fetches of tags
Date: Wed, 24 May 2006 10:21:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org>
References: <20060524131022.GA11449@linux-mips.org> <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 24 19:22:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fix3V-0006Pj-Hf
	for gcvg-git@gmane.org; Wed, 24 May 2006 19:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWEXRVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWEXRVy
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 13:21:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932428AbWEXRVx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 13:21:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4OHLhtH012856
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 May 2006 10:21:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4OHLfim023901;
	Wed, 24 May 2006 10:21:42 -0700
To: Ralf Baechle <ralf@linux-mips.org>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20694>



On Wed, 24 May 2006, Linus Torvalds wrote:
> 
> Can you add a printout to show what the "taglist" is for you in 
> git-fetch.sh (just before the thing that does that
> 
> 	fetch_main "$taglist"
> 
> thing?). It _should_ have pruned out all the tags you already have.

Actually, looking at that tag-fetching logic, we already know that we have 
the objects that the tags point to (because those are the only kinds that 
we should auto-follow). I wonder if the slowness is because of all the 
have/want commit following, which walks the whole tree to say "I have 
this", when in this case we really should directly say "I have these" for 
the objects that the tags point to.

So the problem may be that we basically send a totally unnecessary list of 
all the objects we have, when the other end really only cares about the 
fact that we have the objects that the tags point to. Which we know we do, 
but we didn't say so, because "git-fetch" didn't really mark them that 
way.

And instead of sending the commits that we know we have, and that we know 
are the interesting ones and that will cut off the tag-object-walk, we 
start from all the local tips, and use the regular "parse commits in date 
order" thing and send "have" lines for everything we see that isn't 
common. Walking a lot of unnecessary crud.

Junio? Any ideas? I didn't want to do that tag-auto-following, and while I 
admit it's damn convenient, it's really quite broken, methinks. 

I almost suspect that we need to have a syntax where-by the local 
fetch-list ends up doing

	"$tagname:$tagname:$sha1wehave"

as the argument to fetch-pack, and then fetch-pack would be modified to 
send those "$sha1wehave" objects early as "have" objects. Ie start from 
something like

	diff --git a/git-fetch.sh b/git-fetch.sh
	index 280f62e..dce3812 100755
	--- a/git-fetch.sh
	+++ b/git-fetch.sh
	@@ -400,7 +400,7 @@ case "$no_tags$tags" in
	 			}
	 			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
	 			echo >&2 "Auto-following $name"
	-			echo ".${name}:${name}"
	+			echo ".${name}:${name}:${sha1}"
	 		done)
	 	esac
	 	case "$taglist" in

and then pass the info all the way up (the above patch will obviously 
result in a totally broken script, everything downstream from that point 
would have to be taught about the "already have this" part too).

Ralf, which repo is this, so that others (me, if I get the time and 
energy, Junio or some other hapless sucker^W^Whero if I'm lucky) can try 
things out?

		Linus
