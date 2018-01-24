Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771561F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933233AbeAXLO0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:14:26 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49012 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933170AbeAXLOY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 06:14:24 -0500
X-AuditID: 1207440f-ab7ff70000000ab0-13-5a686a8df52e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.D9.02736.E8A686A5; Wed, 24 Jan 2018 06:14:22 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAE3E5.dip0.t-ipconnect.de [84.170.227.229])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0OBEIi4004669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jan 2018 06:14:20 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/6] Yet another approach to handling empty snapshots
Date:   Wed, 24 Jan 2018 12:14:10 +0100
Message-Id: <cover.1516791909.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
References: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsUixO6iqNuflRFlsLad16LrSjeTRUPvFWaL
        /uVdbBYHO2eyWtxeMZ/Z4kdLD7MDm8ff9x+YPD58jPPoO7KG0eNZ7x5Gj4uXlD0+b5ILYIvi
        sklJzcksSy3St0vgyrixZDZrwUHOiu1T3jI1ML5k72Lk5JAQMJHYPe0VcxcjF4eQwA4miYcv
        G6CcS0wSO2euZAGpYhPQlVjU08wEYosIqElMbDvEAlLELHCaUWLX/mVADgeHsICrRNdvU5Aa
        FgFViTv/fzOC2LwC5hIXDs1nhtgmL/F+wX2wOKeAg0T3jktsILaQgL1E97VDzBMYeRYwMqxi
        lEvMKc3VzU3MzClOTdYtTk7My0st0jXRy80s0UtNKd3ECAkm/h2MXetlDjEKcDAq8fDesEiP
        EmJNLCuuzD3EKMnBpCTKmx+UESXEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDePFaicNyWxsiq1
        KB8mJc3BoiTOq75E3U9IID2xJDU7NbUgtQgmK8PBoSTBezYTaKhgUWp6akVaZk4JQpqJgxNk
        OA/Q8DsgNbzFBYm5xZnpEPlTjLocN168bmMWYsnLz0uVEuetACkSACnKKM2DmwNLAq8YxYHe
        EuYNBaniASYQuEmvgJYwAS25UZMKsqQkESEl1cBYpcx8WfR43GGbbxu4jGc7/DFWZl/3cNPR
        h99ZZQ6U8rG4cKyXX1yeLnV0y6xZJ/OWNXJIzVpvz9EwddVdoaDmxXUF9RHcQec6sw/WLmyI
        /OKo7nTb/u4hGUWp5Cq5v35itufvW5nuuet5m+3lYaHbm1a8DH+1tSCTZcX0H22Vvo++3Vym
        F+OuxFKckWioxVxUnAgAsd5pxt0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes the handling of empty packed-refs snapshots
(i.e., those with `snapshot->buf` and friends equal to `NULL`), partly
by changing `snapshot` to store a pointer to the start of the
post-header `packed-refs` content instead of `header_len`. It makes a
couple of other improvements as well.

I'm not sure whether I like this approach better than the alternative
of always setting `snapshot->buf` to a non-NULL value, by allocating a
length-1 bit of RAM if necessary. The latter is less intrusive, though
even if that approach is taken, I think patches 01, 02, and 04 from
this patch series would be worthwhile improvements.

Michael

Kim Gybels (1):
  packed_ref_cache: don't use mmap() for small files

Michael Haggerty (5):
  struct snapshot: store `start` rather than `header_len`
  create_snapshot(): use `xmemdupz()` rather than a strbuf
  find_reference_location(): make function safe for empty snapshots
  packed_ref_iterator_begin(): make optimization more general
  load_contents(): don't try to mmap an empty file

 refs/packed-backend.c | 106 ++++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 51 deletions(-)

-- 
2.14.2

