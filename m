From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v1 11/45] parse_pathspec: support stripping submodule
 trailing slashes
Date: Mon, 18 Mar 2013 07:53:51 +0700
Message-ID: <CACsJy8BzLtzLKut+2W6Uyf5ESaq+Ek8owe6-yHF7_3BNLowCPA@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-12-git-send-email-pclouds@gmail.com> <7vy5dlpu7i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 01:54:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHOLj-0006xG-ET
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 01:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085Ab3CRAyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 20:54:24 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:56219 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3CRAyX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 20:54:23 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so5079837oag.30
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 17:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ZShSKjhZpyjc1Z2FxUsRIuKs/Dr3Vz7gjsxSz9NmG74=;
        b=tvi6pIlQVhlGziauiJOSQ62L8k48/nusPuqlhzwYLuhlsLXNm6H4RVH3fqr4JpjM2z
         hvOiNoVeaYcW7zFH4e3twj11pRbnfasMAZq/GRGOmGkqIcb/8lT88JhX7OHaF4UaTANu
         bsRzNM8/LF4Ybjrw3ecivTk7RTtad0szdIQlkeBTONcH9TtuBcAZeda+jD1uTE0uPYXB
         dzcB3tDu2GKyXnSlcyGasZIpPPWa5gELeUW+quy8byCO0ty+4LIVVA004TIP/EM7YBPe
         O/TFyjz9Fes959T9XowUjmlIamThkPzJC9nQm00E0L11+c7ZtORJaZQ3a+ziqAVp3hgS
         aqSg==
X-Received: by 10.182.235.49 with SMTP id uj17mr5964595obc.18.1363568061227;
 Sun, 17 Mar 2013 17:54:21 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sun, 17 Mar 2013 17:53:51 -0700 (PDT)
In-Reply-To: <7vy5dlpu7i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218385>

On Mon, Mar 18, 2013 at 4:55 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This flag is equivalent to builtin/ls-files.c:strip_trailing_slashes=
()
>> and is intended to replace that function when ls-files is converted =
to
>> use parse_pathspec.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  pathspec.c | 9 +++++++++
>>  pathspec.h | 1 +
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/pathspec.c b/pathspec.c
>> index b2446c3..2da8bc9 100644
>> --- a/pathspec.c
>> +++ b/pathspec.c
>> @@ -204,6 +204,15 @@ static unsigned prefix_pathspec(struct pathspec=
_item *item,
>>       *raw =3D item->match =3D match;
>>       item->original =3D elt;
>>       item->len =3D strlen(item->match);
>> +
>> +     if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
>
> I see that having cheap and expensive variant at these steps is a
> way to achieve a bug-for-bug compatible rewrite of the existing
> code, but in the longer term should we lose one of them?  After all,
> a path that points at the working tree of another repository that is
> beyond a symlink cannot be added to us as a submodule, so CHEAP can
> be used only when we know that any intermediate component on the
> path is not a symlink pointing elsewhere, and the user in the
> codepath of ls-files may know it.

I did not concentrate on the future part. But yes only one should
remain in long term. Cheap vs expensive does not say much.

> To put it differently, shouldn't CHEAP and EXPENSIVE be accompanied
> by in-code comment and updates to Documentation/technical/api-*.txt
> to help users of the API to decide which one to use?

Will do (also for the comment on 14/45)
--=20
Duy
