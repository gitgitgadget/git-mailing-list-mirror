From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 05/38] pack v4: add commit object parsing
Date: Thu, 5 Sep 2013 12:30:11 +0200
Message-ID: <20130905103011.GA20919@goldbirke>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378362001-1738-6-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 12:30:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHWpf-000769-2e
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 12:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238Ab3IEKa1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 06:30:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:55777 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965234Ab3IEKaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 06:30:24 -0400
Received: from localhost6.localdomain6 (84-236-67-158.pool.digikabel.hu [84.236.67.158])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MRSY4-1VO5LX3c7s-00StLu; Thu, 05 Sep 2013 12:30:12 +0200
Content-Disposition: inline
In-Reply-To: <1378362001-1738-6-git-send-email-nico@fluxnic.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:aEqEo7ivZ13G8vZ/2Zsur3N7QgRCQu4a8NK7WTgHG4s
 5y1Fu7Huk/+8vOBHKTjLxBNt/JeFFaDSo7e8n5h+EmBU5L8iBC
 zQGGI1EN58d1Uracoo++I8ZwJw5U73LlCrSjHEHjSuEVkP1j+A
 M8U1iaHrgWQzfkjnr7fekC8qKibKaMH7VPkiR4VrfwItdQpCZJ
 cSeKC5+TO6xgB9tKWlFqySS/hM7Wc7rvwNFRkbLtVutrH85s8V
 ta9xdsd/Gxt6MRSOeovbLgOLi/CWER/VXoCEr750VgJMBTDjSJ
 3utKWf3ubi5QH/chvDCYUo3L9sSLOIaIQRZJptVSkRxdFjRSFg
 SVd32+XCw/AZ47xEAfYP+dN4ub+VSCAa/esIx5YCi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233951>

Hi,


