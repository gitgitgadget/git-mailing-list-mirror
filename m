Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61F51F406
	for <e@80x24.org>; Tue, 12 Dec 2017 23:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbdLLXb1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 18:31:27 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:30331 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbdLLXbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 18:31:25 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id Ou1De5s0BAp17Ou1DenjQe; Tue, 12 Dec 2017 23:31:24 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=bt3WUTiwAAAA:8
 a=yMhMjlubAAAA:8 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8 a=5rxgeBVgAAAA:8
 a=KtQjr8fj1hifCWTfyAQA:9 a=IFh-RaMEKGTpOeYZ:21 a=R8X3APMIxQeTUp2I:21
 a=wPNLvfGTeEIA:10 a=OXx4ngWzwLx9h_IvVXMu:22 a=xmb-EsYY8bH0VWELuYED:22
 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <46D2661C19CD4ADE81699FE7E99712EE@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jeff Hostetler" <git@jeffhostetler.com>, <git@vger.kernel.org>
Cc:     <gitster@pobox.com>, <peff@peff.net>, <jonathantanmy@google.com>,
        "Jeff Hostetler" <jeffhost@microsoft.com>
References: <20171208192636.13678-1-git@jeffhostetler.com> <20171208192636.13678-2-git@jeffhostetler.com>
Subject: Re: [PATCH] partial-clone: design doc
Date:   Tue, 12 Dec 2017 23:31:22 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171211-6, 11/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfHyMpvNJ+L9FKqf5PhmrdnwiDQNZBQ14bFve7du+shI1O9HHmGXZ3LN0fdIPSwiVe8SAWjwLKk83UuQ0jn1sjKb2Kj74Ia8eJrX/SOrUcMH0X54K8t0D
 vDN215Q5E0iY8ayPZc1RbfQkkvbOcMyk89+GMPdeCkS3BsviBx5SbECs1bL3CZjCykB4Dm8n4pN9yaJg3uL5kbqM/ZR1ZzmYULfmZB/9Wze6JtiAtrJ0YbgP
 9DA/1i02N6NDF1pN7pKyRmjdqj2hQiT/6EO2EPuRSJB8nr//3X5uiH6hLx/8/PfpTm/DNhRohdvj5xZL0Q0qPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff Hostetler" <git@jeffhostetler.com>
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> First draft of design document for partial clone feature.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Documentation/technical/partial-clone.txt | 240 
> ++++++++++++++++++++++++++++++
> 1 file changed, 240 insertions(+)
> create mode 100644 Documentation/technical/partial-clone.txt
>
> diff --git a/Documentation/technical/partial-clone.txt 
> b/Documentation/technical/partial-clone.txt
> new file mode 100644
> index 0000000..7ab39d8
> --- /dev/null
> +++ b/Documentation/technical/partial-clone.txt
> @@ -0,0 +1,240 @@
> +Partial Clone Design Notes
> +==========================
> +
> +The "Partial Clone" feature is a performance optimization for git that
> +allows git to function without having a complete copy of the repository.
> +

I think it would be worthwhile at least listing the issues that make the 
'optimisation' necessary, and then the available factors that make the 
optimisation possible. This helps for future adjustments when those issues 
and factors change.

I think the issues are:
* the size of the repository that is being cloned, both in the width of a 
commit (you mentioned 100M trees) and the time (hours to days) / size to 
clone over the connection.

While the supporting factor is:
* the remote is always on-line and available for on-demand object fetching 
(seconds)

The solution choice then should fall out fairly obviously, and we can 
separate out the other optimisations that are based on other views about the 
issues. E.g. my desire for a solution in the off-line case.

In fact the current design, apart from some terminology, does look well 
matched, with only a couple of places that would be affected.

The airplane-mode expectations of a partial clone should also be stated.


> +During clone and fetch operations, git normally downloads the complete
> +contents and history of the repository.  That is, during clone the client
> +receives all of the commits, trees, and blobs in the repository into a
> +local ODB.  Subsequent fetches extend the local ODB with any new objects.
> +For large repositories, this can take significant time to download and
> +large amounts of diskspace to store.
> +
> +The goal of this work is to allow git better handle extremely large
> +repositories.

Shouln't this goal be nearer the top?

>        Often in these repositories there are many files that the
> +user does not need such as ancient versions of source files, files in
> +portions of the worktree outside of the user's work area, or large binary
> +assets.  If we can avoid downloading such unneeded objects *in advance*
> +during clone and fetch operations, we can decrease download times and
> +reduce ODB disk usage.
> +

Does this need to distinguish between the shallow clone mechanism for 
reducing the cloning of old history from the desire for a width wise partial 
clone of only the users narrow work area, and/or without large files/blobs?

