From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Generate a warning message if we find an unrecognized
 option.
Date: Mon, 8 Feb 2010 22:01:51 -0500
Message-ID: <20100209030151.GA5370@coredump.intra.peff.net>
References: <4B70913F.7060809@winehq.org>
 <20100209004514.GB4065@coredump.intra.peff.net>
 <7vvde7z0kf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremy White <jwhite@winehq.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 04:01:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NegMP-0001sf-HB
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 04:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab0BIDBw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 22:01:52 -0500
Received: from peff.net ([208.65.91.99]:33408 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab0BIDBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 22:01:50 -0500
Received: (qmail 13568 invoked by uid 107); 9 Feb 2010 03:01:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Feb 2010 22:01:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2010 22:01:51 -0500
Content-Disposition: inline
In-Reply-To: <7vvde7z0kf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139350>

On Mon, Feb 08, 2010 at 04:59:12PM -0800, Junio C Hamano wrote:

> > And obviously that is weighed against the ability to notice things =
like
> > typos. But if we are going to start complaining about unknown confi=
g, we
> > would probably do better to complain about _all_ unknown config, an=
d not
> > just this one subsection.
>=20
> We would probably want something like:
>=20
> 	static int do_warn_unknown_config;
>=20
> 	void warn_unknown_config(const char *key)
>         {
> 		if (do_warn_unknown_config)
>                 	warn("Unknown configuration variable %s", key);
>         }
>=20
> and sprinkle that everywhere.

Your "sprinkle that everywhere" is a little harder than one might hope.
There is no code path that reads and claims to recognize _all_ of the
git config. In many cases, the git_*_config for individual subsystems
can reasonably lay claim to the whole of a "[heading]" section. But
there are exceptions even to that.

Diff config is split across git_diff_basic_config and
git_diff_ui_config. You would certainly not want to warn about
diff.color.* just because you are running a plumbing command which
happens not to recognize those entries.

And some headings have entries for several subsystems. remote.*.fetch i=
s
used many places for calculating upstream branches. But only git-remote
looks at remote.*.skipDefaultUpdate.

So in practice I think you will get quite spotty coverage. Which isn't
to say it isn't necessarily worth doing, but I am personally not very
excited about working on it. I do like the suggestion of making it
optional, so that people who don't care about having a portable config
can have the benefit of sanity-checking their config.

> An interesting issue is where to flip do_warn_unknown_config.  A na=C3=
=AFve
> and obvious implementation would do:
>=20
>         static int git_default_core_config(const char *var, const cha=
r *value)
>         {
> 		...
> 		if (!strcmp(var, "core.warnunknownconfig")) {
> 			do_warn_unknown_config =3D git_config_bool(var, value);
> 			return 0;
> 		}
> 		...
> 	}
>=20
> but that means the definition of this variable has to come very early=
 in
> the configuration file to be effective.

I would rather have a "git config --lint" command, but that is even
harder, since we are not even loading most of the subsystems which know
about the valid config options. And it presupposes that people will
bother to actually run such a lint command.

You could always just hoist into an environment variable which neatly
gets rid of the ordering problem.

-Peff
