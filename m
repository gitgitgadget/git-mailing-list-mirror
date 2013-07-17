From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 12/19] read-cache: read index-v5
Date: Wed, 17 Jul 2013 10:11:19 +0200
Message-ID: <87r4exsj14.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-13-git-send-email-t.gummerer@gmail.com> <CACsJy8DDRN5aTOzxuiGSa6UjbBiVUYwHjPcnN+8mw4xKmvkx-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 10:12:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzMqk-0006g7-6X
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 10:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab3GQIM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 04:12:28 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54090 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab3GQILX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 04:11:23 -0400
Received: by mail-ee0-f46.google.com with SMTP id d41so846530eek.19
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=P5UOP785Pth4wd5XCJh0uv2xTnICaMp/qEe3GxU5TUc=;
        b=JGVxcUqx2Lr7nzbbkAdIwpNTv6JXtCxMD1HIT0KMAEziwqeZh0yIB0DZJgtGC/PnyQ
         shP8ppIuW9s4y+fUab7SB47CVE+sy5BhQBpGnQrGTkZL2IHiHURy/y+00hfaLkjxTHPc
         hFcT2PeRpogOxb4Kwp8a81MfA8IOjeJCh3XTIhleL5ixSxNxOOMq4AZZMDF2KKyqD/zM
         E9eI20e2Io/97E/sLiSgEcgk+tMAxou3+e8/cA245XDGUwiZ/5e8Bb46kMC+nOLlWtl6
         WQyLYffp2hu8RSU/9va2P0NAGJkuXNab1jK+iJ1zW1Pv36Px4KwzvbDOV4NHLm30ZyHm
         Pe1A==
X-Received: by 10.14.2.137 with SMTP id 9mr5192841eef.64.1374048682380;
        Wed, 17 Jul 2013 01:11:22 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id n5sm8791522eed.9.2013.07.17.01.11.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 01:11:21 -0700 (PDT)
In-Reply-To: <CACsJy8DDRN5aTOzxuiGSa6UjbBiVUYwHjPcnN+8mw4xKmvkx-A@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230608>

Duy Nguyen <pclouds@gmail.com> writes:

[..]

>> +static int read_entries(struct index_state *istate, struct directory_entry **de,
>> +                       unsigned int *entry_offset, void **mmap,
>> +                       unsigned long mmap_size, unsigned int *nr,
>> +                       unsigned int *foffsetblock)
>> +{
>> +       struct cache_entry *head = NULL, *tail = NULL;
>> +       struct conflict_entry *conflict_queue;
>> +       struct cache_entry *ce;
>> +       int i;
>> +
>> +       conflict_queue = NULL;
>> +       if (read_conflicts(&conflict_queue, *de, mmap, mmap_size) < 0)
>> +               return -1;
>> +       for (i = 0; i < (*de)->de_nfiles; i++) {
>> +               if (read_entry(&ce,
>> +                              *de,
>> +                              entry_offset,
>> +                              mmap,
>> +                              mmap_size,
>> +                              foffsetblock) < 0)
>> +                       return -1;
>> +               ce_queue_push(&head, &tail, ce);
>> +               *foffsetblock += 4;
>> +
>> +               /*
>> +                * Add the conflicted entries at the end of the index file
>> +                * to the in memory format
>> +                */
>> +               if (conflict_queue &&
>> +                   (conflict_queue->entries->flags & CONFLICT_CONFLICTED) != 0 &&
>> +                   !cache_name_compare(conflict_queue->name, conflict_queue->namelen,
>> +                                       ce->name, ce_namelen(ce))) {
>> +                       struct conflict_part *cp;
>> +                       cp = conflict_queue->entries;
>> +                       cp = cp->next;
>> +                       while (cp) {
>> +                               ce = convert_conflict_part(cp,
>> +                                               conflict_queue->name,
>> +                                               conflict_queue->namelen);
>> +                               ce_queue_push(&head, &tail, ce);
>> +                               conflict_part_head_remove(&cp);
>> +                       }
>> +                       conflict_entry_head_remove(&conflict_queue);
>> +               }
>
> I start to wonder if separating staged entries is a good idea. It
> seems to make the code more complicated. The good point about conflict
> section at the end of the file is you can just truncate() it out.
> Another way is putting staged entries in fileentries, sorted
> alphabetically then by stage number, and a flag indicating if the
> entry is valid. When you remove resolve an entry, just set the flag to
> invalid (partial write), so that read code will skip it.
>
> I think this approach is reasonably cheap (unless there are a lot of
> conflicts) and it simplifies this piece of code. truncate() may be
> overrated anyway. In my experience, I "git add <path>" as soon as I
> resolve <path> (so that "git diff" shrinks). One entry at a time, one
> index write at a time. I don't think I ever resolve everything then
> "git add -u .", which is where truncate() shines because staged
> entries are removed all at once. We should optimize for one file
> resolution at a time, imo.

Thanks for your comments.  I'll address the other ones once we decided
to do with the conflicts.

It does make the code quite a bit more complicated, but also has one
advantage that you overlooked.  We wouldn't truncate() when resolving
the conflicts.  The resolve undo data is stored with the conflicts and
therefore we could just flip a bit and set the stage of the cache-entry
in the main index to 0 (always once we got partial writing).  This can
be fast both in case we resolve one entry at a time and when we resolve
a lot of entries.  The advantage is even bigger when we resolve one
entry at a time, when we otherwise would have to re-write the index for
each conflict resolution.

[..]
