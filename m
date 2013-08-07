From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 12/19] read-cache: read index-v5
Date: Wed, 07 Aug 2013 10:23:50 +0200
Message-ID: <87k3jxrjs9.fsf@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Aug 07 10:24:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6z2L-0006uZ-3m
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 10:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106Ab3HGIYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 04:24:00 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:37968 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab3HGIX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 04:23:56 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so1620256pbc.12
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=2aHDhGsRt+t8l6QUlTRNht/yELrviKeVrorfpOC38nM=;
        b=kbw6R0N4Y3hDDmflsorF1FSyfuXbXaJ9bnbXfPew4jqLMX91VC+7N/i0HqtoRJmXp8
         YA+2Y+5TDWICumTtP9e3lVinh/uEy1KvAEW+C0vc0aDPjPPEIXxLeRFe7umVdtwqq8Aj
         u7C261SLC9ud9rm04iFbe+VItDFUDNJac6c7cW2Raa9go1umNxNYNODesGMkjQACQiEc
         iwZmdFD7Yx27uBX5qaRdA7fdYQvW1z+/iK0uUwQp6v7Vyif/Z6FPUmt4ps/5MobyV9Sq
         RSEFYoHyYtljDSZxDMbTv1a4wDTvI8+y+MOIVlvH5kjoNLMbHqU+NDP21Kijqcm7fu9c
         RwQg==
X-Received: by 10.66.169.172 with SMTP id af12mr3256295pac.23.1375863835943;
        Wed, 07 Aug 2013 01:23:55 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id lm2sm9011617pab.2.2013.08.07.01.23.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 01:23:54 -0700 (PDT)
In-Reply-To: <CACsJy8DDRN5aTOzxuiGSa6UjbBiVUYwHjPcnN+8mw4xKmvkx-A@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231810>

Duy Nguyen <pclouds@gmail.com> writes:

> A little bit more..
>
> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +static void ce_queue_push(struct cache_entry **head,
>> +                            struct cache_entry **tail,
>> +                            struct cache_entry *ce)
>> +{
>> +       if (!*head) {
>> +               *head = *tail = ce;
>> +               (*tail)->next = NULL;
>> +               return;
>> +       }
>> +
>> +       (*tail)->next = ce;
>> +       ce->next = NULL;
>> +       *tail = (*tail)->next;
>
> No no no. "next" is for name-hash.c don't "reuse" it here. And I don't
> think you really need to maintain a linked list of cache_entries by
> the way. More on read_entries comments below..

You're right, I don't need it for the reading code.  I do need to keep a
list of cache-entries for writing though, where a linked list is best
suited for the task.  I'll use a next_ce pointer for that.

>> +}
>> +
>> +static struct cache_entry *ce_queue_pop(struct cache_entry **head)
>> +{
>> +       struct cache_entry *ce;
>> +
>> +       ce = *head;
>> +       *head = (*head)->next;
>> +       return ce;
>> +}
>
> Same as ce_queue_push.
>
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
>
>> +       }
>> +
>> +       *de = (*de)->next;
>> +
>> +       while (head) {
>> +               if (*de != NULL
>> +                   && strcmp(head->name, (*de)->pathname) > 0) {
>> +                       read_entries(istate,
>> +                                    de,
>> +                                    entry_offset,
>> +                                    mmap,
>> +                                    mmap_size,
>> +                                    nr,
>> +                                    foffsetblock);
>> +               } else {
>> +                       ce = ce_queue_pop(&head);
>> +                       set_index_entry(istate, *nr, ce);
>> +                       (*nr)++;
>> +                       ce->next = NULL;
>> +               }
>
> In this loop, you do some sort of merge sort combining a list of
> sorted files and a list of sorted directories (which will be expanded
> to bunches of files by the recursive read_entries). strcmp() does two
> things. Assume we're in directory 'a', it makes sure that subdirectory
> 'a/b' is only inserted after file 'a/a' is inserted to maintain index
> sort order. It also makes sure that 'de' of an outside directory 'b'
> will not be expanded here. strcmp will be called for every file,
> checking _full_ path. Sounds expensive.
>
> If you maintain two pointers first_subdir and next_sibling in "de" as
> in my previous mail, you know "de" 'b' is out without string
> comparison (de->next_sibling would be NULL). With that, the purpose of
> strcmp is simply making sure that 'a/b' is inserted after 'a/a'.
> Because we know all possible "de" is a subdirectory of 'a', we don't
> need to compare the prefix 'a/'. We still need to strcmp on every
> file, but we only need to compare the file name, not the leading
> directory anymore. Cheaper.
>
> Going further, I wonder if we could eliminate strcmp completely. We
> could store dummy entries in fileentries to mark the positions of the
> subdirectories. When we encounter a dummy entry, we call
> read_entries() instead of set_index_entry.

I've tried implementing both versions with the internal tree structure,
see below for timings.

simpleapi is the code that was posted to the list, HEAD uses a
tree-structure for the directories internally, and replaces strcmp with
cache_name_compare and leaves out the prefix.  This tree uses dummy
entries for the sub-directories.

Dummy entries are single NUL-bytes mixed with the cache-entries, which
should give optimal performance.  I haven't thought much about
corruption of the index, but I don't think we would need any additional
crc checksums or similar.

The performance advantage seems very slim to none when using the dummy
entries to avoid the comparison though, so I don't think it makes sense
to make the index more complicated for a very small speed-up.

Test                                        simpleapi         HEAD                     this tree             
-------------------------------------------------------------------------------------------------------------
0003.2: v[23]: update-index                 3.22(2.61+0.58)   3.20(2.56+0.61) -0.6%    3.22(2.67+0.53) +0.0% 
0003.3: v[23]: grep nonexistent -- subdir   1.65(1.36+0.27)   1.65(1.34+0.30) +0.0%    1.67(1.34+0.31) +1.2% 
0003.4: v[23]: ls-files -- subdir           1.50(1.20+0.29)   1.54(1.18+0.34) +2.7%    1.53(1.22+0.30) +2.0% 
0003.6: v4: update-index                    2.69(2.28+0.39)   2.70(2.21+0.47) +0.4%    2.70(2.27+0.41) +0.4% 
0003.7: v4: grep nonexistent -- subdir      1.33(0.98+0.34)   1.36(1.01+0.33) +2.3%    1.34(1.03+0.30) +0.8% 
0003.8: v4: ls-files -- subdir              1.21(0.86+0.33)   1.23(0.91+0.30) +1.7%    1.22(0.90+0.30) +0.8% 
0003.10: v5: update-index                   2.12(1.58+0.52)   2.20(1.67+0.52) +3.8%    2.19(1.66+0.51) +3.3% 
0003.11: v5: ls-files                       1.57(1.21+0.34)   1.55(1.20+0.33) -1.3%    1.52(1.21+0.29) -3.2% 
0003.12: v5: grep nonexistent -- subdir     0.08(0.06+0.01)   0.07(0.04+0.02) -12.5%   0.07(0.04+0.02) -12.5%
0003.13: v5: ls-files -- subdir             0.07(0.04+0.01)   0.06(0.05+0.00) -14.3%   0.07(0.05+0.01) +0.0% 


> If you merge the "read_entry" for loop in this while loop, you don't
> need to maintain a linked list of ce to pop out one by one here.

Makes sense, I'll do that.

>> +       }
>> +       return 0;
>> +}
>> +
> --
> Duy
