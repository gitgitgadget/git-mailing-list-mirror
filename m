From: Jeff King <peff@peff.net>
Subject: Re: Questions about git-push for huge repositories
Date: Tue, 8 Sep 2015 01:00:27 -0400
Message-ID: <20150908050027.GB26331@sigill.intra.peff.net>
References: <CAN6cQGPcGpaXUGu_7aaeJtMbruMocte-5po97vG5r39f=YdTZQ@mail.gmail.com>
 <xmqq4mj7bfsf.fsf@gitster.mtv.corp.google.com>
 <CAN6cQGMf089ERn2kZbFpHJ6vyJ4BnjCm-m-E+hQsduH55XFvKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Levin Du <zslevin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 07:00:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZB1G-000725-VW
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 07:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbbIHFAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 01:00:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:56098 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751126AbbIHFAa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 01:00:30 -0400
Received: (qmail 11207 invoked by uid 102); 8 Sep 2015 05:00:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 00:00:30 -0500
Received: (qmail 19040 invoked by uid 107); 8 Sep 2015 05:00:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 01:00:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 01:00:27 -0400
Content-Disposition: inline
In-Reply-To: <CAN6cQGMf089ERn2kZbFpHJ6vyJ4BnjCm-m-E+hQsduH55XFvKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277485>

On Mon, Sep 07, 2015 at 09:05:41AM +0800, Levin Du wrote:

> > Instead, the object transfer is optimized by comparing what commits
> > each side has and sending trees and blobs that are reachable from
> > the commits that the receiving side does not have.
> 
> The sender A sends all the commits that the receiver B does not have.
> The commits contains trees and blobs. In my situation, branch in A has
> only one commit. It seems that B has received lots of duplicate blobs,
> concluded from the GC result.

Right. B tells A "I already have this commit", but A does not already
have it, so that information is not helpful. It cannot make any
assumptions about what B has, and must send all trees and blobs
referenced by its commit.

> What I do not understand is, how duplicate blobs happen in a git repository?
> Git repository is famous for its content addressing storage system.
> I guess that A sends its packed file to B directly, no matter what are
> already in B.

Not exactly.  During a push, git may or may not keep the packfile sent
over the wire, depending on the number of objects in it and the
receive.unpackLimit config setting. The same object can exist in two
separate packfiles. One of the effects of "git gc" is to remove such
duplicates.

So A effectively does send its whole pack in this case, but only because
it cannot find any shared history with B (and B keeps it as-is until the
next gc because it is over the unpackLimit).

-Peff
