From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 4/6] for-each-ref: introduce %(upstream:track[short])
Date: Sun, 17 Nov 2013 11:28:28 +0530
Message-ID: <CALkWK0=3=a5hiU7zxDAk=077CePkmN+MaLZFcuYdeZJM8QXApw@mail.gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
 <1384513148-22633-5-git-send-email-artagnon@gmail.com> <CAPig+cRqwOgE8by8DwuGc1nNA3C_bA07ob-GuRzETKoRPBe+CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 17 06:59:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhvOM-0006s6-3Z
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 06:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743Ab3KQF7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 00:59:11 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:51870 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3KQF7J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 00:59:09 -0500
Received: by mail-ie0-f170.google.com with SMTP id to1so7190718ieb.29
        for <git@vger.kernel.org>; Sat, 16 Nov 2013 21:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AE6th6mSEGykRuLE2z8jEm1ED+SZjgpZjLqr/xkpeIo=;
        b=DLWserXOsCf5NFrZNcnhL3a3xcCWOWvrSaAiSOne/8MLLmJgCzzxsja5pECBseBxfn
         pxI/ogQW4jfkIotOmwfaFX8L9iuAhzZw9fGh32OBiqq0FHn6ZUhC1VGUSixmmCdiHZQ5
         Zy5sMKvYclhicNKbfZfTLEIJdu8A2HC918KUQ3e0SkGykWX3C8hU83nQ1DTYxGh9/eeM
         1KW3cMkG2tJsNCb9OWU6n8q5mf9LKExMTtJUAbPXY/NaY3m+0iewJXKYByRWuohITnHO
         pCyJX04GadKkWRhw6io7N6RZdZkr3NsdqtGyA2DLEstMRvE6waaX+DJhx9ven4JzUnk2
         jQAA==
X-Received: by 10.50.107.70 with SMTP id ha6mr9221973igb.60.1384667948806;
 Sat, 16 Nov 2013 21:59:08 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Sat, 16 Nov 2013 21:58:28 -0800 (PST)
In-Reply-To: <CAPig+cRqwOgE8by8DwuGc1nNA3C_bA07ob-GuRzETKoRPBe+CQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237951>

Eric Sunshine wrote:
> The "prompt" is not mentioned elsewhere in for-each-ref documentation,
> and a person not familiar with contrib/completion/ may be confused by
> this reference. It might make sense instead to explain the meanings of
> ">", "<", "<>", and "=" directly since they are not necessarily
> obvious to the casual reader.

Someone else raised the same point earlier. Okay, I'll elaborate.

>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index 5f1842f..ed81407 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -689,13 +690,46 @@ static void populate_value(struct refinfo *ref)
>>                         continue;
>>
>>                 formatp = strchr(name, ':');
>> -               /* look for "short" refname format */
>>                 if (formatp) {
>> +                       int num_ours, num_theirs;
>> +
>>                         formatp++;
>>                         if (!strcmp(formatp, "short"))
>>                                 refname = shorten_unambiguous_ref(refname,
>>                                                       warn_ambiguous_refs);
>> -                       else
>> +                       else if (!strcmp(formatp, "track") &&
>> +                               !prefixcmp(name, "upstream")) {
>> +                               char buf[40];
>> +
>> +                               stat_tracking_info(branch, &num_ours, &num_theirs);
>> +                               if (!num_ours && !num_theirs)
>> +                                       v->s = "";
>> +                               else if (!num_ours) {
>> +                                       sprintf(buf, "[behind %d]", num_theirs);
>> +                                       v->s = xstrdup(buf);
>> +                               } else if (!num_theirs) {
>> +                                       sprintf(buf, "[ahead %d]", num_ours);
>> +                                       v->s = xstrdup(buf);
>> +                               } else {
>> +                                       sprintf(buf, "[ahead %d, behind %d]",
>
> Is the intention that these strings ("[ahead %d]", etc.) will be
> internationalized in the future? If so, the allocated 40-character
> buffer may be insufficient.

Similar strings in wt-status.c aren't ready for internationalization
either. Besides, these xstrdup() calls leak memory and are quite
suboptimal: if I allocate more memory, I'm going to be leaking more;
so, I'd defer the internationalization discussion until we restructure
this.

>> +                                               num_ours, num_theirs);
>> +                                       v->s = xstrdup(buf);
>> +                               }
>> +                               continue;
>> +                       } else if (!strcmp(formatp, "trackshort") &&
>> +                               !prefixcmp(name, "upstream")) {
>> +
>> +                               stat_tracking_info(branch, &num_ours, &num_theirs);
>> +                               if (!num_ours && !num_theirs)
>> +                                       v->s = "=";
>> +                               else if (!num_ours)
>> +                                       v->s = "<";
>> +                               else if (!num_theirs)
>> +                                       v->s = ">";
>> +                               else
>> +                                       v->s = "<>";
>> +                               continue;
>> +                       } else
>>                                 die("unknown %.*s format %s",
>>                                     (int)(formatp - name), name, formatp);
>
> Is it still accurate to call this a "format" in the error message?
> 'track' and 'trackshort' seem more like decorations.

By convention, all f-e-r formatting errors are reported as fatal
errors (see color errors too, for instance), unlike pretty-formats. We
might want to change this in a later series.

>> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
>> index 5e29ffc..9d874fd 100755
>> --- a/t/t6300-for-each-ref.sh
>> +++ b/t/t6300-for-each-ref.sh
>> @@ -303,6 +303,28 @@ test_expect_success 'Check short upstream format' '
>>         test_cmp expected actual
>>  '
>>
>> +test_expect_success 'setup for upstream:track[short]' '
>> +       test_commit two
>> +'
>> +
>> +cat >expected <<EOF
>> +[ahead 1]
>> +EOF
>> +
>> +test_expect_success 'Check upstream:track format' '
>> +       git for-each-ref --format="%(upstream:track)" refs/heads >actual &&
>> +       test_cmp expected actual
>> +'
>> +
>> +cat >expected <<EOF
>> +>
>> +EOF
>> +
>> +test_expect_success 'Check upstream:trackshort format' '
>> +       git for-each-ref --format="%(upstream:trackshort)" refs/heads >actual &&
>> +       test_cmp expected actual
>> +'
>> +
>>  cat >expected <<EOF
>>  $(git rev-parse --short HEAD)
>>  EOF
>
> Would it make sense also to add tests verifying that :track and
> :trackshort correctly fail when applied to a key other than
> "upstream"?

Sure.

And thanks for the detailed review.
