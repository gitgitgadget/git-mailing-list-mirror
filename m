From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 6/9] builtin-init-db.c: use parse_options()
Date: Fri, 25 Jul 2008 17:20:37 +0200
Message-ID: <4889EF45.1040603@free.fr>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-7-git-send-email-barra_cuda@katamail.com> <4888AAB2.5050007@free.fr> <200807242207.02195.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 17:22:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMP86-0006A2-Tp
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 17:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbYGYPVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbYGYPVv
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 11:21:51 -0400
Received: from postfix2-g20.free.fr ([212.27.60.43]:34195 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbYGYPVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 11:21:50 -0400
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 097AB2860D83
	for <git@vger.kernel.org>; Fri, 25 Jul 2008 15:21:31 +0200 (CEST)
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 37C2432A825;
	Fri, 25 Jul 2008 17:20:38 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 04D5332A866;
	Fri, 25 Jul 2008 17:20:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <200807242207.02195.barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90059>

Michele Ballabio a =E9crit :
>=20
>>> +		  PARSE_OPT_OPTARG, parse_opt_shared_cb, PERM_GROUP },
>> Are you sure the default value is really used here?
>=20
> Yes. Perhaps I don't understand your question. Can you explain what y=
ou mean?

If I read the code correctly in parse-options.c, with OPTION_CALLBACK, =
the
default value is not "automatically" used. You can use it in your callb=
ack
if you want, but because you don't, I think it's never used.

> Would you like this better, with PARSE_OPT_NONEG?

No, I'm fine with the negated option.

> Or do you prefer changing the callback like this:
>=20
> +static int parse_opt_shared_cb(const struct option *opt, const char =
*arg,
> +                              int unset)
> +{
> +       *(int *)(opt->value) =3D unset ? PERM_UMASK : git_config_perm=
("arg", arg);
> +       return 0;
> +}

I think it's better but what I suggested is more something like:

static int parse_opt_shared_cb(const struct option *opt, const char *ar=
g,
			       int unset)
{
	*(int *)(opt->value) =3D unset ? -1 : git_config_perm("arg", arg);
	return 0;
}

int shared =3D -1;

{ OPTION_CALLBACK, 0, "shared", &shared,
	"permissions", "setup as shared repository",
	PARSE_OPT_OPTARG, parse_perm_callback },

if (shared >=3D 0)
	shared_repository =3D shared;

This way we do not change shared_repository during parsing, so we do no=
t
loose the initial value.

But it seems nobody care about this kind of details, so perhaps, you ca=
n
just ignore this suggestion.

Olivier.
