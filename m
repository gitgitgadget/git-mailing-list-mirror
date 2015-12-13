From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 10/10] ref-filter: introduce objectname_atom_parser()
Date: Mon, 14 Dec 2015 01:10:54 +0530
Message-ID: <CAOLa=ZRivWR_0qMVqRU51PrX4OhSdBYdpwQm6Ci8H2wvAzPypw@mail.gmail.com>
References: <20151124214842.GA4848@sigill.intra.peff.net> <1448459082-24492-1-git-send-email-Karthik.188@gmail.com>
 <CAPig+cTduYxSWh5ghmv3vM04saAqrn9TUpBZ0J=TuDOgr05itQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 20:42:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8CWz-0001rZ-GU
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 20:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbbLMTlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 14:41:25 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35239 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbbLMTlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 14:41:24 -0500
Received: by vkha189 with SMTP id a189so142642312vkh.2
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NEye8LZTUwJ7Ln6M7GWcliqBSWxV3hfrZZ46jD2tY44=;
        b=I3bt3tAGWo+PwO7CIdjgWUTgPhQsWELEZcuT7spbOJauI9a72Gq7cO1BM7oSJTQqV+
         4/1iTAzgQXC7oCiD9MykxG6cuEX8cMGZRzE9XlQ0r0L4uyf5XaeUp0t4Bz5gXt/qlWYY
         NUJLRwW20RNbYRk0LiUJoU2xbkrnhibDkEKhyZP7Fj45gdRsPYLIrnhpwueDe458rtf3
         6zlarENjA9Q3pswa7CjkWUehj/sRRohN/ZCFlGdYWhDNJnHnw1C8J1QSrdGAj7CHooLG
         BPlbf+2GvMXr4MxTTv2GY3wlCZyBqmTryewokFgL3+dhYb3yP7bDmqVt+hMSMjJat2sh
         aVeA==
X-Received: by 10.31.169.137 with SMTP id s131mr22017673vke.144.1450035683619;
 Sun, 13 Dec 2015 11:41:23 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sun, 13 Dec 2015 11:40:54 -0800 (PST)
In-Reply-To: <CAPig+cTduYxSWh5ghmv3vM04saAqrn9TUpBZ0J=TuDOgr05itQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282347>

On Sun, Dec 13, 2015 at 10:19 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Nov 25, 2015 at 8:44 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce objectname_atom_parser() which will parse the
>> '%(objectname)' atom and store information into the 'used_atom'
>> structure based on the modifiers used along with the atom.
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -50,6 +50,10 @@ static struct used_atom {
>>                                 lines : 1,
>>                                 no_lines;
>>                 } contents;
>> +               struct {
>> +                       unsigned int shorten : 1,
>> +                               full : 1;
>> +               } objectname;
>
> Same comment as in my patch 8 and 9 reviews: If 'shorten' and 'full'
> are mutually exclusive, then an enum would be clearer. In fact, if
> there are only these two states (full and short), then this could be a
> simple boolean named 'shorten'.
>
>>         } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>> @@ -123,6 +127,21 @@ void contents_atom_parser(struct used_atom *atom)
>> +void objectname_atom_parser(struct used_atom *atom)
>> +{
>> +       const char * buf;
>> +
>> +       if (match_atom_name(atom->str, "objectname", &buf))
>> +               atom->u.objectname.full = 1;
>
> Same comment about bogus logic as in patch 9 review: u.objectname.full
> and u.objectname.shorten are both set to 1 for %(objectname:short).
>

I guess I responded to the same issue, will work on it.

>> +
>> +       if (!buf)
>> +               return;
>
> Same comment about misplaced blank line: Put the blank line after the
> conditional rather than before or drop it altogether.
>

Will change.

>> +       if (!strcmp(buf, "short"))
>> +               atom->u.objectname.shorten = 1;
>> +       else
>> +               die(_("improper format entered objectname:%s"), buf);
>
> Maybe just "unrecognized objectname:%s" or something?
>

die(_("unrecognized %%(objectname) argument: %s"), buf);
to keep things consistent

>> +}
>> +
>> @@ -463,15 +482,16 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
>>  }
>>
>>  static int grab_objectname(const char *name, const unsigned char *sha1,
>> -                           struct atom_value *v)
>> +                          struct atom_value *v, struct used_atom *atom)
>>  {
>> -       if (!strcmp(name, "objectname")) {
>> -               v->s = xstrdup(sha1_to_hex(sha1));
>> -               return 1;
>> -       }
>> -       if (!strcmp(name, "objectname:short")) {
>> -               v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
>> -               return 1;
>> +       if (starts_with(name, "objectname")) {
>> +               if (atom->u.objectname.shorten) {
>> +                       v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
>> +                       return 1;
>> +               } else if (atom->u.objectname.full) {
>> +                       v->s = xstrdup(sha1_to_hex(sha1));
>> +                       return 1;
>> +               }
>>         }
>>         return 0;
>>  }
>> @@ -495,7 +515,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
>>                         v->s = xstrfmt("%lu", sz);
>>                 }
>>                 else if (deref)
>> -                       grab_objectname(name, obj->sha1, v);
>> +                       grab_objectname(name, obj->sha1, v, &used_atom[i]);
>>         }
>>  }
>>
>> @@ -1004,7 +1024,7 @@ static void populate_value(struct ref_array_item *ref)
>>                                 v->s = xstrdup(buf + 1);
>>                         }
>>                         continue;
>> -               } else if (!deref && grab_objectname(name, ref->objectname, v)) {
>> +               } else if (!deref && grab_objectname(name, ref->objectname, v, atom)) {
>>                         continue;
>>                 } else if (!strcmp(name, "HEAD")) {
>>                         const char *head;
>> --
>> 2.6.2



-- 
Regards,
Karthik Nayak
