From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH, fixed] builtin-clone: create remotes/origin/HEAD
	symref, if guessed
Date: Mon, 03 Mar 2008 12:05:13 -0500
Message-ID: <1204563913.4084.3.camel@gaara.boston.redhat.com>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
	 <200802260321.14038.johan@herland.net>
	 <alpine.LNX.1.00.0802261128360.19024@iabervon.org>
	 <alpine.LSU.1.00.0803020556380.22527@racer.site>
	 <alpine.LSU.1.00.0803020622190.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Santi =?ISO-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:07:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWE7c-00080a-2w
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbYCCRFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 12:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbYCCRFe
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 12:05:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57654 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbYCCRFd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 12:05:33 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m23H5JBI014770;
	Mon, 3 Mar 2008 12:05:19 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m23H5JhB020137;
	Mon, 3 Mar 2008 12:05:19 -0500
Received: from [192.168.1.104] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m23H5IRK013242;
	Mon, 3 Mar 2008 12:05:18 -0500
In-Reply-To: <alpine.LSU.1.00.0803020622190.22527@racer.site>
X-Mailer: Evolution 2.21.91 (2.21.91-2.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75947>

On Sun, 2008-03-02 at 06:25 +0000, Johannes Schindelin wrote:
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>=20
> 	Sorry, my previous patch was broken in so many ways.  This one
> 	is better, promise.
>=20
> 	BTW this incidentally fixes the branch.<branch>.{remote,merge}=20
> 	setup: it used to strip all up-to and including a slash from the=20
> 	ref name.  This just _happened_ to work, because commonly HEAD is=20
> 	at "refs/heads/master".  However, if it is at "refs/heads/a/b", it=20
> 	would fail.
>=20
>  builtin-clone.c |   35 ++++++++++++++++++++---------------
>  1 files changed, 20 insertions(+), 15 deletions(-)
>=20
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 056e8a3..f27d205 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -523,33 +523,38 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
>  		git_config_set_multivar(key, value, "^$", 0);
>  	}
> =20
> +	if (head_points_at)
> +		/* Local default branch */
> +		create_symref("HEAD", head_points_at->name, NULL);
> +
>  	if (option_bare) {
> -		if (head_points_at) {
> -			/* Local default branch */
> -			create_symref("HEAD", head_points_at->name, NULL);
> -		}
>  		junk_work_tree =3D NULL;
>  		junk_git_dir =3D NULL;
>  		return 0;
>  	}
> =20
>  	if (head_points_at) {
> -		if (strrchr(head_points_at->name, '/'))
> -			head =3D strrchr(head_points_at->name, '/') + 1;
> -		else
> -			head =3D head_points_at->name;
> +		struct strbuf head_ref, real_ref;
> =20
> -		/* Local default branch */
> -		create_symref("HEAD", head_points_at->name, NULL);
> +		head =3D head_points_at->name;
> +		if (!prefixcmp(head, "refs/heads/"))
> +			head +=3D 11;
> =20
>  		/* Tracking branch for the primary branch at the remote. */
>  		update_ref(NULL, "HEAD", head_points_at->old_sha1,
>  			   NULL, 0, DIE_ON_ERR);
> -	/*
> -		rm -f "refs/remotes/$origin/HEAD"
> -		git symbolic-ref "refs/remotes/$origin/HEAD" \
> -			"refs/remotes/$origin/$head_points_at" &&
> -	*/
> +
> +		strbuf_init(&head_ref, 0);
> +		strbuf_addstr(&head_ref, branch_top);
> +		strbuf_addstr(&head_ref, "/HEAD");
> +		delete_ref(head_ref.buf, head_points_at->old_sha1);
> +		strbuf_init(&real_ref, 0);
> +		strbuf_addstr(&real_ref, branch_top);
> +		strbuf_addch(&real_ref, '/');
> +		strbuf_addstr(&real_ref, head);

What about just using

  strbuf_addf(&real_ref, "%s/%s", branch_top, head);

Are you worried about performance? :-p

Oh and I'm wondering if

  strbuf_initf(&real_ref,=EF=BB=BF "%s/%s", branch_top, head);

would be a worthwhile addition to the strbuf API...

Kristian

