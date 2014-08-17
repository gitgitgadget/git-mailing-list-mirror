From: Jeff King <peff@peff.net>
Subject: [PATCH] subtree: make "all" default target of Makefile
Date: Sun, 17 Aug 2014 03:07:32 -0400
Message-ID: <20140817070732.GA23808@peff.net>
References: <CAMYxyaVrknapiF6L3Lnf5U59h7RCUY8qhYtipZp5P0k3Y1tCxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jack Nagel <jacknagel@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 09:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIuZ8-0006V9-Td
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 09:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbaHQHHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 03:07:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:53509 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750840AbaHQHHe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 03:07:34 -0400
Received: (qmail 4971 invoked by uid 102); 17 Aug 2014 07:07:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 02:07:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 03:07:32 -0400
Content-Disposition: inline
In-Reply-To: <CAMYxyaVrknapiF6L3Lnf5U59h7RCUY8qhYtipZp5P0k3Y1tCxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255348>

You should be able to run "make" in contrib/subtree with no
arguments and get the "all" target. This was broken by
8e2a5cc (contrib/subtree/Makefile: use GIT-VERSION-FILE,
2014-05-06), which put the rule for GIT-VERSION-FILE higher
in the file.

We can fix this by putting an empty "all::" target at the
top of the file. That fixes this instance and future-proofs
against it happening again.

Reported-by: Jack Nagel <jacknagel@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
On Sun, Aug 17, 2014 at 01:49:49AM -0500, Jack Nagel wrote:

> $ make -C contrib/subtree
> /Library/Developer/CommandLineTools/usr/bin/make -C ../../ GIT-VERSION-FILE
> GIT_VERSION = 2.1.0
> make[1]: `GIT-VERSION-FILE' is up to date.
> /Library/Developer/CommandLineTools/usr/bin/make -C ../../ GIT-VERSION-FILE
> make[1]: `GIT-VERSION-FILE' is up to date.
> make: `../../GIT-VERSION-FILE' is up to date.
> $ ls contrib/subtree/git-subtree
> ls: contrib/subtree/git-subtree: No such file or directory

Thanks for a clear report. The patch below should fix it. This is the
same trick we use in the top-level Makefile. I notice we don't use it in
t/Makefile or Documentation/Makefile, though. Maybe we should.

I also notice that GIT-VERSION-FILE is included first in the top-level
Makefile, but in contrib/subtree/Makefile it comes after we include
config.mak and friends. I wonder if that would ever matter. I can see
somebody adjusting their config.mak based on the git version, but it's
probably not likely. It would only be used by somebody who compiles
historical git versions a lot (i.e., git devs). And it would require
using make's "simply expanded variables", since regular variables aren't
expanded until point of use. So it seems unlikely that anybody cares.

 contrib/subtree/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index d9a0ce2..8deffad 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -1,3 +1,5 @@
+all::
+
 -include ../../config.mak.autogen
 -include ../../config.mak
 
@@ -34,7 +36,7 @@ GIT_SUBTREE_XML := git-subtree.xml
 GIT_SUBTREE_TXT := git-subtree.txt
 GIT_SUBTREE_HTML := git-subtree.html
 
-all: $(GIT_SUBTREE)
+all:: $(GIT_SUBTREE)
 
 $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' $< >$@
-- 
2.1.0.344.gf63f03f
