From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] index-pack: kill union delta_base to save memory
Date: Sat, 04 Jul 2015 15:24:48 -0700
Message-ID: <xmqqvbdz36j3.fsf@gitster.dls.corp.google.com>
References: <1429354025-24659-1-git-send-email-pclouds@gmail.com>
	<1429354025-24659-3-git-send-email-pclouds@gmail.com>
	<xmqqoajt5glu.fsf@gitster.dls.corp.google.com>
	<CACsJy8D872sj9WQec_FZrTxx=gqy++L1XLxJdEtEQNpGpFYr=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 11:23:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBg9R-0001jI-T1
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 11:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbbGEJXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 05:23:50 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38197 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbGEJXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 05:23:48 -0400
Received: by igrv9 with SMTP id v9so97808833igr.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Upd4j74z9H1zGLu4aA3QzGE5F2rGVUCADqasOS1Q1Jw=;
        b=Oo8wO9Nij0J6xVy0uIxccEatKQ922afV11IugqK0hWsZePVoVfhdcDdqZenERHQdmx
         vQiFlEAtXBf+3noxNKPLHfUDlpwXZEhY3WSIG6j9eJPd0ehkf7qWVXomHI72o++nzc81
         k48n/JcS6lCf8CQ2oakCpZNoyYM/HpZjRIw8N4CXZ2Gu2JLwbc+YeS4TjNdIc8x+FK5Y
         Mj8AZMI9+t64+jHR+y3Zn4lSf2LAb0dM9dnF/wPpo1QFwrb/S3n5r16vmkJN8Jc0cSiQ
         UC09C3RWKZlCye74OkfPyxylUcbZaiCywXmo82KVh3oS5xPjs1/7krvlAeiDU0Q++vgc
         MaRA==
X-Received: by 10.42.144.131 with SMTP id b3mr26774007icv.35.1436048691100;
        Sat, 04 Jul 2015 15:24:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:188c:ec45:d02d:4866])
        by mx.google.com with ESMTPSA id a139sm9213190ioa.14.2015.07.04.15.24.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 04 Jul 2015 15:24:49 -0700 (PDT)
In-Reply-To: <CACsJy8D872sj9WQec_FZrTxx=gqy++L1XLxJdEtEQNpGpFYr=Q@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 4 Jul 2015 01:29:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273353>

Duy Nguyen <pclouds@gmail.com> writes:

>>> @@ -1282,28 +1344,25 @@ static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolved)
>>>        * resolving deltas in the same order as their position in the pack.
>>>        */
>>>       sorted_by_pos = xmalloc(nr_unresolved * sizeof(*sorted_by_pos));
>>> -     for (i = 0; i < nr_deltas; i++) {
>>> -             if (objects[deltas[i].obj_no].real_type != OBJ_REF_DELTA)
>>> -                     continue;
>>> -             sorted_by_pos[n++] = &deltas[i];
>>> -     }
>>> +     for (i = 0; i < nr_ref_deltas; i++)
>>> +             sorted_by_pos[n++] = &ref_deltas[i];
>>>       qsort(sorted_by_pos, n, sizeof(*sorted_by_pos), delta_pos_compare);
>>
>> You allocate an array of nr_unresolved (which is the sum of
>> nr_ref_deltas and nr_ofs_deltas in the new world order with patch)
>> entries, fill only the first nr_ref_deltas entries of it, and then
>> sort that first n (= nr_ref_deltas) entries.  The qsort and the
>> subsequent loop only looks at the first n entries, so nothing is
>> filling or reading these nr_ofs_deltas entres at the end.
>>
>> I do not see any wrong behaviour other than temporary wastage of
>> nr_ofs_deltas pointers that would be caused by this, but this
>> allocation is misleading.
>>
>> Also, the old code before this change had to use 'i' and 'n' because
>> some of the things we see in the (old) deltas[] array we scanned
>> with 'i' would not make it into the sorted_by_pos[] array in the old
>> world order, but now because you have only ref delta in a separate
>> ref_deltas[] array, they increment lock&step.  That also puzzled me
>> while re-reading this code.
>>
>> Perhaps something like this is needed?
>
> Yeah I can see the confusion when reading the code without checking
> its history. You probably want to kill the argument nr_unresolved too
> because it's not needed anymore after your patch.
>
> So what's the bug you mentioned? All I got from the above was wastage
> and confusion, no bug.

Actually, the above is not analyzed correctly.  I thought
nr_unresolved was ref + ofs, but look at the caller in the
fix_thin_pack codepath:

	int nr_unresolved = nr_ofs_deltas + nr_ref_deltas - nr_resolved_deltas;
	int nr_objects_initial = nr_objects;
	if (nr_unresolved <= 0)
		die(_("confusion beyond insanity"));
	REALLOC_ARRAY(objects, nr_objects + nr_unresolved + 1);
	memset(objects + nr_objects + 1, 0,
	       nr_unresolved * sizeof(*objects));
	f = sha1fd(output_fd, curr_pack);
	fix_unresolved_deltas(f, nr_unresolved);

If there were tons of nr_resolved_deltas and only small number of
nr_ofs_deltas, then the allocation in question may actually be
under-allocating.

So...
