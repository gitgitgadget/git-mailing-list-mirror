From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: re-allow HEAD:Documentation on a remote
 invocation
Date: Wed, 11 Jan 2012 14:39:16 -0500
Message-ID: <20120111193916.GA12333@sigill.intra.peff.net>
References: <20120110232132.GA29245@sigill.intra.peff.net>
 <1326283958-30271-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:39:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl417-0007O0-F9
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 20:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757819Ab2AKTjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 14:39:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35288
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757543Ab2AKTjU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 14:39:20 -0500
Received: (qmail 22602 invoked by uid 107); 11 Jan 2012 19:46:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jan 2012 14:46:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2012 14:39:16 -0500
Content-Disposition: inline
In-Reply-To: <1326283958-30271-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188385>

On Wed, Jan 11, 2012 at 01:12:38PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> The tightening done in (ee27ca4a: archive: don't let remote clients
> get unreachable commits, 2011-11-17) went too far and disallowed
> HEAD:Documentation as it would try to find "HEAD:Documentation" as a
> ref.
>=20
> Only DWIM the "HEAD" part to see if it exists as a ref. Once we're
> sure that we've been given a valid ref, we follow the normal code
> path. This still disallows attempts to access commits which are not
> branch tips.

I'd rather not do this kind of ad-hoc parsing of sha1s in the archive
code, and instead let the regular resolution process tell us more about
what it did, so we can make a policy decision at the upper level.

Patches to follow:

  [1/2]: get_sha1_with_context: report features used in resolution
  [2/2]: archive: loosen restrictions on remote object lookup

> AFAICT this should still be safe. Using HEAD^:Documentation or
> <sha1>:Documentation still complains that HEAD^ and <sha1> aren't
> refs.

My patches enable things like HEAD^, but disallow a raw sha1. The only
way to safely allow a raw sha1 is to check its connectivity from the
tips, which can be somewhat expensive (you have to traverse every tree
of every commit in the worst case).

-Peff
