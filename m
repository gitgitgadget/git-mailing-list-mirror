From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 12/16] sha1_file: add for_each iterators for loose and
 packed objects
Date: Sun, 05 Oct 2014 11:47:39 +0100
Message-ID: <543121CB.8090909@ramsay1.demon.co.uk>
References: <20141003202045.GA15205@peff.net> <20141003203219.GL16293@peff.net> <5430FE0A.4010806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 12:47:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XajM5-0005tK-Nv
	for gcvg-git-2@plane.gmane.org; Sun, 05 Oct 2014 12:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbaJEKro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2014 06:47:44 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:49867 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751152AbaJEKrn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2014 06:47:43 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 9057540141F;
	Sun,  5 Oct 2014 11:47:38 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 41B684013CA;
	Sun,  5 Oct 2014 11:47:38 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Sun,  5 Oct 2014 11:47:37 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <5430FE0A.4010806@web.de>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257899>

On 05/10/14 09:15, Ren=C3=A9 Scharfe wrote:
> Am 03.10.2014 um 22:32 schrieb Jeff King:
>> We typically iterate over the reachable objects in a
>> repository by starting at the tips and walking the graph.
>> There's no easy way to iterate over all of the objects,
>> including unreachable ones. Let's provide a way of doing so.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>   cache.h     | 11 +++++++++++
>>   sha1_file.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++
>>   2 files changed, 73 insertions(+)
>>
>> diff --git a/cache.h b/cache.h
>> index 7abe7f6..3826b4b 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1270,6 +1270,17 @@ int for_each_loose_file_in_objdir(const char =
*path,
>>                     each_loose_subdir_fn subdir_cb,
>>                     void *data);
>>
>> +/*
>> + * Iterate over loose and packed objects in both the local
>> + * repository and any alternates repositories.
>> + */
>> +typedef int each_packed_object_fn(const unsigned char *sha1,
>> +                  struct packed_git *pack,
>> +                  uint32_t pos,
>> +                  void *data);
>> +extern int for_each_loose_object(each_loose_object_fn, void *);
>> +extern int for_each_packed_object(each_packed_object_fn, void *);
>> +
>>   struct object_info {
>>       /* Request */
>>       enum object_type *typep;
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 9fdad47..d017289 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -3313,3 +3313,65 @@ int for_each_loose_file_in_objdir(const char =
*path,
>>       strbuf_release(&buf);
>>       return r;
>>   }
>> +
>> +struct loose_alt_odb_data {
>> +    each_loose_object_fn *cb;
>> +    void *data;
>> +};
>> +
>> +static int loose_from_alt_odb(struct alternate_object_database *alt=
,
>> +                  void *vdata)
>> +{
>> +    struct loose_alt_odb_data *data =3D vdata;
>> +    return for_each_loose_file_in_objdir(alt->base,
>> +                         data->cb, NULL, NULL,
>> +                         data->data);
>> +}
>> +
>> +int for_each_loose_object(each_loose_object_fn cb, void *data)
>> +{
>> +    struct loose_alt_odb_data alt;
>> +    int r;
>> +
>> +    r =3D for_each_loose_file_in_objdir(get_object_directory(),
>> +                      cb, NULL, NULL, data);
>> +    if (r)
>> +        return r;
>> +
>> +    alt.cb =3D cb;
>> +    alt.data =3D data;
>> +    return foreach_alt_odb(loose_from_alt_odb, &alt);
>> +}
>> +
>> +int for_each_object_in_pack(struct packed_git *p, each_packed_objec=
t_fn cb, void *data)
>=20
> Should this one be declared static?  It seems to be used only in sha1=
_file.c.

Heh, I was just about to make the same observation myself (with include=
d patch).

I could imagine this function being useful elsewhere, but until it gain=
s some
more external callers I think it should remain static (so it doesn't ca=
use a
sparse warning), rather than add an extern declaration to cache.h (whic=
h would
also suppress sparse).

ATB,
Ramsay Jones

>=20
>> +{
>> +    uint32_t i;
>> +    int r =3D 0;
>> +
>> +    for (i =3D 0; i < p->num_objects; i++) {
>> +        const unsigned char *sha1 =3D nth_packed_object_sha1(p, i);
>> +
>> +        if (!sha1)
>> +            return error("unable to get sha1 of object %u in %s",
>> +                     i, p->pack_name);
>> +
>> +        r =3D cb(sha1, p, i, data);
>> +        if (r)
>> +            break;
>> +    }
>> +    return r;
>> +}
>> +
>> +int for_each_packed_object(each_packed_object_fn cb, void *data)
>> +{
>> +    struct packed_git *p;
>> +    int r =3D 0;
>> +
>> +    prepare_packed_git();
>> +    for (p =3D packed_git; p; p =3D p->next) {
>> +        r =3D for_each_object_in_pack(p, cb, data);
>> +        if (r)
>> +            break;
>> +    }
>> +    return 0;
>> +}
>=20
> Perhaps return r instead here?
>=20
> Ren=C3=A9
>=20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> .
>=20
