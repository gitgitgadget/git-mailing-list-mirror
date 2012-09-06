From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] fetch: align new ref summary printout in UTF-8 locales
Date: Thu, 6 Sep 2012 19:11:13 +0700
Message-ID: <CACsJy8A60Os1pupMQdi44vnmO+E_ZqtvTELCOR1GeHSPdZeo5g@mail.gmail.com>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com>
 <1346755175-31468-1-git-send-email-pclouds@gmail.com> <504796A5.4070700@gmail.com>
 <5047A602.1020802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 14:11:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9aw4-0002e9-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 14:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab2IFMLp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 08:11:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46999 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab2IFMLo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 08:11:44 -0400
Received: by iahk25 with SMTP id k25so1957588iah.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fC7wyMfgKrpqD1EQlzBs4xjEZcByEjp3AeKo/TLyv0Q=;
        b=UohuytR4SluKA3SaPmW9Ih3rMEkTZSIERZqWjPFaclH0+CJioRdxLVHcPEbH6CQkp7
         2mjI6jPgsAcc/b94v+NKG66qhAZeTEQJqlI4WZkh0kO8cXjCBrRPKnW0B3mK6xaW2QQ+
         awS/JtZobt55zd1r0J8N7HJ0BMVzc1qnwrcabQYBx3YKNsDrTPB7yNQcMyInAr798VGN
         utXKv2om/b4tXyX8QynaTLumw6hm4P9u6rpbfKeyTvUrzOuXQNqCFxP4E3MZE5TmhjNG
         EX+7h/WQnimxp7sl8iKhiRLPlU74m1fUKt+k01NCOLr3aGsHU7KqnayIbvEndEqYC+PW
         weIw==
Received: by 10.50.237.38 with SMTP id uz6mr2570536igc.2.1346933504065; Thu,
 06 Sep 2012 05:11:44 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Thu, 6 Sep 2012 05:11:13 -0700 (PDT)
In-Reply-To: <5047A602.1020802@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204876>

On Thu, Sep 6, 2012 at 2:20 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 09/05/2012 08:15 PM, Torsten B=C3=B6gershausen wrote:
>>
>> On 04.09.12 12:39, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>>
>>> +/* return the number of columns of string 's' in current locale */
>>> +int gettext_width(const char *s)
>>> +{
>>> +       static int is_utf8 =3D -1;
>>> +       if (is_utf8 =3D=3D -1)
>>> +               is_utf8 =3D !strcmp(charset, "UTF-8");
>>> +
>>> +       return is_utf8 ? utf8_strwidth(s) : strlen(s);
>>
>>
>> Will that work for non-ASCII encodings?
>> For ISO-8859-x we can say strlen() =3D=3D strwidth(),
>> but for other encodings using multibytes that doesn't work, does it?

No it does not. I think I mentioned that in the first version that I
was only interested in utf-8. Others can extend the function for their
favourite encodings.

> (Sorry the message went out before completely written)
> Something like that:
>
> int gettext_width(const char *s) {
>
>   static int is_utf8 =3D -1;
>
>   if (is_utf8 =3D=3D -1)
>
>     is_utf8 =3D !strcmp(charset, "UTF-8");
>
>   if (is_utf8)
>     return utf8_strwidth(s);
>   else  {
>     char *s_utf =3D reencode_string(s, "UTF-8", charset);
>     if (s_utf) {
>       witdh =3D utf8_strwidth(s_utf);
>       free(s_utf);
>     } else
>       width =3D strlen(s);
>
>     return width;
> }

Yes, something like that, assuming that column information is intact
after the conversion. Maybe you can make that a new function, int
strwidth(const char *str, const char *charset), and make
gettext_strwidth() a thin wrapper:

int gettext_strwidth(const char *s)
{
   return strwidth(s, charset);
}
--=20
Duy
