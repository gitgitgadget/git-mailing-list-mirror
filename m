From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-clone not fetching all tags?
Date: Sat, 29 Apr 2006 21:11:07 -0700
Message-ID: <7vaca31z50.fsf@assigned-by-dhcp.cox.net>
References: <200604292342.16306.johannes.sixt@telecom.at>
	<20060429221114.557FC35288F@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Sun Apr 30 06:11:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fa3HI-0003JR-Fw
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 06:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWD3ELL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 00:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWD3ELL
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 00:11:11 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:65446 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750896AbWD3ELK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 00:11:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060430041109.ELRG9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Apr 2006 00:11:09 -0400
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060429221114.557FC35288F@atlas.denx.de> (Wolfgang Denk's
	message of "Sun, 30 Apr 2006 00:11:14 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19325>

Wolfgang Denk <wd@denx.de> writes:

> In message <200604292342.16306.johannes.sixt@telecom.at> you wrote:
>>
>> There are two types of tags: They can point to
>> 1. a commit object
>> 2. a proper tag object (which in turn references the commit)
>> 
>> git-update-server-info seems to generate info only for case 2, and so are the 
>> only ones that http can fetch.
>
> And git-cvsimport (at least older versions of it)  imports  CVS  tags
> only as type 1 ?
>
> That would perfectly explain the situation. How can this be fixed?

I suspect there is no need to manufacture the tag.  Something
like this should do.

*WARNING* Since I do not do Porcelain, and I am not a Cogito
user, this is obviously untested.  In addition, I am seriously
drunk right now... 

-- >8 --
[PATCH] (cogito) Auto-follow lightweight tags as well.

---
diff --git a/cg-fetch b/cg-fetch
index 687e6b9..39764c7 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -218,7 +218,8 @@ fetch_tags()
 	git-ls-remote --tags "$uri" |
 		# SHA1 refs/tags/v0.99.8^{} --> SHA1 tags/v0.99.8
 		# where SHA1 is the object v0.99.8 tag points at.
-		sed -ne 's:\([^	]\)	refs/\(tags/.*\)^{}$:\1 \2:p' |
+		sed -n -e 's:\([^	]\)	refs/\(tags/.*\)^{}$:\1 \2:p' \
+		    -e 's:\([^	]\)	refs/\(tags/.*\)$:\1 \2:p|' \
 		while read sha1 tagname; do
 			# Do we have the tag itself?
 			[ -s "$_git/refs/$tagname" ] && continue
