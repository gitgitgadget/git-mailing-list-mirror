Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87D4C432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 06:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE25610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 06:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbhHMGY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 02:24:26 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:21956 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbhHMGYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 02:24:25 -0400
Date:   Fri, 13 Aug 2021 06:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628835838;
        bh=Nsu3izmg99SKHvUSrFBKjS5ekw8Y9ZcJBioU5NSiRKE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=X4y0xY41AG0XjJ3LXYh85gruDr12i2d3GOMfKW84yv+Qy2CnP48FhJhaQCWCuHhzX
         1GahIBuzetPzVLoBaly9uqlAfA7UVc7blvr36rUhQCGbQly077XSSnQ9bYvQD/A1pe
         1YHMt/r3bHV8zV4sYFUovs2dZ4qhfzaf7CnihWDhUt1dZb2zh9ARTLphPdN3jHvEyW
         uZzrPlj2naTJ2gCUVG2O8tIUtpf4zH5dyM0QBDTF+ikIsMD1BgzMdHyYvaQ3CrXaJL
         mpyhzwh+aFcZuQw7skQ95fNA8hCf5ZfWFQVacK6w4J/idorvnCM4d73v2hJkU047Ta
         inVPa9GFTAWMA==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     kim@eagain.st, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, sunshine@sunshineco.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: [PATCH v6 3/3] docs: clarify the interaction of transfer.hideRefs and namespaces
Message-ID: <20210813062237.10403-4-kim@eagain.st>
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

ffcfb68176 (upload-pack.c: treat want-ref relative to namespace,
2021-07-30) taught `upload-pack` to reject `want-ref`s for hidden refs,
which is now mentioned. It is clarified that at no point the name of a
hidden ref is revealed, but the object id it points to may.

Signed-off-by: Kim Altintop <kim@eagain.st>
---
 Documentation/config/transfer.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/trans=
fer.txt
index 505126a780..b49429eb4d 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -52,13 +52,17 @@ If you have multiple hideRefs values, later entries ove=
rride earlier ones
 (and entries in more-specific config files override less-specific ones).
 +
 If a namespace is in use, the namespace prefix is stripped from each
-reference before it is matched against `transfer.hiderefs` patterns.
+reference before it is matched against `transfer.hiderefs` patterns. In
+order to match refs before stripping, add a `^` in front of the ref name. =
If
+you combine `!` and `^`, `!` must be specified first.
++
 For example, if `refs/heads/master` is specified in `transfer.hideRefs` an=
d
 the current namespace is `foo`, then `refs/namespaces/foo/refs/heads/maste=
r`
-is omitted from the advertisements but `refs/heads/master` and
-`refs/namespaces/bar/refs/heads/master` are still advertised as so-called
-"have" lines. In order to match refs before stripping, add a `^` in front =
of
-the ref name. If you combine `!` and `^`, `!` must be specified first.
+is omitted from the advertisements. If `uploadpack.allowRefInWant` is set,
+`upload-pack` will treat `want-ref refs/heads/master` in a protocol v2
+`fetch` command as if `refs/namespaces/foo/refs/heads/master` did not exis=
t.
+`receive-pack`, on the other hand, will still advertise the object id the
+ref is pointing to without mentioning its name (a so-called ".have" line).
 +
 Even if you hide refs, a client may still be able to steal the target
 objects via the techniques described in the "SECURITY" section of the
--
2.32.0


