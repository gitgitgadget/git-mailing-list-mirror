From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Tue, 17 Nov 2015 16:43:48 -0500
Message-ID: <20151117214347.GB27862@sigill.intra.peff.net>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net>
 <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <20151113233807.GD16173@sigill.intra.peff.net>
 <20151113234116.GA18234@sigill.intra.peff.net>
 <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
 <564A279C.6000802@web.de>
 <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
 <CACsJy8D-TRJ---4BYrEZeEkd9_5-xgGp4U0nB9YHNtV3zgxrbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 22:44:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyo2d-0005TS-43
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 22:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbbKQVnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 16:43:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:58950 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752730AbbKQVnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 16:43:50 -0500
Received: (qmail 10573 invoked by uid 102); 17 Nov 2015 21:43:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 15:43:50 -0600
Received: (qmail 30101 invoked by uid 107); 17 Nov 2015 21:44:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 16:44:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Nov 2015 16:43:48 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8D-TRJ---4BYrEZeEkd9_5-xgGp4U0nB9YHNtV3zgxrbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281421>

On Tue, Nov 17, 2015 at 09:17:43PM +0100, Duy Nguyen wrote:

> On Mon, Nov 16, 2015 at 8:25 PM, Stefan Beller <sbeller@google.com> wrote:
> > Instead of having to search all branches for the requested sha1, we could have
> > some sort of data structure to make it not an O(n) operation (n being
> > all objects
> > in the repo).
> >
> > Maybe I overestimate the work which needs to be done, because the server has
> > bitmaps nowadays.
> 
> Quote from [1]
> 
> > If we take the kernel history in rev-list and pick two commits that
> > are roughly ~10,000 commits apart from one another, JGit can compute
> > the rev-list --objects between these two commits in about 120
> > milliseconds (git-core should be faster, or at least comparable).
> 
> I think we should be fine (note that --objects is a lot heavier than
> commit walking). Though.. I just tried it on git.git. 10k commits
> (without --objects) take about 200ms with C Git..

A lot of this depends on the endpoints. We can't store bitmaps for every
commit, so we often have to fall back to traversing from the commit,
collecting reachable objects until we hit a commit that does have
bitmaps.

I think the for the purposes of upload-pack and reachability, it might
be fine to just walk commits, which as you note is much cheaper. The C
git bitmap code does not currently have a way to say "I only care about
commits, do not bother filling in the trees and blobs when you have to
do a fallback traversal". But it would not be hard to add, I think.

-Peff
