From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] optimizing upload-pack ref peeling
Date: Thu, 4 Oct 2012 03:56:09 -0400
Message-ID: <20121004075609.GA1355@sigill.intra.peff.net>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net>
 <CACBZZX4Grya=FbL9XEh_EK6KVsFZYWCuHveV2QevcBwr+iYTMQ@mail.gmail.com>
 <20121003212007.GC4484@sigill.intra.peff.net>
 <CACBZZX6yMfeOx6x4iy8beq5niy9HvPq0c8ND5jZkoiJWAgVjfw@mail.gmail.com>
 <20121003231529.GA11618@sigill.intra.peff.net>
 <CACBZZX5Sm++Wjyoue-qk7TjwxUM3QihXfWGtEHhOq=VtkgvNbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:30:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUV-0001w8-LE
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab2JDH4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 03:56:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40470 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755034Ab2JDH4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:56:12 -0400
Received: (qmail 17603 invoked by uid 107); 4 Oct 2012 07:56:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 03:56:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 03:56:09 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX5Sm++Wjyoue-qk7TjwxUM3QihXfWGtEHhOq=VtkgvNbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207006>

On Thu, Oct 04, 2012 at 01:54:47AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> > Hmm. It seems like we should not need to open the tags at all. The =
main
> > reason is to produce the "peeled" advertisement just after it. But =
for a
> > packed ref with a modern version of git that supports the "peeled"
> > extension, we should already have that information.
>=20
> B.t.w. do you plan to submit this as a non-hack, I'd like to have it
> in git.git, so if you're not going to I could pick it up and clean it
> up a bit. But I think it would be better coming from you.

Here's a cleaned-up version. I realized that peel_ref actually is quite
close to what we want; the key thing is that when you are calling it
from a for_each_ref loop it will not only use peeled information from
packed-refs (if available), but it will also short-circuit the ref
lookup for non-packed refs. So it really does what we want.

I put some timings into the final patch. The results are very satisfyin=
g
from a pure numbers standpoint. However, I'm not 100% sure this is all
that useful a benchmark. The repos where you get a noticeable benefit
are quite big, so I suspect the time to send the advertisements out ove=
r
the wire will dominate. Still, a CPU second saved is a CPU second
earned.

And the series actually ends up making the code cleaner and shares some
of the optimizations I put into upload-pack with other users of
peel_ref. So I think I'd be inclined to use it, even if the speedup
doesn't help that much in practice. We'll see what others think.

  [1/4]: peel_ref: use faster deref_tag_noverify
  [2/4]: peel_ref: do not return a null sha1
  [3/4]: peel_ref: check object type before loading
  [4/4]: upload-pack: use peel_ref for ref advertisements

-Peff