> +
> +Non-Goals
> +---------
> +
> +Partial clone is independent of and not intended to conflict with
> +shallow-clone, refspec, or limited-ref mechanisms since these all operate
> +at the DAG level whereas partial clone and fetch works *within* the set
> +of commits already chosen for download.
> +
> +
> +Design Overview
> +---------------
> +
> +Partial clone logically consists of the following parts:
> +
> +- A mechanism for the client to describe unneeded or unwanted objects to
> +  the server.
> +
> +- A mechanism for the server to omit such unwanted objects from packfiles
> +  sent to the client.
> +
> +- A mechanism for the client to gracefully handle missing objects (that
> +  were previously omitted by the server).
> +
> +- A mechanism for the client to backfill missing objects as needed.
> +
> +
> +Design Details
> +--------------
> +
> +- A new pack-protocol capability "filter" is added to the fetch-pack and
> +  upload-pack negotiation.
> +
> +  This uses the existing capability discovery mechanism.
> +  See "filter" in Documentation/technical/pack-protocol.txt.
> +
> +- Clients pass a "filter-spec" to clone and fetch which is passed to the
> +  server to request filtering during packfile construction.
> +
> +  There are various filters available to accomodate different situations.
> +  See "--filter=<filter-spec>" in Documentation/rev-list-options.txt.
> +
> +- On the server pack-objects applies the requested filter-spec as it
> +  creates "filtered" packfiles for the client.
> +
> +  These filtered packfiles are incomplete in the traditional sense 
> because
> +  they may contain trees that reference blobs that the client does not 
> have.

Is a comment needed here noting that currently, IIUC, the complete trees are 
fetched in the packfiles, it's just the un-necessary blobs that are omitted 
?

> +
> +
> +==== How the local repository gracefully handles missing objects
> +
> +With partial clone, the fact that objects can be missing makes such
> +repositories incompatible with older versions of Git, necessitating a
> +repository extension (see the documentation of "extensions.partialClone"
> +for more information).
> +
> +An object may be missing due to a partial clone or fetch, or missing due
> +to repository corruption. To differentiate these cases, the local
> +repository specially indicates packfiles obtained from the promisor

s/packfiles/filtered packfiles/ ?

> +remote. These "promisor packfiles" consist of a "<name>.promisor" file
> +with arbitrary contents (like the "<name>.keep" files), in addition to
> +their "<name>.pack" and "<name>.idx" files. (In the future, this ability
> +may be extended to loose objects[a].)
> +
> +The local repository considers a "promisor object" to be an object that
> +it knows (to the best of its ability) that the promisor remote has,

s/has/is expected to have/  or /has promised it has/ ?

> +either because the local repository has that object in one of its
> +promisor packfiles, or because another promisor object refers to it. Git
> +can then check if the missing object is a promisor object, and if yes,
> +this situation is common and expected. This also means that there is no
> +need to explicitly maintain an expensive-to-modify list of missing

I didn't get what part the "expensive-to-modify" was referring to. Or why 
whatever it is is expensive?

> +objects on the client.
> +
> +Almost all Git code currently expects any objects referred to by other
> +objects to be present. Therefore, a fallback mechanism is added:
> +whenever Git attempts to read an object that is found to be missing, it
> +will attempt to fetch it from the promisor remote, expanding the subset
> +of objects available locally, then reattempt the read. This allows
> +objects to be "faulted in" from the promisor remote without complicated
> +prediction algorithms. For efficiency reasons, no check as to whether
> +the missing object is a promisor object is performed. This tends to be
> +slow as objects are fetched one at a time.
> +
> +The fallback mechanism can be turned off and on through a global
> +variable.

Perhaps name the variable?

> +
> +checkout (and any other command using unpack-trees) has been taught to

s/checkout/`git-checkout`/  to show that a proper sentence has started, 
maybe?

> +batch blob fetching. rev-list has been taught to be able to print
> +filtered or missing objects and can be used with more general batch
> +fetch scripts. In the future, Git commands will be updated to batch such
> +fetches or otherwise handle missing objects more efficiently.
> +
> +Fsck has been updated to be fully aware of promisor objects. The repack
> +in GC has been updated to not touch promisor packfiles at all, and to
> +only repack other objects.
> +
> +The global variable fetch_if_missing is used to control whether an
> +object lookup will attempt to dynamically fetch a missing object or
> +report an error.

Is this also the airplane mode control?

> +
> +
> +===== Fetching missing objects
> +
> +Fetching of objects is done using the existing transport mechanism using
> +transport_fetch_refs(), setting a new transport option
> +TRANS_OPT_NO_DEPENDENTS to indicate that only the objects themselves are
> +desired, not any object that they refer to. Because some transports
> +invoke fetch_pack() in the same process, fetch_pack() has been updated
> +to not use any object flags when the corresponding argument
> +(no_dependents) is set.
> +
> +The local repository sends a request with the hashes of all requested
> +objects as "want" lines, and does not perform any packfile negotiation.
> +It then receives a packfile.
> +
> +Because we are reusing the existing fetch-pack mechanism, fetching
> +currently fetches all objects referred to by the requested objects, even
> +though they are not necessary.
> +
> +
> +
> +Foot Notes
> +----------
> +
> +[a] Remembering that loose objects are promisor objects is mainly
> +    important for trees, since they may refer to promisor blobs that
> +    the user does not have.  We do not need to mark loose blobs as
> +    promisor because they do not refer to other objects.
> +
> +
> +
> +Current Limitations
> +-------------------
> +
> +- The remote used for a partial clone (or the first partial fetch
> +  following a regular clone) is marked as the "promisor remote".
> +
> +  We are currently limited to a single promisor remote and only that
> +  remote may be used for subsequent partial fetches.
> +
> +- Dynamic object fetching will only ask the promisor remote for missing
> +  objects.  We assume that the promisor remote has a complete view of the
> +  repository and can satisfy all such requests.
> +
> +  Future work may lift this restriction when we figure out how to route

