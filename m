From: Jeff King <peff@peff.net>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 3 Oct 2012 14:03:24 -0400
Message-ID: <20121003180324.GB27446@sigill.intra.peff.net>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 20:04:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJTIM-0003U4-AT
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 20:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933012Ab2JCSD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 14:03:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39295 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932245Ab2JCSD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 14:03:26 -0400
Received: (qmail 10468 invoked by uid 107); 3 Oct 2012 18:03:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Oct 2012 14:03:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2012 14:03:24 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206917>

On Wed, Oct 03, 2012 at 02:36:00PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> I'm creating a system where a lot of remotes constantly fetch from a
> central repository for deployment purposes, but I've noticed that eve=
n
> with a remote.$name.fetch configuration to only get certain refs a
> "git fetch" will still call git-upload pack which will provide a list
> of all references.
>=20
> This is being done against a repository with tens of thousands of ref=
s
> (it has a tag for each deployment), so it ends up burning a lot of CP=
U
> time on the uploader/receiver side.

Where is the CPU being burned? Are your refs packed (that's a huge
savings)? What are the refs like? Are they .have refs from an alternate=
s
repository, or real refs? Are they pointing to commits or tag objects?

What version of git are you using?  In the past year or so, I've made
several tweaks to speed up large numbers of refs, including:

  - cff38a5 (receive-pack: eliminate duplicate .have refs, v1.7.6); not=
e
    that this only helps if they are being pulled in by an alternates
    repo. And even then, it only helps if they are mostly duplicates;
    distinct ones are still O(n^2).

  - 7db8d53 (fetch-pack: avoid quadratic behavior in remove_duplicates)
    a0de288 (fetch-pack: avoid quadratic loop in filter_refs)
    Both in v1.7.11. I think there is still a potential quadratic loop
    in mark_complete()

  - 90108a2 (upload-pack: avoid parsing tag destinations)
    926f1dd (upload-pack: avoid parsing objects during ref advertisemen=
t)
    Both in v1.7.10. Note that tag objects are more expensive to
    advertise than commits, because we have to load and peel them.

Even with those patches, though, I found that it was something like ~2s
to advertise 100,000 refs.

> Has there been any work on extending the protocol so that the client
> tells the server what refs it's interested in?

I don't think so. It would be hard to do in a backwards-compatible way,
because the advertisement is the first thing the server says, before it
has negotiated any capabilities with the client at all.

-Peff
