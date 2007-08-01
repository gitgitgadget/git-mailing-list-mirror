From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui: diff/console part does not show UTF-8 Japanese
Date: Wed, 1 Aug 2007 09:38:42 -0400
Message-ID: <20070801133842.GG20052@spearce.org>
References: <20070624192215.6117@nanako3.bluebottle.com> <7vvebz602q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@bluebottle.com>,
	GIT mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 15:39:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGEPk-00064M-JN
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 15:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761817AbXHANi4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 09:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756797AbXHANi4
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 09:38:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40984 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761622AbXHANiz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 09:38:55 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IGEPP-0001BB-F9; Wed, 01 Aug 2007 09:38:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AACB420FBAE; Wed,  1 Aug 2007 09:38:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vvebz602q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54437>

Junio C Hamano <gitster@pobox.com> wrote:
> Nanako Shiraishi <nanako3@bluebottle.com> writes:
> 
> > 	I was testing git-gui (i18n branch).  I can see the translated 
> > message in the UI buttons and menus, and also commit message part shows 
> > Japanese strings, but I cannot get the diff part at the bottom to show 
> > Japanese.  Because I did set the two fonts to the same font from the 
> > Edit/Option menu, I do not think it is the problem with the font 
> > settings.
> >
> > Can anybody help?
> 
> I can see the same breakage in regular git-gui without i18n.
> Curious.  The commit message shows Japanese but diff part is
> bogus.
> 
> And the breakage is not just Japanese.  I can see this with
> Kristian's name by resetting a branch to 12ace0b2 and then
> attempting to amend it.  Interestingly enough, gitk shows the
> patch as expected.  I do not quite know how it is arranged
> there, though.
> 
> Now, I freely admit I do not quite know what I am doing, but
> this patch that tries to mimick the handling of commit log
> message seems to help it for git-gui.
> 
> I do think using i18n.commitencoding for payload is wrong,
> though.

Yea, it is wrong.  The patch is logically fine as-is, there's nothing
wrong with it except this part.  I think the reason that gitk shows
the patch as expected is because it is using i18n.commitencoding
for the payload, and that's only happening as a side-effect of how
it used it for the commit message itself.  Call it dumb luck the
thing even displays right.

To really Do The Right Thing(tm) here I think we need to store an
encoding for each file path so we know what we are looking at when
we see the file content.  E.g. a gitattributes enc attribute?

For some files we might be able to guess.  But I have to admit,
I'm not up on my encoding guessing algorithms.  ;-)

For XML files we can probably guess its XML ("starts with <?xml")
and we can guess the encoding from that header line.  But not
everything that contains Japanese characters is an XML file.
Like .po files for instance.


Where it gets even more interesting is how do I show a patch
where the encoding changed?  E.g. reencode a file from ISO-8859-1
into UTF-8?  A number of lines would probably be identical, except
for their encoding.  So the user would want to see that they are
the same.  So we really should be able to show the old line using
its old encoding, and the new line using its new encoding.  Hmmph.

As a stop-gap I guess I could include a "Change Encoding" option
for the diff pane and let you set the encoding to a specific name.
But I really think git-gui should be able to do better than that.

-- 
Shawn.
