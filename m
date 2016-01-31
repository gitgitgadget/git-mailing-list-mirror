From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/1] support -4 and -6 switches for remote operations
Date: Sun, 31 Jan 2016 00:01:44 +0000
Message-ID: <20160131000144.GA10117@dcvr.yhbt.net>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
 <20160130085056.GA20118@dcvr.yhbt.net>
 <20160130131353.GA20429@dcvr.yhbt.net>
 <56AD4887.3070207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 31 01:02:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPfTC-0005qX-Rf
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 01:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbcAaABq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2016 19:01:46 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33908 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757162AbcAaABp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 19:01:45 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 2FCC81F736;
	Sun, 31 Jan 2016 00:01:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56AD4887.3070207@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285131>

Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
> On 2016-01-30 14.13, Eric Wong wrote:
> > The ssh(1) command has an equivalent switches which we may
> > pass when we run them.

> Should we mention that putty and tortoiseplink don't have these optio=
ns ?
> At least in the commit message ?

Sure, will remember for v2 and document in the manpages.

Curious, do these ssh implementations throw out a meaningful error
message when given these options?

> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -47,6 +47,7 @@ static const char *real_git_dir;
> >  static char *option_upload_pack =3D "git-upload-pack";
> >  static int option_verbosity;
> >  static int option_progress =3D -1;
> > +static int ipv4, ipv6;
> Do we need 2 variables here ?

Yes, I'm not sure how else to use OPT_BOOL below...

> Or would
> int preferred_ip_version
> be better ?
> >  static struct string_list option_config;
> >  static struct string_list option_reference;
> >  static int option_dissociate;
> > @@ -92,6 +93,8 @@ static struct option builtin_clone_options[] =3D =
{
> >  		   N_("separate git dir from working tree")),
> >  	OPT_STRING_LIST('c', "config", &option_config, N_("key=3Dvalue"),
> >  			N_("set config inside the new repository")),
> > +	OPT_BOOL('4', "ipv4", &ipv4, N_("resolve IPv4 addresses only")),
> > +	OPT_BOOL('6', "ipv6", &ipv6, N_("resolve IPv6 addresses only")),
> Technically OK to mention resolve, but does it give any information t=
o the user ?
> s/resolve IPv4 addresses only/use IPv4 addresses only/

I suppose "use" is shorter and just as informational.
Will prepare that for v2.

> > @@ -970,6 +973,7 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
> >  	remote =3D remote_get(option_origin);
> >  	transport =3D transport_get(remote, remote->url[0]);
> >  	transport_set_verbosity(transport, option_verbosity, option_progr=
ess);
> > +	transport_set_family(transport, ipv4, ipv6);
> > =20
> Does it make sense to name the variable into
> ipv4only (to make clear that it does not mean ipv4_allowed ?)
> (and similar in the rest of the code)

I actually had "only" in the variables originally, but didn't want to
line-wrap in builtin/push.c

=46urthermore, the non-"only" name is used by the long switch (just lik=
e
in both curl(1) and rsync(1)), so I figured we should remain consistent
with what the user will see in documentation.

I think I will drop "ONLY" from the CONNECT_* macros instead...

Will await further comments and prepare v2 in a day or two.
Thanks for the comments.
