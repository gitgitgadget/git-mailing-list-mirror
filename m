From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/3] lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
Date: Mon, 4 Aug 2014 17:13:41 +0700
Message-ID: <CACsJy8BAB3n5BRVaveTBrhdSDpiPBtm==TRjiv4ZR2P6iMne_w@mail.gmail.com>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
 <1406814214-21725-1-git-send-email-pclouds@gmail.com> <1406814214-21725-2-git-send-email-pclouds@gmail.com>
 <xmqqfvhgw3q9.fsf@gitster.dls.corp.google.com> <xmqqtx5wuma8.fsf@gitster.dls.corp.google.com>
 <53DD2A54.1030403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Yue Lin Ho <yuelinho777@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 12:14:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEFHV-0002ZK-C7
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 12:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbaHDKON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2014 06:14:13 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:50083 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaHDKOM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2014 06:14:12 -0400
Received: by mail-ie0-f172.google.com with SMTP id lx4so9484533iec.31
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3x/1J4JjSCb8yOvdL1H/RtPOVy613oUxBIWdGr70INw=;
        b=Fhpb9atQq8HNKxyosnMqS5KROq8BdpPPPgtrY4N0xc3BiLi0iajzKcabimRI8xI04i
         PYU0/PZzzhyflYa51LKZibRbBtTIdjrJgH2QLQFocyI9bdIjLxqON/sBrV7by2C+Xg4j
         zDRExZJlVUVbMVACoVYBpEgAdb+pydGaeN03EsWCZ9iK5or7eaKm6WdNXsqdSVgwZQtO
         59ik2hAvk0F/6GRpws83Z0+c/ncNHTKcr3UvCs+FUC+0PfG4EoTe1/uvnGeU3m3L1QA+
         7UuSBJtt4wYWql6EviD42t8vRLrFQ3crsNOMP402EblOSqHowVrK9HaAyEhiyCmadvh2
         DScw==
X-Received: by 10.43.129.74 with SMTP id hh10mr29331470icc.48.1407147251929;
 Mon, 04 Aug 2014 03:14:11 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Mon, 4 Aug 2014 03:13:41 -0700 (PDT)
In-Reply-To: <53DD2A54.1030403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254735>

On Sun, Aug 3, 2014 at 1:13 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 08/01/2014 07:55 PM, Junio C Hamano wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writ=
es:
>>>
>>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
>>>
>>> Somewhat underexplained, given that it seems to add some new
>>> semantics.
>>>
>>>> +static void clear_filename(struct lock_file *lk)
>>>> +{
>>>> +       free(lk->filename);
>>>> +       lk->filename =3D NULL;
>>>> +}
>>>
>>> It is good to abstract out lk->filename[0] =3D '\0', which used to =
be
>>> the way we say that we are done with the lock.  But I am somewhat
>>> surprised to see that there aren't so many locations that used to
>>> check !!lk->filename[0] to see if we are done with the lock to requ=
ire
>>> a corresponding wrapper.
>>>
>>>>   static void remove_lock_file(void)
>>>>   {
>>>>         pid_t me =3D getpid();
>>>>         while (lock_file_list) {
>>>>                 if (lock_file_list->owner =3D=3D me &&
>>>> -                   lock_file_list->filename[0]) {
>>>> +                   lock_file_list->filename) {
>>>
>>> ... and this seems to be the only location?
>>
>> While looking at possible fallout of merging this topic to any
>> branch, I am starting to suspect that it is probably a bad idea for
>> clear-filename to free lk->filename.  I am wondering if it would be
>> safer to do:
>>
>>   - in lock_file(), free lk->filename if it already exists before
>>     what you do in that function with your series;
>>
>>   - update "is this lock already held?" check !!lk->filename[0] to
>>     check for (lk->filename && !!lk->filename[0]);
>>
>>   - in clear_filename(), clear lk->filename[0] =3D '\0', but do not
>>     free lk->filename itself.
>>
>> Then existing callers that never suspected that lk->filename can be
>> NULL and thought that it does not need freeing can keep doing the
>> same thing as before without leaking nor breaking.
>>
>> If we want to adopt the new world order at once, alternatively, you
>> can keep the code in this series but then lk->filename needs to be
>> renamed to something that the current code base has not heard of to
>> force breakage at the link time for us to notice.
>>
>> I grepped for 'lk->filename' and checked if the ones in read-cache.c
>> and refs.c are OK (they seem to be), but that is not a very robust
>> check.
>>
>> I dunno.
>
>
> My first impression reading this patch was to rename
> clear_filename() into free_and_clear_filename() or better free_filena=
me(),
> but I never pressed the send button ;-)
>
> Reading the discussion above makes me wonder if lk->filename may be r=
eplaced
> by a strbuf
> some day, and in this case clear_filename() will become reset_filenma=
e() ?

I didn't realize Mike is making a lot more changes in lockfile.c, part
of that is converting lk->filename to use strbuf [1]. Perhaps I should
just withdraw this series, wait until Mike's series is merged, then
redo 3/3 on top. Or Mike could just take 3/3 in as part of his series.

[1] http://thread.gmane.org/gmane.comp.version-control.git/246222/focus=
=3D246232
--=20
Duy
