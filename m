From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Wed, 16 Mar 2011 17:24:21 +0100
Message-ID: <1300292667.7214.43.camel@bee.lab.cmartin.tk>
References: <20110314200958.GC22602@sigill.intra.peff.net>
	 <1300274770-4798-1-git-send-email-cmn@elego.de>
	 <AANLkTinEMzezKdfGUrwKv7sJ+tSK5duYM6XZMvBa-yj3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 16 17:24:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PztWZ-0006zr-9O
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441Ab1CPQYd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 12:24:33 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:47308 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1CPQYc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 12:24:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 67E711B4AFF;
	Wed, 16 Mar 2011 17:24:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6BxqYeH6lO24; Wed, 16 Mar 2011 17:24:26 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id C9EDC1B4ABA;
	Wed, 16 Mar 2011 17:24:25 +0100 (CET)
In-Reply-To: <AANLkTinEMzezKdfGUrwKv7sJ+tSK5duYM6XZMvBa-yj3@mail.gmail.com>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169168>

On mi=C3=A9, 2011-03-16 at 16:58 +0100, Erik Faye-Lund wrote:
> On Wed, Mar 16, 2011 at 12:26 PM, Carlos Mart=C3=ADn Nieto <cmn@elego=
=2Ede> wrote:
> > Make system_path behave like the other path functions by using a
> > static buffer, fixing a memory leak.
> >
> > Also make sure the prefix pointer is always initialized to either
> > PREFIX or NULL.
> >
> > Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> > ---
> >
> > This fixes the leak I was trying to fix with my original patch, but
> > this seems much cleaner
> >
> >  exec_cmd.c |    9 ++++-----
> >  1 files changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/exec_cmd.c b/exec_cmd.c
> > index 38545e8..12ce017 100644
> > --- a/exec_cmd.c
> > +++ b/exec_cmd.c
> > @@ -9,11 +9,11 @@ static const char *argv0_path;
> >  const char *system_path(const char *path)
> >  {
> >  #ifdef RUNTIME_PREFIX
> > -       static const char *prefix;
> > +       static const char *prefix =3D NULL;
> >  #else
> >        static const char *prefix =3D PREFIX;
> >  #endif
> > -       struct strbuf d =3D STRBUF_INIT;
> > +       static char buf[PATH_MAX+1];
>=20
> Why PATH_MAX + 1? POSIX says that PATH_MAX includes the null-terminat=
ion...

 A lot of other code I've been looking at uses it. I was not aware it
included the terminator.

>=20
> > @@ -33,9 +33,8 @@ const char *system_path(const char *path)
> >        }
> >  #endif
> >
> > -       strbuf_addf(&d, "%s/%s", prefix, path);
> > -       path =3D strbuf_detach(&d, NULL);
> > -       return path;
> > +       snprintf(buf, PATH_MAX, "%s/%s", prefix, path);
>=20
> Perhaps "snprintf(buf, sizeof(buf) - 1, "%s/%s", prefix, path);" inst=
ead?

 The manpage states that the size parameter includes the
null-terminator, so sizeof(buf) would be better, I think. I'll send out
a new mail with the updated patch.

 Shouldn't we check to see if there was truncation (i.e. return value >=
=3D
sizeof(buf)) and die in that case?
