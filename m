From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 07:16:13 +0100
Message-ID: <e1dab3980709032316l14b4f01gc7c71a750ed35a4@mail.gmail.com>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	 <20070904025153.GS18160@spearce.org>
	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	 <e1dab3980709032119r381f7a91ia84ba09039c21be1@mail.gmail.com>
	 <9e4733910709032252x1fe6f436wdd13bcb1a6f76636@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 08:16:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRi1-0005oO-Uv
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 08:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbXIDGQP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 02:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbXIDGQP
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 02:16:15 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:52459 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXIDGQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 02:16:14 -0400
Received: by py-out-1112.google.com with SMTP id u77so5292858pyb
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 23:16:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aEyl+0vs/tGMMyqbXkTLOrfKonmN3SqXn4C7IsHXtjOh7129US6QV+6uLNM3WB6fn/jgZOPfEadgUHgba6Du6jmna/4WYtfibtTAowkA+7rTmyaGSTJeNpC+aN2dwzZ8LjiPn6J4gLk9ORmdCWkIcsNM5oaOhRISnaBq4dK+Ahk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M0OIiuDHiVdEyHum5RvuQv/7YFGn2HjP8qhDBEG57mG4jTohiTTNjW+aiNVdcv1QYoquVUHS9OV7iKb+C2uWNsef3PTCQ0+HAsuprfOP3myyQ235mQ8aw78uSpG+ZIAHNvM95ZxjCMja7d9EMEpUG9+/soOZtAC/Rwmi8EjCEwE=
Received: by 10.65.116.10 with SMTP id t10mr9698793qbm.1188886573286;
        Mon, 03 Sep 2007 23:16:13 -0700 (PDT)
Received: by 10.65.81.12 with HTTP; Mon, 3 Sep 2007 23:16:13 -0700 (PDT)
In-Reply-To: <9e4733910709032252x1fe6f436wdd13bcb1a6f76636@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57532>

On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 9/4/07, David Tweed <david.tweed@gmail.com> wrote:
> > On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > Git has picked up the hierarchical storage scheme since it was built
> > > on a hierarchical file system.
> >
> > FWIW my memory is that initial git used path-to-blob lists (as you're
> > describing but without delta-ing) and tree nodes were added after a
> > couple of weeks, the motivation _at the time_ being they were a
> > natural way to dramatically reduce the size of repos.
> >
> > One of the nice things about tree nodes is that for doing a diff
> > between versions you can, to overwhelming probability, decide
> > equality/inequality of two arbitrarily deep and complicated subtrees
> > by comparing 40 characters, regardless of how remote and convoluted
> > their common ancestry. With delta chains don't you end up having to
> > trace back to a common "entry" in the history? (Of course, I don't
> > know how packs affect this - presumably there's some delta chasing to
> > get to the bare objects as well.)
>
> While it is a 40 character compare, how many disk accesses were needed
> to get those two SHAs into memory?

That's a difficult question. Clearly if you're starting on a machine
without anything cached, you're probably a bit worse off. If not and
you've got a "wide, shallow tree where changes occur clustered within
directories rather than spread uniformly throughout the tree" then
it's likely already there.

But it's all I suspect it should be looked at in relative terms: with
the respect to the delta-d list of SHA's, do you need to do more or
less disk reads to be able to compare stuff? Dunno: I'd imagine this
depends on precisely what's delta'd against what and how many of those
you need to read in order to put two entries into a comparable form.
The key point I was making was not so much the 40 characters as that
(at least with loose objects) if you can are given the top-level
SHA's, you can efficiently decide equality (a key to efficient
diffing) _without having to care how those two are related in the
history or read any extra history_.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
