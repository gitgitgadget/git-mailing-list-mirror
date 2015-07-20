From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Mon, 20 Jul 2015 23:53:11 +0530
Message-ID: <CAOLa=ZTJ3syFEMjdwumZEP+XXzVK9qWz2S=7QsK_N1ev-WULtw@mail.gmail.com>
References: <CAOLa=ZT7szz=cwzEmVDPKucRbh2o_8mBhUY22=R8qCU34QPwGg@mail.gmail.com>
 <1437412947-17555-1-git-send-email-Karthik.188@gmail.com> <CAPig+cQ1uAHxMRuiBja2ap-nVCU2dUMLcN40Xb=HnT_kN_MW_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 20:23:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHFj8-0005KV-8M
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 20:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbbGTSXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 14:23:42 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35118 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbbGTSXl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 14:23:41 -0400
Received: by obbop1 with SMTP id op1so106911193obb.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wYzNePRcWztzIJ31uFld8XZ9vXJOvTIvNUKKVx/rUao=;
        b=ULpIJWa2P6HFcB+lPIDqtXh4mSUtOCRWfclEGwweaIZh3fE7IZ0hgnLcDGUXFl1Q7e
         8++IDoYRyhGfBjz95nQPUmnnssOBfDR4OjKT1e4DkbCYNNq2n0YKn1VNoOnGToK84Jgh
         HPpLyB7Y0Br34i864E5p9EcXWg2DbCdBFpVBZe5nkd2jBr+H03Dv1ZPLPkCksCTSJ7Cs
         RedTbRb8qDEUw//WolxPSFZPjT35wuDRB51YopWCO7pB8NYQPSjj6nWovW0eVueK4mrN
         ue3CJmijq/kzYTLxaPF2CQKSfGj9zwBMEILyJSm4x2id+A+tVTTsPAdQVhqgvz8y/7oG
         FEGg==
X-Received: by 10.60.62.105 with SMTP id x9mr27018587oer.1.1437416621218; Mon,
 20 Jul 2015 11:23:41 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 20 Jul 2015 11:23:11 -0700 (PDT)
In-Reply-To: <CAPig+cQ1uAHxMRuiBja2ap-nVCU2dUMLcN40Xb=HnT_kN_MW_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274340>

On Mon, Jul 20, 2015 at 11:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jul 20, 2015 at 1:22 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add a new atom "align" and support %(align:X) where X is a number.
>> This will align the preceeding atom value to the left followed by
>> spaces for a total length of X characters. If X is less than the item
>> size, the entire atom value is printed.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 7561727..93f59aa 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -687,6 +690,17 @@ static void populate_value(struct ref_array_item *ref)
>>                         else
>>                                 v->s = " ";
>>                         continue;
>> +               } else if (starts_with(name, "align:")) {
>> +                       const char *valp = NULL;
>> +
>> +                       skip_prefix(name, "align:", &valp);
>> +                       if (!valp[0])
>> +                               die(_("no value given with 'align:'"));
>> +                       strtoul_ui(valp, 10, &ref->align_value);
>> +                       if (ref->align_value < 1)
>> +                               die(_("value should be greater than zero: align:%u"), ref->align_value);
>> +                       v->s = "";
>
> Mental note: v->s points at literal zero-length string ("").
>
>> +                       continue;
>>                 } else
>>                         continue;
>>
>> @@ -1254,17 +1268,40 @@ static void emit(const char *cp, const char *ep)
>>         }
>>  }
>>
>> +static void assign_formating(struct ref_array_item *ref, int parsed_atom, struct atom_value *v)
>> +{
>> +       if (ref->align_value && !starts_with(used_atom[parsed_atom], "align")) {
>> +               unsigned int len = 0;
>> +
>> +               if (*v->s)
>> +                       len = utf8_strwidth(v->s);
>> +               if (ref->align_value > len) {
>> +                       struct strbuf buf = STRBUF_INIT;
>> +                       if (*v->s)
>> +                               strbuf_addstr(&buf, v->s);
>> +                       if (*v->s && v->s[0] == '\0')
>> +                               free((char *)v->s);
>
> Is the "v->s[0] == '\0'" checking for the same literal zero-length
> string assigned above? If so, attempting to free() that string doesn't
> make sense, since it's not heap-allocated. Maybe you meant != '\0'?
>
> Overall, this code is getting rather complex and difficult to follow
> (especially with all the 'v->s' checks thrown in). Junio's proposed
> 'pseudo_atom' and 'ref_formatting_state' would go a long way toward
> simplifying it.
>

You're right, thats what I meant.
Having a look at Junio's proposed idea.

-- 
Regards,
Karthik Nayak
