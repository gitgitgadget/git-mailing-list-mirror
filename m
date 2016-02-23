From: Jeff King <peff@peff.net>
Subject: Re: whither merge-tree?
Date: Tue, 23 Feb 2016 01:03:38 -0500
Message-ID: <20160223060338.GA2912@sigill.intra.peff.net>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
 <20160222221209.GA18522@sigill.intra.peff.net>
 <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
 <20160223050210.GA17767@sigill.intra.peff.net>
 <20160223051402.GA23375@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:03:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY64X-0006yq-SP
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbcBWGDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 01:03:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:47303 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932171AbcBWGDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 01:03:41 -0500
Received: (qmail 8795 invoked by uid 102); 23 Feb 2016 06:03:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 01:03:41 -0500
Received: (qmail 25818 invoked by uid 107); 23 Feb 2016 06:03:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 01:03:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 01:03:38 -0500
Content-Disposition: inline
In-Reply-To: <20160223051402.GA23375@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287017>

On Tue, Feb 23, 2016 at 12:14:02AM -0500, Jeff King wrote:

> I dug this all the way down to your cb93c19 (merge-one-file: use common
> as base, instead of emptiness., 2005-11-09), which states that the goal
> is just to get:
> 
> 	common file contents...
> 	<<<<<< FILENAME
> 	version from our branch...
> 	======
> 	version from their branch...
> 	>>>>>> .merge_file_XXXXXX
> 	more common file contents...
> 
> But that seems to be what we produce now. Did all of this simply predate
> xdl_merge, and the crappy rcs merge did not bother minimizing the diff?
> That certainly seems to be the case in my tests.
> 
> If that is the case, I think we can get rid of the complex
> create_virtual_base(), as well.

So here is what I would propose:

  [1/3]: merge-one-file: use empty blob for add/add base
  [2/3]: merge-tree: drop generate_common strategy
  [3/3]: xdiff: drop XDL_EMIT_COMMON

I briefly wondered if there were any bugs in merge-one-file around this
"no newline at end of file" issue. But there shouldn't be. It generates
the common file by applying the diff to the first file with "--no-add",
which should do the right thing, I think.

I stopped short of dropping the create_virtual_base function in the
first patch, for reasons explained there. But if we were to do so, I
suspect we could deprecated and eventually drop "apply --no-add", too.

-Peff
