From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] use xstrdup, not strdup in ll-merge.c
Date: Mon, 15 Jun 2009 13:49:09 +0200
Message-ID: <877hzdlnt6.fsf@meyering.net>
References: <87bpoqoavp.fsf@meyering.net>
	<81b0412b0906141503v14484d9fyea56198910305bfc@mail.gmail.com>
	<87fxe2lybr.fsf@meyering.net>
	<81b0412b0906150145j7c717a6ar33bb4f2ebd6095e1@mail.gmail.com>
	<87vdmxluj8.fsf@meyering.net>
	<81b0412b0906150439r755a7498ldddbca911b2fd36e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 13:49:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGAgp-0002h3-A8
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 13:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbZFOLtR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 07:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbZFOLtQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 07:49:16 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:42158 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbZFOLtP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 07:49:15 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 06D7A4B0085
	for <git@vger.kernel.org>; Mon, 15 Jun 2009 13:49:12 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 294AE4B00A1
	for <git@vger.kernel.org>; Mon, 15 Jun 2009 13:49:10 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 092174D704; Mon, 15 Jun 2009 13:49:10 +0200 (CEST)
In-Reply-To: <81b0412b0906150439r755a7498ldddbca911b2fd36e@mail.gmail.com>
	(Alex Riesen's message of "Mon, 15 Jun 2009 13:39:08 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121598>

Alex Riesen wrote:

> 2009/6/15 Jim Meyering <jim@meyering.net>:
>> Alex Riesen wrote:
>>> 2009/6/15 Jim Meyering <jim@meyering.net>:
>>>> Alex Riesen wrote:
>>>>> 2009/6/14 Jim Meyering <jim@meyering.net>:
>>>>>> @@ -231,7 +231,7 @@ static int read_merge_config(const char *var=
, const char *value, void *cb)
>>>>>>
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(var, "merge.default")) {
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value=
)
>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 default_ll_merge =3D strdup(value);
>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 default_ll_merge =3D xstrdup(value);
>>>>>
>>>>> read_merge_config has a failure mode (where it returns -1), why n=
ot use it?
>>>>
>>>> I didn't even consider it, because it would be inconsistent with
>>>> the other heap-allocation functions used there (xcalloc, xmemdupz)=
=2E
>>>>
>>>> However, now that I do, it looks like that would mean adding four =
times
>>>> the same code (including conditionals and code to generate a diagn=
ostic via
>>>> a call to error -- or a goto). Why bother, when all of that is alr=
eady
>>>> encapsulated in xmalloc?
>>>
>>> So that a useful error message can be given in the _caller_ (it kno=
ws
>>> more about context)?
>>
>> So you want to tell the user that we failed
>> to strdup the "merge.default" value?
>> Or the "driver" value?
>
> "merge: recursive: error loading configuration (last seen:
> merge.default): Out of memory\n"
>
>> Of more general interest, when xstrdup fails, it might be useful to
>> include in the diagnostic how long the would-be-dup'd string was. =C2=
=A0I.e.,
>> rather than saying
>>
>> =C2=A0 =C2=A0die("Out of memory, strdup failed");
>> say
>> =C2=A0 =C2=A0die("Out of memory, failed to strdup a %lu-byte string"=
,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(unsigned long int) strlen(str));
>
> Yes. Still lacks higher level information, though.
>
>>> Otherwise the error message ("Out of memory, strdup failed") does n=
ot
>>> have anything about the place nor situation in it. As the situation=
s
>>> when a modern system really runs out of memory are very rare,
>>> mostly such reports just point at some inconsistency elsewhere
>>
>> Exactly. =C2=A0This is why I think it's not worthwhile to invest in
>> a more precise diagnostic, here.
>
> I disagree. It is already hard to find starting point for debugging i=
f
> the failed code is just a layer: the config of ll-merge is called not=
 only
> from the merge drivers, but also indirectly from the programs which
> call the merge itself. Now, go figure where has it failed...

If you're convinced of the value of such a change, go for it.
Though it sounds like you're saying you'd prefer a stack trace.
