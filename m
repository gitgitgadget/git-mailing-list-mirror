From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 12/19] read-cache: read index-v5
Date: Mon, 15 Jul 2013 17:12:45 +0700
Message-ID: <CACsJy8DDRN5aTOzxuiGSa6UjbBiVUYwHjPcnN+8mw4xKmvkx-A@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-13-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 12:13:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyfmS-000227-Do
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 12:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab3GOKNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 06:13:16 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:60482 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869Ab3GOKNP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 06:13:15 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so13635717obb.8
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bCt6yvdu+SbuULJyeejzeEREqCtHQVcgTZETdvuCQeY=;
        b=PzUmmJdv43tMLsfmp40QRh+81v4w0RCT2q5WRVMOGW05KjOzKq5JYKj6dhHP43Mb1k
         1s1ROIER4BnMaMenV53Q4Z9JLQclyqXmbWg47d8PGK7Vo2FvLt961nQixD5PDbJPSVCx
         IxPGxRIvfIkWckL7/mQFbpazbfJv4OHUCiJNygsN7Nui/jNgEtEdVZjfuQupJdn+wQ4K
         izSAET8RS54FZaLkakItyU24AyqYudYXULarLjcpvauVa9j7VTELap0Ut97kyKj6VIrA
         Pus/n3qbNbn/aoJh34py2KBg+HjnLAn18gmGeyuilAVXuG82SK3cfUfa0DLT0H0694nh
         wPvw==
X-Received: by 10.182.142.104 with SMTP id rv8mr38341353obb.3.1373883195145;
 Mon, 15 Jul 2013 03:13:15 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Mon, 15 Jul 2013 03:12:45 -0700 (PDT)
In-Reply-To: <1373650024-3001-13-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230456>

A little bit more..

On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +static void ce_queue_push(struct cache_entry **head,
> +                            struct cache_entry **tail,
> +                            struct cache_entry *ce)
> +{
> +       if (!*head) {
> +               *head = *tail = ce;
> +               (*tail)->next = NULL;
> +               return;
> +       }
> +
> +       (*tail)->next = ce;
> +       ce->next = NULL;
> +       *tail = (*tail)->next;

No no no. "next" is for name-hash.c don't "reuse" it here. And I don't
think you really need to maintain a linked list of cache_entries by
the way. More on read_entries comments below..

> +}
> +
> +static struct cache_entry *ce_queue_pop(struct cache_entry **head)
> +{
> +       struct cache_entry *ce;
> +
> +       ce = *head;
> +       *head = (*head)->next;
> +       return ce;
> +}

Same as ce_queue_push.

> +static int read_entries(struct index_state *istate, struct directory_entry **de,
> +                       unsigned int *entry_offset, void **mmap,
> +                       unsigned long mmap_size, unsigned int *nr,
> +                       unsigned int *foffsetblock)
> +{
> +       struct cache_entry *head = NULL, *tail = NULL;
> +       struct conflict_entry *conflict_queue;
> +       struct cache_entry *ce;
> +       int i;
> +
> +       conflict_queue = NULL;
> +       if (read_conflicts(&conflict_queue, *de, mmap, mmap_size) < 0)
> +               return -1;
> +       for (i = 0; i < (*de)->de_nfiles; i++) {
> +               if (read_entry(&ce,
> +                              *de,
> +                              entry_offset,
> +                              mmap,
> +                              mmap_size,
> +                              foffsetblock) < 0)
> +                       return -1;
> +               ce_queue_push(&head, &tail, ce);
> +               *foffsetblock += 4;
> +
> +               /*
> +                * Add the conflicted entries at the end of the index file
> +                * to the in memory format
> +                */
> +               if (conflict_queue &&
> +                   (conflict_queue->entries->flags & CONFLICT_CONFLICTED) != 0 &&
> +                   !cache_name_compare(conflict_queue->name, conflict_queue->namelen,
> +                                       ce->name, ce_namelen(ce))) {
> +                       struct conflict_part *cp;
> +                       cp = conflict_queue->entries;
> +                       cp = cp->next;
> +                       while (cp) {
> +                               ce = convert_conflict_part(cp,
> +                                               conflict_queue->name,
> +                                               conflict_queue->namelen);
> +                               ce_queue_push(&head, &tail, ce);
> +                               conflict_part_head_remove(&cp);
> +                       }
> +                       conflict_entry_head_remove(&conflict_queue);
> +               }

I start to wonder if separating staged entries is a good idea. It
seems to make the code more complicated. The good point about conflict
section at the end of the file is you can just truncate() it out.
Another way is putting staged entries in fileentries, sorted
alphabetically then by stage number, and a flag indicating if the
entry is valid. When you remove resolve an entry, just set the flag to
invalid (partial write), so that read code will skip it.

I think this approach is reasonably cheap (unless there are a lot of
conflicts) and it simplifies this piece of code. truncate() may be
overrated anyway. In my experience, I "git add <path>" as soon as I
resolve <path> (so that "git diff" shrinks). One entry at a time, one
index write at a time. I don't think I ever resolve everything then
"git add -u .", which is where truncate() shines because staged
entries are removed all at once. We should optimize for one file
resolution at a time, imo.

> +       }
> +
> +       *de = (*de)->next;
> +
> +       while (head) {
> +               if (*de != NULL
> +                   && strcmp(head->name, (*de)->pathname) > 0) {
> +                       read_entries(istate,
> +                                    de,
> +                                    entry_offset,
> +                                    mmap,
> +                                    mmap_size,
> +                                    nr,
> +                                    foffsetblock);
> +               } else {
> +                       ce = ce_queue_pop(&head);
> +                       set_index_entry(istate, *nr, ce);
> +                       (*nr)++;
> +                       ce->next = NULL;
> +               }

In this loop, you do some sort of merge sort combining a list of
sorted files and a list of sorted directories (which will be expanded
to bunches of files by the recursive read_entries). strcmp() does two
things. Assume we're in directory 'a', it makes sure that subdirectory
'a/b' is only inserted after file 'a/a' is inserted to maintain index
sort order. It also makes sure that 'de' of an outside directory 'b'
will not be expanded here. strcmp will be called for every file,
checking _full_ path. Sounds expensive.

If you maintain two pointers first_subdir and next_sibling in "de" as
in my previous mail, you know "de" 'b' is out without string
comparison (de->next_sibling would be NULL). With that, the purpose of
strcmp is simply making sure that 'a/b' is inserted after 'a/a'.
Because we know all possible "de" is a subdirectory of 'a', we don't
need to compare the prefix 'a/'. We still need to strcmp on every
file, but we only need to compare the file name, not the leading
directory anymore. Cheaper.

Going further, I wonder if we could eliminate strcmp completely. We
could store dummy entries in fileentries to mark the positions of the
subdirectories. When we encounter a dummy entry, we call
read_entries() instead of set_index_entry.

If you merge the "read_entry" for loop in this while loop, you don't
need to maintain a linked list of ce to pop out one by one here.

> +       }
> +       return 0;
> +}
> +
-- 
Duy
