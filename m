From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Clear fd after closing to avoid double-close error
Date: Tue, 22 Oct 2013 11:29:48 -0400
Message-ID: <20131022152948.GA21940@sigill.intra.peff.net>
References: <1382448962-31782-1-git-send-email-jl@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 17:30:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYduA-0002sJ-H3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 17:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768Ab3JVP3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Oct 2013 11:29:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:53608 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753018Ab3JVP3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 11:29:54 -0400
Received: (qmail 17586 invoked by uid 102); 22 Oct 2013 15:29:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Oct 2013 10:29:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Oct 2013 11:29:48 -0400
Content-Disposition: inline
In-Reply-To: <1382448962-31782-1-git-send-email-jl@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236476>

On Tue, Oct 22, 2013 at 03:36:02PM +0200, Jens Lindstr=C3=B6m wrote:

> In send_pack(), clear the fd passed to pack_objects() by setting
> it to -1, since pack_objects() closes the fd (via a call to
> run_command()).  Likewise, in get_pack(), clear the fd passed to
> run_command().
>=20
> Not doing so risks having git_transport_push(), caller of
> send_pack(), closing the fd again, possibly incorrectly closing
> some other open file; or similarly with fetch_refs_from_pack(),
> indirect caller of get_pack().

Thanks, this looks like the right thing to do.

You had mentioned earlier in the thread the possibility of just droppin=
g
the close() in git_transport_push. I agree that it is not worth going
that route, as it serves as a safety check to avoid leaking in early
returns (and indeed, in both the fetch and push cases, we can return
early without spawning a subprocess when the receiver already has all o=
f
the necessary objects).

> Signed-off-by: Jens Lindstr=C3=B6m <jl@opera.com>

Acked-by: Jeff King <peff@peff.net>

-Peff
