From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Thu, 19 Nov 2015 08:58:08 -0500
Message-ID: <20151119135808.GA9353@sigill.intra.peff.net>
References: <20151113234116.GA18234@sigill.intra.peff.net>
 <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
 <564A279C.6000802@web.de>
 <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
 <CACsJy8D-TRJ---4BYrEZeEkd9_5-xgGp4U0nB9YHNtV3zgxrbg@mail.gmail.com>
 <20151117214347.GB27862@sigill.intra.peff.net>
 <CACsJy8Ah2PgO8CunCvWiKB7RfqMfovWa1a7ro5scHFK+AEAXpg@mail.gmail.com>
 <20151118211158.GA32071@sigill.intra.peff.net>
 <CAGZ79kbD54fubzozMD51fTpP1v-6bbBoBtKn=fibLuwMmiioKA@mail.gmail.com>
 <CAOE36qj2m4e3hw73-QoLbbpGv4RiyhBt_ou7eN4i4q8pF15rdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Terry Parker <tparker@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 14:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzPja-0002kM-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 14:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934177AbbKSN6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 08:58:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:59701 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933902AbbKSN6N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 08:58:13 -0500
Received: (qmail 16391 invoked by uid 102); 19 Nov 2015 13:58:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Nov 2015 07:58:13 -0600
Received: (qmail 16814 invoked by uid 107); 19 Nov 2015 13:58:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Nov 2015 08:58:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Nov 2015 08:58:08 -0500
Content-Disposition: inline
In-Reply-To: <CAOE36qj2m4e3hw73-QoLbbpGv4RiyhBt_ou7eN4i4q8pF15rdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281476>

On Wed, Nov 18, 2015 at 03:40:02PM -0800, Terry Parker wrote:

> > +Terry, who did optimize the JGit implementation for bitmaps,
> > as we also had a "lots of refs" hoarder repo, which underperformed
> > before.
> 
> The performance issue with the "hoarder" repo was that the bitmap
> commit selection algorithm in JGit was selecting too many commits and
> the hoarder repo caused OOMs.
> 
> JGit's selection algorithm walks each branch and makes sure commits
> are selected every 100-200 commits for "recent" history and every
> 5000-5100 commits for more distant history. IIUC cgit sorts all commits
> by date and does a similar selection. Since it doesn't attempt to get
> even coverage on each branch, the selected commits may have
> large gaps for a particular branch.

Thanks for the data point. I agree that cgit seems to have the opposite
problem: selecting fewer commits, which gives worse performance at read
time, but no OOM at write time. :)

I suspect there's some low-hanging fruit in tweaking cgit's
implementation, where we might be able to do a better job of hitting
near the tips of tags without having to drastically increase the number
of bitmapped commits. But I haven't looked closely.

-Peff
