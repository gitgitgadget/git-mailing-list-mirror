Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E276A1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 15:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbdLNP0d (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 10:26:33 -0500
Received: from siwi.pair.com ([209.68.5.199]:31654 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753135AbdLNPYa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 10:24:30 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 696BE844F8;
        Thu, 14 Dec 2017 10:24:30 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CFEEA844F5;
        Thu, 14 Dec 2017 10:24:29 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2] partial-clone: design doc
Date:   Thu, 14 Dec 2017 15:24:04 +0000
Message-Id: <20171214152404.35708-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171214152404.35708-1-git@jeffhostetler.com>
References: <20171214152404.35708-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

First draft of design document for partial clone feature.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/partial-clone.txt | 259 ++++++++++++++++++++++++++++++
 1 file changed, 259 insertions(+)
 create mode 100644 Documentation/technical/partial-clone.txt

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
new file mode 100644
index 0000000..731bd8c
--- /dev/null
+++ b/Documentation/technical/partial-clone.txt
@@ -0,0 +1,259 @@
+Partial Clone Design Notes
+==========================
+
+The "Partial Clone" feature is a performance optimization for git that
+allows git to function without having a complete copy of the repository.
+
+During clone and fetch operations, git normally downloads the complete
+contents and history of the repository.  That is, during clone the client
+receives all of the commits, trees, and blobs in the repository into a
+local ODB.  Subsequent fetches extend the local ODB with any new objects.
+For large repositories, this can take significant time to download and
+large amounts of diskspace to store.
+
+The goal of this work is to allow git better handle extremely large
+repositories.  Often in these repositories there are many files that the
+user does not need such as ancient versions of source files, files in
+portions of the worktree outside of the user's work area, or large binary
+assets.  If we can avoid downloading such unneeded objects *in advance*
+during clone and fetch operations, we can decrease download times and
+reduce ODB disk usage.
+
+
+Non-Goals
+---------
+
+Partial clone is a mechanism to limit the number of blobs and trees downloaded
+*within* a given range of commits -- and is therefore independent of and not
+intended to conflict with existing DAG-level mechanisms to limit the set of
+requested commits (i.e. shallow clone, single branch, or fetch '<refspec>').
+
+
+Design Overview
+---------------
+
+Partial clone logically consists of the following parts:
+
+- A mechanism for the client to describe unneeded or unwanted objects to
+  the server.
+
+- A mechanism for the server to omit such unwanted objects from packfiles
+  sent to the client.
+
+- A mechanism for the client to gracefully handle missing objects (that
+  were previously omitted by the server).
+
+- A mechanism for the client to backfill missing objects as needed.
+
+
+Design Details
+--------------
+
+- A new pack-protocol capability "filter" is added to the fetch-pack and
+  upload-pack negotiation.
+
+  This uses the existing capability discovery mechanism.
+  See "filter" in Documentation/technical/pack-protocol.txt.
+
+- Clients pass a "filter-spec" to clone and fetch which is passed to the
+  server to request filtering during packfile construction.
+
+  There are various filters available to accomodate different situations.
+  See "--filter=<filter-spec>" in Documentation/rev-list-options.txt.
+
+- On the server pack-objects applies the requested filter-spec as it
+  creates "filtered" packfiles for the client.
+
+  These filtered packfiles are incomplete in the traditional sense because
+  they may contain trees that reference blobs that the client does not have.
+
+- On the client these incomplete packfiles are marked as "promisor pacfiles"
+  and treated differently by various commands.
+
+- On the client a repository extension is added to the local config to
+  prevent older versions of git from failing mid-operation because of
+  missing objects that they cannot handle.
+  See "extensions.partialClone" in Documentation/technical/repository-version.txt"
+
+
+Handling Missing Objects
+------------------------
+
+- An object may be missing due to a partial clone or fetch, or missing due
+  to repository corruption.  To differentiate these cases, the local
+  repository specially indicates packfiles obtained from the promisor
+  remote.
+
+  These "promisor packfiles" consist of a "<name>.promisor" file with
+  arbitrary contents (like the "<name>.keep" files), in addition to
+  their "<name>.pack" and "<name>.idx" files.
+
+  In the future, this ability may be extended to loose objects in case
+  a promisor packfile is accidentally unpacked.
+
+- The local repository considers a "promisor object" to be an object that
+  it knows (to the best of its ability) that the promisor remote has, either
+  because the local repository has that object in one of its promisor
+  packfiles, or because another promisor object refers to it.
+
+  When git encounters a missing object, Git can see if it a promisor object
+  and handle it appropriately.  If not, Git can report a corruption.
+
+  This means that there is no need for the client to explicitly maintain an
+  expensive-to-modify list of missing objects.
+
+- Since almost all Git code currently expects any referenced object to be
+  present locally and because we do not want to force every command to do
+  a dry-run first, a fallback mechanism is added to allow Git to attempt
+  to dynamically fetch missing objects from the promisor remote.
+
+  When the normal object lookup fails to find an object, Git invokes
+  fetch-object to try to get the object from the server and then retry
+  the object lookup.  This allows objects to be "faulted in" without
+  complicated prediction algorithms.
+
+  For efficiency reasons, no check as to whether the missing object is
+  actually a promisor object is performed.
+
+  Dynamic object fetching tends to be slow as objects are fetched one at
+  a time.
+
+- checkout (and any other command using unpack-trees) has been taught to
+  bulk pre-fetch all required missing blobs in a single batch.
+
+- rev-list has been taught to print missing objects.
+
+  This can be used by other commands to bulk prefetch objects.
+  For example, a "git log -p A..B" may internally want to first do
+  something like "git rev-list --objects --quiet --missing=print A..B"
+  and prefetch those objects in bulk.
+
+- fsck has been updated to be fully aware of promisor objects.
+
+- repack in GC has been updated to not touch promisor packfiles at all,
+  and to only repack other objects.
+
+- The global variable fetch_if_missing is used to control whether an
+  object lookup will attempt to dynamically fetch a missing object or
+  report an error.
+
+  We are not happy with this global variable and would like to remove it,
+  but that requires significant refactoring of the object code to pass an
+  additional flag.  We hope that concurrent efforts to add an ODB API can
+  encompass this.
+
+
+Fetching Missing Objects
+------------------------
+
+Fetching of objects is done using the existing transport mechanism using
+transport_fetch_refs(), setting a new transport option
+TRANS_OPT_NO_DEPENDENTS to indicate that only the objects themselves are
+desired, not any object that they refer to.  Because some transports
+invoke fetch_pack() in the same process, fetch_pack() has been updated
+to not use any object flags when the corresponding argument
+(no_dependents) is set.
+
+The local repository sends a request with the hashes of all requested
+objects as "want" lines, and does not perform any packfile negotiation.
+It then receives a packfile.
+
+Because we are reusing the existing fetch-pack mechanism, fetching
+currently fetches all objects referred to by the requested objects, even
+though they are not necessary.
+
+
+Current Limitations
+-------------------
+
+- The remote used for a partial clone (or the first partial fetch
+  following a regular clone) is marked as the "promisor remote".
+
+  We are currently limited to a single promisor remote and only that
+  remote may be used for subsequent partial fetches.
+
+- Dynamic object fetching will only ask the promisor remote for missing
+  objects.  We assume that the promisor remote has a complete view of the
+  repository and can satisfy all such requests.
+
+  Future work may lift this restriction when we figure out how to route
+  such requests.  The current assumption is that partial clone will not be
+  used for triangular workflows that would need that (at least initially).
+
+- Repack essentially treats promisor and non-promisor packfiles as 2
+  distinct partitions and does not mix them.  Repack currently only works
+  on non-promisor packfiles and loose objects.
+
+  Future work may let repack work to repack promisor packfiles (while
+  keeping them in a different partition from the others).
+
+- The current object filtering mechanism does not make use of packfile
+  bitmaps (when present).
+
+  We should allow this for filters that are not pathname-based.
+
+- Currently, dynamic object fetching invokes fetch-pack for each item
+  because most algorithms stumble upon a missing object and need to have
+  it resolved before continuing their work.  This may incur significant
+  overhead -- and multiple authentication requests -- if many objects are
+  needed.
+
+  We need to investigate use of a long-running process, such as proposed
+  in [5,6] to reduce process startup and overhead costs.
+
+  It would be nice if pack protocol V2 could allow that long-running
+  process to make a series of requests over a single long-running
+  connection.
+
+- Dynamic object fetching currently uses the existing pack protocol V0
+  which means that each object is requested via fetch-pack.  The server
+  will send a full set of info/refs when the connection is established.
+  If there are large number of refs, this may incur significant overhead.
+
+  We expect that protocol V2 will allow us to avoid this cost.
+
+
+Non-Tasks
+---------
+
+- Every time the subject of "demand loading blobs" comes up it seems
+  that someone suggests that the server be allowed to "guess" and send
+  additional objects that may be related to the requested objects.
+
+  No work has gone into actually doing that; we're just documenting that
+  it is a common suggestion.  We're not sure how it would work and have
+  no plans to work on it.
+
+  It is valid for the server to send more objects than requested (even
+  for a dynamic object fetch), but we are not building on that.
+
+
+Related Links
+-------------
+[0] https://bugs.chromium.org/p/git/issues/detail?id=2
+    Chromium work item for: Partial Clone 
+
+[1] https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
+    Subject: [RFC] Add support for downloading blobs on demand
+    Date: Fri, 13 Jan 2017 10:52:53 -0500
+
+[2] https://public-inbox.org/git/cover.1506714999.git.jonathantanmy@google.com/
+    Subject: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18 patches)
+    Date: Fri, 29 Sep 2017 13:11:36 -0700
+
+[3] https://public-inbox.org/git/20170426221346.25337-1-jonathantanmy@google.com/
+    Subject: Proposal for missing blob support in Git repos
+    Date: Wed, 26 Apr 2017 15:13:46 -0700
+
+[4] https://public-inbox.org/git/1488999039-37631-1-git-send-email-git@jeffhostetler.com/
+    Subject: [PATCH 00/10] RFC Partial Clone and Fetch
+    Date: Wed,  8 Mar 2017 18:50:29 +0000
+
+
+[5] https://public-inbox.org/git/20170505152802.6724-1-benpeart@microsoft.com/
+    Subject: [PATCH v7 00/10] refactor the filter process code into a reusable module
+    Date: Fri,  5 May 2017 11:27:52 -0400
+
+[6] https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/
+    Subject: [RFC/PATCH v2 0/1] Add support for downloading blobs on demand
+    Date: Fri, 14 Jul 2017 09:26:50 -0400
-- 
2.9.3

