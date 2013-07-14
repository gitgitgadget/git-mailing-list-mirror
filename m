From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 12/19] read-cache: read index-v5
Date: Sun, 14 Jul 2013 11:42:28 +0700
Message-ID: <CACsJy8C6HRCYMR3Q=j-D=2kgzvA7=0tauSnwrjpXzSPZWe+VZw@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jul 14 06:43:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyE9d-0002Nn-6O
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 06:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083Ab3GNEnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 00:43:00 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:49935 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab3GNEm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 00:42:59 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so12957229obc.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 21:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8b0v/ajWbBurh7+i5HL601tAVpJr13I6IpcZvVmoxvs=;
        b=bN/lFIEk/p/Wxiw4YJHhpBFJx0LIJVCk7xSVbQqXaBjAUiwYa4L76gYLQx/FDSpmOJ
         sm9tj/5iLhfCvxTItg1xJbTV2JJypXWB9Jigwc87Hj2yqGepQv527ZLYJmHHn90CJ8Fe
         DQ4F6HctXNvhjjnMd15D5PtyYe4gOyh1a4I468I5tBWAbvzwlY6jm7kgRXhGjELASNwc
         fWyCV0AD2PKH15JMxPec5R0W5adNs1z+YyT8LLcEtprQ3OF9MqzC8V7JqJ2Gcat0KPFB
         WgknfsRlfplegzK+vx1F28j8885klXX/6WLz39DeQZ4qWELRsU3vT/AJWUFB3d594htt
         7iUQ==
X-Received: by 10.60.83.116 with SMTP id p20mr39634844oey.83.1373776978972;
 Sat, 13 Jul 2013 21:42:58 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sat, 13 Jul 2013 21:42:28 -0700 (PDT)
In-Reply-To: <1373650024-3001-13-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230308>

On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +struct directory_entry {
> +       struct directory_entry *next;
> +       struct directory_entry *next_hash;
> +       struct cache_entry *ce;
> +       struct cache_entry *ce_last;
> +       struct conflict_entry *conflict;
> +       struct conflict_entry *conflict_last;
> +       unsigned int conflict_size;
> +       unsigned int de_foffset;
> +       unsigned int de_cr;
> +       unsigned int de_ncr;
> +       unsigned int de_nsubtrees;
> +       unsigned int de_nfiles;
> +       unsigned int de_nentries;
> +       unsigned char sha1[20];
> +       unsigned short de_flags;
> +       unsigned int de_pathlen;
> +       char pathname[FLEX_ARRAY];
> +};
> +
> +struct conflict_part {
> +       struct conflict_part *next;
> +       unsigned short flags;
> +       unsigned short entry_mode;
> +       unsigned char sha1[20];
> +};
> +
> +struct conflict_entry {
> +       struct conflict_entry *next;
> +       unsigned int nfileconflicts;
> +       struct conflict_part *entries;
> +       unsigned int namelen;
> +       unsigned int pathlen;
> +       char name[FLEX_ARRAY];
> +};
> +
> +struct ondisk_conflict_part {
> +       unsigned short flags;
> +       unsigned short entry_mode;
> +       unsigned char sha1[20];
> +};

These new structs should probably be in read-cache-v5.c, or read-cache.h

>  #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
> +#define directory_entry_size(len) (offsetof(struct directory_entry,pathname) + (len) + 1)
> +#define conflict_entry_size(len) (offsetof(struct conflict_entry,name) + (len) + 1)

These are used by read-cache-v5.c only so far. I'd say move them to
read-cache.h or read-cache-v5.c together with the new structs.

> +struct ondisk_cache_entry {
> +       unsigned short flags;
> +       unsigned short mode;
> +       struct cache_time mtime;
> +       unsigned int size;
> +       int stat_crc;
> +       unsigned char sha1[20];
> +};
> +
> +struct ondisk_directory_entry {
> +       unsigned int foffset;
> +       unsigned int cr;
> +       unsigned int ncr;
> +       unsigned int nsubtrees;
> +       unsigned int nfiles;
> +       unsigned int nentries;
> +       unsigned char sha1[20];
> +       unsigned short flags;
> +};

Perhaps use uint32_t, uint16_t and friends for all on-disk structures?

