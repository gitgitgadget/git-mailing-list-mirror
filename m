From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] cache-tree: Write updated cache-tree after commit
Date: Tue, 08 Jul 2014 10:05:24 -0700
Message-ID: <xmqqwqbnaii3.fsf@gitster.dls.corp.google.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
	<1404619619-4774-4-git-send-email-dturner@twitter.com>
	<xmqq61j9c4xb.fsf@gitster.dls.corp.google.com>
	<xmqq7g3obsqm.fsf@gitster.dls.corp.google.com>
	<CACsJy8C20oFdATHKTLK=9U3_kHu1QsuS4i74RPgQn0aTwVCC8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 19:05:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Ypy-0005yw-DK
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 19:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbaGHRFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 13:05:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52093 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833AbaGHRFj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 13:05:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96672252CF;
	Tue,  8 Jul 2014 13:05:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ANscy0ZAXZdSlo1Rw8lMrWzXcQ=; b=iw82Eh
	tB+wLusj0XsWtiHyXzTNFrBDi6NwLRTdUlGhKuJ24QEmGqqO6h2pTgI61rAXy3OD
	/U89tjtzcGpCZzZSM6GWXkf4ghBhQ+vNcEEW4kd+DfbUOIVMIJgr5PKwXVxmq5AN
	ZO/WnMJdUUuvjO4lAMHXQ6GVTfDLEt1NqlIsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ANLs3e/UGVFlpo1TKcvD8/RgQe77EC/r
	2tQyNBcgOclItYaGNQD6h9SN01Phz2elXTYwrEj/e5dbJclR0Iez31CqHHi+Ds2N
	Fkd6z7VHw1RWejrKIZ3lQ8/YzviXHL+e6D2xQChl+Oc6RuOWlD3V/oP51ovEkiSu
	OUZMWVi+TOI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F187252CE;
	Tue,  8 Jul 2014 13:05:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2AA04252CA;
	Tue,  8 Jul 2014 13:05:13 -0400 (EDT)
In-Reply-To: <CACsJy8C20oFdATHKTLK=9U3_kHu1QsuS4i74RPgQn0aTwVCC8w@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 8 Jul 2014 17:32:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 069614E6-06C2-11E4-8A93-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253034>

Duy Nguyen <pclouds@gmail.com> writes:

> I wonder if we need to update_main_cache_tree() so many times in this
> function. If I read the code correctly, all roads must lead to
> update_main_cache_tree(0) in prepare_to_commit().

I think prepare-to-commit is too late; it does not want to know if
the index it was given to create a tree out of is the one that the
user will keep using after this invocation of "git commit" or just a
temporary one used for partial commit.  The cache-tree rebuilt there
is what is recorded with commit_tree_extended() in cmd_commit(), but
if you are doing a partial commit, these generic code paths are
given a temporary index file on the filesystem to work on, and
cache-tree in that will not help user's later operation.

For three main uses of "git commit", prepare_index() does these:

 - "git commit -a" and "git commit -i $paths" update the index with
   the new contents from the working tree, fully builds cache-tree
   in-core to write out the tree objects, and writes the index file
   to the filesystem.  Because this index is the one used after this
   invocation of "git commit" returns, we have a fully populated
   cache-tree after this happens.  This code path is perfect and
   there is no need to change.

 - "git commit" commits the contents of the index as-is, so
   technically there is no reason for it to update the index on the
   filesystem at all, but it refreshes the cached stat data to help
   the "status" part of the command, and if it finds that stat data
   was stale, updates the index on the filesystem because it is
   wasteful not to do so.  As we would be spending I/O cycles to
   update the index file in that case anyway, we also rebuild the
   cache-tree and include that in the updated index.

   When the cached stat data was already up-to-date, however, we do
   not update the index on the filesystem, so the series under
   discussion will change the trade-off by doing one more I/O to
   write out a new index to the filesystem only to update cache-tree.

 - "git commit $paths" updates the "real" index with given $paths
   and writes it out to the filesystem first.  This is the index the
   user will use after "git commit" finishes; traditionally our
   trade-off was "populate cache-tree only when we do not have to
   spend any cycle only to do so (i.e. when we are writing trees
   anyway, or when we read from a tree), and let it degrade as paths
   are added, removed and modified" and we avoided populating
   cache-tree in this codepath.  The series under discussion will
   change the trade-off here, too.

   After it updates this "real" index, it builds another temporary
   index that represents the tree state to be committed (starting
   from HEAD and updates with the given $paths), but that will be
   discarded and we do not want to spend any extra cycle to do
   anything only to make its later use more efficient (like writing
   updated cache-tree to it).

> If we find out that
> we have incomplete cache-tree before that call, we could write the
> index one more time after that call,

and that will make an extra I/O only to write out cache-tree to the
temporary index that we will discard immediately after for a partial
commit.
