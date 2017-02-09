Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6316C1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 13:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdBIN2S (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 08:28:18 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63284 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751040AbdBIN2P (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 08:28:15 -0500
X-AuditID: 1207440c-095ff70000000a44-51-589c6e32e4b4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.14.02628.23E6C985; Thu,  9 Feb 2017 08:27:15 -0500 (EST)
Received: from bagpipes.fritz.box (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19DRB5C023019
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 08:27:12 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/5] Store submodules in a hash, not a linked list
Date:   Thu,  9 Feb 2017 14:26:57 +0100
Message-Id: <cover.1486629195.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsUixO6iqGucNyfCoPe1mkXXlW4mi4beK8wW
        /cu72Cxur5jPbLHk4Wtmi+4pbxktNm9uZ3Fg9/j7/gOTx85Zd9k9PnyM81iwqdSjq/0Im8fF
        S8oenzfJBbBHcdmkpOZklqUW6dslcGWsfVJYsEKgYuWaCywNjOd4uxg5OSQETCQONa1i6WLk
        4hASuMwocWjDWRaQhJDASSaJD9OMQWw2AV2JRT3NTCC2iICaxMS2Q2ANzALrmSROz/vACpIQ
        FnCSOHjrN1CCg4NFQFVi7TVZkDCvgLlEz6rZjBDL5CQubfvCPIGRawEjwypGucSc0lzd3MTM
        nOLUZN3i5MS8vNQiXUO93MwSvdSU0k2MkFDh2cH4bZ3MIUYBDkYlHt4Ky9kRQqyJZcWVuYcY
        JTmYlER5I/4DhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwpuTMiRDiTUmsrEotyodJSXOwKInz
        qi5R9xMSSE8sSc1OTS1ILYLJynBwKEnw/gVpFCxKTU+tSMvMKUFIM3FwggznARp+BWx4cUFi
        bnFmOkT+FKOilDhvNkhCACSRUZoH1wuL5VeM4kCvCPN+B6niAaYBuO5XQIOZgAZfPz0LZHBJ
        IkJKqoFxvq08a0DAcy+dx3PU07ochPbIfdv+TXDRo/VyBxpiv2hI2+/0/DBlf/7rrup6hqaD
        yS/akxafKvkvway0VnLF58Sd1pY/qzjmrF7+Pqxnk0LK050F81LvbdgsvfN66trLyw+F955c
        /9o/tmuXl7afFqPeg+0fJx36Nycl/8znR7f1Ag2CNHdkKLEUZyQaajEXFScCABj6f1DAAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have mentioned this patch series on the mailing list a couple of
time [1,2] but haven't submitted it before. I just rebased it to
current master. It is available from my Git fork [3] as branch
"submodule-hash".

The first point of this patch series is to optimize submodule
`ref_store` lookup by storing the `ref_store`s in a hashmap rather
than a linked list. But a more interesting second point is to weaken
the 1:1 relationship between submodules and `ref_stores` a little bit
more.

A `files_ref_store` would be perfectly happy to represent, say, the
references *physically* stored in a linked worktree (e.g., `HEAD`,
`refs/bisect/*`, etc) even though that is not the complete collection
of refs that are *logically* visible from that worktree (which
includes references from the main repository, too). But the old code
was confusing the two things by storing "submodule" in every
`ref_store` instance.

So push the submodule attribute down to the `files_ref_store` class
(but continue to let the `ref_store`s be looked up by submodule).

The last commit is relatively orthogonal to the others; it simplifies
read_loose_refs() by calling resolve_ref_recursively() directly using
the `ref_store` instance that it already has in hand, rather than
indirectly via the public wrappers.

Michael

[1] http://public-inbox.org/git/341999fc-4496-b974-c117-c18a2fca1358@alum.mit.edu/
[2] http://public-inbox.org/git/37fe2024-0378-a974-a28d-18a89d3e2312@alum.mit.edu/
[3] https://github.com/mhagger/git

Michael Haggerty (5):
  refs: store submodule ref stores in a hashmap
  refs: push the submodule attribute down
  register_ref_store(): new function
  files_ref_store::submodule: use NULL for the main repository
  read_loose_refs(): read refs using resolve_ref_recursively()

 refs.c               | 93 ++++++++++++++++++++++++++++++++++------------------
 refs/files-backend.c | 77 +++++++++++++++++++++++++------------------
 refs/refs-internal.h | 37 ++++++++-------------
 3 files changed, 122 insertions(+), 85 deletions(-)

-- 
2.9.3

