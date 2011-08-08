From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 22/48] merge-recursive: Fix sorting order and directory
 change assumptions
Date: Mon, 8 Aug 2011 13:21:08 -0600
Message-ID: <CABPp-BEBFa9vKcKBehq9gV+S1WW+0L+8XZ2+jHdiXsqBp4k+uA@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<1307518278-23814-23-git-send-email-newren@gmail.com>
	<7vhb6jcg68.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 21:21:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqVO0-00040m-ET
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 21:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab1HHTVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 15:21:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59187 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab1HHTVK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 15:21:10 -0400
Received: by fxh19 with SMTP id 19so5670492fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4lQ2bth7UtdrT7FcRMskbjU8PzhAEgZJxdKSwTOoq0w=;
        b=p4LwA71A4aHeKNxuIqC3yYiYK6sMyya0+3fY2mH3zKzteWl8kY7vVGYhVOhSDorpBT
         6uNim2nqNCrYoOrZP2vQILSwcrpPZZg07RJUNhzMu6vBhHa5/jzlv5CXHobKzHvt8EMq
         9eEgr5vSD5pYF7ClL8qTz+33fG0IpuaHQf6VI=
Received: by 10.223.160.131 with SMTP id n3mr7886335fax.111.1312831268644;
 Mon, 08 Aug 2011 12:21:08 -0700 (PDT)
Received: by 10.223.123.13 with HTTP; Mon, 8 Aug 2011 12:21:08 -0700 (PDT)
In-Reply-To: <7vhb6jcg68.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178973>

On Mon, Jul 18, 2011 at 5:39 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> +static int string_list_df_name_compare(const void *a, const void *b=
)
>> +{
>> + =C2=A0 =C2=A0 const struct string_list_item *one =3D a;
>> + =C2=A0 =C2=A0 const struct string_list_item *two =3D b;
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* Here we only care that entries for D/F confl=
icts are
>> + =C2=A0 =C2=A0 =C2=A0* adjacent, in particular with the file of the=
 D/F conflict
>> + =C2=A0 =C2=A0 =C2=A0* appearing before files below the correspondi=
ng directory.
>> + =C2=A0 =C2=A0 =C2=A0* The order of the rest of the list is irrelev=
ant for us.
>> + =C2=A0 =C2=A0 =C2=A0*
>> + =C2=A0 =C2=A0 =C2=A0* To achieve this, we sort with df_name_compar=
e and provide
>> + =C2=A0 =C2=A0 =C2=A0* the mode S_IFDIR so that D/F conflicts will =
sort correctly.
>> + =C2=A0 =C2=A0 =C2=A0* We use the mode S_IFDIR for everything else =
for simplicity,
>> + =C2=A0 =C2=A0 =C2=A0* since in other cases any changes in their or=
der due to
>> + =C2=A0 =C2=A0 =C2=A0* sorting cause no problems for us.
>> + =C2=A0 =C2=A0 =C2=A0*/
>
> I recall there was an issue of this sorting reported earlier...

Yes, in git-fast-export, though.  It was 060df62 (fast-export: Fix
output order of D/F changes 2010-07-09), if you're curious.
