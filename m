From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-status too verbose?
Date: Mon, 6 Mar 2006 12:56:14 -0500
Message-ID: <20060306175614.GG27965@spearce.org>
References: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com> <87irqrzcs7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Jaffe <jaffe.eric@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 18:56:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGJwX-000734-8n
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 18:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbWCFR4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 12:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbWCFR4W
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 12:56:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:9915 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751976AbWCFR4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 12:56:21 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FGJwI-0003yb-90; Mon, 06 Mar 2006 12:56:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BD24820FBAC; Mon,  6 Mar 2006 12:56:14 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87irqrzcs7.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17302>

Carl Worth <cworth@cworth.org> wrote:
> On Sat, 4 Mar 2006 12:52:17 -0500, "Eric Jaffe" wrote:
> > I was wondering if anyone else thinks that git-status should be more
> > like "git-diff --name-status". That is,
> >   # A a/newfile.c
> >   # M a/oldfile.c
> 
> Something like that does seem appealing.
> 
> There are at least two issues with doing it:
> 
> 1) It might be tricky coming up with canonical single characters to be
>    used consistently within git. For example, git-ls-files currently
>    does do some single-character state indication, but it can be
>    rather confusing at times. For example:
> 
> 	State		Option	Character
> 	-----		------	---------
> 	Modified	-m	C
> 	Unmerged	-u	M
> 	Cached		-c	H
> 
>    And that looks like a permanent problem. For legacy reasons,
>    I don't think we can change either the options or the output
>    characters of git-ls-files. But perhaps we could at least
>    agree on a single, consistent mapping for all future uses.
> 
> 2) In an important sense, git-status is not verbose enough. For
>    example, given a single line such as the following:
> 
> 	modified: some-file
> 
>    This could indicate at least two different states for some-file:
> 
> 	1) Modified and updated into the index
> 
> 	2) Modified in working tree, but not updated in the index

I've played around with this idea a little bit in pg's pg-status
command but I most likely do not have all cases covered.

In general I try to show HEAD<-->index first using uppercase letters
then index<-->working directory second in lowercase letters.

Here's the critical portion of pg-status:

	git-diff-index --cached --name-status HEAD | sed -e 's/ / /'
	if test $index_only  = n
	then
	  git-diff-files --name-status | sed \
		-e 's/      / /' \
		-e 's/^D /g /' \
		-e 's/^M /m /' \
		-e '/^U /d'
	  pg--ls-others | sed 's/^/x /'
	fi

Thus far I've found it useful to behave this way and I haven't run
up against any states which didn't make immediate sense to me.
Here's the documentation I have in pg-status describing what it
can show:

Status indicators (displayed in column 1):

 A : New file has been marked for addition with pg-add.
 D : Existing file has been marked as deleted with pg-rm.
 M : Existing file has been modified (and is known to the index).
 U : File still has unmerged hunks, see pg-resolved.

 m : Existing file (maybe) has been modified (use -q to know for sure).
 g : File has been removed from directory but not marked with pg-rm.
 x : File is not known to repository and isn't being ignored.

-- 
Shawn.
