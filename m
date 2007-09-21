From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 6/7] Export rerere() and launch_editor().
Date: Fri, 21 Sep 2007 14:01:18 -0400
Message-ID: <1190397678.31494.57.camel@hinata.boston.redhat.com>
References: <1190074008617-git-send-email-krh@redhat.com>
	 <1190074014548-git-send-email-krh@redhat.com>
	 <11900740142347-git-send-email-krh@redhat.com>
	 <11900740153845-git-send-email-krh@redhat.com>
	 <11900740154136-git-send-email-krh@redhat.com>
	 <1190074016669-git-send-email-krh@redhat.com>
	 <7vr6kunrh7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 20:02:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYmpL-0002G2-54
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 20:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbXIUSCB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Sep 2007 14:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbXIUSCA
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 14:02:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42128 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbXIUSB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 14:01:59 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8LI1P9S031829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Sep 2007 14:01:25 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8LI1O5d008027;
	Fri, 21 Sep 2007 14:01:24 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8LI1NVD012467;
	Fri, 21 Sep 2007 14:01:23 -0400
In-Reply-To: <7vr6kunrh7.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58865>

On Wed, 2007-09-19 at 16:52 -0700, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > +/* Export for builtin-commit. */
> > +int rerere(void)
> > +{
> > +	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
> > +	int fd;
> > +
> > +	git_config(git_rerere_config);
> > +	if (!is_rerere_enabled())
> > +		return 0;
> > +
> > +	merge_rr_path =3D xstrdup(git_path("rr-cache/MERGE_RR"));
> > +	fd =3D hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
> > +	read_rr(&merge_rr);
> > +	return do_plain_rerere(&merge_rr, fd);
> > +}
>=20
> Is it just me who sees a suboptimal cut and paste here?
>=20
> BTW, [1-5/7] look good so far.
>=20
> diff --git a/builtin-rerere.c b/builtin-rerere.c
> index 29d057c..2f51ae0 100644
> --- a/builtin-rerere.c
> +++ b/builtin-rerere.c
> @@ -415,18 +415,39 @@ static int is_rerere_enabled(void)
>  	return 1;
>  }
> =20
> -int cmd_rerere(int argc, const char **argv, const char *prefix)
> +static int setup_rerere(struct path_list *merge_rr)
>  {
> -	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
> -	int i, fd =3D -1;
> +	int fd;
> =20
>  	git_config(git_rerere_config);
>  	if (!is_rerere_enabled())
> -		return 0;
> +		return -1;
> =20
>  	merge_rr_path =3D xstrdup(git_path("rr-cache/MERGE_RR"));
>  	fd =3D hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
> -	read_rr(&merge_rr);
> +	read_rr(merge_rr);
> +	return fd;
> +}
> +
> +int rerere(void)
> +{
> +	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
> +	int fd;
> +
> +	fd =3D setup_rerere(&merge_rr);
> +	if (fd < 0)
> +		return 0;
> +	return do_plain_rerere(&merge_rr, fd);
> +}
> +
> +int cmd_rerere(int argc, const char **argv, const char *prefix)
> +{
> +	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
> +	int i, fd;
> +
> +	fd =3D setup_rerere(&merge_rr);
> +	if (fd < 0)
> +		return 0;
> =20
>  	if (argc < 2)
>  		return do_plain_rerere(&merge_rr, fd);

That looks better, yes.

Kristian
