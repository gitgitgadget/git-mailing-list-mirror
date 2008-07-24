From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 6/9] builtin-init-db.c: use parse_options()
Date: Thu, 24 Jul 2008 22:07:01 +0200
Message-ID: <200807242207.02195.barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-7-git-send-email-barra_cuda@katamail.com> <4888AAB2.5050007@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:01:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM70O-0001YS-BA
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYGXUAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 16:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbYGXUAk
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:00:40 -0400
Received: from smtp.katamail.com ([62.149.157.154]:45293 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751431AbYGXUAj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2008 16:00:39 -0400
Received: (qmail 7637 invoked by uid 89); 24 Jul 2008 20:00:30 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host59-56-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.59)
  by smtp2-pc with SMTP; 24 Jul 2008 20:00:27 -0000
User-Agent: KMail/1.9.9
In-Reply-To: <4888AAB2.5050007@free.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89951>

On Thursday 24 July 2008, Olivier Marin wrote:
> Michele Ballabio a =E9crit :
> >=20
> > +	const struct option options[] =3D {
> > +		OPT_STRING(0, "template", &template_dir, "dir",
> > +			   "directory from which templates will be used"),
>=20
> Perhaps "path", "path to the template repository" to stay consistent =
with clone.

Ok.

> > +		OPT_BOOLEAN(0, "bare", &bare, "set up a bare repo"),
>=20
> s/set up/setup/ and s/repo/repository/?

I think "set up a bare repository" will be fine.

> > +		{ OPTION_CALLBACK, 0, "shared", &shared_repository,
> > +		  "type", "type of shared repository",
>=20
> What about "permissions", "setup a shared repository"?

Ok, but with s/setup/set up/.

> > +		  PARSE_OPT_OPTARG, parse_opt_shared_cb, PERM_GROUP },
>=20
> Are you sure the default value is really used here?

Yes. Perhaps I don't understand your question. Can you explain what you=
 mean?

> Also, perhaps we can play it safer by avoiding changing "share_reposi=
tory"
> directly.
>=20
> $ git init -> shared_repository =3D=3D PERM_UMASK
> $ git init --shared --no-shared -> shared_repository =3D=3D 0
>=20
> It works because PERM_UMASK =3D=3D 0, but it is a side effect. Don't =
you think?

Would you like this better, with PARSE_OPT_NONEG?

+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0{ OPTION_CALLBACK, 0, "sh=
ared", &shared_repository,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0"permissions", "set u=
p a shared repository",
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0PARSE_OPT_OPTARG | PA=
RSE_OPT_NONEG, parse_opt_shared_cb, PERM_GROUP },

Or do you prefer changing the callback like this:

+static int parse_opt_shared_cb(const struct option *opt, const char *a=
rg,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0 =A0 int unset)
+{
+=A0=A0=A0=A0=A0=A0=A0*(int *)(opt->value) =3D unset ? PERM_UMASK : git=
_config_perm("arg", arg);
+=A0=A0=A0=A0=A0=A0=A0return 0;
+}

> > +		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
>=20
> OPT__QUIET(&quiet),
>=20
> if (quiet)
> 	flags |=3D INIT_DB_QUIET;
>=20
> to use the same quiet option everywhere?

I thought about it and decided against ;)
And it's one line vs four (counting "int quiet =3D 0;"). But I see your=
 point.
