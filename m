From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 1/3] lockfile.c: remove PATH_MAX limitation (except
 in resolve_symlink)
Date: Sat, 02 Aug 2014 20:13:40 +0200
Message-ID: <53DD2A54.1030403@web.de>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com>	<1406814214-21725-1-git-send-email-pclouds@gmail.com>	<1406814214-21725-2-git-send-email-pclouds@gmail.com>	<xmqqfvhgw3q9.fsf@gitster.dls.corp.google.com> <xmqqtx5wuma8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk,
	yuelinho777@gmail.com
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 20:14:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDdoq-0007fi-Dx
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 20:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbaHBSOH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Aug 2014 14:14:07 -0400
Received: from mout.web.de ([212.227.17.12]:55610 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932282AbaHBSOF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 14:14:05 -0400
Received: from [192.168.1.87] ([91.141.0.246]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0M73WL-1WHIbQ2m0b-00wipB; Sat, 02 Aug 2014 20:13:58
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <xmqqtx5wuma8.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:bgE8mdIx89WP9QJ0MFOz6PFIheIpdXrhDnGYapLYpdjN0sepCrp
 O6VFqWCkh5lThGGvzEgA/S6O+XtQa4Jx+KmT6LMqwOn9vaye2ZZz5z7zrVMFH01yx+yyKeU
 dGDHNMi0T44lTziFREpIpxZxR6FX6Zy6FdzsTKUPLz3Uc7zACJp8Hudcm6ObcV4eCwIBPzr
 ARNodFEPlEsnYJ8kwUziA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254713>

On 08/01/2014 07:55 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>> Somewhat underexplained, given that it seems to add some new
>> semantics.
>>
>>> +static void clear_filename(struct lock_file *lk)
>>> +{
>>> +	free(lk->filename);
>>> +	lk->filename =3D NULL;
>>> +}
>> It is good to abstract out lk->filename[0] =3D '\0', which used to b=
e
>> the way we say that we are done with the lock.  But I am somewhat
>> surprised to see that there aren't so many locations that used to
>> check !!lk->filename[0] to see if we are done with the lock to requi=
re
>> a corresponding wrapper.
>>
>>>   static void remove_lock_file(void)
>>>   {
>>>   	pid_t me =3D getpid();
>>>  =20
>>>   	while (lock_file_list) {
>>>   		if (lock_file_list->owner =3D=3D me &&
>>> -		    lock_file_list->filename[0]) {
>>> +		    lock_file_list->filename) {
>> ... and this seems to be the only location?
> While looking at possible fallout of merging this topic to any
> branch, I am starting to suspect that it is probably a bad idea for
> clear-filename to free lk->filename.  I am wondering if it would be
> safer to do:
>
>   - in lock_file(), free lk->filename if it already exists before
>     what you do in that function with your series;
>
>   - update "is this lock already held?" check !!lk->filename[0] to
>     check for (lk->filename && !!lk->filename[0]);
>
>   - in clear_filename(), clear lk->filename[0] =3D '\0', but do not
>     free lk->filename itself.
>
> Then existing callers that never suspected that lk->filename can be
> NULL and thought that it does not need freeing can keep doing the
> same thing as before without leaking nor breaking.
>
> If we want to adopt the new world order at once, alternatively, you
> can keep the code in this series but then lk->filename needs to be
> renamed to something that the current code base has not heard of to
> force breakage at the link time for us to notice.
>
> I grepped for 'lk->filename' and checked if the ones in read-cache.c
> and refs.c are OK (they seem to be), but that is not a very robust
> check.
>
> I dunno.

My first impression reading this patch was to rename
clear_filename() into free_and_clear_filename() or better free_filename=
(),
but I never pressed the send button ;-)

Reading the discussion above makes me wonder if lk->filename may be rep=
laced by a strbuf
some day, and in this case clear_filename() will become reset_filenmae(=
) ?
