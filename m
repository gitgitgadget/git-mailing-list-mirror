From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: don't shift conflicts left and right
Date: Mon, 17 Jun 2013 13:44:26 -0700
Message-ID: <7vehc0bh79.fsf@alter.siamese.dyndns.org>
References: <1371339883-22775-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<7va9mqlvpu.fsf@alter.siamese.dyndns.org>
	<51BF71D4.402@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 17 22:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UogHz-0000V4-OZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 22:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab3FQUob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 16:44:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244Ab3FQUoa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jun 2013 16:44:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9202D2861B;
	Mon, 17 Jun 2013 20:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mbGdVnIyBUKU
	yP1kiE0zK9zen8Y=; b=xfllFhrfDzKS/Mti6fwM3v8OjuoSPhXhsYVArif/OcSi
	+O/2mXkIcTUQX0OQPeAkKjp41AAC0w0yxtvNzLqUSoyWPN/ObNEiM7Yqvy5UgRIO
	ZG2ep5GYeQa+S1UbjW/I0wQLCIBSprSOUzLZ8JC4Lg2f08/pyaoxLgrD4lX5jOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hoqz6W
	MYlGx2T4ciT3KG/z/pv0YFuQpJTN34EKYRETzX1VoNZdSej8aXUr6lq7hJJ2tP1g
	7+6e6UuS6WviJK39ww2V89qhZIFT95KE9FOpJY/zfHGQKRnB+RLlb8tCITfojJ22
	4AiUNRvmJs8xdCkfR6ammhi9J2uLMHjaVPybE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8665C28619;
	Mon, 17 Jun 2013 20:44:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8465228618;
	Mon, 17 Jun 2013 20:44:28 +0000 (UTC)
In-Reply-To: <51BF71D4.402@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon,
	17 Jun 2013 22:30:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B457F888-D78E-11E2-9B26-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228114>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> The information is only useful for the unpack_trees callback, and
>> "info->data" is a more appropriate place to hang such a callback
>> specific data.
>>=20
>> Perhaps we should use info->data field to point at
>>=20
>> 	struct {
>>          	struct unpack_trees_options *o;
>>          	unsigned long df_conflict;
>> 	};
>>=20
>> and get rid of info->conflicts field?
>
> Here's a patch that does so, but it complicates matters quite a bit.
> Did I miss anything (or rather: add too much)?

I do not think so.  These bits are needed per recursion level, and
it cannot be shoved into unpack_trees_options so I suspect that your
patch is the best we can do.  Or, perhaps we can

 - add df_conflict to struct unpack_trees_options;

 - have traverse_info->data point at struct unpack_trees_options as
   before; and

 - save the old value of o->df_conflict on the stack of
   traverse_trees_recursive(), update the field in place, and
   restore it when the recursion returns???