Could the "Future Work: " items have a consistent style? It makes it easier 
to see the expectation of the likely development.

> +  such requests.  The current assumption is that partial clone will not 
> be
> +  used for triangular workflows that would need that (at least 
> initially).
> +
> +- Repack essentially treats promisor and non-promisor packfiles as 2
> +  distinct partitions and does not mix them.  Repack currently only works
> +  on non-promisor packfiles and loose objects.
> +
> +  Future work may let repack work to repack promisor packfiles (while
> +  keeping them in a different partition from the others).
> +
> +- The current object filtering mechanism does not make use of packfile
> +  bitmaps (when present).
> +
> +  We should allow this for filters that are not pathname-based.
> +
> +- Currently, dynamic object fetching invokes fetch-pack for each item
> +  because most algorithms stumble upon a missing object and need to have
> +  it resolved before continuing their work.  This may incur significant
> +  overhead -- and multiple authentication requests -- if many objects are
> +  needed.

I think this is one of the points of distinction between the always 
connected partial clone and the potential 'airplane mode' narrow clone where 
missing objects are not [cannot be] fetched on-the-fly.

[my 'solution' is, when requested, to expand the oid to a short distinct 
stub file, and let them stand in the place of the real (missing) 
file/directories, and then let all the regular commands act on those stubs, 
e.g. diffs just show the changed oid embedded in the stub, etc. However that 
is all orthogonal to this design doc.]

> +
> +  We need to investigate use of a long-running process, such as proposed
> +  in [5,6] to reduce process startup and overhead costs.
> +
> +  It would also be nice to use pack protocol V2 to also allow that 
> long-running
> +  process to make a series of requests over a single long-running 
> connection.
> +
> +- We currently only promisor packfiles.

Is there a missing word or phrase, I couldn't parse this.

>                   We need to add support for
> +  promisor loose objects as described earlier.
> +
> +- Dynamic object fetching currently uses the existing pack protocol V0
> +  which means that each object is requested via fetch-pack.  The server
> +  will send a full set of info/refs when the connection is established.
> +  If there are large number of refs, this may incur significant overhead.
> +
> +  We expect that protocol V2 will allow us to avoid this cost.
> +
> +- Every time the subject of "demand loading blobs" comes up it seems
> +  that someone suggest that the server be allowed to "guess" and send
> +  additional objects that may be related to the requested objects.
> +
> +  No work has gone into actually doing that; we're just documenting that
> +  it is a common suggestion for a future enhancement.
> +

Thanks for the write up.
--
Philip

> +
> +Related Links
> +-------------
> +[0] https://bugs.chromium.org/p/git/issues/detail?id=2
> +    Chromium work item for: Partial Clone
> +
> +[1] 
> https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
> +    Subject: [RFC] Add support for downloading blobs on demand
> +    Date: Fri, 13 Jan 2017 10:52:53 -0500
> +
> +[2] 
> https://public-inbox.org/git/cover.1506714999.git.jonathantanmy@google.com/
> +    Subject: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18 
> patches)
> +    Date: Fri, 29 Sep 2017 13:11:36 -0700
> +
> +[3] 
> https://public-inbox.org/git/20170426221346.25337-1-jonathantanmy@google.com/
> +    Subject: Proposal for missing blob support in Git repos
> +    Date: Wed, 26 Apr 2017 15:13:46 -0700
> +
> +[4] 
> https://public-inbox.org/git/1488999039-37631-1-git-send-email-git@jeffhostetler.com/
> +    Subject: [PATCH 00/10] RFC Partial Clone and Fetch
> +    Date: Wed,  8 Mar 2017 18:50:29 +0000
> +
> +
> +[5] 
> https://public-inbox.org/git/20170505152802.6724-1-benpeart@microsoft.com/
> +    Subject: [PATCH v7 00/10] refactor the filter process code into a 
> reusable module
> +    Date: Fri,  5 May 2017 11:27:52 -0400
> +
> +[6] 
> https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/
> +    Subject: [RFC/PATCH v2 0/1] Add support for downloading blobs on 
> demand
> +    Date: Fri, 14 Jul 2017 09:26:50 -0400
> -- 
> 2.9.3
> 

