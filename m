From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb.cgi
Date: Tue, 18 Oct 2005 18:02:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181753340.3369@g5.osdl.org>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org>
 <43552FC2.3000000@zytor.com> <Pine.LNX.4.64.0510181645200.3369@g5.osdl.org>
 <43559575.1060902@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 03:04:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES2Lj-00024r-2S
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 03:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVJSBCb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 21:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVJSBCb
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 21:02:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751307AbVJSBCb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 21:02:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9J12UFC020565
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 18:02:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9J12Tke009201;
	Tue, 18 Oct 2005 18:02:29 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43559575.1060902@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10251>



On Tue, 18 Oct 2005, H. Peter Anvin wrote:
> 
> It turns out that the default CacheSize is only 256K.  D'oh!  Fixed.
> 
> I also changed the CacheDefaultExpire to 600 seconds.

Ok, that sounds like it should improve things. My quick tests didn't seem 
to show any difference, though. Do you need to re-load the apache module 
or something?

> The only thing the front page really should need is to know when the last
> change to the tree was, which presumably means looking at each head of each
> tree and follow the chain until there is a datable object.

Yeah. I tried to follow gitweb.cgi, but I'm neither http- nor 
perl-literate, so I'm not sure I caught everything.

But it does seem to basically end up doing a "git_read_commit()" for each 
project, and that in turn was doing the "git-rev-list --max-count=1" thing 
that I just sent out a suggested improvement for.

It effectively removes two or more copies of

	stat64("/objects/xy/zzy", {...})
	fd = open("objects/xy/zzy", O_RDONLY|O_NOATIME)
	addr = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0)
	close(fd)
	munmap(addr, size)

which really should be very cheap operations, but hey, if the disk head is 
somewhere else (and busy) and it's not cached, it can be quite expensive. 
Especially since we don't end up usign the result.

I'm sure there's room for improvement inside gitweb itself too, but maybe 
the git-rev-list optimization will help.

		Linus
