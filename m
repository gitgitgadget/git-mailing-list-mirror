From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH v4 06/11] Makefile: split GIT_USER_AGENT from GIT-CFLAGS
Date: Fri, 6 Jul 2012 23:42:11 -0500
Message-ID: <20120707044211.GD3574@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183151.GF30995@sigill.intra.peff.net>
 <20120620212135.GE6142@burratino>
 <20120620221616.GC3302@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 07 06:42:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnMqc-0005eO-5m
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 06:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab2GGEmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 00:42:17 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33212 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab2GGEmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2012 00:42:16 -0400
Received: by ghrr11 with SMTP id r11so9193528ghr.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 21:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gjRZ8z6O3b6sB6XSz60fwmyDnyVlwxrw4OVBfvbOhuQ=;
        b=gPSsI6HOvcd3iXgqK+S+tjyn3Zhlb0c3a6vLSGmfOBCVUbXbWTTST4JPA/4QfjYymy
         VfFL7q5cc5CWCyGGf023JBbAF0u6mYSSIGA/DJpZ0EG7T8IcHchW4q8rxpLBnByGrqMq
         cNlNvR89okfOtb6lwVVURSz7ughV/eeyfSrw/fyWgRnJj3xmaXnxsQTZUp8o0iECW8O0
         Ly7/amfCIV3tJgKenF1y85MvMj/nW61G0p7rl6nK7zbXkefD8ml51IY0Pvzu+iHRgs4n
         3Bf/wu1XT3ROna0qddeQWAVSgYwfUdSoebJkVZl/Dw3QDA98F2XYgGzz6DaDj++VwIVo
         GCZQ==
Received: by 10.42.87.75 with SMTP id x11mr16813900icl.25.1341636135160;
        Fri, 06 Jul 2012 21:42:15 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id rd8sm8460039igb.3.2012.07.06.21.42.13
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 21:42:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620221616.GC3302@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201157>

The default user-agent depends on the GIT_VERSION, which means that
anytime you switch versions, it causes a full rebuild. Instead, let's
split it out into its own file and restrict the dependency to
version.o.

To avoid noise during builds, unlike the GIT-CFLAGS rule which prints
"* new build flags or prefix" so the operator knows why all files are
being rebuilt when it changes, GIT-USER-AGENT generation is silent.

If this code breaks and a target depending on GIT-USER-AGENT ends up
being rebuilt when it shouldn't be, the full dependency chain can be
retrieved with "make --debug=b".

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

>           I am tempted to get rid of the informative message altogether.

Like this?

 .gitignore |    1 +
 Makefile   |   10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index bf66648e..7329cfe5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@
 /GIT-CFLAGS
 /GIT-LDFLAGS
 /GIT-GUI-VARS
+/GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
 /git
diff --git a/Makefile b/Makefile
index 7148cadd..2a84cd8b 100644
--- a/Makefile
+++ b/Makefile
@@ -1922,7 +1922,10 @@ endif
 GIT_USER_AGENT_SQ = $(subst ','\'',$(GIT_USER_AGENT))
 GIT_USER_AGENT_CQ = "$(subst ",\",$(subst \,\\,$(GIT_USER_AGENT)))"
 GIT_USER_AGENT_CQ_SQ = $(subst ','\'',$(GIT_USER_AGENT_CQ))
-BASIC_CFLAGS += -DGIT_USER_AGENT='$(GIT_USER_AGENT_CQ_SQ)'
+GIT-USER-AGENT: FORCE
+	@if test x'$(GIT_USER_AGENT_SQ)' != x"`cat GIT-USER-AGENT 2>/dev/null`"; then \
+		echo '$(GIT_USER_AGENT_SQ)' >GIT-USER-AGENT; \
+	fi
 
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
@@ -2021,8 +2024,10 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
+version.sp version.s version.o: GIT-USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
-	'-DGIT_VERSION="$(GIT_VERSION)"'
+	'-DGIT_VERSION="$(GIT_VERSION)"' \
+	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)'
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
@@ -2744,6 +2749,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
+	$(RM) GIT-USER-AGENT
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-- 
1.7.10.4
