Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EBF820D0C
	for <e@80x24.org>; Thu, 22 Jun 2017 19:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbdFVTmT (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:42:19 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34393 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbdFVTmS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:42:18 -0400
Received: by mail-wr0-f194.google.com with SMTP id k67so7073249wrc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TEz8e3ObxCNBXOAjeshRqgYZLT0ehKnfCh79gxA9Co4=;
        b=UdYnTaVW3slby4ivv2Efee1WlSwIulgvjpYZiKIeKiZt8dMgT8epwa9AF5g1YNhAoB
         5WCy/wGZV3T1xEbn0RyGEYFp78H4/1et+hnAa7yWdz2kx9K40sDjjwht4tr4aXyG0fcP
         kucvPZ+TiyelJrKyWHOd2ndZFEFZdImMfng2+aiIgfdRy4H0OWk2XWZeJHMS14+O3tmp
         513RYJ+Qri7mvrC9aFfovmRoRrPlfwF7XqI7ey3mK5v/BWm3X1d2QoQXyy95aBTqRkZl
         nfhHZV/aqRIQnkzUGCYFCwx+5F6Ud7EtS1vjcSttZ4IhX3YTz8WbvZsaCRjwec/CBvvA
         gQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TEz8e3ObxCNBXOAjeshRqgYZLT0ehKnfCh79gxA9Co4=;
        b=KjLHpJY7qDgEJa5oH3ZLh0EAkrX2XQPIb9YsuZM/fWMx6SgmZernd7M6l8g+s2nrZd
         vrpE6rBiWH9juQ/dWz3oSyVFKi63/JlF97YCcSk+wP6haE1Jvqo3A7TaAn8/VJlMpdf0
         d0wqRglwS1z3z45KDoOYHkXfQD9SlGuehwm1tuvO6m9r/4rfi/gAKYmq6c9qK2r5nTya
         Um7sB2sYrJ14BEV3O1BU13DILw1qfsgRnMmYm5HyBlqYNylNIgzzr5MCWOfkP9GbQLV+
         KdChw0L6ypXbRO/WhAB2jeWQdzovkvev8uJ79dx5ANxUfXs1mXi55AzRS+kdOcG8l4qY
         KYiA==
X-Gm-Message-State: AKS2vOxX/StxtqzvOKJ60EIYyUNqicMPBWekzkcZJzWSCrlzmk51+wYP
        DgGZsrLzrqB9Xp5umHgW50HgBJEOzTQ9PQg=
X-Received: by 10.80.164.185 with SMTP id w54mr3793654edb.76.1498160537040;
 Thu, 22 Jun 2017 12:42:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.137.173 with HTTP; Thu, 22 Jun 2017 12:42:16 -0700 (PDT)
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Thu, 22 Jun 2017 22:42:16 +0300
Message-ID: <CAGHpTBLXrrt0DykbCQHqp2up_BqOVftc8_8Towi3sDbh3M12LQ@mail.gmail.com>
Subject: [PATCH] name-rev: Fix tag lookup on repository with mixed types of tags
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 7550424804 (name-rev: include taggerdate in considering the best
name) introduced a bug in name-rev.

If a repository has both annotated and non-annotated tags, annotated
tag will always win, even if it was created decades after the commit.

Consider a repository that always used non-annotated tags, and at some
point started using annotated tags - name-rev --tags will return the
first annotated tags for all the old commits (in our repository it is
followed by ~5067 for one commit, or by ~120^2~21^2~88^2~87 for
another...). This is obviously not what the user expects.

The taggerdate should only be matched if *both tags* have it.
---
 builtin/name-rev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 92a5d8a5d2..8f77023482 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -46,11 +46,13 @@ static void name_rev(struct commit *commit,
  commit->util = name;
  goto copy_data;
  } else if (name->taggerdate > taggerdate ||
- (name->taggerdate == taggerdate &&
+ ((taggerdate == ULONG_MAX || name->taggerdate == taggerdate) &&
  name->distance > distance)) {
 copy_data:
  name->tip_name = tip_name;
- name->taggerdate = taggerdate;
+ if (taggerdate != ULONG_MAX) {
+ name->taggerdate = taggerdate;
+ }
  name->generation = generation;
  name->distance = distance;
  } else
-- 
2.13.1.windows.1.1.ga36e14b3aa
