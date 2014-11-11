From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] replace: fix replacing object with itself
Date: Mon, 10 Nov 2014 22:03:41 -0500
Message-ID: <20141111030341.GC21328@peff.net>
References: <1415661656-3657-1-git-send-email-manzurmm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Manzur Mukhitdinov <manzurmm@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 04:03:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xo1kC-00029x-5K
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 04:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbaKKDDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 22:03:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:38963 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751316AbaKKDDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 22:03:43 -0500
Received: (qmail 7370 invoked by uid 102); 11 Nov 2014 03:03:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 21:03:43 -0600
Received: (qmail 14237 invoked by uid 107); 11 Nov 2014 03:03:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 22:03:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 22:03:41 -0500
Content-Disposition: inline
In-Reply-To: <1415661656-3657-1-git-send-email-manzurmm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 11, 2014 at 12:20:56AM +0100, Manzur Mukhitdinov wrote:

> When object is replaced with itself git shows unhelpful messages like(git log):
>     "fatal: replace depth too high for object <SHA1>"
> 
> Prevents user from replacing object with itself(with test for checking
> this case).

Thanks, this looks good to me.

> +test_expect_success 'replacing object with itself must fail' '
> +    test_must_fail git replace $HASH1 $HASH1 &&
> +    HASH8=$(git rev-parse --verify HEAD) &&
> +    test_must_fail git replace HEAD $HASH8 &&
> +    test_must_fail git replace --graft HEAD HEAD^ &&
> +    test_must_fail env GIT_EDITOR=true git replace --edit HEAD
> +'

I think some of these overlap with earlier tests (I know that the
"--edit" case is checked already), but I think it is nice to keep the
related checks together here.

Should we maybe squash this in to drop the now redundant test (AFAICT,
that is the only one that overlaps)?

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 98ac9dd..5f96374 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -369,9 +369,8 @@ test_expect_success '--edit with and without already replaced object' '
 	git cat-file commit "$PARA3" | grep "A fake Thor"
 '
 
-test_expect_success '--edit and change nothing or command failed' '
+test_expect_success '--edit with failed editor' '
 	git replace -d "$PARA3" &&
-	test_must_fail env GIT_EDITOR=true git replace --edit "$PARA3" &&
 	test_must_fail env GIT_EDITOR="./fakeeditor;false" git replace --edit "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
 	git replace -l | grep "$PARA3" &&
