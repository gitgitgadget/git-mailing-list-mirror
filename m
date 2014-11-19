From: Jeff King <peff@peff.net>
Subject: Re: [RFC] On watchman support
Date: Tue, 18 Nov 2014 20:46:00 -0500
Message-ID: <20141119014600.GA2337@peff.net>
References: <20141111124901.GA6011@lanh>
 <1416270336.13653.23.camel@leckie>
 <CACsJy8BfxP7KF1XF29BOgC6XhO8iAy-ycEoLkDG5rn6TYH_DrA@mail.gmail.com>
 <1416334360.27401.10.camel@leckie>
 <xmqqioicut32.fsf@gitster.dls.corp.google.com>
 <1416345123.27401.11.camel@leckie>
 <xmqqwq6std27.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:46:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquLP-0003yY-S6
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825AbaKSBqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:46:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:42086 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754737AbaKSBqC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:46:02 -0500
Received: (qmail 10406 invoked by uid 102); 19 Nov 2014 01:46:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 19:46:01 -0600
Received: (qmail 25629 invoked by uid 107); 19 Nov 2014 01:46:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 20:46:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 20:46:00 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwq6std27.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 01:26:56PM -0800, Junio C Hamano wrote:

> It is not check_refname_format() that is the real problem. It's the
> fact that we do O(# of refs) work whenever we have to access the
> packed-refs file. check_refname_format() is part of that, surely,
> but so is reading the file, creating all of the refname structs in
> memory, etc. (credit to peff@).

Yeah, I'd agree very much with that. I am not sure if I am cc'd here
because of my general complaining about packed-refs, or if I have said
something clever on the subject.

I did implement at one point a packed-refs reader that does a binary
search on the mmap'd packed-refs file, and can return a single value or
even locate the first entry matching a prefix (like "refs/tags/") and
iterate until we're out of the prefix. Unfortunately this runs very
contrary to the caching design of the refs.c code. It is focused on
caching _loose_ refs, where we may read an outer directory (like
"refs/"), and would like to avoid descending into an inner directory
(likes "refs/foo/") unless we are interested in what is in it. But
caching partial reads of packed-refs like this is "inside out"; we might
read all of "refs/tags/*", but have no clue what else is in "refs/". So
integrating it into refs.c would take pretty major surgery.

-Peff
