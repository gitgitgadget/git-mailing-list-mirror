From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 9/9] for-each-ref: support %(...:aligned) for left alignment
Date: Sun, 19 May 2013 18:41:09 +0700
Message-ID: <CACsJy8DPanqJYJDTtLsEHF=TCDM+zRBnNDiWDdR2x6M-B_crMw@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
 <1368959235-27777-10-git-send-email-pclouds@gmail.com> <CALkWK0md-p25EkyyAjGE3_Ygq-4rEqQ6saG3dDq--FGRqGbF6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:41:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1zk-0006Jl-Gw
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab3ESLlk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:41:40 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:63351 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3ESLlk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:41:40 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so6208425obc.13
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=MCMT/MoMSG/wmt+NcGG9ixUbTQsPPDVNm6Z/v3BhOOQ=;
        b=HD9CA+ZuV83q/n1WtyByxOJ6HJAHSoqxrksKNn2HAX003NrNBPKJIFS3a9o++Glbb7
         hdr4YAf9UPfpfO+SrIpb7cavMGcypwbLTD1iuHL+EcKEBiqqbS681G94AD9uwgFb4s6Y
         RnHlrEN1ngcxqRvQWKtcNRXnpaW8y0V7T2ToolPCNhwXBU7PT6FvQMLbkm90mzRIU1ac
         BRARLM0qm8yXafF2C0zNyj+QUk1vtNOZnCP0SHfaLNxGG8NlnXbKBDKnRAajzBQOFwhL
         Mjn/t6u8Ou+zAtGSGkzOXwxvtasV7c574eDfIMynRWdUZOOkTSxXYFAf5SGxYJSvuKu3
         bxGA==
X-Received: by 10.182.47.196 with SMTP id f4mr7536940obn.31.1368963699627;
 Sun, 19 May 2013 04:41:39 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sun, 19 May 2013 04:41:09 -0700 (PDT)
In-Reply-To: <CALkWK0md-p25EkyyAjGE3_Ygq-4rEqQ6saG3dDq--FGRqGbF6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224859>

On Sun, May 19, 2013 at 6:32 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> I don't think [7/9] and [8/9] belong in this series.  Let's see how
> you've used it in :aligned.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index 1390da8..3240ca0 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -1012,8 +1013,26 @@ static void show_refs(struct refinfo **refs, =
int maxcount,
>>                                 emit(sb + i, cp, sp);
>>                 }
>>                 atom =3D parse_atom(sp + 2, ep);
>> -               for (i =3D 0; i < maxcount; i++)
>> +               aligned =3D !suffixcmp(used_atom[atom], ":aligned");
>> +               for (i =3D 0, max_length =3D 0; aligned && i < maxco=
unt; i++) {
>> +                       struct atom_value *v;
>> +                       get_value(refs[i], atom, &v);
>> +                       len =3D utf8_strnwidth(v->s, -1, 1);
>> +                       if (len > max_length)
>> +                               max_length =3D len;
>
> Why?!  Why are you denying me the pleasure of using %<, %<|, %>, %>|,
> %>>, %>>|, %<>, and %<>| that you invented in pretty?  The code is
> already there: you just have to hook it up.

Because for-each-ref only understands %(...) not %<|, i.e. % followed
by a (. We need more changes in for-each-ref code to make it accept
%<|, I think. Also %<|(N) needs "N". In case of "branch -v" that
should be calculated automatically, so we need a syntax to say "align
to the left, use the smallest width that fits all". I guess "%<|(*)"?
--
Duy