> ---
>  tree-walk.h    |  1 -
>  unpack-trees.c | 38 +++++++++++++++++++++++++++++---------
>  2 files changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/tree-walk.h b/tree-walk.h
> index ae04b64..4876695 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -46,7 +46,6 @@ struct traverse_info {
>  	int pathlen;
>  	struct pathspec *pathspec;
> =20
> -	unsigned long df_conflicts;
>  	traverse_callback_t fn;
>  	void *data;
>  	int show_all_errors;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index b27f2a6..1c1b4de 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -416,11 +416,17 @@ static int unpack_index_entry(struct cache_entr=
y *ce,
>  	return ret;
>  }
> =20
> +struct unpack_callback_info {
> +	struct unpack_trees_options *options;
> +	unsigned long df_conflicts;
> +};
> +
>  static int find_cache_pos(struct traverse_info *, const struct name_=
entry *);
> =20
>  static void restore_cache_bottom(struct traverse_info *info, int bot=
tom)
>  {
> -	struct unpack_trees_options *o =3D info->data;
> +	struct unpack_callback_info *uci =3D info->data;
> +	struct unpack_trees_options *o =3D uci->options;
> =20
>  	if (o->diff_index_cached)
>  		return;
> @@ -429,7 +435,8 @@ static void restore_cache_bottom(struct traverse_=
info *info, int bottom)
> =20
>  static int switch_cache_bottom(struct traverse_info *info)
>  {
> -	struct unpack_trees_options *o =3D info->data;
> +	struct unpack_callback_info *uci =3D info->data;
> +	struct unpack_trees_options *o =3D uci->options;
>  	int ret, pos;
> =20
>  	if (o->diff_index_cached)
> @@ -452,9 +459,14 @@ static int traverse_trees_recursive(int n, unsig=
ned long dirmask,
>  	int i, ret, bottom;
>  	struct tree_desc t[MAX_UNPACK_TREES];
>  	void *buf[MAX_UNPACK_TREES];
> +	struct unpack_callback_info *uci =3D info->data;
> +	struct unpack_callback_info newuci;
>  	struct traverse_info newinfo;
>  	struct name_entry *p;
> =20
> +	newuci =3D *uci;
> +	newuci.df_conflicts |=3D df_conflicts;
> +
>  	p =3D names;
>  	while (!p->mode)
>  		p++;
> @@ -464,7 +476,7 @@ static int traverse_trees_recursive(int n, unsign=
ed long dirmask,
>  	newinfo.pathspec =3D info->pathspec;
>  	newinfo.name =3D *p;
>  	newinfo.pathlen +=3D tree_entry_len(p) + 1;
> -	newinfo.df_conflicts |=3D df_conflicts;
> +	newinfo.data =3D &newuci;
> =20
>  	for (i =3D 0; i < n; i++, dirmask >>=3D 1) {
>  		const unsigned char *sha1 =3D NULL;
> @@ -564,8 +576,9 @@ static int unpack_nondirectories(int n, unsigned =
long mask,
>  				 const struct traverse_info *info)
>  {
>  	int i;
> -	struct unpack_trees_options *o =3D info->data;
> -	unsigned long conflicts =3D info->df_conflicts | dirmask;
> +	struct unpack_callback_info *uci =3D info->data;
> +	struct unpack_trees_options *o =3D uci->options;
> +	unsigned long conflicts =3D uci->df_conflicts | dirmask;
> =20
>  	/* Do we have *only* directories? Nothing to do */
>  	if (mask =3D=3D dirmask && !src[0])
> @@ -644,7 +657,8 @@ static int find_cache_pos(struct traverse_info *i=
nfo,
>  			  const struct name_entry *p)
>  {
>  	int pos;
> -	struct unpack_trees_options *o =3D info->data;
> +	struct unpack_callback_info *uci =3D info->data;
> +	struct unpack_trees_options *o =3D uci->options;
>  	struct index_state *index =3D o->src_index;
>  	int pfxlen =3D info->pathlen;
>  	int p_len =3D tree_entry_len(p);
> @@ -699,7 +713,8 @@ static struct cache_entry *find_cache_entry(struc=
t traverse_info *info,
>  					    const struct name_entry *p)
>  {
>  	int pos =3D find_cache_pos(info, p);
> -	struct unpack_trees_options *o =3D info->data;
> +	struct unpack_callback_info *uci =3D info->data;
> +	struct unpack_trees_options *o =3D uci->options;
> =20
>  	if (0 <=3D pos)
>  		return o->src_index->cache[pos];
> @@ -742,7 +757,8 @@ static void debug_unpack_callback(int n,
>  static int unpack_callback(int n, unsigned long mask, unsigned long =
dirmask, struct name_entry *names, struct traverse_info *info)
>  {
>  	struct cache_entry *src[MAX_UNPACK_TREES + 1] =3D { NULL, };
> -	struct unpack_trees_options *o =3D info->data;
> +	struct unpack_callback_info *uci =3D info->data;
> +	struct unpack_trees_options *o =3D uci->options;
>  	const struct name_entry *p =3D names;
> =20
>  	/* Find first entry with a real name (we could use "mask" too) */
> @@ -1054,11 +1070,15 @@ int unpack_trees(unsigned len, struct tree_de=
sc *t, struct unpack_trees_options
> =20
>  	if (len) {
>  		const char *prefix =3D o->prefix ? o->prefix : "";
> +		struct unpack_callback_info uci;
>  		struct traverse_info info;
> =20
> +		memset(&uci, 0, sizeof(uci));
> +		uci.options =3D o;
> +
>  		setup_traverse_info(&info, prefix);
>  		info.fn =3D unpack_callback;
> -		info.data =3D o;
> +		info.data =3D &uci;
>  		info.show_all_errors =3D o->show_all_errors;
>  		info.pathspec =3D o->pathspec;
> =20
