From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 15/24] read-cache: read index-v5
Date: Tue, 20 Aug 2013 21:01:07 +0700
Message-ID: <CACsJy8A1NpYa6nr6vHKLd-Tap3PObabfUB34U90MH_OdfQJN9Q@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-16-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 16:01:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmVE-0007r6-KE
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab3HTOBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:01:40 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34843 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab3HTOBi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:01:38 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so640201obp.36
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sWaCD0HJqpnO64C9X/bVKD8mGGzkjDO5+vTlyXl8ltw=;
        b=A6niNDluyPrS2D1ZarFPbjXwKsDVqGN9cv6Z5lRy+lz36fAS37Ndvnu4AlB+vUqv0q
         OelwunXhsGTh4cbY080dDYd7r+62fKLL3yIz1Q9Qx/HlbXeYBMlrGbZDGcFb51Rea56k
         LIatnSFUfXkNfaLNgcSRznFkZWliZvoWSykFfbSxPU28DAjZdIwPwOcKpqCIzMdJ4jan
         rRPyvgqBW5UC51gf5qFh0cuVkixqGm+vrFjAoaXPHw2ojYENSID+aN8ntqFbTAW01Gpz
         2gP2fCplGBK5LlhAt2Vk1GxTrGHF9tM6A88LfpDhpi9+5gyKoVtB4b9t6FY8gMqWzXXg
         77LA==
X-Received: by 10.182.119.229 with SMTP id kx5mr1758829obb.23.1377007297939;
 Tue, 20 Aug 2013 07:01:37 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 20 Aug 2013 07:01:07 -0700 (PDT)
In-Reply-To: <1376854933-31241-16-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232597>

General comment: a short comment before each function describing what
the function does would be helpful. This only applies for complex
functions (read_* ones). Of course verify_hdr does not require extra
explanantion.

 On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +static struct directory_entry *directory_entry_from_ondisk(struct ondisk_directory_entry *ondisk,
> +                                                  const char *name,
> +                                                  size_t len)
> +{
> +       struct directory_entry *de = xmalloc(directory_entry_size(len));
> +
> +       memcpy(de->pathname, name, len);
> +       de->pathname[len] = '\0';
> +       de->de_flags      = ntoh_s(ondisk->flags);
> +       de->de_foffset    = ntoh_l(ondisk->foffset);
> +       de->de_cr         = ntoh_l(ondisk->cr);
> +       de->de_ncr        = ntoh_l(ondisk->ncr);
> +       de->de_nsubtrees  = ntoh_l(ondisk->nsubtrees);
> +       de->de_nfiles     = ntoh_l(ondisk->nfiles);
> +       de->de_nentries   = ntoh_l(ondisk->nentries);
> +       de->de_pathlen    = len;
> +       hashcpy(de->sha1, ondisk->sha1);
> +       return de;
> +}

This function leaves a lot of fields uninitialized..

