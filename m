From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Makefile: dependencies for vcs-svn tests
Date: Sun, 10 Oct 2010 00:50:32 -0500
Message-ID: <20101010055032.GA23100@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 07:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4or2-000547-Uj
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 07:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab0JJFxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 01:53:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37351 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0JJFxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 01:53:46 -0400
Received: by iwn6 with SMTP id 6so2002451iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 22:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=KWvNawnJ5n7dBLpXsLcpqaAHYb73VCugWBYBlQDuU18=;
        b=B/eXVWmxaIXHWb9V8yU6poZTerRkxgZE6uUCjs99FQJALBB7fg89W4gA/Bii+iyMIa
         BUoVUIE23SgxCveVaFqQ82u89fGkoJhc6Ayau/2bI3PX5yEMCRgtu/3mXU9e9XrPKEdl
         gU8ZYfP5M8TMQ+lFLcgf0Cdater3PT4+0cKYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=u6MSx/JAn1Ol2EapRinfxUmlcvIFaq1NzvEMAwF9hCK8RHzo8x2o0FL4xLLheRXZQK
         4/Y9s62b5fQHVdvll4fjqIkA8ODR6Q8xw9CJwuXkFvpbKePWfDP/hSuFqhikp9ou5Vuz
         ExaNX5qN0sCa9rUKpKt0UVcv9jm96qIrXuF6Y=
Received: by 10.42.25.3 with SMTP id y3mr1055641icb.473.1286690026103;
        Sat, 09 Oct 2010 22:53:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id x10sm5645361iba.10.2010.10.09.22.53.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 22:53:45 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158644>

The vcs-svn tests (test-treap.o et al) depend on the vcs-svn
headers for declarations and inline functions.  Declare the
dependency.  While at it, declare a dependency of the vcs-svn
objects (vcs-svn/string_pool.o et al) on $(LIB_H) to reflect use
within the vcs-svn library of git-compat-util.h and cache.h.

Without this change, tweaks to inline functions in those headers
do not provoke rebuilds of the corresponding tests[*], making
such changes unnecessarily difficult to test.

Before:

 $ touch vcs-svn/*.h && make test-treap
 $

After:

 $ touch vcs-svn/*.h && make test-treap
 CC test-treap.o
 LINK test-treap
 $

[*] unless COMPUTE_HEADER_DEPENDENCIES is enabled

Detected with "make CHECK_HEADER_DEPENDENCIES=1".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sorry I missed this before.

 Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index d3dcfb1..1bd1823 100644
--- a/Makefile
+++ b/Makefile
@@ -1762,6 +1762,8 @@ XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
 	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o
+VCSSVN_TEST_OBJS = test-obj-pool.o test-string-pool.o \
+	test-line-buffer.o test-treap.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1885,10 +1887,12 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
-$(VCSSVN_OBJS): \
+$(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
 	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
 	vcs-svn/svndump.h
+
+test-svn-fe.o: vcs-svn/svndump.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
-- 
1.7.2.3
