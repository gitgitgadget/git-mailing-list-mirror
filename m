From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/5] cache-tree revisited
Date: Thu, 8 Dec 2011 15:15:29 +0100
Message-ID: <201112081515.29652.trast@student.ethz.ch>
References: <cover.1323191497.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlos =?iso-8859-1?q?Mart=EDn_Nieto?= <cmn@elego.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 08 15:15:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYel7-000588-IG
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 15:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab1LHOPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 09:15:33 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:27110 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab1LHOPc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 09:15:32 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Dec
 2011 15:15:27 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Dec
 2011 15:15:29 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <cover.1323191497.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186566>

Thomas Rast wrote:
> Junio C Hamano wrote:
> > Ahh, I forgot all about that exchange.
> > 
> >   http://thread.gmane.org/gmane.comp.version-control.git/178480/focus=178515
> > 
> > The cache-tree mechanism has traditionally been one of the more important
> > optimizations and it would be very nice if we can resurrect the behaviour
> > for "git commit" too.
> 
> Oh, I buried that.  Let's try something other than the aggressive
> strategy I had there: only compute cache-tree if
> 
> * we know we're going to need it soon, and we're about to write out
>   the index anyway (as in git-commit)

I had another idea: we could write out *just* a new cache-tree data
set at the end of git-commit.

Doing it the cheap way would mean rehashing the on-disk data without
actually touching it.  (That might not be so bad, but then if your
index is small, why is writing it from scratch expensive?)

Doing it efficiently requires making the sha1 restartable, which is
entirely doable withblock-sha1/sha1.h (I haven't looked into
ppc/sha1.h).  As far as I can see it's not feasible with openssl's
sha1.

That is, we would add a new index extension (say PSHA: partial SHA)
and structure the index as

  signature
  header
  cache data
  PSHA <sha state up until just before PSHA>
  TREE ...
  [REUC ...]
  sha1 footer

Then it's easy to cheaply replace only the extensions, by restarting
the hashing from the PSHA data and re-emitting only the extension
data.

I think all the bits are in place, and it would be easy to do.
However, for it to make sense, we would have to make BLK_SHA1 the
default for the most-used platforms and also not mind extending the
SHA1 API.  Do you think that would fly?

I thought about other ways to make the index writing restartable from
the middle, but the only clean approach I came up with would require a
format change to something like

     signature
  0  header
  1  cache data
  2  sha1 of 0..1
  3  extension data A
  4  sha1 of 2..3
  5  extension data B
  6  sha1 of 4..5
  [possibly more]
  7  end-of-index marker
  8  sha1 of 6..7

etc.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
