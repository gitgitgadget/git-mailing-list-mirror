From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/4] config include directives
Date: Fri, 27 Jan 2012 12:34:09 -0500
Message-ID: <20120127173408.GA3053@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <CACBZZX59sur4_61LkN_sMOvXQ4Jdnt1P8O-UOgm0SooBQpjFdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 18:34:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqpgp-00039A-IF
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 18:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab2A0ReO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 12:34:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46653
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab2A0ReO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 12:34:14 -0500
Received: (qmail 7311 invoked by uid 107); 27 Jan 2012 17:41:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jan 2012 12:41:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2012 12:34:09 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX59sur4_61LkN_sMOvXQ4Jdnt1P8O-UOgm0SooBQpjFdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189226>

On Fri, Jan 27, 2012 at 10:51:34AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> If you write the function like that it means your patch series just
> works since values encountered later will override earlier ones, but
> have you checked git's code to make sure we don't have anything like:
>=20
>     static int ignore_add_errors_is_set =3D 0;
>     static int add_config(const char *var, const char *value, void *c=
b)
>     {
>     	if (!ignore_add_errors_is_set &&
>             (!strcmp(var, "add.ignoreerrors") ||
>     	     !strcmp(var, "add.ignore-errors"))) {
>     		ignore_add_errors =3D git_config_bool(var, value);
>             ignore_add_errors_is_set =3D 1;
>     		return 0;
>     	}
>     	return git_default_config(var, value, cb);
>     }
>=20
> Which would mean that the include config support would be silently
> ignored.

I'm not sure what the issue is. If you write code like this, it will
already ignore the second invocation when it is found later in the same
file, or when it is found in a later file (i.e., in both .git/config an=
d
=2Egitconfig). So I don't think includes introduce a new problem with
respect to code like this (and no, I didn't check exhaustively, but I
don't recall seeing code like this in git).

A bigger potential problem is multi-key values that form lists. For
example, I cannot use a later "remote.foo.url" line to override an
earlier one; instead, it gets appended to the list of URLs for "foo".
In practice, it's not a problem because the list-like options don't ten=
d
to be found in multiple places. And again, this is not a new problem of
includes, since we already handle multiple files.

Accidentally including the same file twice would cause duplicates for
multi-key values. But I'm going to take Junio's suggestion to avoid
including the same file twice (which also prevents infinite loops due t=
o
cycles).

-Peff
