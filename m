From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] revert: add --stdin option to read commits from stdin
Date: Tue, 15 Jun 2010 05:28:05 +0200
Message-ID: <201006150528.05265.chriscool@tuxfamily.org>
References: <20100614032251.20121.83253.chriscool@tuxfamily.org> <20100614052027.GA1509@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 05:36:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOMx8-0006Wr-KL
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 05:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab0FODge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 23:36:34 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39270 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab0FODgd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 23:36:33 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0E90F81801E;
	Tue, 15 Jun 2010 05:36:24 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <20100614052027.GA1509@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149154>

On Monday 14 June 2010 07:20:27 Jonathan Nieder wrote:
> Christian Couder wrote:
> > --- a/t/t3508-cherry-pick-many-commits.sh
> > +++ b/t/t3508-cherry-pick-many-commits.sh
> > @@ -92,4 +92,14 @@ test_expect_failure 'cherry-pick -3 fourth works=
' '
> >  	test "$(git rev-parse --verify HEAD)" !=3D "$(git rev-parse --ver=
ify
> > fourth)" '
> >
> > +test_expect_success 'cherry-pick --stdin works' '
> > +	git checkout master &&
> > +	git reset --hard first &&
>=20
> [...]
>=20
> This test fails for me as written, since the previous test leaves som=
e
> files in an unmerged state.  Patch 1 below works around that.

Ok.

> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -79,7 +80,7 @@ static void parse_args(int argc, const char **arg=
v)
> >  	}
> >
> >  	commit_argc =3D parse_options(argc, argv, NULL, options, usage_st=
r, 0);
>=20
> [...]
>=20
> > @@ -527,10 +528,12 @@ static void prepare_revs(struct rev_info *rev=
s)
> >  {
> >  	int argc =3D 0;
> >  	int i;
> > -	const char **argv =3D xmalloc((commit_argc + 4) * sizeof(*argv));
> > +	const char **argv =3D xmalloc((commit_argc + 5) * sizeof(*argv));
> >
> >  	argv[argc++] =3D NULL;
> >  	argv[argc++] =3D "--no-walk";
> > +	if (read_stdin)
> > +		argv[argc++] =3D "--stdin";
>=20
> Ah, I see the problem now.  But it would be even nicer to allow arbit=
rary
> rev-list options, so a person could =E2=80=98git cherry-pick --revers=
e a..b=E2=80=99,
> for example.

Yeah, I agree that is nicer.

> In other words, how about something like patch 2 below?
>=20
> Patch 3 is a small cleanup, as a bonus.
>=20
> Christian Couder (1):
>   revert: accept arbitrary rev-list options
>=20
> Jonathan Nieder (2):
>   t3508 (cherry-pick): futureproof against unmerged files
>   revert: do not rebuild argv on heap

I get "indent with spaces" errors when I apply patches 2/3 and 3/3:

$ git am ../messages/\[PATCH\ 2_3\]\ revert_\ accept\ arbitrary\ rev-li=
st\=20
options.mbox
Applying: revert: accept arbitrary rev-list options                    =
                                                 =20
/home/christian/work/git/.git/rebase-apply/patch:35: indent with spaces=
=2E                                                =20
                                    PARSE_OPT_KEEP_UNKNOWN); =20

$ git am ../messages/\[PATCH\ 3_3\]\ revert_\ do\ not\ rebuild\ argv\ o=
n\=20
heap.mbox
Applying: revert: do not rebuild argv on heap                          =
                                             =20
/home/christian/work/git/.git/rebase-apply/patch:33: indent with spaces=
=2E                                            =20
                                    PARSE_OPT_KEEP_ARGV0 |             =
                                             =20
warning: 1 line adds whitespace errors.

But otherwise it all looks very good to me.

Even something like "git cherry-pick -3 fourth" is now working after pa=
tch=20
2/3, so all test cases now pass. This is because "--no-walk" does not a=
lways=20
take over "-3" it looks like it depends on the order of the arguments.

=46or example I get:

$ git rev-list --no-walk -3 --reverse fourth
453a04748224b3f212580d1195b452334d346e75
e85abe28a2b8ef771f760575b325f4c41f9c815f
94d3184b3f0dcfebb393faf5a122dc429d775538

but:

$ git rev-list -3 --no-walk --reverse fourth
94d3184b3f0dcfebb393faf5a122dc429d775538

I will post an updated v2 series without the whitespace errors and with=
 a few=20
documentation and test updates in patch 2/3.

Thanks,
Christian.
