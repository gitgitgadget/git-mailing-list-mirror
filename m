Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192261F404
	for <e@80x24.org>; Sat,  3 Mar 2018 05:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeCCF1L (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 00:27:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:45314 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751733AbeCCF1K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 00:27:10 -0500
Received: (qmail 6042 invoked by uid 109); 3 Mar 2018 05:27:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 05:27:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3324 invoked by uid 111); 3 Mar 2018 05:28:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 00:28:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 00:27:08 -0500
Date:   Sat, 3 Mar 2018 00:27:08 -0500
From:   Jeff King <peff@peff.net>
To:     Dorian Taylor <dorian.taylor.lists@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH] smart-http: document flush after "# service" line
Message-ID: <20180303052708.GF27689@sigill.intra.peff.net>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com>
 <20180221221516.GA7944@sigill.intra.peff.net>
 <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com>
 <20180222053722.GB133592@aiede.svl.corp.google.com>
 <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com>
 <20180222100840.GD12442@sigill.intra.peff.net>
 <xmqqbmggx063.fsf@gitster-ct.c.googlers.com>
 <01B07AA7-B2A4-4A81-B1F0-E2EC3D6BFBF9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01B07AA7-B2A4-4A81-B1F0-E2EC3D6BFBF9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 12:12:54PM -0800, Dorian Taylor wrote:

> This patch exists because I was asked to write it. I don’t know squat
> about this protocol other than the fact that I followed the spec and
> it didn’t work. I traced a known-good protocol endpoint and found it
> contained content that didn’t agree with the spec. I then obliged the
> request to submit a patch with *what I knew to be true* about the
> sample that actually worked. I then followed the recommendations
> *advertised on GitHub* for submitting the patch.

I take it that a revised patch is not forthcoming, then. :-/

Let's wrap up this topic with this, then, which adds a commit message
and fixes the flush/version-1 ordering issue.

-- >8 --
Subject: smart-http: document flush after "# service" line

The http-protocol.txt spec fails to mention that a flush
packet comes in the smart server response after sending any
the "service" header.

Technically the client code is actually ready to receive an
arbitrary number of headers here, but since we haven't
introduced any other headers in the past decade (and the
client would just throw them away), let's not mention it in
the spec.

This fixes both BNF and the example. While we're fixing the
latter, let's also add the missing flush after the ref list.

Reported-by: Dorian Taylor <dorian.taylor.lists@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/http-protocol.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index a0e45f2889..64f49d0bbb 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -214,10 +214,12 @@ smart server reply:
    S: Cache-Control: no-cache
    S:
    S: 001e# service=git-upload-pack\n
+   S: 0000
    S: 004895dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint\0multi_ack\n
    S: 0042d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master\n
    S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
    S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
+   S: 0000
 
 The client may send Extra Parameters (see
 Documentation/technical/pack-protocol.txt) as a colon-separated string
@@ -277,6 +279,7 @@ The returned response contains "version 1" if "version=1" was sent as an
 Extra Parameter.
 
   smart_reply     =  PKT-LINE("# service=$servicename" LF)
+		     "0000"
 		     *1("version 1")
 		     ref_list
 		     "0000"
-- 
2.16.2.708.g0b2ed7f536

