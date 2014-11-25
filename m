From: Jeff King <peff@peff.net>
Subject: Re: BUG in http-backend.c  > http.receivepack
Date: Mon, 24 Nov 2014 22:56:19 -0500
Message-ID: <20141125035618.GA19301@peff.net>
References: <F9AF62ADACFFBA47BEEADC5C12509F3401226EE8F8@Hermes.sns.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: "Springer, Stephan" <springer@sloman-neptun.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 04:56:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt7Eu-0006G9-Uq
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 04:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbaKYD4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 22:56:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:44610 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750784AbaKYD4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 22:56:20 -0500
Received: (qmail 27592 invoked by uid 102); 25 Nov 2014 03:56:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 21:56:20 -0600
Received: (qmail 26434 invoked by uid 107); 25 Nov 2014 03:56:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 22:56:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 22:56:19 -0500
Content-Disposition: inline
In-Reply-To: <F9AF62ADACFFBA47BEEADC5C12509F3401226EE8F8@Hermes.sns.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260188>

On Mon, Nov 24, 2014 at 09:18:52AM +0100, Springer, Stephan wrote:

> I found bug in http-backend.c with config-flag "http.receivepack" =C2=
=A0You
> describe in our documentation: "This serves git send-pack clients,
> allowing push. It is disabled by default for anonymous users, and
> enabled by default for users authenticated by the web server. It can
> be disabled by setting this item to false, or enabled for all users,
> including anonymous users, by setting it to true."
> That cannot work, while svc-enable less than 0. See attachment

Sorry, I don't quite understand. The "enabled" field is one of:

  -1: we allow access if $REMOTE_USER is set, and otherwise not
   0: we never allow access
   1: we always allow access

The default is -1. By setting it to "true" or "false" you get 1 or 0,
respectively. You cannot explicitly ask for the default, except by not
setting the value in the first place.

>         #
>         # better (svc->enabled <=3D 0) than can ?REMOTE_USER? enable =
push function=20
>         #
>         if (svc->enabled < 0) {       =20
>                const char *user =3D getenv("REMOTE_USER");
>                svc->enabled =3D (user && *user) ? 1 : 0;
>         }

If this condition were "svc->enabled <=3D 0", then setting the config
option to "false", which should turn off access, will respect
$REMOTE_USER instead. That is not right.

Can you describe what you're configuring and running, what behavior you
expect, and what you get instead?

-Peff
