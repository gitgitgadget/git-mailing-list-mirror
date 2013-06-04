From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 02/15] for-each-ref: don't print out elements directly
Date: Wed, 5 Jun 2013 06:44:26 +0700
Message-ID: <CACsJy8CES9qebDSuO2_rzqNgPPZrhMfvRiaO+ReQNaLVxMAsuA@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
 <1370349337-20938-3-git-send-email-artagnon@gmail.com> <7vsj0x4ghm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 01:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk0uh-0000ud-9B
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 01:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab3FDXo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 19:44:59 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:37334 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab3FDXo5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 19:44:57 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so1510934obq.21
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=h52S0wmqAmAJgMA1ewQFQ4mcDxUC34E3WeX8Jw8KU0U=;
        b=J7XcK/1BWNQ4Q7/CRmEA8paiZSMee5CiFatWI8SiXG9KvOGXQjGpCc+8OGqf3tUezA
         Rb9+q2zSVAKwL6QG3lp/o8x8wSOg5aPlNRpoZlAYT/BgGAKsJXseYlffMip3zT6IEB+G
         EQdN9Y+MyFGPlf7pPSMLmXoxOtDScqTJLsndTeU9xvjCC5GqA45lzewIzV3hyxkSx4TP
         MJz87r6V4tMvDY/ZrMpO+y61SnTc13O7i3o9xdxeouaNW//xe60oYbap2RnWLtebeeFw
         lMuDwK6MGD0UiKICOWiqWwMUwYCKT1k1t9+qdS3bfSceB+Q/N8WhPtBxg/+D+UD9DCLe
         AEWA==
X-Received: by 10.60.99.10 with SMTP id em10mr12940199oeb.58.1370389496592;
 Tue, 04 Jun 2013 16:44:56 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 4 Jun 2013 16:44:26 -0700 (PDT)
In-Reply-To: <7vsj0x4ghm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226423>

On Wed, Jun 5, 2013 at 6:13 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>
>> Currently, the entire callchain starting from show_ref() parses and
>> prints immediately.  This inflexibility limits our ability to extend=
 the
>> parser.  So, convert the entire callchain to accept a strbuf argumen=
t to
>> write to.  Also introduce a show_refs() helper that calls show_ref()=
 in
>> a loop to avoid cluttering up cmd_for_each_ref() with the task of
>> initializing/freeing the strbuf.
>>
>> [rr: commit message]
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  builtin/for-each-ref.c | 55 ++++++++++++++++++++++++++++++++-------=
-----------
>>  1 file changed, 35 insertions(+), 20 deletions(-)
>>
>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index 1d4083c..e2d6c5a 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -864,31 +864,31 @@ static void sort_refs(struct ref_sort *sort, s=
truct refinfo **refs, int num_refs
>>       qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
>>  }
>>
>> -static void print_value(struct refinfo *ref, int atom, int quote_st=
yle)
>> +static void print_value(struct strbuf *sb, struct refinfo *ref,
>> +                     int atom, int quote_style)
>>  {
>>       struct atom_value *v;
>> -     struct strbuf sb =3D STRBUF_INIT;
>>       get_value(ref, atom, &v);
>>       switch (quote_style) {
>>       case QUOTE_NONE:
>> -             fputs(v->s, stdout);
>> +             strbuf_addstr(sb, v->s);
>>               break;
>>       case QUOTE_SHELL:
>> -             sq_quote_buf(&sb, v->s);
>> +             sq_quote_buf(sb, v->s);
>>               break;
>>       case QUOTE_PERL:
>> -             perl_quote_buf(&sb, v->s);
>> +             perl_quote_buf(sb, v->s);
>>               break;
>>       case QUOTE_PYTHON:
>> -             python_quote_buf(&sb, v->s);
>> +             python_quote_buf(sb, v->s);
>>               break;
>>       case QUOTE_TCL:
>> -             tcl_quote_buf(&sb, v->s);
>> +             tcl_quote_buf(sb, v->s);
>>               break;
>>       }
>>       if (quote_style !=3D QUOTE_NONE) {
>> -             fputs(sb.buf, stdout);
>> -             strbuf_release(&sb);
>> +             fputs(sb->buf, stdout);
>> +             strbuf_release(sb);
>>       }
>>  }
>
> The change in the first step made some sense; if asked not to quote,
> it just emits the atom with fputs() in the switch (quote_style), so
> there is nothing more to do after the switch.
>
> But this change cannot be correct.  It prints literally to sb, and
> leaves the function without emitting anything nor freeing the
> resource in sb.

Everything will/should be emitted in show_refs(), so the "if
(quote_style !=3D..)" block should be removed. The end result still
looks correct due to the order of fputs (in print_value and
show_refs). It only breaks down when %<(*) is used together because
then "sb" content matters. Will fix.
--
Duy
