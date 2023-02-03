Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD8C636CC
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 08:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBCIQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 03:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjBCIPu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 03:15:50 -0500
X-Greylist: delayed 548 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 00:15:45 PST
Received: from out-35.mta0.migadu.com (out-35.mta0.migadu.com [IPv6:2001:41d0:1004:224b::23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97E32707
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 00:15:45 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1675411594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xB1hg30Nzgfo7wddXb8sSFTs2Fp3e7NPmIB1IPz2tfg=;
        b=MhswjQa1wBcWOF2yWOn4JI8dOmrH5ICwy5RB7r4aXAVePasyRLQOtZ//4oQrJEcAjQbnHl
        0SBGpJubWA/mIa5xZ6oG3gCL16R+XhiyKRKnkHb/XKMa6htWZ2GF2zcnbszHAKG9afDiga
        9ca87Kbf7gDmqMXVPpzRhhFw1W5olBw=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     ray@ameretat.dev
Cc:     avarab@gmail.com, demerphq@gmail.com, eschwartz93@gmail.com,
        git@vger.kernel.org, gitster@pobox.com,
        konstantin@linuxfoundation.org, l.s.r@web.de, msuchanek@suse.de,
        phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net,
        tytso@mit.edu
Subject: [PATCH] archive: document output stability concerns
Date:   Fri,  3 Feb 2023 03:06:29 -0500
Message-Id: <20230203080629.31492-1-ray@ameretat.dev>
In-Reply-To: <de8f1e338e6ee99cd3ee06b16f1edbce@ameretat.dev>
References: <de8f1e338e6ee99cd3ee06b16f1edbce@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4f4be00d302 (archive-tar: use internal gzip by default), the 'git
archive' command switched to using an internal compression filter
implemented with zlib rather than invoking a 'gzip' binary, for the
'.tar.gz' / '.tgz' output formats.

This change brought to light a common misconception that the output of
'git archive' is intended to be byte-for-byte stable. While this is not
the case, stable archive output is desirable for many applications; we
discuss concerns related to output stability and suggest ways in which
the user can control the compression used with the
"tar.<format>.command" configuration option.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
I think that something along these lines should be included in the
docs, but that the behavior should be kept the same. If it is decided
later to stabilize output, e.g. by vendoring a blessed zlib version
forever, the current state as of 2.38 is the best starting point;
and reverting a useful change because of external breakage which
already has a solution, while also promising instability, seems like
a poor choice.

 Documentation/git-archive.txt | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 60c040988b..77acdacdf8 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -178,6 +178,41 @@ appropriate export-ignore in its `.gitattributes`), adjust the checked out
 option.  Alternatively you can keep necessary attributes that should apply
 while archiving any tree in your `$GIT_DIR/info/attributes` file.
 
+[[STABILITY]]
+STABILITY
+---------
+
+'git archive' does not guarantee that precisely identical archive files
+will be produced for invocations on the same commit or tree.
+
+'git archive' uses an internal implementation of `tar` archiving
+for the `tar` format, which includes the commit ID in an extended
+pax header.  For the `tgz` and `tar.gz` formats, it is augmented with
+a compression filter applied to the output, which is implemented by
+'git archive' by linking to the system zlib.
+
+If the commit ID of the "same" commit is different, for instance in the
+case of an object format migration from SHA-1 to SHA-256, the `tar`
+archive will necessarily differ due to including a different ID.
+
+The output of the compression filter is less deterministic than
+the output of the `tar` implementation, because the versions
+of zlib used may differ. The internal compression filter can be
+replaced with a particular command specified by the user using the
+`tar.<format>.command` configuration option; for instance, a particular
+gzip binary provided by the user could be specified here for consistent
+output.
+
+The `tar` format used by 'git archive' is unlikely to change
+frequently, but is not guaranteed to be completely stable; its output
+will remain identical at least within the same Git version.
+
+The `zip` format has similar concerns to the `tar.gz` and `tgz`
+formats; ZIP archiving is implemented internally, but the Deflate
+compression used relies on the linked zlib. However, because archiving
+and compression are combined into a single operation, there is no
+user-specifiable filter command for the `zip` format.
+
 EXAMPLES
 --------
 `git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)`::
-- 
2.39.1.561.g98d13ac3e7

