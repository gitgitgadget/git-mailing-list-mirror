Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005C9CA0EC4
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349407AbjIKVd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbjIKQfV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 12:35:21 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9F1D3
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 09:35:15 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55018)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfjsY-00A9Se-OJ; Mon, 11 Sep 2023 10:35:14 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:39214 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfjsX-0052b3-Hx; Mon, 11 Sep 2023 10:35:14 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-2-ebiederm@xmission.com>
        <ZP3UCQf+9D/J3wqT@tapette.crustytoothpaste.net>
        <xmqqy1hdi6hp.fsf@gitster.g>
Date:   Mon, 11 Sep 2023 11:35:07 -0500
In-Reply-To: <xmqqy1hdi6hp.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        10 Sep 2023 23:11:46 -0700")
Message-ID: <87sf7kd5xg.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qfjsX-0052b3-Hx;;;mid=<87sf7kd5xg.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1906cX5uVSF3TBq9q1ZXfFnp4+qpvuIGmQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 02/32] doc hash-function-transition: Replace
 compatObjectFormat with mapObjectFormat
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Deeply and fundamentally the plan is to only operate one one hash
function for the core of git, to use only one hash function for what
is stored in the repository.

To avoid requring a flag day to transition hash functions for naming
objects, and to support being able to access objects using legacy object
names a mapping functionality will be provided.

We want to provide user facing configuration that is robust enough
that it can accomodate multiple different scenarios on how git
evolves and how people use their repositories.

There are two different ways it is envisioned to use mapped object
ids.  The first is to require every object in the repository to have a
mapping, so that pushes and pulls from repositories using a different
hash algorithm can work.  The second is to have an incomplete mapping
of object ids so that old references to objects in emails, commit
messages, bug trackers and are usable in a read-only manner
with tools like "git show".

The first way fundamentally needs every object in the repository to
have a mapping, which requires the repository to be marked incompatible
for writes fron older versions of git.  Thus the mapObjectFormat option
is placed in [extensions].

The ext2 family of filesystems has 3 ways of describing new features
compatible, read-only-compatible, and incompatible.  The current git
configurtation has compat (any feature mentioned anywhere in the
configuration outside of [extensions] section), and incompatible (any
configuration inside of the [extensions] section.  It would be nice to
have a read-only compatible section for the mandatory mapping
function.  Would it be worth adding it now so that we have it for
future extensions?

Having a mapping that is just used in a read-only mode for looking up
old objects with old object ids will be needed post-transition.  Such
a mode does not require computing the old hash function or even
support automatically writing any new mappings.  So it is completely
safe to enable in a backwards compatible mode.  Fort that let's
use core.readObjectMap to make it clear the mappings only read.

I have documented that both of the options readObjectMap and
mapObjectFormat can be specified multiple times if that is needed to
support the desired configuration of git.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Posting this to hopefully move the conversation forward.  Unfortunately
I need something like this so I can tests so I guess now is the time to
resolve this detail.

 .../technical/hash-function-transition.txt    | 49 ++++++++++++++++---
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 4b937480848a..9f5c672d9ad1 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -149,13 +149,13 @@ Repository format extension
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A SHA-256 repository uses repository format version `1` (see
 Documentation/technical/repository-version.txt) with extensions
-`objectFormat` and `compatObjectFormat`:
+`objectFormat` and `mapObjectFormat`:
 
 	[core]
 		repositoryFormatVersion = 1
 	[extensions]
 		objectFormat = sha256
-		compatObjectFormat = sha1
+		mapObjectFormat = sha1
 
 The combination of setting `core.repositoryFormatVersion=1` and
 populating `extensions.*` ensures that all versions of Git later than
@@ -171,6 +171,43 @@ repository, instead producing an error message.
 		objectformat
 		compatobjectformat
 
+Configurate for a future hash function transition would be:
+
+	[core]
+		repositoryFormatVersion = 1
+	[extensions]
+		objectFormat = futureHash
+		mapObjectFormat = sha256
+		mapObjectFormat = sha1
+
+Or possibly:
+
+	[core]
+		repositoryFormatVersion = 1
+		readObjectMap = sha1
+	[extensions]
+		objectFormat = futureHash
+		mapObjectFormat = sha256
+
+Or post transition to futureHash:
+
+	[core]
+		repositoryFormatVersion = 1
+		readObjectMap = sha1
+		readObjectMap = sha256
+	[extensions]
+		objectFormat = futureHash
+
+The difference between mapObjectFormat and readObjectMap would be that
+mapObjectFormat would ask git to read existing maps, but would not ask
+git to write or create them.  Which is enough to support looking up
+old oids post transition, when they are only needed to support
+references in commit logs, bug trackers, emails and the like.
+
+Meanwhile with mapObjectFormat set every object in the entire
+repository would be required to have a bi-directional mapping from the
+the mapped object format to the repositories storage hash function.
+
 See the "Transition plan" section below for more details on these
 repository extensions.
 
@@ -682,7 +719,7 @@ Some initial steps can be implemented independently of one another:
 - adding support for the PSRC field and safer object pruning
 
 The first user-visible change is the introduction of the objectFormat
-extension (without compatObjectFormat). This requires:
+extension. This requires:
 
 - teaching fsck about this mode of operation
 - using the hash function API (vtable) when computing object names
@@ -690,7 +727,7 @@ extension (without compatObjectFormat). This requires:
 - rejecting attempts to fetch from or push to an incompatible
   repository
 
-Next comes introduction of compatObjectFormat:
+Next comes introduction of mapObjectFormat:
 
 - implementing the loose-object-idx
 - translating object names between object formats
@@ -724,9 +761,9 @@ Over time projects would encourage their users to adopt the "early
 transition" and then "late transition" modes to take advantage of the
 new, more futureproof SHA-256 object names.
 
-When objectFormat and compatObjectFormat are both set, commands
+When objectFormat and mapObjectFormat are both set, commands
 generating signatures would generate both SHA-1 and SHA-256 signatures
 by default to support both new and old users.
 
 In projects using SHA-256 heavily, users could be encouraged to adopt
 the "post-transition" mode to avoid accidentally making implicit use
-- 
2.41.0

