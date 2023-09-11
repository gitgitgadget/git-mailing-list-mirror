Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4027ECA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 01:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjILBmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 21:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjILBmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 21:42:21 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A7E8117F
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 18:18:53 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:32880)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfqnM-00C1we-5J; Mon, 11 Sep 2023 17:58:20 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:48404 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfqnK-00F1xw-Sl; Mon, 11 Sep 2023 17:58:19 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-2-ebiederm@xmission.com>
        <ZP3UCQf+9D/J3wqT@tapette.crustytoothpaste.net>
        <xmqqy1hdi6hp.fsf@gitster.g>
        <87sf7kd5xg.fsf_-_@email.froward.int.ebiederm.org>
Date:   Mon, 11 Sep 2023 18:46:19 -0500
In-Reply-To: <87sf7kd5xg.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 11 Sep 2023 11:35:07 -0500")
Message-ID: <87ledcb7ec.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qfqnK-00F1xw-Sl;;;mid=<87ledcb7ec.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19m/sIqAlvQL+7+YKX8r/ba6MIGPmKQ0xw=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v3 02/32] doc hash-function-transition: Augment
 compatObjectFormat with readCompatMap
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
for writes fron older versions of git.  Thus the compatObjectFormat option
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
use core.readCompatMap to make it clear the mappings only read.

I have documented that both of the options readCompatMap and
compatObjectFormat can be specified multiple times if that is needed to
support the desired configuration of git.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

My v2 version was just silly.  Changing the name of the option in
the [extensions] section made practical sense.  It was just me being
contrary for no good reason.  I still think we should have an additional
option for reading old hashes and to document that we expect multiple of
these.

So here is my proposal for extending the documentation along those
lines.

Additionally just accepting the existing option name means I am not
bottlenecked for writing tests convert_object_file which is the
important part right now.

My apologies for all of the noise.

 .../technical/hash-function-transition.txt    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 4b937480848a..26dfc3138b3b 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -171,6 +171,43 @@ repository, instead producing an error message.
 		objectformat
 		compatobjectformat
 
+Configurate for a future hash function transition would be:
+
+	[core]
+		repositoryFormatVersion = 1
+	[extensions]
+		objectFormat = futureHash
+		compatObjectFormat = sha256
+		compatObjectFormat = sha1
+
+Or possibly:
+
+	[core]
+		repositoryFormatVersion = 1
+		readCompatMap = sha1
+	[extensions]
+		objectFormat = futureHash
+		compatObjectFormat = sha256
+
+Or post transition to futureHash:
+
+	[core]
+		repositoryFormatVersion = 1
+		readCompatMap = sha1
+		readComaptMap = sha256
+	[extensions]
+		objectFormat = futureHash
+
+The difference between compatObjectFormat and readCompatMap would be that
+compatObjectFormat would ask git to read existing maps, but would not ask
+git to write or create them.  Which is enough to support looking up
+old oids post transition, when they are only needed to support
+references in commit logs, bug trackers, emails and the like.
+
+Meanwhile with compatObjectFormat set every object in the entire
+repository would be required to have a bi-directional mapping from the
+the mapped object format to the repositories storage hash function.
+
 See the "Transition plan" section below for more details on these
 repository extensions.
 
-- 
2.41.0

