From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Mon, 20 Jul 2015 20:36:44 +0530
Message-ID: <CAOLa=ZRp0WXKj7au_eDk=80ivsgsNWEyO9JBy_rwzOXmnQwS_A@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
 <1437246749-14423-2-git-send-email-Karthik.188@gmail.com> <CAPig+cRXsmi=UxRr-3rnt919d86jD6uMuTqdDxCComYLXk1TYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHCf7-00039Z-5L
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 17:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbbGTPHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 11:07:18 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33865 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbbGTPHR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 11:07:17 -0400
Received: by obre1 with SMTP id e1so103442817obr.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kUCv7u8oznQE1G6jn3ZHahqU1p3le3Xs3zEy5d2c99U=;
        b=GJfo6JmHgPSJ/Bt8BdapiY/Eq5gW6xO0CXD9UBs+bRYSxxigASTOI+Pt5o5vyme2T1
         VumkHeuQS7IdgRUlzHX0A7YiOEm2u5U0arybYbttAmKR9MBZGlUeyEa/51T3TCVziINS
         9IPWwePyfWsJLbbQu8zj6x3Cu0PYAjDQ/phS5/zEoxNmPNFehvsnkD63H/9iIVoBSDaD
         dTL/77cmG/4kT58uSk55utSOV+sHix7cCUyceLUtP+pQ8US0S0ly797N9XDU0TZjBMvp
         AVJLsdd8OOEzEBp6ggqVYv8g1TOnNPIjMgZj2EHPLU9OTEDlz/ezDIi8denfFW0H3tnJ
         1ehQ==
X-Received: by 10.182.204.38 with SMTP id kv6mr26565505obc.70.1437404834266;
 Mon, 20 Jul 2015 08:07:14 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 20 Jul 2015 08:06:44 -0700 (PDT)
In-Reply-To: <CAPig+cRXsmi=UxRr-3rnt919d86jD6uMuTqdDxCComYLXk1TYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274323>

On Mon, Jul 20, 2015 at 5:19 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add a new atom "align" and support %(align:X) where X is a number.
>> This will align the preceeding atom value to the left followed by
>> spaces for a total length of X characters. If X is less than the item
>> size, the entire atom value is printed.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 7561727..b81a08d 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -53,6 +55,7 @@ static struct {
>>         { "flag" },
>>         { "HEAD" },
>>         { "color" },
>> +       { "align" },
>
> Not a new issue, but some compilers (Solaris?) complain about the
> trailing comma.
>

Ok will check.

>>  };
>>
>>  /*
>> @@ -687,6 +690,17 @@ static void populate_value(struct ref_array_item *ref)
>>                         else
>>                                 v->s = " ";
>>                         continue;
>> +               } else if (starts_with(name, "align:")) {
>> +                       const char *valp = NULL;
>> +
>> +                       skip_prefix(name, "align:", &valp);
>> +                       if (!valp[0])
>> +                               die(_("No value given with 'align='"));
>
> The parser expects "align:", but the error message talks about
> "align=". Also, current trend is to drop capitalization from the error
> message.
>

Thanks will change.

>> +                       strtoul_ui(valp, 10, &ref->align_value);
>> +                       if (ref->align_value < 1)
>> +                               die(_("Value should be greater than zero"));
>
> Drop capitalization. Also, the user seeing this message won't
> necessarily know to which value this refers. Better would be to
> provide context ("'align:' value should be..."), and even better would
> be to show the actual value at fault:
>
>     die(_("value should be greater than zero: align:%u\n",
>         ref_align_value);
>
> or something.

Makes sense, thanks :)

>
>> +                       v->s = "";
>> +                       continue;
>>                 } else
>>                         continue;
>>
>> @@ -1254,17 +1268,38 @@ static void emit(const char *cp, const char *ep)
>>         }
>>  }
>>
>> +static void assign_formating(struct ref_array_item *ref, int parsed_atom, struct atom_value *v)
>> +{
>> +       if (v->s[0] && ref->align_value) {
>
> Mental note: v->s[0] is not NUL ('\0').
>
> Also, in this code base, this is typically written *v->s rather than v->s[0].
>

My bad, got confused with that :)

>> +               unsigned int len = 0;
>> +               len = utf8_strwidth(v->s);
>
> You initialize 'len' to 0 but then immediately re-assign it.

Will change.

>
>> +               if (ref->align_value > len) {
>> +                       struct strbuf buf = STRBUF_INIT;
>> +                       strbuf_addstr(&buf, v->s);
>> +                       if (!v->s[0])
>> +                               free((char *)v->s);
>
> We know from the "mental note" above that v->s[0] is not NUL ('\0'),
> so this 'if' statement can never be true, thus is dead code.

Yes, my bad. Will change.

>
>> +                       strbuf_addchars(&buf, ' ', ref->align_value - len);
>> +                       v->s = strbuf_detach(&buf, NULL);
>> +               }
>> +               ref->align_value = 0;
>> +       }
>> +}

Thanks.

-- 
Regards,
Karthik Nayak
