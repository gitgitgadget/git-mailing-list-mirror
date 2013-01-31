From: Greg KH <gregkh@linuxfoundation.org>
Subject: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Thu, 31 Jan 2013 18:28:05 +0100
Message-ID: <20130131172805.GC16593@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Konstantin Ryabitsev <mricon@kernel.org>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 18:27:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0xuj-0000yL-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 18:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980Ab3AaR0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 12:26:11 -0500
Received: from mail.kernel.org ([198.145.19.201]:40906 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755978Ab3AaR0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 12:26:09 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2402E20318;
	Thu, 31 Jan 2013 17:26:08 +0000 (UTC)
Received: from localhost (ip-188-118-20-209.reverse.destiny.be [188.118.20.209])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C17D720317;
	Thu, 31 Jan 2013 17:26:05 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215130>

Hi,

The way we upload the Linux kernel to kernel.org involves creating a tar
archive, signing the archive, and then just uploading the signature.
The server then checks out the repo based on the tag, generates the tar
archive and checks the signature to make sure they match.

A few days ago I released the 3.0.61 kernel, and it turned out that I
couldn't upload the kernel release because 'git archive' now creates a
binary file that differs from an older version of git.

I tracked this down to commit 22f0dcd9634a818a0c83f23ea1a48f2d620c0546
(archive-tar: split long paths more carefully).  The diff of a hex dump
of the tar archives shows the following difference:

--- old_git_archive	2013-01-31 17:31:24.466343388 +0100
+++ new_git_archive	2013-01-31 17:32:21.509674417 +0100
@@ -19239998,8 +19239998,8 @@
 125943d0:0000 0000 0000 0000 0000 0000 0000 0000  ................
 125943e0:0000 0000 0000 0000 0000 0000 0000 0000  ................
 125943f0:0000 0000 0000 0000 0000 0000 0000 0000  ................
-12594400:0000 0000 0000 0000 0000 0000 0000 0000  ................
-12594410:0000 0000 0000 0000 0000 0000 0000 0000  ................
+12594400:7765 7374 6272 6964 6765 2d6f 6d61 7033  westbridge-omap3
+12594410:2d70 6e61 6e64 2d68 616c 2f00 0000 0000  -pnand-hal/.....
 12594420:0000 0000 0000 0000 0000 0000 0000 0000  ................
 12594430:0000 0000 0000 0000 0000 0000 0000 0000  ................
 12594440:0000 0000 0000 0000 0000 0000 0000 0000  ................
@@ -19240025,8 +19240025,8 @@
 12594580:2f61 7374 6f72 6961 2f61 7263 682f 6172  /astoria/arch/ar
 12594590:6d2f 706c 6174 2d6f 6d61 702f 696e 636c  m/plat-omap/incl
 125945a0:7564 652f 6d61 6368 2f77 6573 7462 7269  ude/mach/westbri
-125945b0:6467 652f 7765 7374 6272 6964 6765 2d6f  dge/westbridge-o
-125945c0:6d61 7033 2d70 6e61 6e64 2d68 616c 0000  map3-pnand-hal..
+125945b0:6467 6500 0000 0000 0000 0000 0000 0000  dge.............
+125945c0:0000 0000 0000 0000 0000 0000 0000 0000  ................
 125945d0:0000 0000 0000 0000 0000 0000 0000 0000  ................
 125945e0:0000 0000 0000 0000 0000 0000 0000 0000  ................
 125945f0:0000 0000 0000 0000 0000 0000 0000 0000  ................

Interestingly, the output of uncompressing the tar archives is
identical, so the data is correct, but the binary isn't.

Now keeping binary compatibility of tar archive files isn't really a big
deal, but, the commit to git that causes this seems a bit odd, is it
really needed?  Or can we just fix the version of tar with NetBSD
instead?  :)

Any ideas?

thanks,

greg k-h
