From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb.cgi
Date: Wed, 19 Oct 2005 03:23:41 +0200
Message-ID: <20051019012341.GA15256@vrfy.org>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org> <43552FC2.3000000@zytor.com> <Pine.LNX.4.64.0510181645200.3369@g5.osdl.org> <43559575.1060902@zytor.com> <Pine.LNX.4.64.0510181753340.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 03:23:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES2gG-0006Ul-2f
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 03:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVJSBXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 21:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVJSBXq
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 21:23:46 -0400
Received: from soundwarez.org ([217.160.171.123]:19606 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932412AbVJSBXp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 21:23:45 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 103E263595; Wed, 19 Oct 2005 03:23:42 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510181753340.3369@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10257>

On Tue, Oct 18, 2005 at 06:02:29PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 18 Oct 2005, H. Peter Anvin wrote:
> > 
> > It turns out that the default CacheSize is only 256K.  D'oh!  Fixed.
> > 
> > I also changed the CacheDefaultExpire to 600 seconds.
> 
> Ok, that sounds like it should improve things. My quick tests didn't seem 
> to show any difference, though. Do you need to re-load the apache module 
> or something?
> 
> > The only thing the front page really should need is to know when the last
> > change to the tree was, which presumably means looking at each head of each
> > tree and follow the chain until there is a datable object.
> 
> Yeah. I tried to follow gitweb.cgi, but I'm neither http- nor 
> perl-literate, so I'm not sure I caught everything.
> 
> But it does seem to basically end up doing a "git_read_commit()" for each 
> project, and that in turn was doing the "git-rev-list --max-count=1" thing 
> that I just sent out a suggested improvement for.
> 
> It effectively removes two or more copies of
> 
> 	stat64("/objects/xy/zzy", {...})
> 	fd = open("objects/xy/zzy", O_RDONLY|O_NOATIME)
> 	addr = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0)
> 	close(fd)
> 	munmap(addr, size)
> 
> which really should be very cheap operations, but hey, if the disk head is 
> somewhere else (and busy) and it's not cached, it can be quite expensive. 
> Especially since we don't end up usign the result.
> 
> I'm sure there's room for improvement inside gitweb itself too, but maybe 
> the git-rev-list optimization will help.

There definitely is! But I tried a single "stat() all HEAD files" with a
simple script and it took more than 3 seconds for the 80 trees. Then I
gave up "optimizing" and was sure we want to have a single-file cached front
page instead. :)

Kay
