From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 12/24] read-cache: read index-v5
Date: Sat, 30 Nov 2013 11:40:32 +0100
Message-ID: <87wqjqxjdr.fsf@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com> <1385553659-9928-13-git-send-email-t.gummerer@gmail.com> <CACsJy8C5Px6d5dKOG8mbKYvLPHVFOBhJ8i5_6oRB33zB1Rmvhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, tr@thomasrast.ch,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 11:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmhyn-0007Y0-Tg
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 11:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab3K3Kkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 05:40:35 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:33380 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab3K3Kkd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 05:40:33 -0500
Received: by mail-la0-f53.google.com with SMTP id ea20so7260204lab.40
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 02:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=bstPKGRhXIiZKCVT9VAZgpzeAbZ2hgtWYOKsfh6zLB8=;
        b=lvF+QQzNdCVUcMm4rpNqGqT6FkzR/dCx6xnlRzDhhYn0R9c9kwdXwTPkDc6EUALqdW
         Rt+Oi5T5MNloSIiVnoDrsUEmYe93l1VlkpY1ny15CBPE/GIY9RkosMEfjt0yHLEgRGO0
         zPtyaLrqIOv16K4lcWqP4+ZdCf0RcsnALt1TEhtn7leEhSoGeqZvhQst1RdhQAiy+Ds5
         iHOZ/Bwph7R0qTIt2xtb1j0l/iX5/KszGan3zCD3eA8hmzW2dTbjrE2Dv16TcBXfewWp
         1O5cI6o3YlEaqNUhOwAeiggZQCuFFfPXKJt0ioFBKSciMWYgPEzwvYPDY5NJYcblFfNV
         Jkig==
X-Received: by 10.152.184.35 with SMTP id er3mr928600lac.23.1385808031823;
        Sat, 30 Nov 2013 02:40:31 -0800 (PST)
