From: Jeff King <peff@peff.net>
Subject: Re: git update --prune issue
Date: Tue, 27 Oct 2009 12:29:36 -0400
Message-ID: <20091027162936.GA8130@sigill.intra.peff.net>
References: <4389ce950910261508p7eca354el77bad07305a80952@mail.gmail.com>
 <4AE6B28F.9010407@drmicha.warpmail.net>
 <4389ce950910270807o69d51155xb083f34bb31e1dae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeffrey Middleton <jefromi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 17:29:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2ove-0005RW-Ja
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 17:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915AbZJ0Q3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 12:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755888AbZJ0Q3f
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 12:29:35 -0400
Received: from peff.net ([208.65.91.99]:55015 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850AbZJ0Q3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 12:29:35 -0400
Received: (qmail 1766 invoked by uid 107); 27 Oct 2009 16:33:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 27 Oct 2009 12:33:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2009 12:29:36 -0400
Content-Disposition: inline
In-Reply-To: <4389ce950910270807o69d51155xb083f34bb31e1dae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131353>

On Tue, Oct 27, 2009 at 10:07:27AM -0500, Jeffrey Middleton wrote:

> > Do you get the same problem if you do the steps individually, i.e.:
> >
> > git remote update steph
> > git remote prune steph
> > git remote update kevin
>=20
> I don't *think* I'll see it this way - I was doing essentially this
> prior to introduction of the --prune option, and never saw it then.

I suspect you are seeing git keeping an invalid cache of the set of ref=
s
within a single program. Your original report had:

> Pruning steph
> URL: /users/sdewet/CxTF_DEV/CxTF_DB/
> =C2=A0* [pruned] steph/beta_gc_dev_old
> Updating kevin
> error: refs/remotes/steph/beta_gc_dev does not point to a valid objec=
t!
> error: refs/remotes/steph/beta_veh_dev does not point to a valid obje=
ct!

The "pruned" line basically means that we are deleting that ref, and
then we complain immediately about that very ref (which is probably
pointing to the null sha1 or something at this point). We tend to cache
packed refs, so that may be the cause.

So either we need to invalidate that ref from the cache when it gets
deleted, or perhaps we are already invalidating it and we need to be
respecting that invalidation in other parts of the code. I'll take a
look.

-Peff
