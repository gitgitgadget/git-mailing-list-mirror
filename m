From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Wed, 8 Aug 2012 20:54:09 +0700
Message-ID: <CACsJy8DfJJpwidfUQFDeqM=5uPpGF6rZ6C1pS0H6mSNHUqOkbg@mail.gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com> <7vehnjzzfd.fsf@alter.siamese.dyndns.org>
 <CACsJy8CepAQr4r-c_hzwgT2-_bpFV-=VmOsFaBcDZqBpG52reQ@mail.gmail.com> <7v7gtaups3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu,
	robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 15:54:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz6ik-0007E8-8f
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 15:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318Ab2HHNyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 09:54:41 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:57095 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932440Ab2HHNyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 09:54:40 -0400
Received: by qcro28 with SMTP id o28so426812qcr.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sPbpm6OrarGNuPyBh/aKfIMuLMtHTyIkvtZugTmaX5M=;
        b=LCnsl7ov9R5uSmDof35joh+HJE8UnwcgxL0OfsUEEVJRCtmT9SFAM9XvFdbTiSAjqc
         +BdgPyiBdMLWFG1AnZIg6UBPBhAN6NCaT90IHJIkv2oHTruV8zFZuA4YlXvg9aiihUQ3
         5d0XpI3elSKw30kZv9gkpG9oGpF0uJFoPt8dOAme9JxSgD3WtO2JrBUss/juid2qOP5A
         GjZh1oEPHD2pLSPfQaJ4S1U+spksEYjvH8kvTFPV/Ur94Plb74F821pwJcg80mEDxELk
         HD8JoDwO0aiq612EWz1S6gx75A96aHNo3VzRZ60coaQSiYn4tkM81cPUGKZNOHem8XJ4
         GGzQ==
Received: by 10.224.185.148 with SMTP id co20mr30220980qab.4.1344434079236;
 Wed, 08 Aug 2012 06:54:39 -0700 (PDT)
Received: by 10.49.84.73 with HTTP; Wed, 8 Aug 2012 06:54:09 -0700 (PDT)
In-Reply-To: <7v7gtaups3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203092>

On Wed, Aug 8, 2012 at 8:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> If the workload we _care_ about is served better by using an API
> that works over an in-core tree-shaped index data structure, I do
> not think it is unreasonable to read the v2 on-disk format and
> represent it as a tree-shaped index while we read it.  Of course,
> there are things that are not as effective when reading from the
> flat v2 on-disk format (e.g. path limited reading will have to at
> least _scan_ the whole thing, even though it may process only the
> entries that match the pathspec) compared to reading from a
> tree-shaped on-disk format, but I doubt that the difference between
> the cost of reading into a flat array and the cost of reading and
> forming whatever non-flat data structure you seem to think is better
> is so big that it would negate the benefit of using a better in-core
> structure.

OK how about this. The general idea is preserve/extend current flat
index API and add a new (tree-based) one. Index users can use either.
They can even mix them up (which they do because we can't just flip
the API in one day for about 200 source files).

The day that unpack_trees() is converted to tree API, I will declare
v5 victory ;)

= Cleanup =

struct cache_entry becomes partly opaque. ce_ctime..ce_gid are hidden
in -v2.c and -v5.c. We only expose ce_size, ce_flags, ce_namelen, name
and sha1 to index users. Extra v5 fields like ce_stat_crc, next and
dir_next are also hidden. These fields can be put in a real struct in
read-cache.h, which is supposedly included by -v2.c and -v5.c

= Updating =

All index update API (add_index_entry, add_to_index,
remove_index_entry_at, remove_marked_cached_entries) are hooked by v5
when the loaded index is v5. v5 can update internal data when these
are called (e.g. conflict resolution), or just mark them "dirty" to be
worked on later in flush_index().

Anybody who updates a cache_entry is supposed to call
cache_entry_updated() function, which is no-op for v2 but v5 may want
to watch this activity.

Refreshing index is a special operation. Of course it's hooked by v5.
v5 may need its own implementation because it could walk working tree
and index tree at the same time. Of course v5 impl must also update
flat API data structure along the way.

A new function flush_index() is introduced, where v5 can update all
internal data and keep it in sync with index_state. When flat/tree
APIs are mixed, flush_index() must be called when switching from flat
API to tree API.

To help v5 deal with index rewrite in unpack_trees(),
index_bulk_update() may be introduced, which tells v5 "we are going to
do a lot of adding/removing/shuffling, keep your actions to minimum,
you most likely have to rebuild the trees at flush_index() anyway"

New API may be introduced for some big operations if it proves
v5-beneficial. I'm thinking of adding/removing a bunch of files by
pathspec, where v5 can walk working directory at the same time it
walks index directory tables.

= Tree traversal =

I don't see big problems here. We support opendir/readdir-like API for
tree traversing (with pathspec filtering). We also support
lookup_cache_entry to get cache_entry* of a certain path.

When tree traversal gets to a conflict entry, it lets the caller know
there's a conflict entry, it does not traverse through stage 1-3
during traversal. Caller is expected to use conflict lookup API for
that.

We also support reading partial index, filtered by pathspec. On v2, it
reads full index.

= Tree update =

At some point we may want to work on trees exclusively. Any operations
here must keep flat API data structure in sync.

We may want to postpone the sync if it's a lot of work, by doing all
the work in flush_index() before caller switches from tree API to flat
API again.

= Flat API deprecation =

At some point, tree update API will not update flat API any more
unless explicitly asked by caller. I don't expect "cache" in struct
index_state to be removed, unless we do really good merges using tree
API.
-- 
Duy
