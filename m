From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH 03/16] pack-objects: use a faster hash table
Date: Wed, 26 Jun 2013 01:09:35 +0200
Message-ID: <CAFFjANQWb8S4NJAGQYs2-O9abLKBCxE4M7SqWG4pB_CC1K5G4Q@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-4-git-send-email-tanoku@gmail.com> <7vk3lhzu0q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 01:10:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrcN6-0003xB-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 01:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065Ab3FYXJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 19:09:56 -0400
Received: from mail-vb0-f50.google.com ([209.85.212.50]:62197 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab3FYXJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 19:09:56 -0400
Received: by mail-vb0-f50.google.com with SMTP id w16so10043910vbb.23
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 16:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4i4S6Zc2+zE+lYVr2brotFMII697RfCrbzaMyViTPAA=;
        b=tJy7qcZSQLz+d3psZxRI7VuBl65LjHoK5RyekpGfqHi4vb8yLD4+PH+fy7XTQY50P2
         A8hNn+Tx3DLEpUV6jBHwdJId2IwfTJ3M5A9/ClzjEZYVvxnM90HTM4Bpr4RjyjCTdQkx
         AR48u8bpvOKStB+6HoU3n2ZoyA5pTHY6cu8SDwx7ZfQQavZ4E+CpAs5oCVsduApJ5Qh4
         yOi6pjUe1RxQ/3LSNWmL3KONecjkRmjHdmf4Ee/cUG2/iZygJlKuVNO4iKkCgVUHuCmJ
         h5MzvoP5rvjYh995Iw2aieLl4qa0U0RNEP7S4nUkysklHRI7pgTDy6HiXJl4vY82pgOY
         mnzw==
X-Received: by 10.58.85.161 with SMTP id i1mr632953vez.97.1372201795525; Tue,
 25 Jun 2013 16:09:55 -0700 (PDT)
Received: by 10.221.45.131 with HTTP; Tue, 25 Jun 2013 16:09:35 -0700 (PDT)
In-Reply-To: <7vk3lhzu0q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229015>

On Wed, Jun 26, 2013 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> After this, the function returns.  The original did not add to the
> table the object name we are looking at, but the new code first adds
> it to the table with the unconditional kh_put_sha1() above.  Is a
> call to kh_del_sha1() missing here ...

No, this is not the case. That's the return case for when *the object
was found because it already existed in the hash table* (hence we
access it if we're excluding it, to tag it as excluded). We don't want
to remove it from the hash table because we're not the ones we
inserted it.

We only call `kh_del_sha1` in the cases where:

    1. The object wasn't found.
    2. We inserted its key on the hash table.
    3. We later learnt that we don't really want to pack this object.

>
>> @@ -921,38 +916,42 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>>               return 0;
>>       }
>>
>> -     if (!exclude && local && has_loose_object_nonlocal(sha1))
>> +     if (!exclude && local && has_loose_object_nonlocal(sha1)) {
>> +             kh_del_sha1(packed_objects, ix);
>>               return 0;
>
> ... like this one, which seems to compensate for "ahh, after all we
> realize we do not want to add this one to the table"?
>
>> @@ -966,19 +965,30 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>>               entry->in_pack_offset = found_offset;
>>       }
>>
>> -     if (object_ix_hashsz * 3 <= nr_objects * 4)
>> -             rehash_objects();
>> -     else
>> -             object_ix[-1 - ix] = nr_objects;
>> +     kh_value(packed_objects, ix) = entry;
>> +     kh_key(packed_objects, ix) = entry->idx.sha1;
>> +     objects[nr_objects++] = entry;
>>
>>       display_progress(progress_state, nr_objects);
>>
>> -     if (name && no_try_delta(name))
>> -             entry->no_try_delta = 1;
>> -
>>       return 1;
>>  }
>>
>> +static int add_object_entry(const unsigned char *sha1, enum object_type type,
>> +                         const char *name, int exclude)
>> +{
>> +     if (add_object_entry_1(sha1, type, name_hash(name), exclude, NULL, 0)) {
>> +             struct object_entry *entry = objects[nr_objects - 1];
>> +
>> +             if (name && no_try_delta(name))
>> +                     entry->no_try_delta = 1;
>> +
>> +             return 1;
>> +     }
>> +
>> +     return 0;
>> +}
>
> It is somewhat unclear what we are getting from the split of the
> main part of this function into *_1(), other than the *_1() function
> now has a very deep indentation inside "if (!found_pack)", which is
> always true because the caller always passes NULL to found_pack.
> Perhaps this is an unrelated refactoring that is needed for later
> steps and does not have anything to do with the use of new hash
> function?

Yes, apologies for not making this clear. By refactoring into `_1`,
you can see how `traverse_bitmap_commit_list` can use the `_1` version
directly as a callback, to insert objects straight into the packing
list without looking them up. This is very efficient because we can
pass the whole API straight from the bitmap code:

1. The SHA1: we find it by simply looking up the `nth` sha1 on the
pack index (if we are yielding bit `n`)
2. The object type: we find it because we have type indexes that let
us know the type of any given bit in the bitmap by and-ing it with the
index.
3. The hash for its name: we can look it up from the name hash cache
in the new bitmap format.
4. Exclude flag: we never exclude when working with bitmaps
5. found_pack: all the bitmapped objects come from the same pack!
6. found_offset: we find it by simply looking up the `nth` offset on
the pack index (if we are yielding bit `n`)

Boom! We filled the callback just from the data in a bitmap. Ain't that nice?

Let me amend the commit message.
