From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] cache-tree: invalidate i-t-a paths after
 generating trees
Date: Sat, 15 Dec 2012 09:52:52 +0700
Message-ID: <CACsJy8BcLmGmxBUq3+4_Go4v1-HOFDOj9wi8A_-fbk-on4MX3A@mail.gmail.com>
References: <7vip89bz4v.fsf@alter.siamese.dyndns.org> <1355362747-13474-1-git-send-email-pclouds@gmail.com>
 <7v4njq1ze7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathon Mah <me@jonathonmah.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 03:53:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjhsn-0001EH-7A
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 03:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab2LOCxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 21:53:23 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61080 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab2LOCxW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 21:53:22 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so4045944obb.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 18:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=or9rzJLau+qsmxRLW0gS36gpR6ujch22BxbQQ/mNuPs=;
        b=l3Izm0SKLN6Oq/PKy0PHR8C1L53CBi5pcxCt8cUiyzWS4iKBiTaHAAOs38v3KfPko1
         O4ZVgBMa+LAyqMjTwzMxl6ENyWekfVdnv3Bd7MzKjEWxukVkMe+H+WnKlaK3ocXCLSlm
         uEkOsFkhicNCrXS8mFw09gQTQ7hl6LGQ0ML67u2KJZW1Hteum95v9LVjWsF8fUpb17yj
         O21C14qezxYuXj++Yc9SsLNroBj3ijbodsCmOiWB6JlXvAFSoD0nfMxYca2BeafamhvS
         KDoKZhlPQkqu7cSbBI3fOc6/cIi9lmXmsLz1bhNeSK7UvCms/Iemdf2faqdabM1eg3oN
         EkAA==
Received: by 10.60.30.70 with SMTP id q6mr6267346oeh.107.1355540002138; Fri,
 14 Dec 2012 18:53:22 -0800 (PST)
Received: by 10.182.41.229 with HTTP; Fri, 14 Dec 2012 18:52:52 -0800 (PST)
In-Reply-To: <7v4njq1ze7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211515>

On Thu, Dec 13, 2012 at 9:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -324,7 +325,14 @@ static int update_one(struct cache_tree *it,
>>                       if (!sub)
>>                               die("cache-tree.c: '%.*s' in '%s' not found",
>>                                   entlen, path + baselen, path);
>> -                     i += sub->cache_tree->entry_count - 1;
>> +                     i--; /* this entry is already counted in "sub" */
>
> Huh?
>
> The "-1" in the original is the bog-standard compensation for the
> for(;;i++) loop.

Exactly. It took me a while to figure out what " - 1" was for and I
wanted to avoid that for other developers. Only I worded it badly.
I'll replace the for loop with a while loop to make it clearer...

>
>> +                     if (sub->cache_tree->entry_count < 0) {
>> +                             i -= sub->cache_tree->entry_count;
>> +                             sub->cache_tree->entry_count = -1;
>> +                             to_invalidate = 1;
>> +                     }
>> +                     else
>> +                             i += sub->cache_tree->entry_count;
>
> While the rewritten version is not *wrong* per-se, I have a feeling
> that it may be much easier to read if written like this:
>
>         if (sub->cache_tree_entry_count < 0) {
>                 to_invalidate = 1;
>                 to_skip = 0 - sub->cache_tree_entry_count;
>                 sub->cache_tree_entry_count = -1;
>         } else {
>                 to_skip = sub->cache_tree_entry_count;
>         }
>         i += to_skip - 1;
>

..or this would be fine too. Which way to go?

A while we're still at the cache tree

> -               if (ce->ce_flags & (CE_REMOVE | CE_INTENT_TO_ADD))
> -                       continue; /* entry being removed or placeholder */
> +               /*
> +                * CE_REMOVE entries are removed before the index is
> +                * written to disk. Skip them to remain consistent
> +                * with the future on-disk index.
> +                */
> +               if (ce->ce_flags & CE_REMOVE)
> +                       continue;
> +

A CE_REMOVE entry is removed later from the index, however it is still
counted in entry_count. entry_count serves two purposes: to skip the
number of processed entries in the in-memory index, and to record the
number of entries in the on-disk index. These numbers do not match
when CE_REMOVE is present. We have correct in-memory entry_count,
which means incorrect on-disk entry_count in this case.

I tested with an index that has a/b and a/c. The latter has CE_REMOVE.
After writing cache tree I get:

$ git ls-files --stage
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       a/b
$ ../test-dump-cache-tree
878e27c626266ac04087a203e4bdd396dcf74763  (2 entries, 1 subtrees)
878e27c626266ac04087a203e4bdd396dcf74763 #(ref)  (1 entries, 1 subtrees)
4277b6e69d25e5efa77c455340557b384a4c018a a/ (2 entries, 0 subtrees)
4277b6e69d25e5efa77c455340557b384a4c018a #(ref) a/ (1 entries, 0 subtrees)

If I throw out that index, create a new one with a/b alone and write-tree, I get

$ ../test-dump-cache-tree
878e27c626266ac04087a203e4bdd396dcf74763  (1 entries, 1 subtrees)
4277b6e69d25e5efa77c455340557b384a4c018a a/ (1 entries, 0 subtrees)

Shall we fix this too? I'm thinking of adding "skip" argument to update_one and

   i += sub->cache_tree->entry_count - 1;

would become

   i += sub->cache_tree->entry_count + skip - 1;

and entry_count would always reflect on-disk value. This "skip" can be
reused for this i-t-a patch as well.
-- 
Duy
