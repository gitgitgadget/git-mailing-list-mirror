From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Wed, 8 Feb 2012 16:01:56 -0500
Message-ID: <20120208210156.GA9588@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <20120206081342.GB3966@sigill.intra.peff.net>
 <7vk4408ir6.fsf@alter.siamese.dyndns.org>
 <7vfweo8ikq.fsf@alter.siamese.dyndns.org>
 <20120206083832.GA9425@sigill.intra.peff.net>
 <7vty337rug.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 22:02:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvEeS-0005Lu-OV
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 22:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab2BHVB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 16:01:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59715
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab2BHVB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 16:01:58 -0500
Received: (qmail 19843 invoked by uid 107); 8 Feb 2012 21:09:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Feb 2012 16:09:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2012 16:01:56 -0500
Content-Disposition: inline
In-Reply-To: <7vty337rug.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190255>

On Mon, Feb 06, 2012 at 10:13:27AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > OK, that's easy enough to do. Should we show lightweight tags to commits
> > for backwards compatibility (and just drop the parse_signature junk in
> > that case)? The showing of blobs or trees is the really bad thing, I
> > think.
> 
> For now, dropping 3/3 and queuing this instead...
> 
> ---
> Subject: tag: do not show non-tag contents with "-n"

Since jk/maint-tag-show-fixes is still in pu, perhaps we can squash in
this test from my 3/3:

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e93ac73..0db0f6a 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -586,6 +586,19 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+test_expect_success 'annotations for blobs are empty' '
+	blob=$(git hash-object -w --stdin <<-\EOF
+	Blob paragraph 1.
+
+	Blob paragraph 2.
+	EOF
+	) &&
+	git tag tag-blob $blob &&
+	echo "tag-blob        " >expect &&
+	git tag -n1 -l tag-blob >actual &&
+	test_cmp expect actual
+'
+
 # trying to verify annotated non-signed tags:
 
 test_expect_success GPG \

If we want to be more thorough, I can write up a more complete test
battery making sure tags and commits are both shown, but blobs and trees
are not.

-Peff
