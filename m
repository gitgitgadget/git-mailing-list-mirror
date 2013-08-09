From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 12/19] read-cache: read index-v5
Date: Fri, 09 Aug 2013 15:10:31 +0200
Message-ID: <87eha3qabc.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-13-git-send-email-t.gummerer@gmail.com> <CACsJy8DDRN5aTOzxuiGSa6UjbBiVUYwHjPcnN+8mw4xKmvkx-A@mail.gmail.com> <87r4exsj14.fsf@gmail.com> <CACsJy8C4r=5K3ZdzNnNJ95xS3_xnsTSH2bUyLJ+rwRv4Jxo2zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 15:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7mSn-0002F0-4O
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 15:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104Ab3HINKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 09:10:37 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:45955 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757990Ab3HINKg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 09:10:36 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so2037846ead.2
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=CWvPZZ3qJ0nHq0r9tXZdq3J8iozYqM6tc62BJUp9Qq8=;
        b=TSjYVGcjF5AWFrW9JmAbA5dxzyeNXrcvpLcOmpTjF8VY6qgKNL8wUfzw0cJYbsP0a3
         LA2EiT62o5wJZoeEm6KJrYE8WdpWh5Zh9gvKhxUu00BxrMAmzS5X3m0V2BW6QOIDSjRn
         sj/R9ZVXaKJHeioHKgq7UYFGlHzkGciJ4cyQsABDvBxt5juG9RolwFqP4ebBUqNKxt2O
         oY9HBB+H1XbSv1o/dJva8IovfKtue9RnW1r/sNfV5sqzNwdYCrWegSkI9/ck5spfCjQ3
         UGQxkNELb+Nnrrl0aciio5+sGQx7gMWcYcGFQ/fiY5UxaidkDHaFRPaUHSL+qQfo6i6f
         RxvA==
X-Received: by 10.14.224.66 with SMTP id w42mr6282985eep.1.1376053834651;
        Fri, 09 Aug 2013 06:10:34 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id k7sm28573217eeg.13.2013.08.09.06.10.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 06:10:33 -0700 (PDT)