On Thu, Sep 05, 2013 at 02:19:28AM -0400, Nicolas Pitre wrote:
> Let's create another dictionary table to hold the author and committe=
r
> entries.  We use the same table format used for tree entries where th=
e
> 16 bit data prefix is conveniently used to store the timezone value.
>=20
> In order to copy straight from a commit object buffer, dict_add_entry=
()
> is modified to get the string length as the provided string pointer i=
s
> not always be null terminated.
>=20
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
>  packv4-create.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++=
++++------
>  1 file changed, 89 insertions(+), 9 deletions(-)
>=20
> diff --git a/packv4-create.c b/packv4-create.c
> index eccd9fc..5c08871 100644
> --- a/packv4-create.c
> +++ b/packv4-create.c
> @@ -1,5 +1,5 @@
>  /*
> - * packv4-create.c: management of dictionary tables used in pack v4
> + * packv4-create.c: creation of dictionary tables and objects used i=
n pack v4
>   *
>   * (C) Nicolas Pitre <nico@fluxnic.net>
>   *
> @@ -80,9 +80,9 @@ static void rehash_entries(struct dict_table *t)
>  	}
>  }
> =20
> -int dict_add_entry(struct dict_table *t, int val, const char *str)
> +int dict_add_entry(struct dict_table *t, int val, const char *str, i=
nt str_len)
>  {
> -	int i, val_len =3D 2, str_len =3D strlen(str) + 1;
> +	int i, val_len =3D 2;
> =20
>  	if (t->ptr + val_len + str_len > t->size) {

We need a +1 here on the left side, i.e.

        if (t->ptr + val_len + str_len + 1 > t->size) {

The str_len variable accounted for the terminating null character
before, but this patch removes str_len =3D strlen(str) + 1; above, and
callers specify the length of str without the terminating null in
str_len.  Thus it can lead to memory corruption, when the new entry
happens to end at 't->ptr + val_len + str_len' and the line added in
the next hunk writes the terminating null beyond the end of the
buffer.  I couldn't create a v4 pack from a current linux repo because
of this; either glibc detected something or 'git packv4-create'
crashed.

Sidenote: couldn't we call the 'ptr' field something else, like
end_offset or end_idx?  It took me some headscratching to figure out
why is it OK to compare a pointer to an integer above, or use a
pointer without dereferencing as an index into an array below (because
ptr is, well, not a pointer after all).

>  		t->size =3D (t->size + val_len + str_len + 1024) * 3 / 2;
> @@ -92,6 +92,7 @@ int dict_add_entry(struct dict_table *t, int val, c=
onst char *str)
>  	t->data[t->ptr] =3D val >> 8;
>  	t->data[t->ptr + 1] =3D val;
>  	memcpy(t->data + t->ptr + val_len, str, str_len);
> +	t->data[t->ptr + val_len + str_len] =3D 0;
> =20
>  	i =3D (t->nb_entries) ?
>  		locate_entry(t, t->data + t->ptr, val_len + str_len) : -1;
> @@ -107,7 +108,7 @@ int dict_add_entry(struct dict_table *t, int val,=
 const char *str)
>  	t->entry[t->nb_entries].offset =3D t->ptr;
>  	t->entry[t->nb_entries].size =3D val_len + str_len;
>  	t->entry[t->nb_entries].hits =3D 1;
> -	t->ptr +=3D val_len + str_len;
> +	t->ptr +=3D val_len + str_len + 1;

Good.


Best,
G=E1bor


>  	t->nb_entries++;
> =20
>  	if (t->hash_size * 3 <=3D t->nb_entries * 4)
> @@ -135,8 +136,73 @@ static void sort_dict_entries_by_hits(struct dic=
t_table *t)
>  	rehash_entries(t);
>  }
> =20
> +static struct dict_table *commit_name_table;
>  static struct dict_table *tree_path_table;
> =20
> +/*
> + * Parse the author/committer line from a canonical commit object.
> + * The 'from' argument points right after the "author " or "committe=
r "
> + * string.  The time zone is parsed and stored in *tz_val.  The retu=
rned
> + * pointer is right after the end of the email address which is also=
 just
> + * before the time value, or NULL if a parsing error is encountered.
> + */
> +static char *get_nameend_and_tz(char *from, int *tz_val)
> +{
> +	char *end, *tz;
> +
> +	tz =3D strchr(from, '\n');
> +	/* let's assume the smallest possible string to be "x <x> 0 +0000\n=
" */
> +	if (!tz || tz - from < 13)
> +		return NULL;
> +	tz -=3D 4;
> +	end =3D tz - 4;
> +	while (end - from > 5 && *end !=3D ' ')
> +		end--;
> +	if (end[-1] !=3D '>' || end[0] !=3D ' ' || tz[-2] !=3D ' ')
> +		return NULL;
> +	*tz_val =3D (tz[0] - '0') * 1000 +
> +		  (tz[1] - '0') * 100 +
> +		  (tz[2] - '0') * 10 +
> +		  (tz[3] - '0');
> +	switch (tz[-1]) {
> +	default:	return NULL;
> +	case '+':	break;
> +	case '-':	*tz_val =3D -*tz_val;
> +	}
> +	return end;
> +}
> +
> +static int add_commit_dict_entries(void *buf, unsigned long size)
> +{
> +	char *name, *end =3D NULL;
> +	int tz_val;
> +
> +	if (!commit_name_table)
> +		commit_name_table =3D create_dict_table();
> +
> +	/* parse and add author info */
> +	name =3D strstr(buf, "\nauthor ");
> +	if (name) {
> +		name +=3D 8;
> +		end =3D get_nameend_and_tz(name, &tz_val);
> +	}
> +	if (!name || !end)
> +		return -1;
> +	dict_add_entry(commit_name_table, tz_val, name, end - name);
> +
> +	/* parse and add committer info */
> +	name =3D strstr(end, "\ncommitter ");
> +	if (name) {
> +	       name +=3D 11;
> +	       end =3D get_nameend_and_tz(name, &tz_val);
> +	}
> +	if (!name || !end)
> +		return -1;
> +	dict_add_entry(commit_name_table, tz_val, name, end - name);
> +
> +	return 0;
> +}
> +
>  static int add_tree_dict_entries(void *buf, unsigned long size)
>  {
>  	struct tree_desc desc;
> @@ -146,13 +212,16 @@ static int add_tree_dict_entries(void *buf, uns=
igned long size)
>  		tree_path_table =3D create_dict_table();
> =20
>  	init_tree_desc(&desc, buf, size);
> -	while (tree_entry(&desc, &name_entry))
> +	while (tree_entry(&desc, &name_entry)) {
> +		int pathlen =3D tree_entry_len(&name_entry);
>  		dict_add_entry(tree_path_table, name_entry.mode,
> -			       name_entry.path);
> +				name_entry.path, pathlen);
> +	}
> +
>  	return 0;
>  }
> =20
> -void dict_dump(struct dict_table *t)
> +void dump_dict_table(struct dict_table *t)
>  {
>  	int i;
> =20
> @@ -169,6 +238,12 @@ void dict_dump(struct dict_table *t)
>  	}
>  }
> =20
> +static void dict_dump(void)
> +{
> +	dump_dict_table(commit_name_table);
> +	dump_dict_table(tree_path_table);
> +}
> +
>  struct idx_entry
>  {
>  	off_t                offset;
> @@ -205,6 +280,7 @@ static int create_pack_dictionaries(struct packed=
_git *p)
>  		enum object_type type;
>  		unsigned long size;
>  		struct object_info oi =3D {};
> +		int (*add_dict_entries)(void *, unsigned long);
> =20
>  		oi.typep =3D &type;
>  		oi.sizep =3D &size;
> @@ -213,7 +289,11 @@ static int create_pack_dictionaries(struct packe=
d_git *p)
>  			    sha1_to_hex(objects[i].sha1), p->pack_name);
> =20
>  		switch (type) {
> +		case OBJ_COMMIT:
> +			add_dict_entries =3D add_commit_dict_entries;
> +			break;
>  		case OBJ_TREE:
> +			add_dict_entries =3D add_tree_dict_entries;
>  			break;
>  		default:
>  			continue;
> @@ -225,7 +305,7 @@ static int create_pack_dictionaries(struct packed=
_git *p)
>  		if (check_sha1_signature(objects[i].sha1, data, size, typename(typ=
e)))
>  			die("packed %s from %s is corrupt",
>  			    sha1_to_hex(objects[i].sha1), p->pack_name);
> -		if (add_tree_dict_entries(data, size) < 0)
> +		if (add_dict_entries(data, size) < 0)
>  			die("can't process %s object %s",
>  				typename(type), sha1_to_hex(objects[i].sha1));
>  		free(data);
> @@ -285,6 +365,6 @@ int main(int argc, char *argv[])
>  		exit(1);
>  	}
>  	process_one_pack(argv[1]);
> -	dict_dump(tree_path_table);
> +	dict_dump();
>  	return 0;
>  }
> --=20
> 1.8.4.38.g317e65b
>=20
>=20
