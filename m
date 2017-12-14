Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 420B31F404
	for <e@80x24.org>; Thu, 14 Dec 2017 20:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbdLNUcL (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 15:32:11 -0500
Received: from siwi.pair.com ([209.68.5.199]:25656 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752455AbdLNUcK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 15:32:10 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F15348450E;
        Thu, 14 Dec 2017 15:32:09 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A25658450D;
        Thu, 14 Dec 2017 15:32:09 -0500 (EST)
Subject: Re: [PATCH] partial-clone: design doc
To:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171208192636.13678-1-git@jeffhostetler.com>
 <20171208192636.13678-2-git@jeffhostetler.com>
 <46D2661C19CD4ADE81699FE7E99712EE@PhilipOakley>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <61f0bd31-adc5-92ed-c644-28d025da93fa@jeffhostetler.com>
Date:   Thu, 14 Dec 2017 15:32:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <46D2661C19CD4ADE81699FE7E99712EE@PhilipOakley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Sorry, I didn't see this message in my inbox when I posted V2 of the
design doc.  I'll address questions here and update the doc as necessary.


On 12/12/2017 6:31 PM, Philip Oakley wrote:
> From: "Jeff Hostetler" <git@jeffhostetler.com>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> First draft of design document for partial clone feature.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>> Documentation/technical/partial-clone.txt | 240 ++++++++++++++++++++++++++++++
>> 1 file changed, 240 insertions(+)
>> create mode 100644 Documentation/technical/partial-clone.txt
>>
>> diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
>> new file mode 100644
>> index 0000000..7ab39d8
>> --- /dev/null
>> +++ b/Documentation/technical/partial-clone.txt
>> @@ -0,0 +1,240 @@
>> +Partial Clone Design Notes
>> +==========================
>> +
>> +The "Partial Clone" feature is a performance optimization for git that
>> +allows git to function without having a complete copy of the repository.
>> +
> 
> I think it would be worthwhile at least listing the issues that make the 'optimisation' necessary, and then the available factors that make the optimisation possible. This helps for future adjustments when those issues and factors change.
> 
> I think the issues are:
> * the size of the repository that is being cloned, both in the width of a commit (you mentioned 100M trees) and the time (hours to days) / size to clone over the connection.
> 
> While the supporting factor is:
> * the remote is always on-line and available for on-demand object fetching (seconds)
> 
> The solution choice then should fall out fairly obviously, and we can separate out the other optimisations that are based on other views about the issues. E.g. my desire for a solution in the off-line case.
> 
> In fact the current design, apart from some terminology, does look well matched, with only a couple of places that would be affected.
> 
> The airplane-mode expectations of a partial clone should also be stated.

Good points.  I'll try to work these into V3.
  
  
>> +During clone and fetch operations, git normally downloads the complete
>> +contents and history of the repository.  That is, during clone the client
>> +receives all of the commits, trees, and blobs in the repository into a
>> +local ODB.  Subsequent fetches extend the local ODB with any new objects.
>> +For large repositories, this can take significant time to download and
>> +large amounts of diskspace to store.
>> +
>> +The goal of this work is to allow git better handle extremely large
>> +repositories.
> 
> Shouln't this goal be nearer the top?

maybe. i'll see about reordering the paragraphs in the introduction.


> 
>>        Often in these repositories there are many files that the
>> +user does not need such as ancient versions of source files, files in
>> +portions of the worktree outside of the user's work area, or large binary
>> +assets.  If we can avoid downloading such unneeded objects *in advance*
>> +during clone and fetch operations, we can decrease download times and
>> +reduce ODB disk usage.
>> +
> 
> Does this need to distinguish between the shallow clone mechanism for reducing the cloning of old history from the desire for a width wise partial clone of only the users narrow work area, and/or without large files/blobs?

I tried to state in the next section that partial clone is independent of
shallow clone.  That is, our stuff works on filtering *within* the
set of commits received.  The existing shallow clone and have/wants
commit limiting features still apply.  I didn't go into detail on the
specific filters, because they are documented elsewhere and I view them
as an expandable set.  The primary goal here is to describe how we
handle missing objects without regard to why an object is missing.

  
>> +
>> +Non-Goals
>> +---------
>> +
>> +Partial clone is independent of and not intended to conflict with
>> +shallow-clone, refspec, or limited-ref mechanisms since these all operate
>> +at the DAG level whereas partial clone and fetch works *within* the set
>> +of commits already chosen for download.
>> +
[...]
>> +Design Details
>> +--------------
[...]
>> +  These filtered packfiles are incomplete in the traditional sense because
>> +  they may contain trees that reference blobs that the client does not have.
> 
> Is a comment needed here noting that currently, IIUC, the complete trees are fetched in the packfiles, it's just the un-necessary blobs that are omitted ?

Currently, we have filters to omit unwanted blobs.  Later, we hope to
add other filters to omit trees too.  My point was that the packfiles
are incomplete (have missing objects).  I'll reword the above statement
a little.


>> +
>> +
>> +==== How the local repository gracefully handles missing objects
>> +
>> +With partial clone, the fact that objects can be missing makes such
>> +repositories incompatible with older versions of Git, necessitating a
>> +repository extension (see the documentation of "extensions.partialClone"
>> +for more information).
>> +
>> +An object may be missing due to a partial clone or fetch, or missing due
>> +to repository corruption. To differentiate these cases, the local
>> +repository specially indicates packfiles obtained from the promisor
> 
> s/packfiles/filtered packfiles/ ?

got it.

> 
>> +remote. These "promisor packfiles" consist of a "<name>.promisor" file
>> +with arbitrary contents (like the "<name>.keep" files), in addition to
>> +their "<name>.pack" and "<name>.idx" files. (In the future, this ability
>> +may be extended to loose objects[a].)
>> +
>> +The local repository considers a "promisor object" to be an object that
>> +it knows (to the best of its ability) that the promisor remote has,
> 
> s/has/is expected to have/  or /has promised it has/ ?

got it.

> 
>> +either because the local repository has that object in one of its
>> +promisor packfiles, or because another promisor object refers to it. Git
>> +can then check if the missing object is a promisor object, and if yes,
>> +this situation is common and expected. This also means that there is no
>> +need to explicitly maintain an expensive-to-modify list of missing
> 
> I didn't get what part the "expensive-to-modify" was referring to. Or why whatever it is is expensive?

I'll add a paragraph to explain that comment.

  
>> +objects on the client.
>> +
>> +Almost all Git code currently expects any objects referred to by other
>> +objects to be present. Therefore, a fallback mechanism is added:
>> +whenever Git attempts to read an object that is found to be missing, it
>> +will attempt to fetch it from the promisor remote, expanding the subset
>> +of objects available locally, then reattempt the read. This allows
>> +objects to be "faulted in" from the promisor remote without complicated
>> +prediction algorithms. For efficiency reasons, no check as to whether
>> +the missing object is a promisor object is performed. This tends to be
>> +slow as objects are fetched one at a time.
>> +
>> +The fallback mechanism can be turned off and on through a global
>> +variable.
> 
> Perhaps name the variable?

got it.

  
>> +
>> +checkout (and any other command using unpack-trees) has been taught to
> 
> s/checkout/`git-checkout`/  to show that a proper sentence has started, maybe?
> 
>> +batch blob fetching. rev-list has been taught to be able to print
>> +filtered or missing objects and can be used with more general batch
>> +fetch scripts. In the future, Git commands will be updated to batch such
>> +fetches or otherwise handle missing objects more efficiently.
>> +
>> +Fsck has been updated to be fully aware of promisor objects. The repack
>> +in GC has been updated to not touch promisor packfiles at all, and to
>> +only repack other objects.
>> +
>> +The global variable fetch_if_missing is used to control whether an
>> +object lookup will attempt to dynamically fetch a missing object or
>> +report an error.
> 
> Is this also the airplane mode control?

This can be used by fsck or other commands to gently try to load an object
and get an error rather than implicitly attempting fetch it.

  
>> +Current Limitations
>> +-------------------
>> +
>> +- The remote used for a partial clone (or the first partial fetch
>> +  following a regular clone) is marked as the "promisor remote".
>> +
>> +  We are currently limited to a single promisor remote and only that
>> +  remote may be used for subsequent partial fetches.
>> +
>> +- Dynamic object fetching will only ask the promisor remote for missing
>> +  objects.  We assume that the promisor remote has a complete view of the
>> +  repository and can satisfy all such requests.
>> +
>> +  Future work may lift this restriction when we figure out how to route
> 
> Could the "Future Work: " items have a consistent style? It makes it easier to see the expectation of the likely development.

sure. i'll break this into 2 sections.

  
>> +  such requests.  The current assumption is that partial clone will not be
>> +  used for triangular workflows that would need that (at least initially).
>> +
>> +- Repack essentially treats promisor and non-promisor packfiles as 2
>> +  distinct partitions and does not mix them.  Repack currently only works
>> +  on non-promisor packfiles and loose objects.
>> +
>> +  Future work may let repack work to repack promisor packfiles (while
>> +  keeping them in a different partition from the others).
>> +
>> +- The current object filtering mechanism does not make use of packfile
>> +  bitmaps (when present).
>> +
>> +  We should allow this for filters that are not pathname-based.
>> +
>> +- Currently, dynamic object fetching invokes fetch-pack for each item
>> +  because most algorithms stumble upon a missing object and need to have
>> +  it resolved before continuing their work.  This may incur significant
>> +  overhead -- and multiple authentication requests -- if many objects are
>> +  needed.
> 
> I think this is one of the points of distinction between the always connected partial clone and the potential 'airplane mode' narrow clone where missing objects are not [cannot be] fetched on-the-fly.
> 
> [my 'solution' is, when requested, to expand the oid to a short distinct stub file, and let them stand in the place of the real (missing) file/directories, and then let all the regular commands act on those stubs, e.g. diffs just show the changed oid embedded in the stub, etc. However that is all orthogonal to this design doc.]

I'm not really prepared to discuss your proposal (no offense, I just haven't
kept up with it).  Also, it might be fine for git-diff to print stub file
meta-data, but commands that actually need the file contents (like GCC) will
still fail, so I'm not sure how useful this is.  But again, I've not kept up
with your proposal, so I might be missing something here.

[...]
> Thanks for the write up.
> -- 
> Philip

Thanks for the comments,
Jeff

