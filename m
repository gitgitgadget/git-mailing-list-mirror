From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [RFC/PATCH 1/2] config: Add cache for config value querying
Date: Tue, 27 May 2014 06:54:38 -0700
Message-ID: <5384991E.10409@gmail.com>
References: <1401125601-18249-1-git-send-email-tanayabh@gmail.com> <1401125601-18249-2-git-send-email-tanayabh@gmail.com> <53839DEE.9090504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 27 15:55:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpHq7-0007bJ-5U
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 15:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbaE0Nyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2014 09:54:47 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:44857 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbaE0Nyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 09:54:46 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so9385843pbc.1
        for <git@vger.kernel.org>; Tue, 27 May 2014 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Sm/dYh+j6MCstvOTGdTNmVch395+tK/E0sc62Ze7vb4=;
        b=eAscW97iu1ocoovV0OdDIHxdZI6CSwemyUBexgCsfVUxg9ZMVvIA56HiT3HlOe05C+
         /jcsl4vgUNAMdSrtNL9f/vGgKDMElLABw3Pjjn6LC+T1Yq1gBC709Pj3djQ0X1PLYSww
         nTTvRz1xVBNMPQUrl8jl1y7DrHpRmvnFMAAKiVRh7Mjue6Zt9m3fifxSVz5MuX58fzS/
         Idkd1BpoFNJtHYMDZCu2DsLSKtc7O5TkzB2hx7CwFSi7uPQycim1CMYcYouqJxNUg699
         fiwS99QXPPaLInZXkPt/3mdMz3WP7OilqlEfMl7GQ2Oc4WMyvn2BUCRT9sntaZlVCc6P
         t37g==
X-Received: by 10.68.211.233 with SMTP id nf9mr36580663pbc.29.1401198886246;
        Tue, 27 May 2014 06:54:46 -0700 (PDT)
Received: from [192.168.52.160] ([117.254.223.251])
        by mx.google.com with ESMTPSA id bx5sm73866203pad.22.2014.05.27.06.54.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 27 May 2014 06:54:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <53839DEE.9090504@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250167>

Hi,

On 05/26/2014 01:02 PM, Torsten B=C3=B6gershausen wrote:
>> Add an internal cache with the all variable value pairs read from th=
e usual
> "cache": The word "cache" is in Git often used for "index"=20
Okay, point noted. I thought about choosing between "hashmap" and "cach=
e" and chose
the later.
> "variable value" can be written as "key value"

I  had used the term "variable" to be consistent with the documentation
(api-config.txt). But I think "key" is much clearer.

> "usual": I don't think we handle "unusual" config files,
> (so can we drop the word usual ?)

Okay, noted.

> I think the (important) first line can be written like this:
>=20
>> Add a hash table with the all key-value pairs read from the
> or
>> Add a hash table to cache all key-value pairs read from the
>=20
>> config files(repo specific .git/config, user wide ~/.gitconfig and t=
he global
>> /etc/gitconfig). Also, add two external functions `git_config_get_st=
ring` and
> Can we drop "Also" ?
>> @@ -37,6 +39,102 @@ static struct config_source *cf;
>> =20
>>  static int zlib_compression_seen;
>> =20
>> +struct hashmap config_cache;
>> +
>> +struct config_cache_node {
>> +	struct hashmap_entry ent;
>> +	struct strbuf key;
> Do we need a whole strbuf for the key?
> Or could a "char *key" work as well?=20
> (and/or could it be "const char *key" ?

To maintain consistency with config.c. config.c uses strbuf for both ke=
y and value
throughout. I found the reason by git-blaming config.c. Key length is f=
lexible so it
would be better to use a api construct such as strbuf for it.

>> +	struct string_list *value_list ;
>=20
>=20
>=20
>> +static struct string_list *config_cache_get_value(const char *key)
>> +{
>> +	struct config_cache_node *e =3D config_cache_find_entry(key);
> why "e" ? Will "node" be easier to read ? Or entry ?=20

Noted. Entry is much better.

>> +static void config_cache_set_value(const char *key, const char *val=
ue)
>> +{
>> +	struct config_cache_node *e;
>> +
>> +	if (!value)
>> +		return;
> Hm, either NULL could mean "unset=3D=3Dremove" the value, (but we don=
't do that, do we?
>=20
> Or it could mean a programming or runtime error?, Should there be a w=
arning ?

Nope. It is just a check to not save blank values for a key in the hash=
map. Removal
functionality will come later. NULL=3D=3Dremove is implemented in
git_config_set_multivar_in_file(). We are not reading key value pairs f=
rom that, just
from git_config().
>> +
>> +	e =3D config_cache_find_entry(key);
>> +	if (!e) {
>> +		e =3D malloc(sizeof(*e));
>> +		hashmap_entry_init(e, strihash(key));
>> +		strbuf_init(&(e->key), 1024);
>> +		strbuf_addstr(&(e->key),key);
>> +		e->value_list =3D malloc(sizeof(struct string_list));
>> +		e->value_list->strdup_strings =3D 1;
>> +		e->value_list->nr =3D 0;
>> +		e->value_list->alloc =3D 0;
>> +		e->value_list->items =3D NULL;
>> +		e->value_list->cmp =3D NULL;
> When malloc() is replaced by xcalloc()  the x =3D NULL and y =3D 0 ca=
n go away,
> and the code is shorter and easier to read.

Much better, thanks.

>> +extern const char *git_config_get_string(const char *name)
>> +{
>> +	struct string_list *values;
>> +	int num_values;
>> +	char *result;
>> +	values =3D config_cache_get_value(name);
>> +	if (!values)
>> +		return NULL;
>> +	num_values =3D values->nr;
>> +	result =3D values->items[num_values-1].string ;
> We could get rid of the variable  "int num_values" by simply writing
> result =3D values->items[values->nr-1].string;
>=20

Noted.


Cheers,
Tanay Abhra.
