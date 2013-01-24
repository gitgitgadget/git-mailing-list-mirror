From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 21:14:47 +0700
Message-ID: <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
References: <20130123143816.GA579@krypton.darkbyte.org> <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com> <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Armin <netzverweigerer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 15:15:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyNaf-0005OM-Hm
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 15:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab3AXOPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 09:15:20 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:61142 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab3AXOPS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 09:15:18 -0500
Received: by mail-ob0-f182.google.com with SMTP id uo13so4773945obb.41
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=UbPDej99/C99XNn3M8/iXxSFe1lA6U6xJCkWLU0x8Ss=;
        b=yBBGns37LIKcIpCkRUPheChcEYiW0YzzbSMZ91hSYSMBUjUwpKwdk+jBa/XgauC/Vu
         5EXSnZ3NS/VNvZOBLOifmSVvBrSMYHz6NSLrFaEwex+SocJLWmOV6o6f0wcA556MGrsx
         DOQIWyWizrhUyo1bS5C8orFaJ8akeruhmDYfcAXFDWN0jgHKVNyeLFKDCkPfNgNyAV/8
         LL/3Kc440LC3N94K/n9GeEnNxvWl6Ie4T9AiNAGmUxGnFO/WF10Eirlqeo7/LqdLOk64
         0yGX22tpHjhTWKr2dXlHDmoJqNmWLqGHg+YIJbpfoM65jsU9jrkhx0GLGn+2hrZzBKw7
         3C6Q==
X-Received: by 10.60.8.131 with SMTP id r3mr1584512oea.14.1359036917625; Thu,
 24 Jan 2013 06:15:17 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Thu, 24 Jan 2013 06:14:47 -0800 (PST)
In-Reply-To: <51013FDD.5030004@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214431>

On Thu, Jan 24, 2013 at 9:06 PM, Stefan N=C3=A4we
<stefan.naewe@atlas-elektronik.com> wrote:
> Am Donnerstag, 24. Januar 2013 14:40:47 schrieb Duy Nguyen:
>> On Thu, Jan 24, 2013 at 7:11 PM, Stefan N=C3=A4we
>> <stefan.naewe@atlas-elektronik.com> wrote:
>>>> Does it fail with older versions of git? If so, can you bisect?
>>>
>>> I did. My bisection told me this is the suspect:
>>>
>>> ccdc603 (parse_object: try internal cache before reading object db)
>>
>> diff --git a/object.c b/object.c
>> index d8d09f9..6b06297 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -191,10 +191,15 @@ struct object *parse_object(const unsigned cha=
r *sha1)
>>         enum object_type type;
>>         int eaten;
>>         const unsigned char *repl =3D lookup_replace_object(sha1);
>> -       void *buffer =3D read_sha1_file(sha1, &type, &size);
>> +       void *buffer;
>> +       struct object *obj;
>> +
>> +       obj =3D lookup_object(sha1);
>> +       if (obj && obj->parsed)
>> +               return obj;
>>
>> Any chance obj->parsed is 1 but ((struct commit*)obj)->buffer is NUL=
L?
>> What if you change that "if" to
>>
>> if (obj && obj->parsed && (obj->type !=3D OBJ_COMMIT || ((struct com=
mit
>> *)obj)->buffer))
>>
>
> No more segfault!

Sweet. I have no idea how that fixes it. Maybe Jeff can give some
explanation after he wakes up.
--=20
Duy
