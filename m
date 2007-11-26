From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] "git-tag -s" should create a signed annotated tag
Date: Sun, 25 Nov 2007 23:50:58 -0500
Message-ID: <20071126045058.GB6471@sigill.intra.peff.net>
References: <7vprxxj4hl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Carlos Rica <jasampler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 05:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwVwI-0002Cf-O0
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 05:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399AbXKZEvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 23:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758369AbXKZEvD
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 23:51:03 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1489 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758155AbXKZEvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 23:51:01 -0500
Received: (qmail 17589 invoked by uid 111); 26 Nov 2007 04:51:00 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 25 Nov 2007 23:51:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Nov 2007 23:50:58 -0500
Content-Disposition: inline
In-Reply-To: <7vprxxj4hl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66044>

On Sun, Nov 25, 2007 at 03:21:42PM -0800, Junio C Hamano wrote:

>  * It's _very_ disturbing that the testsuite did not catch this
>    breakage, even though I though we had a very detailed coverage for
>    "git tag" when it was rewritten in C.

Then where is the new test to accompany your patch? :P

-- >8 --
git-tag: test that -s implies an annotated tag

This detects a regression introduced while moving git-tag to a C
builtin.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7004-tag.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 736f22e..c7130c4 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -667,6 +667,22 @@ test_expect_success 'creating a signed tag with -F - should succeed' '
 	git diff expect actual
 '
 
+cat >fakeeditor <<'EOF'
+#!/bin/sh
+test -n "$1" && exec >"$1"
+echo A signed tag message
+echo from a fake editor.
+EOF
+chmod +x fakeeditor
+get_tag_header implied-annotate $commit commit $time >expect
+./fakeeditor >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success '-s implies annotated tag' '
+	GIT_EDITOR=./fakeeditor git-tag -s implied-annotate &&
+	get_tag_msg implied-annotate >actual &&
+	git diff expect actual
+'
+
 test_expect_success \
 	'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
-- 
1.5.3.6.2022.gd7807a-dirty
