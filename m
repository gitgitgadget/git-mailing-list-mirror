From: Jeff King <peff@peff.net>
Subject: Re: [BUG] resolved deltas
Date: Sat, 23 Aug 2014 07:18:04 -0400
Message-ID: <20140823111804.GA17335@peff.net>
References: <53F5D98F.4040700@redhat.com>
 <53F79CE3.60803@gmx.net>
 <53F868F8.9080000@web.de>
 <20140823105640.GA6881@peff.net>
 <20140823110459.GA13087@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 23 13:18:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL9Km-0000Ma-Q9
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 13:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbaHWLSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 07:18:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:57414 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752398AbaHWLSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 07:18:07 -0400
Received: (qmail 31841 invoked by uid 102); 23 Aug 2014 11:18:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 06:18:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 07:18:04 -0400
Content-Disposition: inline
In-Reply-To: <20140823110459.GA13087@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255747>

On Sat, Aug 23, 2014 at 07:04:59AM -0400, Jeff King wrote:

> On Sat, Aug 23, 2014 at 06:56:40AM -0400, Jeff King wrote:
> 
> > So I think your patch is doing the right thing.
> 
> By the way, if you want to add a test to your patch, there is
> infrastructure in t5308 to create packs with duplicate objects. If I
> understand the problem correctly, you could trigger this by having a
> delta object whose base is duplicated, even without the missing object.

This actually turned out to be really easy. The test below fails without
your patch and passes with it. Please feel free to squash it in.

diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 9c5a876..50f7a69 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -77,4 +77,19 @@ test_expect_success 'index-pack can reject packs with duplicates' '
 	test_expect_code 1 git cat-file -e $LO_SHA1
 '
 
+test_expect_success 'duplicated delta base does not trigger assert' '
+	clear_packs &&
+	{
+		A=01d7713666f4de822776c7622c10f1b07de280dc &&
+		B=e68fe8129b546b101aee9510c5328e7f21ca1d18 &&
+		pack_header 3 &&
+		pack_obj $A $B &&
+		pack_obj $B &&
+		pack_obj $B
+	} >dups.pack &&
+	pack_trailer dups.pack &&
+	git index-pack --stdin <dups.pack &&
+	test_must_fail git index-pack --stdin --strict <dups.pack
+'
+
 test_done
