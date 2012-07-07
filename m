From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] Makefile: document ground rules for target-specific
 dependencies
Date: Fri, 6 Jul 2012 23:19:09 -0500
Message-ID: <20120707041909.GC3574@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183133.GD30995@sigill.intra.peff.net>
 <20120620211225.GD6142@burratino>
 <20120620221502.GB3302@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 07 06:19:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnMUP-0005yL-JJ
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 06:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058Ab2GGETT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 00:19:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36094 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab2GGETS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2012 00:19:18 -0400
Received: by obbuo13 with SMTP id uo13so16205142obb.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 21:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HEFAjw7mmn2fS7E3sgLf1lvVoEpFInDWhxofRvvVYLE=;
        b=hqJt8aG1W2H1HFSF2X7UwLd7cHFnBuxHXT3bV0oDuAoItEGL/pVSIdOaepvNdhYodT
         O2uZNuL1EZkNxip6lQHD6QFH2AdgqmY6chTjYy44JgO9J16RqljBZtbgP2/v3Rg0BiIh
         VCa1gz8J1Ir+g2tSOwatuMb+jatQpdgw4ke3yA3gVtBQJL8tMboUHh4ckG/AUIVpvJTe
         YBMKPw1Y2vNl2Ufj1JsLn0vLHEQyuyqeHZIxQZgIpVUipKkg24Au+1NIdwAS851FQsMl
         W9GbrsLeFprHea1mw86CKa4UDAJwV3VqKSNvvXO0gBYqv8aIr7s/ZkDWD7Fqq7ybYDav
         SD+g==
Received: by 10.50.242.73 with SMTP id wo9mr2399689igc.1.1341634758043;
        Fri, 06 Jul 2012 21:19:18 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id y5sm8353609igb.11.2012.07.06.21.19.17
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 21:19:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620221502.GB3302@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201156>

When a source file makes use of a makefile variable, there should be a
corresponding dependency on a file that changes when that variable
changes to ensure the build output is not left stale when the variable
changes.

Document this, even though we are not following the rule perfectly
yet.  Based on an explanation from Jeff King.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:
> On Wed, Jun 20, 2012 at 04:12:25PM -0500, Jonathan Nieder wrote:

>> Wouldn't it be simpler to put the ground rules in a comment or a
>> document somewhere under Documentation/ where they can be easily
>> found?
>
> I think a comment in the Makefile might make sense (especially if it
> introduces the section as "and this is the place to put weird
> target-specific cppflags and dependencies").

How about something like this?

 Makefile |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Makefile b/Makefile
index 3f82b51b..542856f0 100644
--- a/Makefile
+++ b/Makefile
@@ -1970,6 +1970,40 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
+
+### Target-specific flags and dependencies
+
+# The generic compilation pattern rule and automatically
+# computed header dependencies (falling back to a dependency on
+# LIB_H) are enough to describe how most targets should be built,
+# but some targets are special enough to need something a little
+# different.
+#
+# - When a source file "foo.c" #includes a generated header file,
+#   we need to list that dependency for the "foo.o" target.
+#
+#   We also list it from other targets that are built from foo.c
+#   like "foo.sp" and "foo.s", even though that is easy to forget
+#   to do because the generated header is already present around
+#   after a regular build attempt.
+#
+# - Some code depends on configuration kept in makefile
+#   variables. The target-specific variable EXTRA_CPPFLAGS can
+#   be used to convey that information to the C preprocessor
+#   using -D options.
+#
+#   The "foo.o" target should have a corresponding dependency on
+#   a file that changes when the value of the makefile variable
+#   changes.  For example, targets making use of the
+#   $(GIT_VERSION) variable depend on GIT-VERSION-FILE.
+#
+#   Technically the ".sp" and ".s" targets do not need this
+#   dependency because they are force-built, but they get the
+#   same dependency for consistency. This way, you do not have to
+#   know how each target is implemented. And it means the
+#   dependencies here will not need to change if the force-build
+#   details change some day.
+
 git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
-- 
1.7.10.4
