From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 3/3] index-pack: support multithreaded delta resolving
Date: Fri, 4 May 2012 19:50:26 +0700
Message-ID: <CACsJy8DHtBZdhoh1BPwn2_-3wVDRWypJOg3kR9wjd2o1bLUW-Q@mail.gmail.com>
References: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
 <1334123388-6083-4-git-send-email-pclouds@gmail.com> <7v62ccex0x.fsf@alter.siamese.dyndns.org>
 <7vipgccvp9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 14:51:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQHyR-0001dG-5C
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 14:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757Ab2EDMu6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 08:50:58 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35232 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701Ab2EDMu6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 08:50:58 -0400
Received: by wibhr7 with SMTP id hr7so1363956wib.1
        for <git@vger.kernel.org>; Fri, 04 May 2012 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2NXIDifg+kNnP5wwO+gDOC7ABjXSqfa+7Zf5zvO/Aew=;
        b=GsMYRxVUhf9lxsAgnt3bZH7K1voJgJBe0zPuwVfaNwvXHXshhDF1ak7uTjiB5JO0lZ
         gaQHvhdUH+1IwsI2y/b76IkKx27vE4Yr/cBZdE3kkyOHXUzuToOu6XtTyekXghYH5NKJ
         9ZrJdiY3MDOMMlmCVyERaakeTcNUHjHvwxQ/ak3KbT/0r3qHjLFvJh+rkwKxQXRrKkWr
         INlXsALDi6T3mnBSZ2rlS+j8PRJ0obCcdizNadTKapnyOF0iJAmoC7MU5NMfgIajVhuW
         uIxGABbzC4wrb+UF95H3DMJtLmeyi5n1Nw1wEJ0ObHq5u/NUZcQlu2Q7dVPw2dSXKgeH
         CNSw==
Received: by 10.180.81.166 with SMTP id b6mr12823756wiy.0.1336135856715; Fri,
 04 May 2012 05:50:56 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Fri, 4 May 2012 05:50:26 -0700 (PDT)
In-Reply-To: <7vipgccvp9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197016>

Junio, can you make a patch (or update current ones) with better
naming? I obviously did not see why these names were bad. You may
provide more convincing explanation than me in the commit message.

On Fri, May 4, 2012 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>>
>>> @@ -696,7 +796,31 @@ static void second_pass(struct object_entry *o=
bj)
>>> =C2=A0 =C2=A0 =C2=A0base_obj->obj =3D obj;
>>> =C2=A0 =C2=A0 =C2=A0base_obj->data =3D NULL;
>>> =C2=A0 =C2=A0 =C2=A0find_unresolved_deltas(base_obj);
>>> - =C2=A0 =C2=A0display_progress(progress, nr_resolved_deltas);
>>> +}
>>> +
>>> +static void *threaded_second_pass(void *arg)
>>> +{
>>> +#ifndef NO_PTHREADS
>>> + =C2=A0 =C2=A0if (threads_active)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_setspecific(key,=
 arg);
>>> +#endif
>>> + =C2=A0 =C2=A0for (;;) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0work_lock();
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0display_progress(progres=
s, nr_resolved_deltas);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (nr_processed < nr=
_objects &&
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is=
_delta_type(objects[nr_processed].type))
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0nr_processed++;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nr_processed >=3D nr=
_objects) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0work_unlock();
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D nr_processed++;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0work_unlock();
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0second_pass(&objects[i])=
;
>>> + =C2=A0 =C2=A0}
>>> + =C2=A0 =C2=A0return NULL;
>>> =C2=A0}
>>
>> It may be just the matter of naming, but the above is taking the
>> abstraction backwards, I think. =C2=A0Shouldn't it be structured in =
such a way
>> that the caller may call second_pass() and its implementation may tu=
rn out
>> to be threaded (or not)?
>>
>> The naming of "arg" made things worse. =C2=A0I wasted 5 minutes scra=
tching my
>> head thinking "arg" was a single specific object that was to be give=
n to
>> second_pass(), and wondered why it is made into thread-local data. =C2=
=A0Name
>> it "thread_data" or something.
>>
>> And I think the root cause of this confusion is the way "second_pass=
" was
>> split out in the earlier patch. =C2=A0It is not the entire second-pa=
ss, but is
>> merely a single step of it (the whole "for (i =3D 0; i < nr_objects;=
 i++)"
>> is the second-pass, in other words), and its implementation detail m=
ight
>> change to either thread (i.e. instead of a single line of control
>> iterating from 0 to nr_objects, each thread grab the next available =
task
>> and work on it until everything is exhausted) or not.
>>
>> By the way, if one object is very heavy and takes a lot of time unti=
l
>> completion, could it be possible that objects[0] is still being proc=
essed
>> for its base data but objects[1] has already completed and an availa=
ble
>> thread could work on objects[2]? =C2=A0How does it learn to process =
objects[2]
>> in such a case, or does it wait until the thread working on objects[=
0] is
>> done?
>
> Please disregard the "By the way" part, except that my confusion that=
 led
> to the "By the way" comment was caused by another misnaming, namely,
> "nr_processed". =C2=A0It is not counting "How many of them have we al=
ready
> processed?"---it merely counts "How many of them have we dispatched?"=
 and
> completion of the task does not matter in this critical section, whic=
h I
> missed. =C2=A0If it were named "nr_dispatched", I wouldn't have waste=
d my time
> wondering about the loop and writing the "By the way" review comment.
>



--=20
Duy
