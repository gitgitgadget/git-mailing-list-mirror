From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Tue, 17 Sep 2013 16:10:04 -0400
Message-ID: <20130917201003.GA16860@sigill.intra.peff.net>
References: <20130917190659.GA15588@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:10:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1bh-0005Zh-4C
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab3IQUKi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Sep 2013 16:10:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:47539 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254Ab3IQUKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:10:11 -0400
Received: (qmail 20480 invoked by uid 102); 17 Sep 2013 20:10:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Sep 2013 15:10:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Sep 2013 16:10:04 -0400
Content-Disposition: inline
In-Reply-To: <20130917190659.GA15588@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234912>

On Tue, Sep 17, 2013 at 09:06:59PM +0200, Uwe Kleine-K=C3=B6nig wrote:

> 	$ git checkout HEAD^ -- subdir
>=20
> I'd expect that subdir/b is removed from the index as this file didn'=
t
> exist in HEAD^ but git-status only reports:

I'm not sure if this is intentional or not. The definition of "git
checkout $tree $path" given in commit 0a1283b says:

    Checking paths out of a tree is (currently) defined to do:

     - Grab the paths from the named tree that match the given pathspec=
,
       and add them to the index;

     - Check out the contents from the index for paths that match the
       pathspec to the working tree; and while at it

     - If the given pathspec did not match anything, suspect a typo fro=
m the
       command line and error out without updating the index nor the wo=
rking
       tree.

So we are applying the pathspec to the named tree, and pulling anything
that matches into the index. Which by definition cannot involve a
deletion, because there is no comparison happening (so we either have
it, or we do not). Whereas what you are expecting is to compare the tre=
e
and the index, limited by the pathspec, and pull any changes from the
tree into the index.

I tend to agree that the latter is more like how other git commands
behave (e.g., if you tried to use "read-tree" to emulate what
git-checkout was doing, I think you would end up with a two-way merge).
But there may be implications I haven't thought of.

Note also that "git checkout -p" does present "subdir/b" as a deletion.
It works by doing a pathspec-limited diff between the two endpoints,
which will notice deletions. So there is some inconsistency there with
the baseline form.

-Peff
