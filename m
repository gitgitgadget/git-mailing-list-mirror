Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE7BC432BE
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510D661159
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhHISAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 14:00:14 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:55064 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhHIR61 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 13:58:27 -0400
Date:   Mon, 09 Aug 2021 17:57:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628531853;
        bh=PawN1DSchlwwynFD29hO5I1QaJ0beebmNePcuE23PCE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=oPoJSlHyuAbWNfwCJvZfGaKyU0V+n5aUNXS9dpCybqAETmk5NFhUOvAb+8PfjBmf8
         5w/kk8BzBoEpQn6kqbG7EHzLiGnE9boQ4/tG3k27yhHRsD/nrF4VXqLG8l0MSZXlQ2
         8WTG4oX3Xf3X5tmGG+STp8f0ntUsaVt9wkuGs8tE2z3LpS+1IJV3UwJ0sZMiNpfi8w
         cb+zAaSWiLQbafrU2TZuBPB180ickRs6dx1HVfzj1boO5OnFEPShjBvq8Q5Kv4ls9t
         JtDoGhcFyyDtbBmVMzDOg3yZ1MbEDX5adaodAGzZwUbHdvnQ+K3gglIMaEmdBluDIo
         rKHfCVNJhUuFg==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     kim@eagain.st, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: [PATCH 3/3] docs: clarify the interaction of transfer.hideRefs and namespaces
Message-ID: <20210809175530.75326-4-kim@eagain.st>
In-Reply-To: <20210809175530.75326-1-kim@eagain.st>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expand the section about namespaces in the documentation of
`transfer.hideRefs` to point out the subtle differences between
`upload-pack` and `receive-pack`.

9bedd82017 (upload-pack.c: treat want-ref relative to namespace,
2021-07-30) taught `upload-pack` to reject `want-ref`s for hidden refs,
which is now documented.

Signed-off-by: Kim Altintop <kim@eagain.st>
---
 Documentation/config/transfer.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/trans=
fer.txt
index 505126a780..09ebb399ce 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -52,13 +52,16 @@ If you have multiple hideRefs values, later entries ove=
rride earlier ones
 (and entries in more-specific config files override less-specific ones).
 +
 If a namespace is in use, the namespace prefix is stripped from each
-reference before it is matched against `transfer.hiderefs` patterns.
-For example, if `refs/heads/master` is specified in `transfer.hideRefs` an=
d
-the current namespace is `foo`, then `refs/namespaces/foo/refs/heads/maste=
r`
-is omitted from the advertisements but `refs/heads/master` and
-`refs/namespaces/bar/refs/heads/master` are still advertised as so-called
-"have" lines. In order to match refs before stripping, add a `^` in front =
of
-the ref name. If you combine `!` and `^`, `!` must be specified first.
+reference before it is matched against `transfer.hiderefs` patterns. For
+example, if `refs/heads/master` is specified in `transfer.hideRefs` and th=
e
+current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master` i=
s
+omitted from the advertisements. If `uploadpack.allowRefInWant` is set,
+`upload-pack` will treat `want-ref refs/heads/master` in a protocol v2
+`fetch` command as if `refs/heads/master` was unknown. Note, however, that
+`receive-pack` will still advertise the object id `refs/heads/master` is
+pointing to, but will conceil the name of the ref. In order to match refs
+before stripping, add a `^` in front of the ref name. If you combine `!` a=
nd
+`^`, `!` must be specified first.
 +
 Even if you hide refs, a client may still be able to steal the target
 objects via the techniques described in the "SECURITY" section of the
--
2.32.0


