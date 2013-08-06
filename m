From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/16] blame: accept multiple -L ranges
Date: Tue, 6 Aug 2013 18:44:44 -0400
Message-ID: <CAPig+cTHbV-ijfXNBn45v2opOH7Jh0A22QaxCeKhRBPA39xAwQ@mail.gmail.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
	<1375797589-65308-6-git-send-email-sunshine@sunshineco.com>
	<7v1u66fqrz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 00:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6pzp-0001fS-LU
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 00:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787Ab3HFWot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 18:44:49 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:57725 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756800Ab3HFWor (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 18:44:47 -0400
Received: by mail-la0-f44.google.com with SMTP id fo12so742962lab.17
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 15:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Mub2+MiiEqyR2mrxo/CSK6gtiXd0d4e8XyWdl9MRl7w=;
        b=OPKz0HJnb1rS8b8ZPI+FYZjHAiqqlq1rUPSoK28qo7XzCCZTZ7iqOEB0WWKFiUoewR
         j1Zl547L6kFKOiT1A3KeMWaFa+AZxE2z9b/K/oIdvV5CuAdkIdn1OXRmGU1jRqwv6PQw
         06Y/hhvIdsT2VB95DsL+HCsyBp3KK1xl6vEHOx9fEUlJL9HnnnO8Qc7CfsP2B7ZB/up+
         G3n3/F9/qa/Yi8qhfEgbectPjmOuOUUrtMlbYVCKzEHxP6pKt0PowD1zOLRYVIqimluD
         HMsEfNVQ2zIIkBruDqUB4NwJ0/fhKDe/FjAjpdQmMxafdOwBRClORFn3VvE+2JSRL7z9
         N7AA==
X-Received: by 10.112.97.132 with SMTP id ea4mr397663lbb.80.1375829085084;
 Tue, 06 Aug 2013 15:44:45 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 6 Aug 2013 15:44:44 -0700 (PDT)
In-Reply-To: <7v1u66fqrz.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: Mk1MY_t47iiAO3L8MPwajoV9q5M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231792>

On Tue, Aug 6, 2013 at 5:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     for (range_i = ranges.nr; range_i > 0; --range_i) {
>> +             const struct range *r = &ranges.ranges[range_i - 1];
>> +             long bottom = r->start;
>> +             long top = r->end;
>> +             struct blame_entry *next = ent;
>> +             ent = xcalloc(1, sizeof(*ent));
>> +             ent->lno = bottom;
>> +             ent->num_lines = top - bottom;
>> +             ent->suspect = o;
>> +             ent->s_lno = bottom;
>> +             ent->next = next;
>> +             if (next)
>> +                     next->prev = ent;
>> +             origin_incref(o);
>> +     }
>> +     origin_decref(o);
>
> Hmph, I do not see where the need for this decref is coming from.
> Did we incref once too many somewhere?

Each constructed blame_entry must own a reference to the suspect.
o->refcnt should equal the number of blame_entries. At construction, a
'struct origin' has refcnt 1. In the original code, which supported
only a single initial range (blame_entry), we had:

  o = get-initial-suspect();  # refcnt already 1
  ent->suspect = o;  # refcnt still 1
  sb.ent = ent;
  assign_blame(&sb);

So, o->refcnt equals the number of blame_entries (1) when
assign_blame() is called.

The new for-loop calls origin_incref() on each iteration since each
blame_entry needs to own a reference to the suspect. Assume that we
have two disjoint -L ranges:

  o = get-initial-suspect();  # refcnt already 1
  foreach range:
    ent = new blame_entry;
    ent->suspect = o;
    origin_incref(o);  # refcnt++
  end
  # for 2 ranges, refcnt incremented twice, so value is 3
  origin_decref(o);  # refcnt = 2
  sb.ent = ent;
  assign_blame(&sb);

Thus, as with the original code, o->refcnt equals the number of
blame_entries (2) when assign_blame() is called.

The same holds for the boundary case when the file is empty and there
is no range. o->refcnt starts at 1, the loop is never entered so no
blame_entries are created, and o->refcnt gets decremented to 0, which
again matches the number of blame_entries (0).
