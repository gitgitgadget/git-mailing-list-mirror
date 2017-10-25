Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19FF202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 09:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932401AbdJYJxa (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 05:53:30 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54234 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932315AbdJYJx3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2017 05:53:29 -0400
X-AuditID: 12074411-f7dff70000007f0a-f2-59f05f183236
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 55.B7.32522.81F50F95; Wed, 25 Oct 2017 05:53:28 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC93E.dip0.t-ipconnect.de [87.188.201.62])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9P9rPQY025997
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 25 Oct 2017 05:53:27 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Avoid rewriting "packed-refs" unnecessarily
Date:   Wed, 25 Oct 2017 11:53:19 +0200
Message-Id: <cover.1508924577.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsUixO6iqCsR/yHS4Os6ZYuuK91MFg29V5gt
        bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFJdNSmpOZllqkb5dAlfGvbv/WQu+
        clcs/byUqYHxHmcXIyeHhICJxLzpC1i6GLk4hAR2MEkc2XyKDcI5ySSxsPsnG0gVm4CuxKKe
        ZiYQW0RATWJi2yEWEJtZIEWi43k3I4gtLOAgceftHbAaFgFViesnFoLZvALmEg2Xp7NAbJOX
        OPfgNvMERq4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MUL8LriDccZJ
        uUOMAhyMSjy8AtPfRwqxJpYVV+YeYpTkYFIS5Q33+BApxJeUn1KZkVicEV9UmpNafIhRgoNZ
        SYS3PRYox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4DWJA2oULEpN
        T61Iy8wpQUgzcXCCDOcBGl4PUsNbXJCYW5yZDpE/xWjM0XHz7h8mjmczXzcwC7Hk5eelSonz
        fgW5QwCkNKM0D24aLHZfMYoDPScMsZQHGPdw814BrWICWtWkCraqJBEhJdXAaGW15r6Q49eJ
        vwLD3nx9Ma9irbv+owO9mqZz5ezXbhV3ufLratKrkKOzc64bTF6gr9r69uvXjl1X0t8HVMfJ
        S3D2ykW9OZT+eUPzm2+RS33cO7a+5J7/eIPglTtV6adLrI46qy47emf23muK+w6c3+R5KOfZ
        RoOYcrW1L+uX9E+TaW9lFJhbVqnEUpyRaKjFXFScCACp2h3QuAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit dc39e09942 (files_ref_store: use a transaction to update
packed refs, 2017-09-08), we've been rewriting the `packed-refs` file
unnecessarily when deleting a loose reference that has no packed
counterpart. Add some tests demonstrating this problem, then fix it by
teaching `files_backend` to see whether any references being deleted
have packed versions, and if not, skipping the packed_refs
transaction.

This is a mild regression since 2.14, which avoided rewriting the
`packed-refs` file in these cases (though it still had to *read* the
whole file to determine whether the rewrite could be skipped).
Therefore, it might be considered for 2.15. On the other hand, it is
late in the release cycle, so the risk of accepting this change might
be considered too risky.

These patches apply on top of master and commute with
mh/ref-locking-fix. They are also available from my GitHub fork [1] as
branch `avoid-rewriting-packed-refs`.

Michael

[1] https://github.com/mhagger/git

Michael Haggerty (2):
  t1409: check that `packed-refs` is not rewritten unnecessarily
  files-backend: don't rewrite the `packed-refs` file unnecessarily

 refs/files-backend.c          |  18 ++++++-
 refs/packed-backend.c         |  68 ++++++++++++++++++++++++
 refs/packed-backend.h         |   8 +++
 t/t1409-avoid-packing-refs.sh | 118 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100755 t/t1409-avoid-packing-refs.sh

-- 
2.14.1

