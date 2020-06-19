Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0769C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF79920776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g4NgoqiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbgFSR5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39508 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404163AbgFSR42 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AF5ED60A6F;
        Fri, 19 Jun 2020 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589383;
        bh=C0FilukGeoJOoC7fEq9AzoHQHWIHaLoxTcro18B7DmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=g4NgoqiPijwSVRSK7ou1FLZ+qGtn+lXfyN/7abSM2OiIXZUpEQ0TWMWmn1SIlhDb7
         qvHbJMdHrNdB2lg7CjinCX6+TZ8WCMxxlQvg4JfETrYvpbNmGfL5OspDYfhYptDg5T
         ITallqmExo+ZFAgOjbTrGvvGutvss5osiLSAgUO9Km/0XgzqtyfeHHbcB3TN70UT2R
         +Q7kbrhlGcD9av0dkpqbMtr6lgAbRxdCzuH44eV97roTRWg8NL5R7V/abJQI7QHIbQ
         qdNFXFbVEzOp1ybWRJYPN8aK6EKzJh4g3mCT94D+GMtvWJ1DE7DtiWkwmT35oUQKG3
         9+BCPkVDG6GeA657kie4cA+tqItfevU2/NyBanH5sq45u7amCiWIz/ELbeJ2jNmx4o
         S50dY9NRRdZ+vKpymAtyi8bY7xXpn4E9Ttkh3dzFgyOWqBhZCClyvpMykTuOxPQNKD
         A2zrfErf4bfX5icy/sHxwhS7uX8L67pxNa4Xir0Muc5IPoiEMWC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 19/44] builtin/clone: initialize hash algorithm properly
Date:   Fri, 19 Jun 2020 17:55:36 +0000
Message-Id: <20200619175601.569856-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing a clone, we don't know what hash algorithm the other end
will support.  Currently, we don't support fetching data belonging to a
different algorithm, so we must know what algorithm the remote side is
using in order to properly initialize the repository.  We can know that
only after fetching the refs, so if the remote side has any references,
use that information to reinitialize the repository with the correct
hash algorithm information.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/clone.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 2a8e3aaaed..e3519a8355 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1220,6 +1220,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport, &ref_prefixes);
 
 	if (refs) {
+		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
+
+		/*
+		 * Now that we know what algorithm the remote side is using,
+		 * let's set ours to the same thing.
+		 */
+		initialize_repository_version(hash_algo);
+		repo_set_hash_algo(the_repository, hash_algo);
+
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
