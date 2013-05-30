From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 7/7] unpack-trees: free cache_entry array members for
 merges
Date: Thu, 30 May 2013 16:40:14 +0200
Message-ID: <51A764CE.4000708@lsrfire.ath.cx>
References: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <1369913664-49734-8-git-send-email-rene.scharfe@lsrfire.ath.cx> <CAMP44s2=YuBLHgz52ie-FZYU5iz4o4tY0-zH+6XuzpiupjomLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 16:40:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui41k-0006Jk-VS
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 16:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027Ab3E3OkZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 10:40:25 -0400
Received: from india601.server4you.de ([85.25.151.105]:57651 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932733Ab3E3OkY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 10:40:24 -0400
Received: from [192.168.2.105] (p579BEB6E.dip0.t-ipconnect.de [87.155.235.110])
	by india601.server4you.de (Postfix) with ESMTPSA id 25AB31FF;
	Thu, 30 May 2013 16:40:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s2=YuBLHgz52ie-FZYU5iz4o4tY0-zH+6XuzpiupjomLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226004>

Am 30.05.2013 14:04, schrieb Felipe Contreras:
> On Thu, May 30, 2013 at 6:34 AM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> The merge functions duplicate entries as needed and they don't free
>> them.  Release them in unpack_nondirectories, the same function
>> where they were allocated, after we're done.
>
> Ah, you beat me to this change, but..
>
>> @@ -600,9 +600,14 @@ static int unpack_nondirectories(int n, unsigne=
d long mask,
>>                  src[i + o->merge] =3D create_ce_entry(info, names +=
 i, stage);
>>          }
>>
>> -       if (o->merge)
>> -               return call_unpack_fn((const struct cache_entry * co=
nst *)src,
>> -                                     o);
>> +       if (o->merge) {
>> +               int rc =3D call_unpack_fn((const struct cache_entry =
* const *)src,
>> +                                       o);
>> +               for (i =3D 1; i <=3D n; i++)
>> +                       if (src[i] && src[i] !=3D o->df_conflict_ent=
ry)
>> +                               free(src[i]);
>
> Doesn't it make more sense to follow the code above and do src[i + o-=
>merge]?

Not sure I understand.  Is the goal to avoid confusion for code readers=
=20
by using the same indexing method for allocation and release?  Or are=20
you worried about o->merge having a different value than 1 in that loop=
?

We'd have to add 1 (=3D=3D o->merge) to each index variable usage with =
a=20
zero-based loop.  A one-based loop avoids that, and while it's not=20
pretty it's also not too complicated, I think.

Ren=C3=A9
