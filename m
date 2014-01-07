From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_name: don't resolve refs when
 core.warnambiguousrefs is false
Date: Tue, 7 Jan 2014 17:08:56 -0500
Message-ID: <20140107220856.GA10074@sigill.intra.peff.net>
References: <1389065521-46331-1-git-send-email-brodie@sf.io>
 <CAEfQM484kqLSVeyjhYtg7GfXOQkQNjaO1FV2_U3uAqO=Nargdg@mail.gmail.com>
 <20140107171307.GA19482@sigill.intra.peff.net>
 <xmqqzjn7el4k.fsf@gitster.dls.corp.google.com>
 <20140107175241.GA20415@sigill.intra.peff.net>
 <xmqqppo3d1lk.fsf@gitster.dls.corp.google.com>
 <20140107195844.GA21812@sigill.intra.peff.net>
 <xmqqd2k3cz42.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:09:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0epd-0002S9-Bs
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbaAGWJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 17:09:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:56746 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754138AbaAGWI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 17:08:58 -0500
Received: (qmail 27610 invoked by uid 102); 7 Jan 2014 22:08:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 16:08:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 17:08:56 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd2k3cz42.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240168>

On Tue, Jan 07, 2014 at 12:31:57PM -0800, Junio C Hamano wrote:

> >   c. Just leave it at Brodie's patch with nothing else on top.
> >
> > My thinking in favor of (b) was basically "does anybody actually care
> > about ambiguous refs in this situation anyway?". If they do, then I
> > think (c) is my preferred choice.
> 
> OK.  I agree with that line of thinking.  Let's take it one step at
> a time, i.e. do c. and also use warn_on_object_refname_ambiguity in
> "rev-list --stdin" first and leave the simplification (i.e. b.) for
> later.

Here's a series to do that. The first three are just cleanups I noticed
while looking at the problem.

While I was writing the commit messages, though, I had a thought. Maybe
we could simply do the check faster for the common case that most refs
do not look like object names? Right now we blindly call dwim_ref for
each get_sha1 call, which is the expensive part. If we instead just
loaded all of the refnames from the dwim_ref location (basically heads,
tags and the top-level of "refs/"), we could build an index of all of
the entries matching the 40-hex pattern. In 99% of cases, this would be
zero entries, and the check would collapse to a simple integer
comparison (and even if we did have one, it would be a simple binary
search in memory).

Our index is more racy than actually checking the filesystem, but I
don't think it matters here.

Anyway, here is the series I came up with, in the meantime. I can take a
quick peek at just making it faster, too.

  [1/4]: cat-file: refactor error handling of batch_objects
  [2/4]: cat-file: fix a minor memory leak in batch_objects
  [3/4]: cat-file: restore ambiguity warning flag in batch_objects
  [4/4]: revision: turn off object/refname ambiguity check for --stdin

-Peff
