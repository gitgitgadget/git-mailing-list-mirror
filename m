From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Mon, 5 Jun 2006 14:06:59 +1200
Message-ID: <46a038f90606041906k66d85152v6e402c65151d7ab8@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>
	 <46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>
	 <447D043D.1020609@gentoo.org>
	 <46a038f90605302305g7a969a62r277af1724b912069@mail.gmail.com>
	 <447DA028.3040606@gentoo.org>
	 <46a038f90605311503o1526c664qe61b0f3f40929b92@mail.gmail.com>
	 <447E4611.7000309@gentoo.org>
	 <46a038f90606010047r676840d2nd91ad2361abbe1c8@mail.gmail.com>
	 <44837BDB.2090601@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Donnie Berkholz" <spyderous@gentoo.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 05 04:07:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn4Uq-0000Zt-GJ
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 04:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWFECHB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 22:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWFECHB
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 22:07:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:48144 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932379AbWFECHA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 22:07:00 -0400
Received: by wr-out-0506.google.com with SMTP id i22so877894wra
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 19:06:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YZgyZgRC47oF76go9Kcczn76xFwrd1agQNCb1L3aolkv3hn28l7y4P2BIIxGDH2Xz4VX9LeuNuBzxrerkFjP9J8oN8KHuyxVLVp/zOZeX7cD7DO8cJ2DbscFc1U3Ur2f6IGUZq17D1Y9ylDCAT2nFR1wkFMDwcIgzhzK9fldK08=
Received: by 10.54.94.10 with SMTP id r10mr4457783wrb;
        Sun, 04 Jun 2006 19:06:59 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Sun, 4 Jun 2006 19:06:59 -0700 (PDT)
To: antarus@gentoo.org
In-Reply-To: <44837BDB.2090601@gentoo.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21304>

On 6/5/06, Alec Warner <antarus@gentoo.org> wrote:
> Ok the box this was running on had issues, so I switched to using
> pearl.amd64.dev.gentoo.org, a dual core amd64 X2 4600+ with 4 gigs of
> ram and plenty of disk.  The "problem" now is just converstion time...30
> hours and I'm into 2004-09-17...but it's been in 2004 all day, seems
> like most of the commits are in the last three years.  Are there
> architectural issues with doing this in parallel?

I don't think you can do this in parallel. What I would do is remove
the -a from the git-repack invocation. It does hurt import times quite
a bit -- just do a git-repack -a -d when it's done.

And... having said that, there is still a memory leak somehow,
somewhere. It's been evading me for 2 weeks now, so I feel an idiot
now. Not too bad in general, but it shows clearly in the gentoo and
mozilla imports.

> Since the repository commits are all in cvs, it should be possible to do
> the work in parallel, since you know what all the commits touch.  The
> concern would be ordering of nodes in the tree; you'd end up building a
> bunch of subtrees and patching them together?

Well... parsecvs does a bit of this but in sequential fashion... it
imports all the files first, and then runs through the history
building the tree+commits in order, committing them. It saves a lot of
time in the file imports by parsing the RCS file directly. The
downside is that it must keep a filename+version=>sha1 mapping --
which I think is why parsecvs won't fit in memory until it's changed
to store it on disk somehow ;-)

You are forced to do it in a sequence because cvsps only tells you
about the files added/removed/changed in a commit -- you need the
ancestor to have a view of what the whole tree looked like. The only
room for parallelism I see is to fork off new processes to work on
branches in parallel.



martin
