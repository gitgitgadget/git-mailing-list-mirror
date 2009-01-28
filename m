From: Jeff King <peff@peff.net>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 13:11:15 -0500
Message-ID: <20090128181115.GF8863@coredump.intra.peff.net>
References: <7vk58gz04l.fsf@gitster.siamese.dyndns.org> <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com> <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org> <20090128033020.GF1321@spearce.org> <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org> <20090128044150.GI1321@spearce.org> <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org> <20090128160900.GJ1321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 19:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSEu4-0002iV-P6
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 19:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbZA1SLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 13:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbZA1SLS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 13:11:18 -0500
Received: from peff.net ([208.65.91.99]:34294 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbZA1SLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 13:11:17 -0500
Received: (qmail 24387 invoked by uid 107); 28 Jan 2009 18:11:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 13:11:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 13:11:15 -0500
Content-Disposition: inline
In-Reply-To: <20090128160900.GJ1321@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107556>

On Wed, Jan 28, 2009 at 08:09:00AM -0800, Shawn O. Pearce wrote:

> I don't think its right to ignore broken UNINTERESTING chains all
> of the time.  Today we would see fatal errors if I asked for
> 
>   git log R ^C
> 
> and A was missing, but R and C are both local refs.  I still want
> to see that fatal error.  Its a local corruption that should be
> raised quickly to the user.  In fact by A missing we'd compute the
> wrong result and produce D-E too, which is wrong.

I think you wrote this before reading the other part of the thread where
we see that many of these checks are not in C git. But to be clear, even
without Junio's patches the exact case I mentioned is not currently
reported as an error (i.e., will produce incorrect results). I tested
with:

-- >8 --
commit() {
    echo $1 >$1 && git add $1 && git commit -m $1 && git tag $1
}

mkdir repo && cd repo && git init
commit A
commit B
commit C
commit D
git checkout -b other B
commit E
commit F

rm -f .git/objects/`git rev-parse E | sed 's,^..,&/,'`
git log F..D
-- 8< --

which shows A-B-C-D.

-Peff
