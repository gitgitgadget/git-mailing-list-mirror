From: Jeff King <peff@peff.net>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 14 Nov 2011 15:25:22 -0500
Message-ID: <20111114202522.GA26269@sigill.intra.peff.net>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
 <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
 <CAD=rjTXgH+AivmK+zLurQVC+=p1UYqFy_p=wBF-1-TOQ=Cqjtw@mail.gmail.com>
 <20111114103451.GA10847@sigill.intra.peff.net>
 <7vfwhqjw4u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Simon Brenner <olsner@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 21:25:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ363-0005Rv-Fr
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 21:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191Ab1KNUZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 15:25:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41269
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170Ab1KNUZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 15:25:34 -0500
Received: (qmail 31598 invoked by uid 107); 14 Nov 2011 20:25:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 15:25:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 15:25:22 -0500
Content-Disposition: inline
In-Reply-To: <7vfwhqjw4u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185396>

On Mon, Nov 14, 2011 at 12:18:25PM -0800, Junio C Hamano wrote:

> > Yes, I think that is sensible. I'm not sure there is even any core git
> > code to be written. I think a wrapper that does the following would
> > probably work:
> 
> I agree with your outline, which I find is in line with what I had in mind
> in the message Miles responded.
> 
> The approach is different from what Miles alluded to, which is to have
> "clients" create objects in the "central" place in the first place,
> though.

It seems to me that is simply an optimization that can come later. An
initial, no-C-code implementation would write to individual repos as
usual, and then occasionally migrate objects to the master shared repo
(and remove duplicates from individual repos). That's an easy to
implement low-risk experiment from which we can draw conclusions about
how well such a system works in practice.

And then if it seems like a good path, an obvious optimization[1] is to
write directly into the parent object store, skipping the migration.
This might involve git-core code, or maybe it just means setting up the
repos differently (e.g., symlinking the objects directory to the master
store).

-Peff

[1] Actually, I am slightly dubious that this optimization is worth
doing. It seems like it would save you from writing the data only to
copy it later. But in practice, we write loose objects, and you are
already rewriting the data to migrate it into packfiles. So the
migration already happens, and instead we would just be migrating to
packfiles in the central repo.