In-Reply-To: <CACsJy8C4r=5K3ZdzNnNJ95xS3_xnsTSH2bUyLJ+rwRv4Jxo2zw@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231979>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jul 17, 2013 at 3:11 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>> [..]
>>
>>>> +static int read_entries(struct index_state *istate, struct directory_entry **de,
>>>> +                       unsigned int *entry_offset, void **mmap,
>>>> +                       unsigned long mmap_size, unsigned int *nr,
>>>> +                       unsigned int *foffsetblock)
>>>> +{
>>>> +       struct cache_entry *head = NULL, *tail = NULL;
>>>> +       struct conflict_entry *conflict_queue;
>>>> +       struct cache_entry *ce;
>>>> +       int i;
>>>> +
>>>> +       conflict_queue = NULL;
>>>> +       if (read_conflicts(&conflict_queue, *de, mmap, mmap_size) < 0)
>>>> +               return -1;
>>>> +       for (i = 0; i < (*de)->de_nfiles; i++) {
>>>> +               if (read_entry(&ce,
>>>> +                              *de,
>>>> +                              entry_offset,
>>>> +                              mmap,
>>>> +                              mmap_size,
>>>> +                              foffsetblock) < 0)
>>>> +                       return -1;
>>>> +               ce_queue_push(&head, &tail, ce);
>>>> +               *foffsetblock += 4;
>>>> +
>>>> +               /*
>>>> +                * Add the conflicted entries at the end of the index file
>>>> +                * to the in memory format
>>>> +                */
>>>> +               if (conflict_queue &&
>>>> +                   (conflict_queue->entries->flags & CONFLICT_CONFLICTED) != 0 &&
>>>> +                   !cache_name_compare(conflict_queue->name, conflict_queue->namelen,
>>>> +                                       ce->name, ce_namelen(ce))) {
>>>> +                       struct conflict_part *cp;
>>>> +                       cp = conflict_queue->entries;
>>>> +                       cp = cp->next;
>>>> +                       while (cp) {
>>>> +                               ce = convert_conflict_part(cp,
>>>> +                                               conflict_queue->name,
>>>> +                                               conflict_queue->namelen);
>>>> +                               ce_queue_push(&head, &tail, ce);
>>>> +                               conflict_part_head_remove(&cp);
>>>> +                       }
>>>> +                       conflict_entry_head_remove(&conflict_queue);
>>>> +               }
>>>
>>> I start to wonder if separating staged entries is a good idea. It
>>> seems to make the code more complicated. The good point about conflict
>>> section at the end of the file is you can just truncate() it out.
>>> Another way is putting staged entries in fileentries, sorted
>>> alphabetically then by stage number, and a flag indicating if the
>>> entry is valid. When you remove resolve an entry, just set the flag to
>>> invalid (partial write), so that read code will skip it.
>>>
>>> I think this approach is reasonably cheap (unless there are a lot of
>>> conflicts) and it simplifies this piece of code. truncate() may be
>>> overrated anyway. In my experience, I "git add <path>" as soon as I
>>> resolve <path> (so that "git diff" shrinks). One entry at a time, one
>>> index write at a time. I don't think I ever resolve everything then
>>> "git add -u .", which is where truncate() shines because staged
>>> entries are removed all at once. We should optimize for one file
>>> resolution at a time, imo.
>>
>> Thanks for your comments.  I'll address the other ones once we decided
>> to do with the conflicts.
>>
>> It does make the code quite a bit more complicated, but also has one
>> advantage that you overlooked.
>
> I did overlook, although my goal is to keep the code simpler, not more
> comlicated. The thinking is if we can find everything in fileentries
> table, the code here is simplified, so..
>
>> We wouldn't truncate() when resolving
>> the conflicts.  The resolve undo data is stored with the conflicts and
>> therefore we could just flip a bit and set the stage of the cache-entry
>> in the main index to 0 (always once we got partial writing).  This can
>> be fast both in case we resolve one entry at a time and when we resolve
>> a lot of entries.  The advantage is even bigger when we resolve one
>> entry at a time, when we otherwise would have to re-write the index for
>> each conflict resolution.
>
> If I understand it correctly, filentries can only contain stage-0 or
> stage-1 entries, "stage > 0" entries are stored in conflict data. Once
> a conflict is solved, you update the stage-1 entry in fileentries,
> turning it to stage-0 and recalculate the entry checksum. Conflict
> data remains there to function as the old REUC extension. Correct?
>
> First of all, if that's true, we only need 1 bit for stage in fileentries table.
>
> Secondly, you may get away with looking up to conflict data in this
> function by storing all stages in fileentries (now we need 2-bit
> stage), replicated in conflict data for reuc function. When you
> resolve conflict, you flip stage-1 to stage-0, and flip (a new bit) to
> mark stage-2 entry invalid so the code knows to skip it. Next time the
> index is rewritten, invalid entries are removed, but we still have old
> stage entries in conflict data. The flipping business is pretty much
> what you plan anyway, but the reading code does not need to look at
> both fileentries and conflict data at the same time.
>
> What do you think?

I've now tried it out for my synthetic repository, and created ~115,000
conflicts in it.  It's a only a little slower even for that large number
of conflicts (which I don't think will ever happen in practice) but the
code is definitely simpler, so I will go with this.  The times for the
old and new version are below.

Test                                        HEAD~1            this tree
-----------------------------------------------------------------------------------
0003.2: v[23]: update-index                 3.50(2.87+0.61)   3.52(2.89+0.60) +0.6%
0003.3: v[23]: grep nonexistent -- subdir   1.80(1.43+0.35)   1.86(1.50+0.34) +3.3%
0003.4: v[23]: ls-files -- subdir           1.67(1.29+0.36)   1.70(1.31+0.37) +1.8%
0003.6: v4: update-index                    2.97(2.44+0.51)   3.00(2.50+0.48) +1.0%
0003.7: v4: grep nonexistent -- subdir      1.45(1.12+0.31)   1.48(1.06+0.40) +2.1%
0003.8: v4: ls-files -- subdir              1.33(0.99+0.33)   1.35(1.02+0.32) +1.5%
0003.10: v5: update-index                   2.42(1.87+0.54)   2.50(1.84+0.63) +3.3%
0003.11: v5: ls-files                       1.75(1.38+0.35)   1.80(1.37+0.41) +2.9%
0003.12: v5: grep nonexistent -- subdir     0.07(0.05+0.01)   0.07(0.05+0.01) +0.0%
0003.13: v5: ls-files -- subdir             0.07(0.05+0.01)   0.07(0.06+0.00) +0.0%
