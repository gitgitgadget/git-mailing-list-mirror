From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] commit: allow core.commentChar=auto for character
 auto selection
Date: Sat, 17 May 2014 06:41:19 +0700
Message-ID: <CACsJy8ASmBV2ORZeDQ=GUAGcq80_Gz2zmv6MGysFAVNR4Hs3YA@mail.gmail.com>
References: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
 <1400248283-303-1-git-send-email-pclouds@gmail.com> <1400248283-303-2-git-send-email-pclouds@gmail.com>
 <20140516164053.GB12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 01:41:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlRlC-0000ZD-7k
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 01:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455AbaEPXlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 19:41:50 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:58812 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019AbaEPXlu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 19:41:50 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so5399632qga.0
        for <git@vger.kernel.org>; Fri, 16 May 2014 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jFqPDn2wJbbVwwmMz50MHOFTb5Wc5QJ10q0nNrOsyT8=;
        b=gZ+b+l6tLOW7XOiZQ8fti0lszlRyj8lLJiUNC9mQEdrETRnzCjXmrs8VrmyUmg/eu2
         zdnlXuNGmrn3zzvQGyGQz8m0CcVpiHSkuDuptZLL6VX+P5ZPsd84AnrWWoNaGU0HDGFF
         GKHQJXDE8AtZiFZB+yj5iAfgz4dZH+UKxKkDY1YwKzpwx8jvJPAlLT4qyxYVR4ZV3Q43
         7EC623PFZRNwq35Lq+R6GM2QENOsKk8DeN3V2hJd0F9I+P+mzaSIFJaOJNQOsVHEGQrL
         ogKgxmVKOLqPOrMPEFoMKmZwV4NkO/UPXjarI4JpzzpSfbm2YlYRAT3gcXzFkisxR2IK
         m96A==
X-Received: by 10.140.91.161 with SMTP id z30mr28153270qgd.65.1400283709214;
 Fri, 16 May 2014 16:41:49 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 16 May 2014 16:41:19 -0700 (PDT)
In-Reply-To: <20140516164053.GB12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249432>

On Fri, May 16, 2014 at 11:40 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> core.commentChar starts with '#' as in default but if it's already i=
n
>> the prepared message, find another one among a small subset. This
>> should stop surprises because git strips some lines unexpectedly.
>
> Probably worth mentioning this only kicks in if someone explicitly
> configures [core] commentchar =3D auto.
>
> Would it be a goal to make 'auto' the default eventually if people
> turn out to like it?

No. I started this with a patch that does this automatically without a
config knob. It broke git-commit with custom templates. It broke
--cleanup=3Dstrip -e -F.. So people may want to put this in ~/.gitconfi=
g
but it's their decision.

>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -594,6 +594,40 @@ static char *cut_ident_timestamp_part(char *str=
ing)
>>       return ket;
>>  }
>>
>> +static void adjust_comment_line_char(const struct strbuf *sb)
>> +{
>> +     char candidates[] =3D " @!#$%^&|:;~";
>
> This prefers '@' over '#'.  Intended?

It used to be the order of keys 1, 2, 3... on qwerty keyboard, but I
was afraid ! may become history expansion in bash so I made @
preferred over !. Will make # and ; higher priority.

>> +     char *candidate;
>> +     const char *p;
>> +
>> +     if (!sb->len)
>> +             return;
>> +
>> +     if (!strchr(candidates, comment_line_char))
>> +             candidates[0] =3D comment_line_char;
>
> Could do
>
>         if (!memchr(sb->buf, comment_line_char, sb->len))
>                 return;
>
> to solve the precedence problem.  The comment_line_char not appearing
> in the message is the usual case and handling it separately means it
> gets handled faster.

Now that we use "auto" to turn this on, the placeholder candidates[0]
could probably be removed, we know comment_line_char is '#' at this
point.

>> --- a/config.c
>> +++ b/config.c
>> @@ -829,6 +829,8 @@ static int git_default_core_config(const char *v=
ar, const char *value)
>>               if (!ret) {
>>                       if (comment[0] && !comment[1])
>>                               comment_line_char =3D comment[0];
>> +                     else if (!strcasecmp(comment, "auto"))
>> +                             auto_comment_line_char =3D 1;
>
> Is there a way to disable 'auto' if 'auto' is already set?
>
> comment_line_char still can be set and matters when 'auto' is set.
> Should they be separate settings?

I think the next core.commentChar should override the old one, so
auto_comment_line_char should be clear when we set new value to
comment_line_char.
--=20
Duy
