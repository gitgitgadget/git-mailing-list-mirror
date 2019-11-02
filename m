Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96FCE1F4C0
	for <e@80x24.org>; Sat,  2 Nov 2019 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKBT0t (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 15:26:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59072 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727102AbfKBT0s (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Nov 2019 15:26:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 22EF661CB5;
        Sat,  2 Nov 2019 19:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572722807;
        bh=Qf5NsUjDZrZDrLSCefxAUKdg0PmgaxWPN4plBbcqfjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kQbNg96XqqnBJC73Qw/gPEsKVsypY/2FD1N+I7UlMDYGli19ADMzjgr0s38rsBkeQ
         5a//MCiHFtvyewuauLNAkfTeYgFe0BTUDanfI+5rvaQ87hXPUUJpv7kApCjsLxWYTL
         +jOHChWiQ7yTZNjaO549jkF5JQ1E4Qv7e1X10XokFx2bdV5sKpVzwunJ2kcf0Vtlxh
         HUjESpfHav4uCmEwQSupVREEJsjRFDP5If7FOiIllI/1vq9kFXCd3bXrCsO6CSKWk/
         z4etDXTmCLup5niMhtgsfjgf4IDnXtWcS99V3m6bD3ZQIC3npCfju4o3rCwiJHk0w1
         14dLasLGjsIQPp1Tndt6STRS9LmdDMLJsajbEKmFu5KpAk+VI665GBfKuusS2ukJxe
         aVCGJe7+E1994cSaCr23HeDgtyctGQReA8eemg4EJQQvwyK5wsK7ExX7DlaNZYjeTb
         1c6RvMyMVSUdZHD+0koPU9Ay8GVRL2RIi6nXbIsWAyZZMbiPyKE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 3/4] doc: dissuade users from trying to ignore tracked files
Date:   Sat,  2 Nov 2019 19:26:14 +0000
Message-Id: <20191102192615.10013-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc2.428.g50e10028f1
In-Reply-To: <20191102192615.10013-1-sandals@crustytoothpaste.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is quite common for users to want to ignore the changes to a file
that Git tracks.  Common scenarios for this case are IDE settings and
configuration files, which should generally not be tracked and possibly
generated from tracked files using a templating mechanism.

However, users learn about the assume-unchanged and skip-worktree bits
and try to use them to do this anyway.  This is problematic, because
when these bits are set, many operations behave as the user expects, but
they usually do not help when git checkout needs to replace a file.

There is no sensible behavior in this case, because sometimes the data
is precious, such as certain configuration files, and sometimes it is
irrelevant data that the user would be happy to discard.

Since this is not a supported configuration and users are prone to
misuse the existing features for unintended purposes, causing general
sadness and confusion, let's document the existing behavior and the
pitfalls in the documentation for git update-index so that users know
they should explore alternate solutions.

In additon, let's provide a recommended solution to dealing with the
common case of configuration files, since there are well-known
approaches used successfully in many environments.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-update-index.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1c4d146a41..11230376c8 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -543,6 +543,22 @@ The untracked cache extension can be enabled by the
 `core.untrackedCache` configuration variable (see
 linkgit:git-config[1]).
 
+NOTES
+-----
+
+Users often try to use the ``assume unchanged'' and skip-worktree bits
+to tell Git to ignore changes to files that are tracked.  This does not
+work as expected, since Git may still check working tree files against
+the index when performing certain operations.  In general, Git does not
+provide a way to ignore changes to tracked files, so alternate solutions
+are recommended.
+
+If the file you want to change is some sort of configuration file (say,
+for a build tool, IDE, or editor), a common solution is to use a
+templating mechanism, such as Ruby's ERB, to generate the ignored
+configuration file from a template stored in the repository and a source
+of data using a script or build step.
+
 SEE ALSO
 --------
 linkgit:git-config[1],