> +static struct directory_entry *read_directories(unsigned int *dir_offset,
> +                               unsigned int *dir_table_offset,
> +                               void *mmap,
> +                               int mmap_size)
> +{
> ....
> +       de = directory_entry_from_ondisk(disk_de, name, len);
> +       de->next = NULL;
> +       de->sub = NULL;

..and two of them are set to NULL here. Maybe
directory_entry_from_ondisk() could be made to call
init_directory_entry() instead so that we don't need to manually reset
some fields here, which leaves me wondering why other fields are not
important to reset. init_directory_entry() is introduced later in
"write index-v5" patch, you so may want to move it up a few patches.

> +static int read_entry(struct cache_entry **ce, char *pathname, size_t pathlen,
> +                     void *mmap, unsigned long mmap_size,
> +                     unsigned int first_entry_offset,
> +                     unsigned int foffsetblock)
> +{
> +       int len, offset_to_offset;
> +       char *name;
> +       uint32_t foffsetblockcrc, *filecrc, *beginning, *end, entry_offset;
> +       struct ondisk_cache_entry *disk_ce;
> +
> +       beginning = ptr_add(mmap, foffsetblock);
> +       end = ptr_add(mmap, foffsetblock + 4);
> +       len = ntoh_l(*end) - ntoh_l(*beginning) - sizeof(struct ondisk_cache_entry) - 5;

It took me a while to check and figure out " - 5" here means minus NUL
and the crc. A short comment would help. I think there's also another
-5 in read_directories(). Or maybe just rename len to namelen.

> +struct conflict_entry *create_new_conflict(char *name, int len, int pathlen)
> +{
> +       struct conflict_entry *conflict_entry;
> +
> +       if (pathlen)
> +               pathlen++;
> +       conflict_entry = xmalloc(conflict_entry_size(len));
> +       conflict_entry->entries = NULL;
> +       conflict_entry->nfileconflicts = 0;
> +       conflict_entry->namelen = len;
> +       memcpy(conflict_entry->name, name, len);
> +       conflict_entry->name[len] = '\0';
> +       conflict_entry->pathlen = pathlen;
> +       conflict_entry->next = NULL;

A memset followed by memcpy and conflict_entry->pathlen = pathlen
would make this shorter and won't miss new fields added in future.

> +static int read_entries(struct index_state *istate, struct directory_entry *de,
> +                       unsigned int first_entry_offset, void *mmap,
> +                       unsigned long mmap_size, unsigned int *nr,
> +                       unsigned int foffsetblock)
> +{
> +       struct cache_entry *ce;
> +       int i, subdir = 0;
> +
> +       for (i = 0; i < de->de_nfiles; i++) {
> +               unsigned int subdir_foffsetblock = de->de_foffset + foffsetblock + (i * 4);
> +               if (read_entry(&ce, de->pathname, de->de_pathlen, mmap, mmap_size,
> +                              first_entry_offset, subdir_foffsetblock) < 0)
> +                       return -1;

You read one file entry, say abc/def...

> +               while (subdir < de->de_nsubtrees &&
> +                      cache_name_compare(ce->name + de->de_pathlen,
> +                                         ce_namelen(ce) - de->de_pathlen,
> +                                         de->sub[subdir]->pathname + de->de_pathlen,
> +                                         de->sub[subdir]->de_pathlen - de->de_pathlen) > 0) {

Oh right the entry belongs the the substree "abc" so..

> +                       read_entries(istate, de->sub[subdir], first_entry_offset, mmap,
> +                                    mmap_size, nr, foffsetblock);

you recurse in, which will add following entries like abc/def and abc/xyz...

> +                       subdir++;
> +               }
> +               if (!ce)
> +                       continue;
> +               set_index_entry(istate, (*nr)++, ce);

then back here after recusion and add abc/def, again, after abc/xyz.
Did I read this code correctly?

> +       }
> +       for (i = subdir; i < de->de_nsubtrees; i++) {
> +               read_entries(istate, de->sub[i], first_entry_offset, mmap,
> +                            mmap_size, nr, foffsetblock);
> +       }
> +       return 0;
> +}
> +

> +static int read_index_v5(struct index_state *istate, void *mmap,
> +                        unsigned long mmap_size, struct filter_opts *opts)
> +{
> +       unsigned int entry_offset, ndirs, foffsetblock, nr = 0;
> +       struct directory_entry *root_directory, *de, *last_de;
> +       const char **paths = NULL;
> +       struct pathspec adjusted_pathspec;
> +       int need_root = 0, i;
> +
> +       root_directory = read_all_directories(istate, &entry_offset,
> +                                             &foffsetblock, &ndirs,
> +                                             mmap, mmap_size);
> +
> +       if (opts && opts->pathspec && opts->pathspec->nr) {
> +               need_root = 0;

need_root is already initialized at declaration.

> +               paths = xmalloc((opts->pathspec->nr + 1)*sizeof(char *));
> +               paths[opts->pathspec->nr] = NULL;
> +               for (i = 0; i < opts->pathspec->nr; i++) {
> +                       char *super = strdup(opts->pathspec->items[i].match);
> +                       int len = strlen(super);
> +                       while (len && super[len - 1] == '/' && super[len - 2] == '/')
> +                               super[--len] = '\0'; /* strip all but one trailing slash */
> +                       while (len && super[--len] != '/')
> +                               ; /* scan backwards to next / */
> +                       if (len >= 0)
> +                               super[len--] = '\0';
> +                       if (len <= 0) {
> +                               need_root = 1;
> +                               break;
> +                       }
> +                       paths[i] = super;
> +               }
> +       }
> +
> +       if (!need_root)
> +               parse_pathspec(&adjusted_pathspec, PATHSPEC_ALL_MAGIC, PATHSPEC_PREFER_CWD, NULL, paths);
> +
> +       de = root_directory;
> +       last_de = de;
> +       while (de) {
> +               if (need_root ||
> +                   match_pathspec_depth(&adjusted_pathspec, de->pathname, de->de_pathlen, 0, NULL)) {
> +                       if (read_entries(istate, de, entry_offset,
> +                                        mmap, mmap_size, &nr,
> +                                        foffsetblock) < 0)
> +                               return -1;
> +               } else {
> +                       for (i = 0; i < de->de_nsubtrees; i++) {
> +                               last_de->next = de->sub[i];
> +                               last_de = last_de->next;
> +                       }
> +               }
> +               de = de->next;

I'm missing something here. read_entries is a function that reads all
entries inside "de" including subdirectories and the first "de" is
root_directory, which makes it read the whole index in. Because
de->next is only set in this function, de->next after read_entries()
is NULL, which termintates the loop and the else block never runs. It
does not sound right..
-- 
Duy
