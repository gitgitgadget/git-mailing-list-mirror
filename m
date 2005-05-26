From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Summary of core GIT while you are away.
Date: Wed, 25 May 2005 18:45:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org> <20050526004411.GA12360@vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 03:42:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db7O4-0001vL-OY
	for gcvg-git@gmane.org; Thu, 26 May 2005 03:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVEZBoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 21:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVEZBoA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 21:44:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:65472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261663AbVEZBnb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 21:43:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4Q1hAjA013362
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 May 2005 18:43:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4Q1h8gt028431;
	Wed, 25 May 2005 18:43:09 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050526004411.GA12360@vrfy.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, Kay Sievers wrote:
>
> On Mon, May 16, 2005 at 09:10:10AM -0700, Linus Torvalds wrote:
> > 
> > Then you could just do
> > 
> > 	git-rev-list -v --header HEAD | grep -z 'author[^\n]*Linus'
> > 
> > to tell it to do the "verbose" thing (only showing the header of the 
> > commit, not the whole message), and grep for "Linus" in the author line.
> 
> What happened to that idea? That's not already working in some other way I
> missed, right? The pickaxe stuff is nice and was easy to call from the cgi,
> but searching in commit messages would be nice too.
> If it's not going to happen in the git-binaries, I may do it just in the
> cgi itself.

Ok, you twisted my arm. Checked in.

	git-rev-list --header HEAD | grep -z 'author[\n]*Linus'

and you will get output that is a series of commits by me (strictly 
speaking, that's not true, since the "author" thing might be in the 
non-header part).

The format is:

	<commit-id> '\n' <commit-msg> '\0'

and if the full commit message is binary and contains NUL bytes in itself
(only crazy people do that, but let's keep in mind that crazy people
exist), we naturally truncate it at the first NUL. This makes it easy to 
parse, and is what makes "grep -z" work, for example.

It also has a rudimentary "stop at commit x" function, but I'm not doing
any reachability analysis, so it's purely based on the commit date, and is
thus _not_ equivalent to "git-rev-tree START ^END". I reserve the right to
try to change that behaviour, though, if I decide I (or sombody else ;)  
can do a nice incremental reacability thing.

So you can do

	git-rev-list --header HEAD v2.6.12-rc5

and it will print out all the commits in date order until it hits 
v2.6.12-rc5 (which it won't print out).

The output format is really optimized for something like "git log" or
"gitweb". I suspect it's pretty much perfect for doing the "last 10" 
things, without having to do "git-cat-file" for each commit.

Oh, and I considered adding a "--header-lines=c" which limits the header
printout to 'c' lines (probably starting at where the free-form thing 
starts, so that "--header-lines=0" would print out just the fixed-format 
header of the commit messages.

(This is slightly different from what I initially envisioned, which had
"-v" and "--header", and I'm not sure it's better but it ended up being
what I did.  If you think my first idea was better, send me a (by now
trivial) patch).

		Linus