Received: from goose.tgummerer.com (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id e1sm17452792lbe.0.2013.11.30.02.40.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2013 02:40:30 -0800 (PST)
In-Reply-To: <CACsJy8C5Px6d5dKOG8mbKYvLPHVFOBhJ8i5_6oRB33zB1Rmvhg@mail.gmail.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238554>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Nov 27, 2013 at 7:00 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -132,11 +141,17 @@ struct cache_entry {
>>         char name[FLEX_ARRAY]; /* more */
>>  };
>>
>> +#define CE_NAMEMASK  (0x0fff)
>
> CE_NAMEMASK is redefined in read-cache-v2.c in "read-cache: move index
> v2 specific functions to their own file". My gcc is smart enough to
> see the two defines are about the same value and does not warn me. But
> we should remove one (likely this one as I see no use of this macro
> outside read-cache-v2.c)

Thanks for catching that, there's no need to have it here.  I'll remove
it in the re-roll.

>>  #define CE_STAGEMASK (0x3000)
>>  #define CE_EXTENDED  (0x4000)
>>  #define CE_VALID     (0x8000)
>> +#define CE_SMUDGED   (0x0400) /* index v5 only flag */
>>  #define CE_STAGESHIFT 12
>>
>> +#define CONFLICT_CONFLICTED (0x8000)
>> +#define CONFLICT_STAGESHIFT 13
>> +#define CONFLICT_STAGEMASK (0x6000)
>> +
>>  /*
>>   * Range 0xFFFF0000 in ce_flags is divided into
>>   * two parts: in-memory flags and on-disk ones.
>
>> diff --git a/read-cache-v5.c b/read-cache-v5.c
>> new file mode 100644
>> index 0000000..9d8c8f0
>> --- /dev/null
>> +++ b/read-cache-v5.c
>> +static int read_index_v5(struct index_state *istate, void *mmap,
>> +                        unsigned long mmap_size, struct filter_opts *opts)
>> +{
>> +       unsigned int entry_offset, foffsetblock, nr = 0, *extoffsets;
>> +       unsigned int dir_offset, dir_table_offset;
>> +       int need_root = 0, i;
>> +       uint32_t *offset;
>> +       struct directory_entry *root_directory, *de, *last_de;
>> +       const char **paths = NULL;
>> +       struct pathspec adjusted_pathspec;
>> +       struct cache_header *hdr;
>> +       struct cache_header_v5 *hdr_v5;
>> +
>> +       hdr = mmap;
>> +       hdr_v5 = ptr_add(mmap, sizeof(*hdr));
>> +       istate->cache_alloc = alloc_nr(ntohl(hdr->hdr_entries));
>> +       istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
>> +       extoffsets = xcalloc(ntohl(hdr_v5->hdr_nextension), sizeof(int));
>> +       for (i = 0; i < ntohl(hdr_v5->hdr_nextension); i++) {
>> +               offset = ptr_add(mmap, sizeof(*hdr) + sizeof(*hdr_v5));
>> +               extoffsets[i] = htonl(*offset);
>> +       }
>> +
>> +       /* Skip size of the header + crc sum + size of offsets to extensions + size of offsets */
>> +       dir_offset = sizeof(*hdr) + sizeof(*hdr_v5) + ntohl(hdr_v5->hdr_nextension) * 4 + 4
>> +               + (ntohl(hdr_v5->hdr_ndir) + 1) * 4;
>> +       dir_table_offset = sizeof(*hdr) + sizeof(*hdr_v5) + ntohl(hdr_v5->hdr_nextension) * 4 + 4;
>> +       root_directory = read_directories(&dir_offset, &dir_table_offset,
>> +                                         mmap, mmap_size);
>> +
>> +       entry_offset = ntohl(hdr_v5->hdr_fblockoffset);
>> +       foffsetblock = dir_offset;
>> +
>> +       if (opts && opts->pathspec && opts->pathspec->nr) {
>> +               paths = xmalloc((opts->pathspec->nr + 1)*sizeof(char *));
>> +               paths[opts->pathspec->nr] = NULL;
>
> Put this statement here
>
> GUARD_PATHSPEC(opts->pathspec,
>       PATHSPEC_FROMTOP |
>       PATHSPEC_MAXDEPTH |
>       PATHSPEC_LITERAL |
>       PATHSPEC_GLOB |
>       PATHSPEC_ICASE);
>
> This says the mentioned magic is safe in this code. New magic may or
> may not be and needs to be checked (soonest by me, I'm going to add
> negative pathspec and I'll need to look into how it should be handled
> in this code block).

Thanks, I'll add the statement in the re-roll.

>> +               for (i = 0; i < opts->pathspec->nr; i++) {
>> +                       char *super = strdup(opts->pathspec->items[i].match);
>> +                       int len = strlen(super);
>
> You should only check as far as items[i].nowildcard_len, not strlen().
> The rest could be wildcards and stuff and not so reliable.

Ok, will change it in the re-roll.

>> +                       while (len && super[len - 1] == '/' && super[len - 2] == '/')
>> +                               super[--len] = '\0'; /* strip all but one trailing slash */
>> +                       while (len && super[--len] != '/')
>> +                               ; /* scan backwards to next / */
>> +                       if (len >= 0)
>> +                               super[len--] = '\0';
>> +                       if (len <= 0) {
>> +                               need_root = 1;
>> +                               break;
>> +                       }
>> +                       paths[i] = super;
>> +               }
>
> And maybe put the comment "FIXME: consider merging this code with
> create_simplify() in dir.c" somewhere. It's for me to look for things
> to do when I'm bored ;-)

Heh, thanks, will do.

>> +       }
>> +
>> +       if (!need_root)
>> +               parse_pathspec(&adjusted_pathspec, PATHSPEC_ALL_MAGIC, PATHSPEC_PREFER_CWD, NULL, paths);
>
> I would go with PATHSPEC_PREFER_FULL instead of _CWD as it's safer.
> Looking only at this function without caller context, it's hard to say
> if _CWD is the right choice.

Ok, thanks, will change.

>> +
>> +       de = root_directory;
>> +       last_de = de;
>
> This statement is redundant. last_de is only used in one code block
> below and it's always re-initialized before entering the loop to skip
> subdirs.

Right, good catch!  Will remove it.

>> +       while (de) {
>> +               if (need_root ||
>> +                   match_pathspec_depth(&adjusted_pathspec, de->pathname, de->de_pathlen, 0, NULL)) {
>> +                       if (read_entries(istate, de, entry_offset,
>> +                                        mmap, mmap_size, &nr,
>> +                                        foffsetblock) < 0)
>> +                               return -1;
>> +               } else {
>> +                       last_de = de;
>> +                       for (i = 0; i < de->de_nsubtrees; i++) {
>> +                               de->sub[i]->next = last_de->next;
>> +                               last_de->next = de->sub[i];
>> +                               last_de = last_de->next;
>> +                       }
>> +               }
>> +               de = de->next;
>> +       }
>> +       free_directory_tree(root_directory);
>> +       istate->cache_nr = nr;
>> +       return 0;
>> +}
> -- 
> Duy
