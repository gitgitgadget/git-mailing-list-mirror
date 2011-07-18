From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Sun, 17 Jul 2011 23:41:06 -0400
Message-ID: <20110718034106.GB2468@sigill.intra.peff.net>
References: <20110714200144.GE26918@sigill.intra.peff.net>
 <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net>
 <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net>
 <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <CAJo=hJtuxNLhSjn_sDJxG7xu5k2wbJ_QLf_n+Z1E=o2AndAuJQ@mail.gmail.com>
 <CA+55aFw_XjWm+4XwsN6CRJnsrcEu5YEChOHSHN51UUBN6PynWw@mail.gmail.com>
 <20110715184211.GH8453@thunk.org>
 <CAP8UFD3p8rv9BoPkTYSr_qRztKhWmmHgjHi0pZ6gN9YzkSX0Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 05:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiehm-00023v-En
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 05:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab1GRDlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 23:41:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44514
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272Ab1GRDlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 23:41:08 -0400
Received: (qmail 17665 invoked by uid 107); 18 Jul 2011 03:41:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Jul 2011 23:41:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jul 2011 23:41:06 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD3p8rv9BoPkTYSr_qRztKhWmmHgjHi0pZ6gN9YzkSX0Jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177335>

On Sat, Jul 16, 2011 at 11:16:45AM +0200, Christian Couder wrote:

> If  "git tag --contains" and "git branch --contains" give incorrect
> answers because the commiter date is wrong in some commits, then why
> not use "git replace" to "change" the commiter date in the commits
> that have a wrong date? Is it because you don't want to use "git
> replace", or because there is no script to do it automatically, or is
> there another reason?

That would work. There are a few tricky things, though:

  1. Most commits have less than 100 skewed commits. But some have many
     (e.g., thousands in the mesa repo). How well does git cope with
     large numbers of replace refs, performance-wise?

  2. Declaring which commits are skewed is actually tricky. You can find
     a commit whose timestamp is less than the timestamp of one of its
     ancestors. But you don't know whether it is skewed, or the
     ancestor.

     If you are implementing a list of commits whose timestamps
     shouldn't be used for traversal cutoff, it doesn't really matter
     who is _right_; you just care about whether the timestamps are
     strictly increasing from that point.

     But once you start replacing commits, you need to put in a
     reasonable value for the timestamp. So you may well be replacing a
     perfectly valid commit with one that has bogus, skewed information
     in the commit timestamp.

  3. Any value you put in is actually going to be a lie during things
     like "git log --pretty=raw". That may be OK. But it is letting an
     optimization meant to make traversal fast and accurate bleed into
     the actual data we show the user.

  4. Sometimes we need to do traversals on the real objects (e.g.,
     because we are doing upload-pack). To get the benefit, those
     traversals would presumably need to look at both the original
     object and the replacement, use the timestamp from the replacement
     for traversal, but otherwise use the original object.

-Peff
