From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 05/22] read-cache: add index reading api
Date: Mon, 08 Jul 2013 22:10:58 +0200
Message-ID: <874nc4rewd.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <7va9lx100l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 22:11:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwHmD-00066d-L2
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 22:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab3GHULH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 16:11:07 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:43582 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab3GHULF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 16:11:05 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so4740684pac.26
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 13:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=gyknFlTPa4Gp4/0VRk+yACrJbgTeIkPcIIaU83K5N7I=;
        b=Liyjh4IKeF2OSNiOCyo++x78sv5Qny08kMcEmSV4jdunXEJphQa8M8EHeIeWz22crV
         seM81b3FYgBDG/zoUMp/EaveUsDhKazTTb60LKdc8pwL0eD2t60Yv9kR5cVObRFrKAZn
         Zbj0pmACPFK73eHnAHarhgFWoN5KZ1rxRjj4/CJ6FxGbhReMz2lEoZBYAFsoOQsPKpMR
         IEse6Xc5tJlfx5/MB1FAXGW7MAuEU5H7SDmdBdlJxdvS4zuAi8xum8YjuvKcHnD+C0a6
         /VxLIonG+vJGrB9dBtPU4NSliD5l2ATd09GobVEhOdRiFM9gD0tWnTcjLOwIPYepFGFP
         +4SA==
X-Received: by 10.68.231.200 with SMTP id ti8mr22915002pbc.46.1373314264906;
        Mon, 08 Jul 2013 13:11:04 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id sz6sm25843404pab.5.2013.07.08.13.11.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 13:11:04 -0700 (PDT)
In-Reply-To: <7va9lx100l.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229890>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> Add an api for access to the index file.  Currently there is only a very
>> basic api for accessing the index file, which only allows a full read of
>> the index, and lets the users of the data filter it.  The new index api
>> gives the users the possibility to use only part of the index and
>> provides functions for iterating over and accessing cache entries.
>>
>> This simplifies future improvements to the in-memory format, as changes
>> will be concentrated on one file, instead of the whole git source code.
>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>>  cache.h         |  57 +++++++++++++++++++++++++++++-
>>  read-cache-v2.c |  96 +++++++++++++++++++++++++++++++++++++++++++++++--
>>  read-cache.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>>  read-cache.h    |  12 ++++++-
>>  4 files changed, 263 insertions(+), 10 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index 5082b34..d38dfbd 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -127,7 +127,8 @@ struct cache_entry {
>>  	unsigned int ce_flags;
>>  	unsigned int ce_namelen;
>>  	unsigned char sha1[20];
>> -	struct cache_entry *next;
>> +	struct cache_entry *next; /* used by name_hash */
>> +	struct cache_entry *next_ce; /* used to keep a list of cache entries */
>
> The reader often needs to rewind the read-pointer partially while
> walking the index (e.g. next_cache_entry() in unpack-trees.c and how
> the o->cache_bottom position is used throughout the subsystem).  I
> am not sure if this singly-linked list is a good way to go.

I'm not very familiar with the unpack-trees code, but from a quick look
the pointer (or position in the cache) is always only moved forward.  A
problem I do see though is skipping a number of entries at once.  An
example for that below:
			int matches;
			matches = cache_tree_matches_traversal(o->src_index->cache_tree,
							       names, info);
			/*
			 * Everything under the name matches; skip the
			 * entire hierarchy.  diff_index_cached codepath
			 * special cases D/F conflicts in such a way that
			 * it does not do any look-ahead, so this is safe.
			 */
			if (matches) {
				o->cache_bottom += matches;
				return mask;
			}

This could probably be transformed into something like
skip_cache_tree_matches(cache-tree, names, info);

I'll take some time to familiarize myself with the unpack-trees code to
see if I can find a better solution than this, and if there are more
pitfalls.

>> +/*
>> + * Options by which the index should be filtered when read partially.
>> + *
>> + * pathspec: The pathspec which the index entries have to match
>> + * seen: Used to return the seen parameter from match_pathspec()
>> + * max_prefix, max_prefix_len: These variables are set to the longest
>> + *     common prefix, the length of the longest common prefix of the
>> + *     given pathspec
>
> These probably should use "struct pathspec" abstration, not just the
> "array of raw strings", no?

Yes, thanks, that's probably a good idea.
