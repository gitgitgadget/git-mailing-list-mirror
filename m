Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAC00201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdBXXGI (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:06:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:33700 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbdBXXGH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:06:07 -0500
Received: (qmail 20144 invoked by uid 109); 24 Feb 2017 23:06:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 23:06:07 +0000
Received: (qmail 15870 invoked by uid 111); 24 Feb 2017 23:06:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 18:06:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 18:06:05 -0500
Date:   Fri, 24 Feb 2017 18:06:05 -0500
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 11:47:46PM +0100, Jakub Narębski wrote:

> I have just read on ArsTechnica[1] that while Git repository could be
> corrupted (though this would require attackers to spend great amount
> of resources creating their own collision, while as said elsewhere
> in this thread allegedly easy to detect), putting two proof-of-concept
> different PDFs with same size and SHA-1 actually *breaks* Subversion.
> Repository can become corrupt, and stop accepting new commits.  
> 
> From what I understand people tried this, and Git doesn't exhibit
> such problem.  I wonder what assumptions SVN made that were broken...

To be clear, nobody has generated a sha1 collision in Git yet, and you
cannot blindly use the shattered PDFs to do so. Git's notion of the
SHA-1 of an object include the header, so somebody would have to do a
shattered-level collision search for something that starts with the
correct "blob 1234\0" header.

So we don't actually know how Git would behave in the face of a SHA-1
collision. It would be pretty easy to simulate it with something like:

---
diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 22b125cf8..1be5b5ba3 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -231,6 +231,16 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 		memcpy(ctx->W, data, len);
 }
 
+/* sha1 of blobs containing "foo\n" and "bar\n" */
+static const unsigned char foo_sha1[] = {
+	0x25, 0x7c, 0xc5, 0x64, 0x2c, 0xb1, 0xa0, 0x54, 0xf0, 0x8c,
+	0xc8, 0x3f, 0x2d, 0x94, 0x3e, 0x56, 0xfd, 0x3e, 0xbe, 0x99
+};
+static const unsigned char bar_sha1[] = {
+	0x57, 0x16, 0xca, 0x59, 0x87, 0xcb, 0xf9, 0x7d, 0x6b, 0xb5,
+	0x49, 0x20, 0xbe, 0xa6, 0xad, 0xde, 0x24, 0x2d, 0x87, 0xe6
+};
+
 void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 {
 	static const unsigned char pad[64] = { 0x80 };
@@ -248,4 +258,8 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 	/* Output hash */
 	for (i = 0; i < 5; i++)
 		put_be32(hashout + i * 4, ctx->H[i]);
+
+	/* pretend "foo" and "bar" collide */
+	if (!memcmp(hashout, bar_sha1, 20))
+		memcpy(hashout, foo_sha1, 20);
 }
