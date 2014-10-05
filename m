From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 12/16] sha1_file: add for_each iterators for loose and
 packed objects
Date: Sun, 05 Oct 2014 10:15:06 +0200
Message-ID: <5430FE0A.4010806@web.de>
References: <20141003202045.GA15205@peff.net> <20141003203219.GL16293@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 10:16:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XagzQ-0000CO-14
	for gcvg-git-2@plane.gmane.org; Sun, 05 Oct 2014 10:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbaJEIQS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2014 04:16:18 -0400
Received: from mout.web.de ([212.227.17.11]:57848 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbaJEIQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2014 04:16:16 -0400
Received: from [192.168.178.27] ([79.253.129.50]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MXpZD-1XgtJb3KcB-00Wkny; Sun, 05 Oct 2014 10:16:12
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <20141003203219.GL16293@peff.net>
X-Provags-ID: V03:K0:VhXsILqbleXPq8ZrzrK5wWXto0UAuJ3aSFFqklj4UmhMoTg+W+G
 yjmhNlDSqTcZgsTeOFuz2b+0iXjTvmJNvsyjWTYr/fygWzHyJMKCgwq8qzG0Hd+S0bITNrK
 Fvd0sj38hCMhnyU7bGjxizr6+UDIP7GIMt1z/AyryB7XrKmYqhkgwY6eDTj1Kqn3dITQy2I
 8oB5+/3hZ8tL3cu6FFssA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257896>

Am 03.10.2014 um 22:32 schrieb Jeff King:
> We typically iterate over the reachable objects in a
> repository by starting at the tips and walking the graph.
> There's no easy way to iterate over all of the objects,
> including unreachable ones. Let's provide a way of doing so.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   cache.h     | 11 +++++++++++
>   sha1_file.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
>   2 files changed, 73 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 7abe7f6..3826b4b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1270,6 +1270,17 @@ int for_each_loose_file_in_objdir(const char *=
path,
>   				  each_loose_subdir_fn subdir_cb,
>   				  void *data);
>
> +/*
> + * Iterate over loose and packed objects in both the local
> + * repository and any alternates repositories.
> + */
> +typedef int each_packed_object_fn(const unsigned char *sha1,
> +				  struct packed_git *pack,
> +				  uint32_t pos,
> +				  void *data);
> +extern int for_each_loose_object(each_loose_object_fn, void *);
> +extern int for_each_packed_object(each_packed_object_fn, void *);
> +
>   struct object_info {
>   	/* Request */
>   	enum object_type *typep;
> diff --git a/sha1_file.c b/sha1_file.c
> index 9fdad47..d017289 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3313,3 +3313,65 @@ int for_each_loose_file_in_objdir(const char *=
path,
>   	strbuf_release(&buf);
>   	return r;
>   }
> +
> +struct loose_alt_odb_data {
> +	each_loose_object_fn *cb;
> +	void *data;
> +};
> +
> +static int loose_from_alt_odb(struct alternate_object_database *alt,
> +			      void *vdata)
> +{
> +	struct loose_alt_odb_data *data =3D vdata;
> +	return for_each_loose_file_in_objdir(alt->base,
> +					     data->cb, NULL, NULL,
> +					     data->data);
> +}
> +
> +int for_each_loose_object(each_loose_object_fn cb, void *data)
> +{
> +	struct loose_alt_odb_data alt;
> +	int r;
> +
> +	r =3D for_each_loose_file_in_objdir(get_object_directory(),
> +					  cb, NULL, NULL, data);
> +	if (r)
> +		return r;
> +
> +	alt.cb =3D cb;
> +	alt.data =3D data;
> +	return foreach_alt_odb(loose_from_alt_odb, &alt);
> +}
> +
> +int for_each_object_in_pack(struct packed_git *p, each_packed_object=
_fn cb, void *data)

Should this one be declared static?  It seems to be used only in=20
sha1_file.c.

> +{
> +	uint32_t i;
> +	int r =3D 0;
> +
> +	for (i =3D 0; i < p->num_objects; i++) {
> +		const unsigned char *sha1 =3D nth_packed_object_sha1(p, i);
> +
> +		if (!sha1)
> +			return error("unable to get sha1 of object %u in %s",
> +				     i, p->pack_name);
> +
> +		r =3D cb(sha1, p, i, data);
> +		if (r)
> +			break;
> +	}
> +	return r;
> +}
> +
> +int for_each_packed_object(each_packed_object_fn cb, void *data)
> +{
> +	struct packed_git *p;
> +	int r =3D 0;
> +
> +	prepare_packed_git();
> +	for (p =3D packed_git; p; p =3D p->next) {
> +		r =3D for_each_object_in_pack(p, cb, data);
> +		if (r)
> +			break;
> +	}
> +	return 0;
> +}

Perhaps return r instead here?

Ren=C3=A9
