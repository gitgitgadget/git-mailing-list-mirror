From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] git-gui and spell checking
Date: Sun, 3 Feb 2008 21:21:22 -0500
Message-ID: <20080204022122.GJ24004@spearce.org>
References: <alpine.DEB.1.00.0802021142320.21831@an.sumeria>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Flott <adam@npjh.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 03:22:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLqy8-00015h-5g
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 03:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbYBDCV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 21:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755127AbYBDCV1
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 21:21:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40394 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbYBDCV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 21:21:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JLqxQ-0005BH-6i; Sun, 03 Feb 2008 21:21:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3CFE820FBAE; Sun,  3 Feb 2008 21:21:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0802021142320.21831@an.sumeria>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72454>

Adam Flott <adam@npjh.com> wrote:
> The other day I committed something with a comment that had a rather
> embarrassing misspelling. I had some more commits on top of that and I
> was about to dcommit it up to the companies SVN repository before I
> caught it. I reset the commits to fix it and all was well.
> 
> But it had me thinking about avoiding the problem in the future and how
> I handle it in other applications. So far, I think Opera has the best
> GUI spell checking[1]. I then went and poked around the git-gui code to
> see how hard it would be to learn some minimal Tk in order to implement
> such a thing.
> 
> [1]: http://npjh.com/etc/opera-spell-check.png
> 
> If Tk comes really natural and you could crank this sort of thing out
> and have the time to do so, I would really appreciate it. Otherwise I
> might take a stab at it. Reading the aspell documentation (what Opera)
> uses doesn't seem all that bad about operating with stdout/stdin. I
> browsed the web looking for "recipes" for making something very similar
> to the Opera spell checker, but I don't think I found any good resources
> which explain going from little Tcl/Tk to a workable simple GUI.
> 
> Is this some functionality you and/or others would like to see?

I've been thinking about adding some sort of spell checking to git-gui.
One of the things I liked about Mozilla's XUL implementation is that
you can perform spell checking on any input field "for free" by just
asking for it.  Tk hasn't caught up to that level of functionality. :-\

I would personally prefer the more complex solution that a lot of
tools do these days, which is to underline the misspelled words
in red and let the user correct the word by right clicking on it.
Mozilla does this for textareas in HTML (based upon that XUL widget),
Outlook does it on Windows, Microsoft Word does it, and a number
of Mac OS X applications implement it.

The ispell/aspell pipe protocol should make this rather easy:

  - Open a bidirectional pipe to aspell on startup;
  - Set it into terse mode;
  - Use a UTF-8 encoding.

  - On idle if the commit message area is dirty we already save it
    to a backup file (in case of random Tk crashes).
  - Feed the text to aspell and remember the lines we sent.

  - When we get the results back, if the line still matches what is
    in the Tk widget add a 'mispelled' tag to the mispelled words.
    Such lines haven't been edited by the user since we submitted
    it to aspell.

  - Setup a right-click binding on the 'mispelled' tag to show a
    popup menu.  Populate the menu with the suggestions from aspell.
    I'm thinking its easier to re-ask aspell for suggestions then
    it would be to keep track of the suggestions we received when
    we asked for the mispelling detection.

-- 
Shawn.
