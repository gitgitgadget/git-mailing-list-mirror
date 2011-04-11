From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Mon, 11 Apr 2011 08:20:19 +0200
Message-ID: <201104110820.20342.chriscool@tuxfamily.org>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com> <201104110518.04413.chriscool@tuxfamily.org> <20110411044900.GA20939@kytes>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 08:20:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9AUL-0006nI-8S
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 08:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab1DKGUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 02:20:31 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36859 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab1DKGUa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 02:20:30 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7DED3A63E5;
	Mon, 11 Apr 2011 08:20:22 +0200 (CEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <20110411044900.GA20939@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171307>

Hi Ram,

On Monday 11 April 2011 06:49:05 Ramkumar Ramachandra wrote:
> Hi Christian,
> 
> Christian Couder writes:
> > On Sunday 10 April 2011 17:11:46 Ramkumar Ramachandra wrote:
> > > Hi,
> > > 
> > > I've started working on building a sequencer for Git.
> > 
> > So you are starting the GSoC early! Great!
> > When (or before) it really starts, just make sure you put your work on a
> > public Git repository and you send status updates regularly (weekly if
> > possible).
> 
> Ofcourse.  I've already discussed many of these issues last year [1].
> The work corresponding to this particular series can be found in the
> 'sequencer' branch on my GitHub fork [2].  

Great! Thanks!

> Since the results haven't
> been announced, and the coding period hasn't begun, this work should
> be treated like "normal work" -- I just wrote it this weekend.

Ok.

> > > 3. From the format of the TODO and DONE files, one more thing should
> > > be clear- I'm trying to stick to a slight variation of the 'rebase -i'
> > > format.  This part will go into the sequencer.  Then I'll use a
> > > cherry-pick specific file to keep the command-line options.  Yes, I'm
> > > trying to work on Daniel's idea [3] from the very start.  Is this a
> > > good idea?
> > 
> > I think that the TODO and DONE file format will need at one point to
> > include options and it is simpler if this change is done early. Using a
> > cherry-pick specific file to keep the options is not very generic for a
> > sequencer that could be used for many things.
> > 
> > For example, as we have rebase --interactive, we will probably want to
> > have cherry-pick --interactive, and when editing the TODO file we might
> > want to use different cherry-pick options when picking different
> > commits.
> 
> Point noted -- I shouldn't narrow down the various things I can do
> with a single commit early on and lock us into a more restrictive
> design.  However, I'm not in favor of making it too generic; I
> certainly wouldn't like to edit an instruction sheet that looks like
> this:
> 
> cherry-pick -m 1 -s -r 83a4fe9
> revert -n 3a6fe42
> cherry-pick -x --ff dacfe41
> cherry-pick -s recursive -Xpatience b31d4e2

I wouldn't like either, but I would like it even less if it was like this:

pick 83a4fe9 # -m 1 -s -r 
revert 3a6fe42 # -n 
pick dacfe41 # -x --ff 
pick b31d4e2 # -s recursive -Xpatience 

I mean that of course people should not use too many options for no good 
reason, but if they do need to use some options, it's better if they are shown 
like in a shell, as they will be more familiar with them this way.

There is no point of making options look different to prevent people from 
abusing them.

> It'll become impossible to tell which options are disallowed over what
> else, and it'll become a nightmare to debug when something goes wrong.
> My idea is that we add commit-specific options in an optional
> backward-compatible manner later:
> 
> pick 83a4fe9
> revert 3a6fe42 # -n
> pick dacfe41 # -s
> pick b31d4e2
> 
> That way, there'll be two sets of options:
> 
> 1. One "global" set of command-line switches that applies
> to all the commits, which will be written to a command-specific
> location.  The sequencer itself knows nothing about this.

I don't see the point of this global set. And if the sequencer knows nothing 
about it, the user may not know about it too and so may not understand how 
things work.

> 2. Optional commit-specific stuff that's passed in the
> form of a (modified) commit_list to the sequencer API to write to the
> todo/ done files.
> 
> Do you like this idea?
> 
> > This would also make the different cherry-pick options available when
> > using rebase --interactive once it uses the sequencer.
> > 
> > > [1]:
> > > http://thread.gmane.org/gmane.comp.version-control.git/170758/focus=170
> > > 908 [2]: http://thread.gmane.org/gmane.comp.version-control.git/162183
> > > [3]:
> > > http://thread.gmane.org/gmane.comp.version-control.git/170758/focus=17
> > > 0834
> > 
> > [3] is missing here.
> 
> Your email client is perhaps wrapping too aggressively? It's fine in
> my original email [3].

Yeah, sorry about that!
Christian.
