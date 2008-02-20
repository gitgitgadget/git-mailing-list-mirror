From: Jeff King <peff@peff.net>
Subject: Re: Solaris test failure -- FAIL 61: invalid bool (set)
Date: Wed, 20 Feb 2008 00:04:20 -0500
Message-ID: <20080220050420.GA16745@coredump.intra.peff.net>
References: <8ec76080802191322t2417ea48y1537011f1031dff8@mail.gmail.com> <alpine.LSU.1.00.0802192220440.7826@racer.site> <8ec76080802191517k5f070d45l497063d93e080272@mail.gmail.com> <20080219234422.GA9987@coredump.intra.peff.net> <20080219234945.GB9987@coredump.intra.peff.net> <20080219235250.GA12979@coredump.intra.peff.net> <8ec76080802191611s3348beb1icd0b24db8b0a9556@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 06:04:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRh8c-0001r9-Px
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 06:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbYBTFEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 00:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbYBTFEX
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 00:04:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4074 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbYBTFEX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 00:04:23 -0500
Received: (qmail 27910 invoked by uid 111); 20 Feb 2008 05:04:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Feb 2008 00:04:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2008 00:04:20 -0500
Content-Disposition: inline
In-Reply-To: <8ec76080802191611s3348beb1icd0b24db8b0a9556@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74502>

On Tue, Feb 19, 2008 at 07:11:01PM -0500, Whit Armstrong wrote:

> That certainly fixes t1300-repo-config.sh.
> 
> I must be seeing the same failures as you ( in t3404-rebase-interactive.sh ).

I actually was seeing errors later in t1300, but they were fixed by
putting GNU coreutils at the front of my path (btw, we had discussed
previously using "diff -u" to compare actual and expected output in many
tests -- Solaris diff doesn't understand "-u").

I see the errors in t3404. They are caused by the Solaris /bin/sh not
understanding $() syntax. We create a "fake-editor" script to simulate
the editor during interactive rebase, and it is hard-coded to /bin/sh.

So we should probably do something like:

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e5ed745..62e65d7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -61,8 +61,8 @@ test_expect_success 'setup' '
 	git tag I
 '
 
-cat > fake-editor.sh <<\EOF
-#!/bin/sh
+echo "#!$SHELL" >fake-editor
+cat >> fake-editor.sh <<\EOF
 case "$1" in
 */COMMIT_EDITMSG)
 	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"

There are probably more instances of this problem, but I haven't
checked. I had high hopes of running the testsuite to completion
tonight, but I am getting stuck now in t3900.

-Peff
