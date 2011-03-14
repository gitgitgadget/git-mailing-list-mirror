From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 2/3] setup_path(): Free temporary buffer
Date: Mon, 14 Mar 2011 23:01:53 +0100
Message-ID: <1300140119.4320.38.camel@bee.lab.cmartin.tk>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
	 <1300130318-11279-3-git-send-email-cmn@elego.de>
	 <7v7hc1cvdt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 23:11:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzFyo-0003Ez-Ri
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 23:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372Ab1CNWLB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 18:11:01 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:45981 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab1CNWLA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 18:11:00 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Mar 2011 18:11:00 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 505DC1B4B8D;
	Mon, 14 Mar 2011 23:02:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ReZNT1BF4v6k; Mon, 14 Mar 2011 23:01:59 +0100 (CET)
Received: from [192.168.1.16] (brln-4dbc728c.pool.mediaWays.net [77.188.114.140])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 8BCFE1B4B52;
	Mon, 14 Mar 2011 23:01:59 +0100 (CET)
In-Reply-To: <7v7hc1cvdt.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169028>

On lun, 2011-03-14 at 13:14 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> [...]
>=20
>     Update only one caller setup_path() to follow the new API, but le=
ave
>     other callers to leak even in normal cases.  The caller in git.c =
exits
>     immediately after using it, so we don't care about the leak there
>     anyway.  Also help.c has a few calls to it but the number of call=
s to
>     the function is small and bounded, so the leak is small and we do=
n't
>     care.

 Oops. I blindly tested the path only on the test case where it was
triggering an error without it and completely missed the other uses,
which is embarrassing.

>=20
>=20
> And then reviewers can agree or disagree if the small leaks in git.c =
(just
> one string allocation that immediately is followed by exit after its =
use)
> and help.c (in list_commands() and load_commands_list(), neither of w=
hich
> is called millions of times anyway) are OK to accept.
>=20
> I tend to think they are Ok, but then I also tend to think one leak o=
f
> exec-path return value in setup_path() is perfectly fine for the same
> reason, so in that sense I don't see a point in this patch...

 Which brings us to the matter of whether we actually care about memory
leaks, as the processes are short-lived and the system is going to clea=
n
up after us. Do we, unless the leaks are huge? As there is built-in
valgrind support in the test suite, I went in with the assumption that
we did. It seems however that hardly any code paths free their memory,
other than when using strbuf.

 In case we don't, valgrind should be told not to bother reporting leak=
s
(and maybe mention in some document that small leaks are not an issue).

>=20
> > diff --git a/exec_cmd.c b/exec_cmd.c
> > index 38545e8..c16c3d4 100644
> > --- a/exec_cmd.c
> > +++ b/exec_cmd.c
> > @@ -73,11 +73,11 @@ const char *git_exec_path(void)
> >  	const char *env;
> > =20
> >  	if (argv_exec_path)
> > -		return argv_exec_path;
> > +		return xstrdup(argv_exec_path);
> > =20
> >  	env =3D getenv(EXEC_PATH_ENVIRONMENT);
> >  	if (env && *env) {
> > -		return env;
> > +		return xstrdup(env);
> >  	}
> > =20
> >  	return system_path(GIT_EXEC_PATH);
> > @@ -99,10 +99,13 @@ void setup_path(void)
> >  {
> >  	const char *old_path =3D getenv("PATH");
> >  	struct strbuf new_path =3D STRBUF_INIT;
> > +	char *exec_path =3D (char *) git_exec_path();
> > =20
> > -	add_path(&new_path, git_exec_path());
> > +	add_path(&new_path, exec_path);
> >  	add_path(&new_path, argv0_path);
> > =20
> > +	free(exec_path);
> > +
> >  	if (old_path)
> >  		strbuf_addstr(&new_path, old_path);
> >  	else
