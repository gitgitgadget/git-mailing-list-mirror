From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 12/19] read-cache: read index-v5
Date: Thu, 8 Aug 2013 09:00:51 +0700
Message-ID: <CACsJy8C4r=5K3ZdzNnNJ95xS3_xnsTSH2bUyLJ+rwRv4Jxo2zw@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
 <1373650024-3001-13-git-send-email-t.gummerer@gmail.com> <CACsJy8DDRN5aTOzxuiGSa6UjbBiVUYwHjPcnN+8mw4xKmvkx-A@mail.gmail.com>
 <87r4exsj14.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 04:01:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7FXc-0004se-0P
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 04:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757613Ab3HHCBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 22:01:22 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56309 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757597Ab3HHCBV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 22:01:21 -0400
Received: by mail-ob0-f169.google.com with SMTP id wc20so4754324obb.14
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 19:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x1EYTOL4Y69WdH/QnWR6tCmpSqL+CMnrk6xHCdr9+x4=;
        b=jXsl5EMxc4WUpd+SWb07UIjorXocKZsDQkKY4bpfted2oQjM5Vy0H6bIvEpOzG8S5i
         HFIWWpXLXaZD2y3jVgzDEQMKyhCbcREeOCF6pA2BX1Ks+cbaAQYXOdip872i9TImneIy
         W4GajyiGpY+3wcwa9sPPFyp1Ixgj2VmYbpV+YO5J4RzRrl236WnYy2pnHndC2wQVdV/P
         jFyrAfxhK7m1arh6ZxDkskkxVORKwPONk4msvOIQPF3DsJyXB+bpB5fpIr2T4Gvti3VJ
         MCl/qywVaJZPaA9/9r/7RN2KDGNT41BGrcjPkolZJeZ02jlJxzEm9QvZVbEHTwilPMvf
         fY+g==
X-Received: by 10.182.199.100 with SMTP id jj4mr4658790obc.102.1375927281224;
 Wed, 07 Aug 2013 19:01:21 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 7 Aug 2013 19:00:51 -0700 (PDT)
In-Reply-To: <87r4exsj14.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231855>

On Wed, Jul 17, 2013 at 3:11 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
> [..]
>
>>> +static int read_entries(struct index_state *istate, struct directory_entry **de,
>>> +                       unsigned int *entry_offset, void **mmap,
>>> +                       unsigned long mmap_size, unsigned int *nr,
>>> +                       unsigned int *foffsetblock)
>>> +{
>>> +       struct cache_entry *head = NULL, *tail = NULL;
>>> +       struct conflict_entry *conflict_queue;
>>> +       struct cache_entry *ce;
>>> +       int i;
>>> +
>>> +       conflict_queue = NULL;
>>> +       if (read_conflicts(&conflict_queue, *de, mmap, mmap_size) < 0)
>>> +               return -1;
>>> +       for (i = 0; i < (*de)->de_nfiles; i++) {
>>> +               if (read_entry(&ce,
>>> +                              *de,
>>> +                              entry_offset,
>>> +                              mmap,
>>> +                              mmap_size,
>>> +                              foffsetblock) < 0)
>>> +                       return -1;
>>> +               ce_queue_push(&head, &tail, ce);
>>> +               *foffsetblock += 4;
>>> +
>>> +               /*
>>> +                * Add the conflicted entries at the end of the index file
>>> +                * to the in memory format
>>> +                */
>>> +               if (conflict_queue &&
>>> +                   (conflict_queue->entries->flags & CONFLICT_CONFLICTED) != 0 &&
>>> +                   !cache_name_compare(conflict_queue->name, conflict_queue->namelen,
>>> +                                       ce->name, ce_namelen(ce))) {
>>> +                       struct conflict_part *cp;
>>> +                       cp = conflict_queue->entries;
>>> +                       cp = cp->next;
>>> +                       while (cp) {
>>> +                               ce = convert_conflict_part(cp,
>>> +                                               conflict_queue->name,
>>> +                                               conflict_queue->namelen);
>>> +                               ce_queue_push(&head, &tail, ce);
>>> +                               conflict_part_head_remove(&cp);
>>> +                       }
>>> +                       conflict_entry_head_remove(&conflict_queue);
>>> +               }
>>
>> I start to wonder if separating staged entries is a good idea. It
>> seems to make the code more complicated. The good point about conflict
>> section at the end of the file is you can just truncate() it out.
>> Another way is putting staged entries in fileentries, sorted
>> alphabetically then by stage number, and a flag indicating if the
>> entry is valid. When you remove resolve an entry, just set the flag to
>> invalid (partial write), so that read code will skip it.
>>
>> I think this approach is reasonably cheap (unless there are a lot of
>> conflicts) and it simplifies this piece of code. truncate() may be
>> overrated anyway. In my experience, I "git add <path>" as soon as I
>> resolve <path> (so that "git diff" shrinks). One entry at a time, one
>> index write at a time. I don't think I ever resolve everything then
>> "git add -u .", which is where truncate() shines because staged
>> entries are removed all at once. We should optimize for one file
>> resolution at a time, imo.
>
> Thanks for your comments.  I'll address the other ones once we decided
> to do with the conflicts.
>
> It does make the code quite a bit more complicated, but also has one
> advantage that you overlooked.

I did overlook, although my goal is to keep the code simpler, not more
comlicated. The thinking is if we can find everything in fileentries
table, the code here is simplified, so..

> We wouldn't truncate() when resolving
> the conflicts.  The resolve undo data is stored with the conflicts and
> therefore we could just flip a bit and set the stage of the cache-entry
> in the main index to 0 (always once we got partial writing).  This can
> be fast both in case we resolve one entry at a time and when we resolve
> a lot of entries.  The advantage is even bigger when we resolve one
> entry at a time, when we otherwise would have to re-write the index for
> each conflict resolution.

If I understand it correctly, filentries can only contain stage-0 or
stage-1 entries, "stage > 0" entries are stored in conflict data. Once
a conflict is solved, you update the stage-1 entry in fileentries,
turning it to stage-0 and recalculate the entry checksum. Conflict
data remains there to function as the old REUC extension. Correct?

First of all, if that's true, we only need 1 bit for stage in fileentries table.

Secondly, you may get away with looking up to conflict data in this
function by storing all stages in fileentries (now we need 2-bit
stage), replicated in conflict data for reuc function. When you
resolve conflict, you flip stage-1 to stage-0, and flip (a new bit) to
mark stage-2 entry invalid so the code knows to skip it. Next time the
index is rewritten, invalid entries are removed, but we still have old
stage entries in conflict data. The flipping business is pretty much
what you plan anyway, but the reading code does not need to look at
both fileentries and conflict data at the same time.

What do you think?
-- 
Duy
