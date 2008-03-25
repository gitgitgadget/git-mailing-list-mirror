From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Tue, 25 Mar 2008 01:36:49 -0400
Message-ID: <20080325053649.GE4759@spearce.org>
References: <20080324092726.GQ8410@spearce.org> <47E8889E.6090403@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Mar 25 06:37:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je1r1-0002dp-TG
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 06:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbYCYFhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 01:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbYCYFhB
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 01:37:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46099 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842AbYCYFgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 01:36:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Je1q6-00071i-Uo; Tue, 25 Mar 2008 01:36:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E2ABB20FBAE; Tue, 25 Mar 2008 01:36:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47E8889E.6090403@intelinet.com.br>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78148>

"Roger C. Soares" <rogersoares@intelinet.com.br> wrote:
> Shawn O. Pearce escreveu:
> >The history page has been completely replaced.
> 
> I have a git.git clone on my eclipse and now egit can open it, cool! :) 

Yea, that was my impression too.  "Yay, it can open git.git!"  :)

> But it wasn't that fast, it took some minutes to finish building the 
> whole tree. Also, changing projects (different git repos) makes the cpu 
> go very high, and what opened fast the first time takes minutes after...

Hmm.  How long does C Git take for "git rev-list HEAD >/dev/null" ?
I have thus far only tuned the lower level machinary, and there
may still be tuning left there, but I _really_ have not tried to
tune the plotting portion yet.

I did push something out a few minutes ago (b66eae Limit the number
of UI refreshes ...) that may help improve performance on larger
histories.

Another thing is how many pack files/loose objects do you have?
The loose objects are harder to access, and jgit is currently
lacking some of the pack search tricks that C Git uses to get
good performance.  As such all of my testing has been working on
a fully packed repository that has exactly one packfile in it,
with no alternates.

Its _almost_ acceptable to me.  We can still do better, but there's
a point at which we just can't get past.  We probably can't beat
rev-list, but I think we should be able to beat gitk almost always.
In the simple fully packed case "jgit glog" beats gitk at opening
the full graph and displaying it.

> When reading the email I thought the new history page would have the 
> same features from the current, but it doesn't. It looks promissing thought.

Nope.  Sorry.  Its basically a rewrite.
 
> My first impression is that I like the current way of showing files in 
> the strutucture compare better.

I actually prefer the individual files in the right pane, like gitk
does, as I like to browse up and down sometimes looking at changes.
Maybe we can make it an option to show that right side panel,
and give a button (or IOpenListener on the graph table?) to let
you open the whole commit in the structure compare view.

> In the future I would like the option to 
> make it open on the left pane (where package explorer is) and have the 
> options to collapse/expand directories, present in flat/hierarchical 
> modes, have the fast view, etc.

Oooh.  Sounds fun.
 
> Comments now can't be automatically wrapped.

Oversight/planned loss of feature.  I'm a strong believer of showing
the commit message *exactly* as recorded, which means don't do
line wrapping of it.  Things like character encoding translation
and indenting the left side 2-4 spaces to keep it unambiguous from
headers is fine when showing it to a human, but otherwise it should
match what the user wrote.

I forgot to offer a wrap option.  If we do enable line wrapping I
think we should give the user a way to toggle it on/off for the
message area viewer so that if line wrapping is enabled and its
borking the current message (e.g. a nice pretty ASCII diagram)
you can disable it.

> I actually prefer to leave 
> wrapping to the computer, I don't like having to manually fix line 
> lenghts when amending a comment, I think eclipse should do it. Also, 
> currently, the history page usually has little space allocated for it 
> and currently the first lines of the comment are visible. In the new 
> page I have to scroll to see the comment when the history page is not 
> maximized.

Yea, I started to notice that myself today.  The area isn't quite
wide enough, and I was using Eclipse on a very high resolution CRT
and it was taking up a good 80% of the display.  Most users can't
sanely devote the area I did to the History view, and it was still
not wide enough for some git.git messages.

Thanks for the feedback.  Obviously its still got a lot of areas
for improvements.

-- 
Shawn.
