From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git bisect goes wild?
Date: Tue, 24 Feb 2009 16:15:07 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902241553310.19665@iabervon.org>
References: <20090224184414.GE22108@duck.suse.cz> <eaa105840902241059y70143c43s7d12b10fe35127e6@mail.gmail.com> <20090224191002.GF22108@duck.suse.cz> <alpine.LNX.1.00.0902241427420.19665@iabervon.org> <20090224200416.GH22108@duck.suse.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-197066972-1235510107=:19665"
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Jan Kara <jack@suse.cz>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc4dq-0003XU-QM
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 22:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbZBXVPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756813AbZBXVPK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:15:10 -0500
Received: from iabervon.org ([66.92.72.58]:59417 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756399AbZBXVPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:15:09 -0500
Received: (qmail 27631 invoked by uid 1000); 24 Feb 2009 21:15:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Feb 2009 21:15:07 -0000
In-Reply-To: <20090224200416.GH22108@duck.suse.cz>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111341>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-197066972-1235510107=:19665
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 24 Feb 2009, Jan Kara wrote:

> On Tue 24-02-09 14:46:09, Daniel Barkalow wrote:
> > On Tue, 24 Feb 2009, Jan Kara wrote:
> > 
> > > On Tue 24-02-09 13:59:16, Peter Harris wrote:
> > > > 2009/2/24 Jan Kara:
> > > > >  Hi,
> > > > >
> > > > >  I've been bisecting some change in Linux kernel. The output of
> > > > > "git bisect log" is:
> > > > ...
> > > > > git-bisect bad 419217cb1d0266f62cbea6cdc6b1d1324350bc34
> > > > ...
> > > > > git-bisect good 3e9830dcabdeb3656855ec1b678b6bcf3b50261c
> > > > >
> > > > >  But after the last command, I was sent to commit
> > > > > 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b which is far outside the window
> > > > > between the last good and bad commit.
> > > > 
> > > > How did you determine that this commit is outside the window?
> > > > 
> > > > When I run "gitk 3e9830..419217" it shows that commit, as does "git
> > > > log". 9ec76fb appears to be inside the window to me.
> > >   Ho, hum, right. But if I do:
> > > git describe 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b
> > >   I get v2.6.23-rc3-215-g9ec76fb which is a bit strange for bisecting
> > > between 2.6.23 and 2.6.24. Also the kernel gets named 2.6.23-rc3 and kernel
> > > config options get also to some pre 2.6.23 state. That's what is confusing
> > > me. It seems like the kernel checked out is some old one. I'm not a git
> > > expert so it might be fine but it just seems really strange.
> > 
> > If you're trying to find a problem that got into the mainline kernel 
> > between 2.6.23 and 2.6.24, you should expect to find a change that was 
> > added less than 2 weeks after 2.6.23 was released, and written before 
> > 2.6.23 was released. Such a change would probably have been written 
> > against a mainline kernel somewhere in the 2.6.23-rcN range. So the 
> > description you should expect of the version that introduces the bug is 
> > "2.6.23-rcN with some patches that hadn't been merged to mainline".
> > 
> > In order for your bisect to end up with a commit that looks like it's 
> > between 2.6.23 and 2.6.24, Linus would have to have merged a buggy commit 
> > for 2.6.24 written after 2.6.23 was released, which is against how things 
> > are supposed to be done.
>   Yes, thanks for explanation. I've figured it out as well after reading
> the posted link. What makes me a bit afraid is that bugs (or especially
> performance regression, which is what I'm hunting right now) can be caused
> by interference of two independent changes. I.e., in a situation like:
>   A-B-C-D
>    \_E_/
> 
>   if I start bisecting between B and D and the problem happens only when
> both C and E are merged, then the best what I can end up with is that the
> merge-commit is what causes the regression, isn't it? Which is sometimes
> useless when the merge commit is a merge of some branch with 1000
> patches...

You'll end up with it blaming D, yes.

>   So it might be useful if git-bisect had a "linear" mode - we would first
> create a linear history of commits and then bisect in it. Now I understand
> that this is not always possible (sometimes changes would not apply) but it
> should be possible when merges are trivial (i.e., all commits apply cleanly
> to the source just before the merge commit - and this is quite often the
> case at least with the Linux kernel). Just my 2 cents.

Linearizing wouldn't really give entirely accurate results for bisecting a 
combination; you would get one of the sides where the problem starts, but 
you wouldn't know what it conflicts with. The ideal thing would actually 
be to first find that some particular merge is bad, and then bisect each 
side individually, looking for the first commit on each side that, when 
they're merged together, produces a result with the problem. In any case, 
doing much more complicated than the current bisect requires being able to 
automate a complicated sequence of operations (going back to the user at 
certain points, because it may be necessary to do a manual merge to test), 
which hasn't been made practical yet.

	-Daniel
*This .sig left intentionally blank*
--1547844168-197066972-1235510107=:19665--
