From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Wed, 18 Nov 2015 16:11:59 -0500
Message-ID: <20151118211158.GA32071@sigill.intra.peff.net>
References: <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <20151113233807.GD16173@sigill.intra.peff.net>
 <20151113234116.GA18234@sigill.intra.peff.net>
 <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
 <564A279C.6000802@web.de>
 <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
 <CACsJy8D-TRJ---4BYrEZeEkd9_5-xgGp4U0nB9YHNtV3zgxrbg@mail.gmail.com>
 <20151117214347.GB27862@sigill.intra.peff.net>
 <CACsJy8Ah2PgO8CunCvWiKB7RfqMfovWa1a7ro5scHFK+AEAXpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 22:12:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzA1R-00086r-PT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 22:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbbKRVME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 16:12:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:59431 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755916AbbKRVMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 16:12:03 -0500
Received: (qmail 6312 invoked by uid 102); 18 Nov 2015 21:12:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Nov 2015 15:12:02 -0600
Received: (qmail 8504 invoked by uid 107); 18 Nov 2015 21:12:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Nov 2015 16:12:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Nov 2015 16:11:59 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Ah2PgO8CunCvWiKB7RfqMfovWa1a7ro5scHFK+AEAXpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281458>

On Wed, Nov 18, 2015 at 01:32:36PM +0100, Duy Nguyen wrote:

> Yeah I think that was the 10k commits in Shawn's mail: the number of
> commits we may have to walk until we hit a reachability bitmap. It
> looks like C Git will create a bitmap every 5k commits, not 10k,
> though, if I read the code correctly. The point is reachability test
> with the presence of pack bitmaps is not O(n) anymore. Which is
> probably good enough for now.

There are some pathological cases, though. I hit one recently that still
took 40s to do "rev-list --objects --all --use-bitmap-index" (it's 80s
without bitmaps).  The problem is that it has over 20,000 refs. We try
to put a bitmap at the tip of each ref, but it's tough when there are
that many.

I suspect there's room for improvement in the commit selection in such
cases. That code hasn't really been tweaked since it was originally
written, and repositories like that are extreme outliers.

-Peff
