From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] describe: =?utf-8?B?RG9u4oCZ?= =?utf-8?Q?t?= look up
 commits with --exact-match
Date: Fri, 3 Dec 2010 02:43:48 -0600
Message-ID: <20101203084348.GD18202@burratino>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 09:44:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PORFV-0006DG-BF
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 09:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676Ab0LCIoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 03:44:06 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59576 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab0LCIoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 03:44:04 -0500
Received: by ywl5 with SMTP id 5so4637002ywl.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 00:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iKEfYdP6a1BBJ/ypfOekOuk8vHChqtCFzjSsxaxiS0U=;
        b=BQBk3wMYfBUXPCjZf+jMtISszQ2jd0ss4VQVLfccAUujxJxSF5y1NP3goZDVoofr12
         OmPGRJbrlOU3G+CIVwHPZ5fnBjHe56qU3xBfHN1S3zqmJcz5o72HscYMuqApE9HoxqCd
         CsccIpupBY3d/VA0DoAmQT0V8/jTqjTenVQmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mOSQMMQLgms0bVsHLqLLHhaacpjj4vXjVgfELTDuH8gYTDNFPsuQeQBDMkkXoFW4X3
         o1BrBTItKXStds9Oy1kZDVw0TbhHmhJzQbAzQMOOnPsjxkir/aKyB2vgC+e8Gaml5bb8
         ESdw6yAoV+rYo04MYcPFG0rrJ5x6zk8BRJBa0=
Received: by 10.100.238.8 with SMTP id l8mr1275694anh.119.1291365842150;
        Fri, 03 Dec 2010 00:44:02 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id c24sm1553923ana.30.2010.12.03.00.43.59
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 00:44:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162775>

(+cc: completion people, who might test; Thomas, who knows this
code well)

Anders Kaseorg wrote:

> This makes =E2=80=98git describe --exact-match HEAD=E2=80=99 about 15=
 times faster on
> a cold cache (2.3s instead of 35s) in a linux-2.6 repository with man=
y
> packed tags.  That=E2=80=99s a huge win for the interactivity of the =
__git_ps1
> shell prompt helper.

Nice.

> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -22,7 +22,7 @@ static int tags;	/* Allow lightweight tags */
>  static int longformat;
>  static int abbrev =3D DEFAULT_ABBREV;
>  static int max_candidates =3D 10;
> -static int found_names;
> +struct commit_name *names =3D NULL;

Nits:
 - static?
 - the convention in git is to leave off the zero-initializers
   for bss-allocated vars (static and globals).

> @@ -34,6 +34,8 @@ static const char *diff_index_args[] =3D {
> =20
> =20
>  struct commit_name {
> +	struct commit_name *next;
> +	unsigned char peeled[20];
>  	struct tag *tag;
>  	unsigned prio:2; /* annotated tag =3D 2, tag =3D 1, head =3D 0 */
>  	unsigned name_checked:1;

Hm, so the tags read so far will be stored in the "names" list.

> @@ -240,7 +231,12 @@ static void describe(const char *arg, int last_o=
ne)
>  	if (!cmit)
>  		die("%s is not a valid '%s' object", arg, commit_type);
> =20
> -	n =3D cmit->util;
> +	n =3D NULL;
> +	for (e =3D names; e; e =3D e->next) {
> +		if (hashcmp(e->peeled, cmit->object.sha1) =3D=3D 0 &&

The usual convention is to use !hashcmp(...) to match the !strcmp(...)
idiom.

> +		    replace_name(n, e->prio, e->sha1, &e->tag))
> +			n =3D e;
> +	}

Instead of looking up the commit to be matched exactly in the commits
hash table, this makes a linear search.

No change to the assymptotic running time, but would this make things
much slower in the case of many tags?  How many before it's a problem
(if ever)?  (If it's a problem in ordinary cases, I think the
optimization could be limited to --exact-match pretty easily.)

> @@ -259,6 +255,12 @@ static void describe(const char *arg, int last_o=
ne)
>  	if (debug)
>  		fprintf(stderr, "searching to describe %s\n", arg);
> =20
> +	for (e =3D names; e; e =3D e->next) {
> +		struct commit *c =3D lookup_commit_reference_gently(e->peeled, 1);
> +		if (c && replace_name(c->util, e->prio, e->sha1, &e->tag))
> +			c->util =3D e;
> +	}

=46illing the commits table in preparation for object traversal.  Now
the world's back to normal.

> @@ -418,8 +420,8 @@ int cmd_describe(int argc, const char **argv, con=
st char *prefix)
>  		return cmd_name_rev(i + argc, args, prefix);
>  	}
> =20
> -	for_each_ref(get_name, NULL);
> +	for_each_rawref(get_name, NULL);

Orthogonal change snuck in?

> -	if (!found_names && !always)
> +	if (!names && !always)

Everything else looks good and very readable.
