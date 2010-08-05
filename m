From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v2 2/3] stash: Allow git stash branch to process commits 
	that look like stashes but are not stash references.
Date: Thu, 5 Aug 2010 15:23:19 +1000
Message-ID: <AANLkTikA0_Og4bzB8AHo3s2cLCvf6pc9=wC4w_8emuxU@mail.gmail.com>
References: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
	<1280831775-30759-3-git-send-email-jon.seymour@gmail.com>
	<7vwrs6djie.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ams@toroid.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 07:23:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgsvO-0003I3-7T
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 07:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab0HEFXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 01:23:21 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45845 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab0HEFXU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 01:23:20 -0400
Received: by qyk7 with SMTP id 7so2428837qyk.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SgT1hc+BNw4OsN68slHy8S0IrvA4cJIHbTPj4dmLV3g=;
        b=SbQjdMPaqlnkmpAXmTWvNjTcGalscaAgp6jqkdZxnJ4WngH4ew+Jvh5+uIIFJu574M
         PkG0vXDfxo2FhitvmHoeMf5tyrg5YsX1MfV+8GfDpxf0RRksvXr3xFKA5AVMVEx26EZd
         Tqspsj2YcU6EEuNpfqtYAGDd+jK2OhE/lLbzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AazG/JL0+q4k9q8X96eH6wH86x8mU08/EZ/aG6wJCeheMlCNzMyUTAE+yjNBHu/Hmz
         8rMbzHnjaBX74mhVGra6/LEDDvwc6khuu1VzBWBzu9pxXjGa/0As5j67EY2XLhSukfIz
         fLTTLCEZ4nSoSCcCOzheXIiTAAk9lQOxtOYYQ=
Received: by 10.229.127.148 with SMTP id g20mr2986334qcs.221.1280985799409; 
	Wed, 04 Aug 2010 22:23:19 -0700 (PDT)
Received: by 10.229.222.13 with HTTP; Wed, 4 Aug 2010 22:23:19 -0700 (PDT)
In-Reply-To: <7vwrs6djie.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152615>

Junio,

Thanks for the feedback. I'll rework along the lines you suggest. If
it makes sense to make the other stash commands tolerant of non-stash
entry references I'll add tests, support and documentation for that.

jon.

On Thu, August 2010 at 9:51 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jon  Seymour <jon.seymour@gmail.com> writes:
>
>> This patch allows git stash branch to work with stash-like commits c=
reated by git stash create.
>>
>> Two changes were required:
>>
>> * relax the pre-condition so that a stash stack is required if and o=
nly if a stash argument is not specified
>> * don't attempt to drop a stash argument that doesn't look like a st=
ash reference.
>>
>>
>> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
>
> Please wrap very long lines.
>
>> diff --git a/git-stash.sh b/git-stash.sh
>> index 1d95447..432ddae 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -225,6 +225,12 @@ show_stash () {
>> =C2=A0 =C2=A0 =C2=A0 git diff $flags $b_commit $w_commit
>> =C2=A0}
>>
>> +if_stash_ref() {
>> + =C2=A0 =C2=A0 ref=3D"$1"
>> + =C2=A0 =C2=A0 shift
>> + =C2=A0 =C2=A0 test "${ref#stash}" =3D "${ref}" -a "${ref#$ref_stas=
h}" =3D "${ref}" || "$@"
>> +}
>
> The interface to this function looks a rather bad taste to me; wouldn=
't it
> look more natural if the callers can say:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if stash_ref $it
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do this
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> Your criteria used here is that the given parameter does not begin wi=
th
> "stash" nor "refs/stash". =C2=A0If it begins with either of these two=
 strings,
> the "test" fails and "$@" is run. =C2=A0Wouldn't this produce a false=
 hit if
> you kept a handcrafted stash-looking commit with a tag "stash-42" or
> something?
>
> It may make more sense to give "stash drop" an option to be silent if
> the given parameter is not on the list to begin with, perhaps?
>
>
