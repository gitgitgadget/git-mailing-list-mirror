From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 17/24] read-cache: read cache-tree in index-v5
Date: Mon, 25 Nov 2013 16:41:11 +0100
Message-ID: <87iovgo5ew.fsf@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-18-git-send-email-t.gummerer@gmail.com> <CACsJy8Br8EaEtoZeaz2eLKvxDmPJqUc02bYsL_OSLJvJ2dBU-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 16:41:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkyHn-0004w2-J0
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 16:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab3KYPlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 10:41:15 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:64514 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab3KYPlP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 10:41:15 -0500
Received: by mail-lb0-f182.google.com with SMTP id u14so3428367lbd.27
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 07:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=suCExPsqWJ/rTOxQ2R1EVPs6uKVU2jVvX3a/qk3NNsE=;
        b=hiK3evyJ+dysx7CW1chSo2ow0PeGF9OW5zXK4KWu3eABg0T+Cw7gC1qU86n105TSXm
         jNwJJQ89dqkN2AJ1sFQL00v6pz/Fo6JTZIIAHqBL8/olE9oLEdZ2OefNJogHiJkNnoFG
         91Cy5to4mZAkvgo2A3CL6JXV6Cs+znjW/3RWmEtjTBKjiQqKFq0Pl8rcX4qLGD0V78sz
         6YKJXpV/lPgeBlCwoZdTC3ycG7nL8VNAAtPRNrjdUEkOHBLhN6i6a4oxaQeFKYGec4B5
         D0UlF2UDAKRV7rIpd8vSFpbXwVF3BBo2Hpn2adc/DY+zWos1taP7rAmhBcvjES1nqZyS
         36Xg==
X-Received: by 10.152.88.8 with SMTP id bc8mr1132613lab.47.1385394070768;
        Mon, 25 Nov 2013 07:41:10 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id o1sm54008454lah.8.2013.11.25.07.41.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2013 07:41:09 -0800 (PST)
In-Reply-To: <CACsJy8Br8EaEtoZeaz2eLKvxDmPJqUc02bYsL_OSLJvJ2dBU-g@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238318>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +/*
>> + * This function modifies the directory argument that is given to it.
>> + * Don't use it if the directory entries are still needed after.
>> + */
>
> There goes my hope of keeping directory_entry* in core so that at
> write-time, after validation, we only need to recreate some trees
> instead of all of them..
>
> Or we could make cache-tree keep references to directory_entry. If a
> cache-tree is not invalidated, then the attached directory_tree should
> be reused..

I've now re-written the algorithm that converts the directory entries to
cache entries, and it's now no longer destructive.  For now the
directory entries are not needed in core, so I'll free them when done
with reading the index, but it's possible to keep it.

>> +static struct cache_tree *cache_tree_convert_v5(struct directory_entry *de)
>> +{
>> +       if (!de->de_nentries)
>> +               return NULL;
>> +       sort_directories(de);
>> +       return convert_one(de);
>> +}
>> +
>>  static int read_entries(struct index_state *istate, struct directory_entry *de,
>>                         unsigned int first_entry_offset, void *mmap,
>>                         unsigned long mmap_size, unsigned int *nr,
>> @@ -591,6 +668,7 @@ static int read_index_v5(struct index_state *istate, void *mmap,
>>                 }
>>                 de = de->next;
>>         }
>> +       istate->cache_tree = cache_tree_convert_v5(root_directory);
>>         istate->cache_nr = nr;
>>         return 0;
>>  }
>
> Otherwise we do need to free root_directory down to the deepest
> subtrees, I think. People have been complaining about read-cache
> leaking memory like mad, so this is a real issue. Even if you keep
> references in cache-tree, you still need to free it
> cache_tree_invalidate_path() to avoid leaking

I'm freeing them for now, as they are not used anywhere, but in the
future we might want to keep them for some optimizations.
