From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 05/22] read-cache: add index reading api
Date: Mon, 08 Jul 2013 13:20:04 +0200
Message-ID: <87pputqowr.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <CACsJy8C0F+v3g+gPon6Y8+z7ObN1Jv8Ln==RNrVsRp7aya74hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 13:20:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw9UP-00025r-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 13:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704Ab3GHLUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 07:20:11 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:52398 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3GHLUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 07:20:09 -0400
Received: by mail-ea0-f180.google.com with SMTP id k10so2864271eaj.39
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=QI4FhW9GGlIYoev16zvIhYA2yK5Qv94+6vg1lCSo3Z8=;
        b=Y0y/iWwKt9qzVU394LgW3zahexLohMwFbhDID7tra1hzu9dDdWxjDBc/6CUqOPHT1/
         DcRAeBNDaHEbZupYYKWMSzfiP3OV6KNmybX6SA/FMtIB6VqH0QUjZZVFGxuuZoxJM96v
         JXAwY/B2vmqruG/Glzaa2RHj6SYwkdl2aTIFa55pFID049Dgc4MG3jp5vxKNOCTDutCo
         Vs4hM1e3R1jY0jwzExEv43ylUGIccUSxsjAaD+vkvXRVYwsB1buw4vGvpg/ZtQDR2q5t
         TwkxsuPdMg9Y7Su02RSzEay2qTAuVT86WStL0CVtQSD2mGajJ7/oU1z4/FM/BMy0zMvJ
         K3rw==
X-Received: by 10.15.10.132 with SMTP id g4mr24217989eet.38.1373282407934;
        Mon, 08 Jul 2013 04:20:07 -0700 (PDT)
Received: from localhost (nat5.unibz.it. [46.18.27.5])
        by mx.google.com with ESMTPSA id w43sm41394368eez.6.2013.07.08.04.20.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 04:20:06 -0700 (PDT)
In-Reply-To: <CACsJy8C0F+v3g+gPon6Y8+z7ObN1Jv8Ln==RNrVsRp7aya74hw@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229839>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Jul 7, 2013 at 3:11 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +/*
>> + * Options by which the index should be filtered when read partially.
>> + *
>> + * pathspec: The pathspec which the index entries have to match
>> + * seen: Used to return the seen parameter from match_pathspec()
>> + * max_prefix, max_prefix_len: These variables are set to the longest
>> + *     common prefix, the length of the longest common prefix of the
>> + *     given pathspec
>> + *
>> + * read_staged: used to indicate if the conflicted entries (entries
>> + *     with a stage) should be included
>> + * read_cache_tree: used to indicate if the cache-tree should be read
>> + * read_resolve_undo: used to indicate if the resolve undo data should
>> + *     be read
>> + */
>> +struct filter_opts {
>> +       const char **pathspec;
>> +       char *seen;
>> +       char *max_prefix;
>> +       int max_prefix_len;
>> +
>> +       int read_staged;
>> +       int read_cache_tree;
>> +       int read_resolve_undo;
>> +};
>> +
>>  struct index_state {
>>         struct cache_entry **cache;
>>         unsigned int version;
>> @@ -270,6 +297,8 @@ struct index_state {
>>         struct hash_table name_hash;
>>         struct hash_table dir_hash;
>>         struct index_ops *ops;
>> +       struct internal_ops *internal_ops;
>> +       struct filter_opts *filter_opts;
>>  };
>
> ...
>
>> -/* remember to discard_cache() before reading a different cache! */
>> -int read_index_from(struct index_state *istate, const char *path)
>> +
>> +int read_index_filtered_from(struct index_state *istate, const char *path,
>> +                            struct filter_opts *opts)
>>  {
>>         int fd, err, i;
>>         struct stat st_old, st_new;
>> @@ -1337,7 +1425,7 @@ int read_index_from(struct index_state *istate, const char *path)
>>                 if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
>>                         err = 1;
>>
>> -               if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
>> +               if (istate->ops->read_index(istate, mmap, mmap_size, opts) < 0)
>>                         err = 1;
>>                 istate->timestamp.sec = st_old.st_mtime;
>>                 istate->timestamp.nsec = ST_MTIME_NSEC(st_old);
>> @@ -1345,6 +1433,7 @@ int read_index_from(struct index_state *istate, const char *path)
>>                         die_errno("cannot stat the open index");
>>
>>                 munmap(mmap, mmap_size);
>> +               istate->filter_opts = opts;
>>                 if (!index_changed(&st_old, &st_new) && !err)
>>                         return istate->cache_nr;
>>         }
>
> Putting filter_opts in index_state feels like a bad design. Iterator
> information should be separated from the iterated object, so that two
> callers can walk through the same index without stepping on each other
> (I'm not talking about multithreading, a caller may walk a bit, then
> the other caller starts walking, then the former caller resumes
> walking again in a call chain).

Yes, you're right.  We need the filter_opts to see what part of the
index has been loaded [1] and which part has been skipped, but it
shouldn't be used for filtering in the for_each_index_entry function.

I think there should be two versions of the for_each_index_entry
function then, where the for_each_index_entry function would behave the
same way as the for_each_index_entry_filtered function with the
filter_opts parameter set to NULL:
for_each_index_entry_filtered(struct index_state *, each_cache_entry_fn, void *cb_data, struct filter_opts *)
for_each_index_entry(struct index_state *, each_cache_entry_fn, void *cb_data)

Both of them then should call index_change_filter_opts to make sure all
the entries that are needed are loaded in the in-memory format.

Does that make sense?

[1] That is only important for the new index-v5 file format, which can
    be loaded partially.  The filter_opts could always be set to NULL,
    as the whole index is always loaded anyway.