> +static struct directory_entry *read_directories(unsigned int *dir_offset,
> +                               unsigned int *dir_table_offset,
> +                               void *mmap,
> +                               int mmap_size)
> +{
> +       int i, ondisk_directory_size;
> +       uint32_t *filecrc, *beginning, *end;
> +       struct directory_entry *current = NULL;
> +       struct ondisk_directory_entry *disk_de;
> +       struct directory_entry *de;
> +       unsigned int data_len, len;
> +       char *name;
> +
> +       /*
> +        * Length of pathname + nul byte for termination + size of
> +        * members of ondisk_directory_entry. (Just using the size
> +        * of the struct doesn't work, because there may be padding
> +        * bytes for the struct)
> +        */
> +       ondisk_directory_size = sizeof(disk_de->flags)
> +               + sizeof(disk_de->foffset)
> +               + sizeof(disk_de->cr)
> +               + sizeof(disk_de->ncr)
> +               + sizeof(disk_de->nsubtrees)
> +               + sizeof(disk_de->nfiles)
> +               + sizeof(disk_de->nentries)
> +               + sizeof(disk_de->sha1);
> +       name = ptr_add(mmap, *dir_offset);
> +       beginning = ptr_add(mmap, *dir_table_offset);
> +       end = ptr_add(mmap, *dir_table_offset + 4);
> +       len = ntoh_l(*end) - ntoh_l(*beginning) - ondisk_directory_size - 5;
> +       disk_de = ptr_add(mmap, *dir_offset + len + 1);
> +       de = directory_entry_from_ondisk(disk_de, name, len);
> +       de->next = NULL;
> +
> +       data_len = len + 1 + ondisk_directory_size;
> +       filecrc = ptr_add(mmap, *dir_offset + data_len);
> +       if (!check_crc32(0, ptr_add(mmap, *dir_offset), data_len, ntoh_l(*filecrc)))
> +               goto unmap;
> +
> +       *dir_table_offset += 4;
> +       *dir_offset += data_len + 4; /* crc code */
> +
> +       current = de;
> +       for (i = 0; i < de->de_nsubtrees; i++) {
> +               current->next = read_directories(dir_offset, dir_table_offset,
> +                                               mmap, mmap_size);
> +               while (current->next)
> +                       current = current->next;
> +       }
> +
> +       return de;
> +unmap:
> +       munmap(mmap, mmap_size);
> +       die("directory crc doesn't match for '%s'", de->pathname);
> +}

You don't have to munmap when you die() anway. I'm not sure if flatten
the directory hierarchy into a list (linked by next pointer) is a good
idea, or we should maintain the tree structure in memory. Still a lot
of reading to figure that out..

I skipped from here..

> +static void ce_queue_push(struct cache_entry **head,
> +                            struct cache_entry **tail,
> +                            struct cache_entry *ce)
> +{

...

> +static int read_conflicts(struct conflict_entry **head,
> +                         struct directory_entry *de,
> +                         void **mmap, unsigned long mmap_size)
> +{

till the end of this function. Not interested in conflict stuff yet.


> +static struct directory_entry *read_head_directories(struct index_state *istate,
> +                                                    unsigned int *entry_offset,
> +                                                    unsigned int *foffsetblock,
> +                                                    unsigned int *ndirs,
> +                                                    void *mmap, unsigned long mmap_size)
> +{

Maybe read_all_directories is a better nam.

> +static int read_index_filtered_v5(struct index_state *istate, void *mmap,
> +                                 unsigned long mmap_size, struct filter_opts *opts)
> +{
> +       unsigned int entry_offset, ndirs, foffsetblock, nr = 0;
> +       struct directory_entry *root_directory, *de;
> +       const char **adjusted_pathspec = NULL;
> +       int need_root = 0, i, n;
> +       char *oldpath, *seen;
> +
> +       ...
> +
> +       de = root_directory;
> +       while (de) {
> +               if (need_root ||
> +                   match_pathspec(adjusted_pathspec, de->pathname, de->de_pathlen, 0, NULL)) {
> +                       unsigned int subdir_foffsetblock = de->de_foffset + foffsetblock;
> +                       unsigned int *off = mmap + subdir_foffsetblock;
> +                       unsigned int subdir_entry_offset = entry_offset + ntoh_l(*off);
> +                       oldpath = de->pathname;
> +                       do {
> +                               if (read_entries(istate, &de, &subdir_entry_offset,
> +                                                &mmap, mmap_size, &nr,
> +                                                &subdir_foffsetblock) < 0)
> +                                       return -1;
> +                       } while (de && !prefixcmp(de->pathname, oldpath));
> +               } else
> +                       de = de->next;
> +       }

Hm.. if we maintain a tree structure here (one link to the first
subdir, one link to the next sibling), I think the "do" loop could be
done without prefixcmp. Just check if "de" returned by read_entries is
the next sibling "de" (iow the end of current directory recursively).

> +       istate->cache_nr = nr;
> +       return 0;
> +}
> +
> +static int read_index_v5(struct index_state *istate, void *mmap,
> +                        unsigned long mmap_size, struct filter_opts *opts)
> +{
> +       unsigned int entry_offset, ndirs, foffsetblock, nr = 0;
> +       struct directory_entry *root_directory, *de;
> +
> +       if (opts != NULL)
> +               return read_index_filtered_v5(istate, mmap, mmap_size, opts);
> +
> +       root_directory = read_head_directories(istate, &entry_offset,
> +                                              &foffsetblock, &ndirs,
> +                                              mmap, mmap_size);
> +       de = root_directory;
> +       while (de)
> +               if (read_entries(istate, &de, &entry_offset, &mmap,
> +                                mmap_size, &nr, &foffsetblock) < 0)
> +                       return -1;
> +       istate->cache_nr = nr;
> +       return 0;
> +}

Make it call read_index_filtered_v5 with an empty pathspec instead.
match_pathspec* returns true immediately if pathspec is empty. Without
the removal of prefixcmp() in the "do" loop mentioned above,
read_index_filtered_v5 can't be more expensive than this version.

That was it! Lunch time! Maybe I'll read the rest in the afternoon, or
someday next week.
--
Duy
