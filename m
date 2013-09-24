From: Jeff King <peff@peff.net>
Subject: Re: Local tag killer
Date: Tue, 24 Sep 2013 03:51:19 -0400
Message-ID: <20130924075119.GD7257@sigill.intra.peff.net>
References: <52327E62.2040301@alum.mit.edu>
 <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
 <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com>
 <523D3FD2.4090002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 24 09:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VONP6-0006IN-BQ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 09:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733Ab3IXHvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 03:51:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:54067 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab3IXHvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 03:51:23 -0400
Received: (qmail 8476 invoked by uid 102); 24 Sep 2013 07:51:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 02:51:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 03:51:19 -0400
Content-Disposition: inline
In-Reply-To: <523D3FD2.4090002@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235282>

On Sat, Sep 21, 2013 at 08:42:26AM +0200, Michael Haggerty wrote:

> I think it would be preferable if "--prune" would *not* affect tags, and
> if there were an extra option like "--prune-tags" that would have to be
> used explicitly to cause tags to be pruned.  Would somebody object to
> such a change?

I think most of this problem is the way that we fetch tags straight into
the refs/tags hierarchy. You would not do:

  [remote "origin"]
  fetch = +refs/heads/*:refs/heads/*
  prune = true

unless you wanted to be a pure-mirror, because you would hose your local
changes any time you fetched. But that is _exactly_ what we do with a
refs/tags/*:refs/tags/* fetch.

If we instead moved to a default fetch refspec more like:

  [remote "origin"]
  fetch = +refs/*:refs/remotes/origin/refs/*

Then everything would Just Work. If you prune what the other side has
locally, that's fine. All you're doing is pruning your view of what he
has, not anything you've done locally.

The tricky part is tweaking the lookup rules so that "origin/master"
still works, and that looking for "v1.0" checks both refs/tags and
refs/remotes/*/refs/tags. And of course managing backwards
compatibility. :)

In the meantime, I'd almost be tempted to say that "--prune" should
refuse to work when we are touching anything outside of refs/remotes/.
But that would make true mirrors fail, who do want to munge their local
refs/heads/. You'd need some way to say "no, really, it's OK to prune".
Maybe let remote.*.prune be "remotes", "always", or "none", and "true"
maps to "remotes"? That's not backwards compatible, but it would be much
safer.

-Peff
