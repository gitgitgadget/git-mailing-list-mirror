From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 17/44] fast-import.c: change update_branch to use ref transactions
Date: Thu, 15 May 2014 15:20:32 -0700
Message-ID: <CAL=YDWm-9Bq+bpqEieUuARzGO6+3ubbsLPg5cU+2g3OiYTdm8g@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-18-git-send-email-sahlberg@google.com>
	<20140515214745.GN26471@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:20:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl410-0007iX-O1
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbaEOWUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:20:34 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:34468 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbaEOWUd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:20:33 -0400
Received: by mail-ve0-f180.google.com with SMTP id db12so2079690veb.25
        for <git@vger.kernel.org>; Thu, 15 May 2014 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O2ECZytFjWYAksbG8um2Ut9jY3IYpCvjum5l9wIYwIw=;
        b=k30ryrUq0bjNNLZYfIAZfblFTC7i4dZKHZaIBM7UkbyM61vzOsaPZczdG0SZ1Y1dWP
         k0I6GAsUx6xdS9V5PC8LOmkocA9oMKZhfJIyh1DTSSXmCP8pCT/g1Yp/vPmQ/aw676MS
         D1fqUoWjnZ7M0ryxAfVaRAb0TwGa/3oViKjOsAaQuwE5pSdyAEkUlQBkNpfd0q2LKCkd
         kNJ1APDOLAXAXSbuomtwZpZie+tnnxl9I+4cm550mt/JcbGnr9RiWKNd+Bkr2RBLXbzG
         r2Y/sd7iUwoYlXDDrDp79WTTxTposZDokD/D9XMNNPbLexQZadMOGJjwLdrgeNnKyW0o
         lF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=O2ECZytFjWYAksbG8um2Ut9jY3IYpCvjum5l9wIYwIw=;
        b=WexyVYK29CzVE6v47yvv7069A/cYx9lJDVPSRgrca3cW3unHKQDf4MT/CA/oh8HRe4
         G85l/zRlHTdpOQ3mGBgRwqpncysu4aH943HpCDStNhBpRXW0wXbq6HgSJ3KAm5NwmwnI
         ioutwOwZxXdT22r/mBszw5tJ9D6+IMeiFYunc5WdCR/kuU164w3JcEju+0EAcy9FG54/
         RlhTIZYtf0DHsz9ZFU0m0bRedEu8kszL6pq9G0ZRwSqZ6uw8UWbI4MR2Gdzc7RjreiaP
         MATNuOuYrBsNISoVyeYXJkxCvtJhqZ6ZBvZqOYAAM9zZYapiGIe0Y5K+aijaIXl9WvkE
         8mYA==
X-Gm-Message-State: ALoCoQl7ExFil9DAGZMmlWzhndLEGv+zPqlv4+C99RBVyn7/7eLZZDkPTNPJQp/iOylBXby9STxo
X-Received: by 10.52.227.138 with SMTP id sa10mr8817862vdc.25.1400192432752;
 Thu, 15 May 2014 15:20:32 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 15:20:32 -0700 (PDT)
In-Reply-To: <20140515214745.GN26471@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249211>

On Thu, May 15, 2014 at 2:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1679,39 +1679,45 @@ found_entry:
>>  static int update_branch(struct branch *b)
>>  {
>>       static const char *msg = "fast-import";
>> -     struct ref_lock *lock;
>> +     struct ref_transaction *transaction;
>>       unsigned char old_sha1[20];
>> +     struct strbuf err = STRBUF_INIT;
>>
>>       if (read_ref(b->name, old_sha1))
>>               hashclr(old_sha1);
>> +
>>       if (is_null_sha1(b->sha1)) {
>>               if (b->delete)
>>                       delete_ref(b->name, old_sha1, 0);
>>               return 0;
>>       }
>> -     lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
>> -     if (!lock)
>> -             return error("Unable to lock %s", b->name);
>>       if (!force_update && !is_null_sha1(old_sha1)) {
>>               struct commit *old_cmit, *new_cmit;
>>
>>               old_cmit = lookup_commit_reference_gently(old_sha1, 0);
>>               new_cmit = lookup_commit_reference_gently(b->sha1, 0);
>>               if (!old_cmit || !new_cmit) {
>> -                     unlock_ref(lock);
>>                       return error("Branch %s is missing commits.", b->name);
>>               }
>
> (style) Now that there's only one line in the "if" body, we can
> drop the braces.
>

Done.

>>
>>               if (!in_merge_bases(old_cmit, new_cmit)) {
>> -                     unlock_ref(lock);
>>                       warning("Not updating %s"
>>                               " (new tip %s does not contain %s)",
>>                               b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
>>                       return -1;
>
> (not about this patch, feel free to ignore) This could
> return warning("...")

Ignored.

>
>>       }
>> -     if (write_ref_sha1(lock, b->sha1, msg) < 0)
>> -             return error("Unable to update %s", b->name);
>> +     transaction = ref_transaction_begin();
>> +     if ((!transaction ||
>> +         ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
>> +                                0, 1)) ||
>
> Would be more idiomatic to drop a layer of parentheses:
>
>         if (!transaction ||
>             ref_transaction_update(...) ||
>
>> +         (ref_transaction_commit(transaction, msg, &err) &&
>> +          !(transaction = NULL))) {
>

Done.


> Would be clearer if ref_transaction_commit didn't take care of the
> rollback (or in other words if patch 21 were earlier in the series).

True, but first making it correct, but ugly, here makes one appreciate
patch 21 more. That patch makes it correct and not ugly :-)
Leaving as is.

>
>> +             ref_transaction_rollback(transaction);
>> +             error("Unable to update branch %s: %s", b->name, err.buf);
>> +             strbuf_release(&err);
>> +             return -1;
>> +     }
>
> Example old message:
>
>         error: Unable to lock refs/heads/master
>
> New message:
>
>         error: Unable to update branch refs/heads/master: Cannot lock the ref 'refs/heads/master'.
>
> So 'error("%s", err.buf)' would probably work better.

Done.

>
> The only call site is dump_branches:
>
>         for (i = 0; i < branch_table_sz; i++) {
>                 for (b = branch_table[i]; b; b = b->table_next_branch)
>                         failure |= update_branch(b);
>         }
>
> Should these happen in a single transaction?  I haven't thought
> through whether it would be a good idea, if it should be optional, or
> what.
>
> Anyway, that would be a bigger behavior change, but it's interesting
> to think about.

I will try to add it to the next patch series.

>
> Thanks,
> Jonathan
