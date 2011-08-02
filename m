From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH 2/5] fast-import: don't fail on omitted committer name
Date: Tue, 2 Aug 2011 23:07:25 +0600
Message-ID: <CA+gfSn-15+z+PYhFH6=RQF7HKC7i_1p=fyJqtepv3xPdUnTVdQ@mail.gmail.com>
References: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
	<1311831844-13123-3-git-send-email-divanorama@gmail.com>
	<7voc07g3fr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, SASAKI Suguru <sss.sonik@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 19:07:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoIRR-0001sG-Vw
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 19:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab1HBRHb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 13:07:31 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60521 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab1HBRH1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 13:07:27 -0400
Received: by qyk9 with SMTP id 9so4029083qyk.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=t6gpNWB7AOeOVF2XIUCM5RUnULwWD+MxJnkfNkao96k=;
        b=FsiDB5OtV65EaX7VGqwIK7DbCq6sfHX5wjmkQ4JnEcrSLmo5YlywPIW5Ft0ZICe5xt
         GXcYmpglE0DWy17vfwt2LpS19cafMebbsXt1uKCivBYPDXrM608V2WQuVLRYysrKqhv9
         x6t2iS2emp49pK8X3UMDSLyfokA3BTGpUwTpg=
Received: by 10.229.38.208 with SMTP id c16mr4033720qce.74.1312304845772; Tue,
 02 Aug 2011 10:07:25 -0700 (PDT)
Received: by 10.229.189.3 with HTTP; Tue, 2 Aug 2011 10:07:25 -0700 (PDT)
In-Reply-To: <7voc07g3fr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178485>

On Tue, Aug 2, 2011 at 10:53 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Dmitry Ivankov <divanorama@gmail.com> writes:
>
>> fast-import format declares 'committer_name SP' to be optional. But =
SP
>> between empty or not name and a email is obligatory and checked by
>
> Sorry, cannot parse this.
Ok, the point is fast-import input format for identities is declared to=
 be
'(name SP)? LT email GT' (followed by a datetime)
where name and email are allowed to be empty (and should not have
LF, LT, GT characters).
While git-fsck checks identities to be in form
'name SP LT email GT' (followed by a datetime)
where name and email are allowed to be empty (and should not have
LF, LT, GT characters).
So fast-import must prepend a space if the name part is omitted. This
patch makes it do so.

>
>> git-fsck, so fast-import must prepend the SP if the name is omitted.
>> Currently it doesn't.
>>
>> Name cannot contain LT or GT and ident always comes after SP in
>> fast-import. So reuse that SP as if a valid 'SP <email>' ident was p=
assed.
>>
>> This fixes a ident parsing bug for a well-formed fast-import input.
>> Though the parsing is still loose and can accept a ill-formed input.
>>
>> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
>> ---
>> =A0fast-import.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++++
>> =A0t/t9300-fast-import.sh | =A0 =A02 +-
>> =A02 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/fast-import.c b/fast-import.c
>> index 9e8d186..3194f4e 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1972,6 +1972,10 @@ static char *parse_ident(const char *buf)
>> =A0 =A0 =A0 size_t name_len;
>> =A0 =A0 =A0 char *ident;
>>
>> + =A0 =A0 /* ensure there is a space delimiter even if there is no n=
ame */
>> + =A0 =A0 if (*buf =3D=3D '<')
>> + =A0 =A0 =A0 =A0 =A0 =A0 --buf;
>> +
>> =A0 =A0 =A0 gt =3D strrchr(buf, '>');
>> =A0 =A0 =A0 if (!gt)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Missing > in ident string: %s", buf=
);
>> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
>> index a659dd4..09ef6ba 100755
>> --- a/t/t9300-fast-import.sh
>> +++ b/t/t9300-fast-import.sh
>> @@ -352,7 +352,7 @@ data <<COMMIT
>> =A0empty commit
>> =A0COMMIT
>> =A0INPUT_END
>> -test_expect_failure 'B: accept and fixup committer with no name' '
>> +test_expect_success 'B: accept and fixup committer with no name' '
>> =A0 =A0 =A0 git fast-import <input &&
>> =A0 =A0 =A0 out=3D$(git fsck) &&
>> =A0 =A0 =A0 echo "$out" &&
>
