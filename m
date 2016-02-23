From: Jeff King <peff@peff.net>
Subject: Re: whither merge-tree?
Date: Tue, 23 Feb 2016 00:14:02 -0500
Message-ID: <20160223051402.GA23375@sigill.intra.peff.net>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
 <20160222221209.GA18522@sigill.intra.peff.net>
 <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
 <20160223050210.GA17767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 06:14:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY5IZ-0005yX-EP
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 06:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbcBWFOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 00:14:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:47284 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750807AbcBWFOG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 00:14:06 -0500
Received: (qmail 6684 invoked by uid 102); 23 Feb 2016 05:14:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 00:14:05 -0500
Received: (qmail 25507 invoked by uid 107); 23 Feb 2016 05:14:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 00:14:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 00:14:02 -0500
Content-Disposition: inline
In-Reply-To: <20160223050210.GA17767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287015>

On Tue, Feb 23, 2016 at 12:02:10AM -0500, Jeff King wrote:

> > git-merge-resolve (rather, git-merge-one-file) attempts the same
> > "resolve add/add by taking the common" thing, but it implements it
> > in quite a different way.
> 
> I suppose the end result of what merge-tree is trying to do makes sense.
> It's definitely a conflict, but we are interested in showing the minimal
> content-level conflict. But I think xdl_merge() takes care of that for
> us, if we simply feed an empty base. And that is what merge-recursive
> does.
> 
> I do see that merge-one-file tries create_virtual_base(), which does
> some magic with diff. But I'm having trouble conceiving of a case where
> that would do something different or useful.

I dug this all the way down to your cb93c19 (merge-one-file: use common
as base, instead of emptiness., 2005-11-09), which states that the goal
is just to get:

	common file contents...
	<<<<<< FILENAME
	version from our branch...
	======
	version from their branch...
	>>>>>> .merge_file_XXXXXX
	more common file contents...

But that seems to be what we produce now. Did all of this simply predate
xdl_merge, and the crappy rcs merge did not bother minimizing the diff?
That certainly seems to be the case in my tests.

If that is the case, I think we can get rid of the complex
create_virtual_base(), as well.

-Peff
