From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] add option to find zlib in custom path
Date: Sun, 29 Jul 2007 20:35:45 +0200
Message-ID: <20070729183545.GC29424@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 20:35:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFDcR-0003wQ-21
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 20:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765107AbXG2Sfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 14:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765041AbXG2Sfw
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 14:35:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:20571 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761718AbXG2Sfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 14:35:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so948119ugf
        for <git@vger.kernel.org>; Sun, 29 Jul 2007 11:35:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=kmK0dDoENOv/O2ArfHaynB8tSjMLVF+26cKhnV9BccS9P5sTTHHd0ZGk4mOwnRCtJmCtJO8+DMqnMab4OH0Vj06HS5PsFV4dsyVyHfI98/jfN5RQ/kDuLE2RfcnHMSwkCmxlmfwockspbbZ08y+3+EhI/uXphGexmMSDmclcJLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=jR/N13JfSUPwTh7s+s0aq4FxFk9/oFZmvfq3VBbN8lb+fs4Uo6+nq92w4i9E3JR+gnEWLHuZKHjTn4CGUzUTAdxO74BC6TJSXD+ylCNj9plx3TOLrZJfv4FFcYAlQoRV51Q/KWB1ig5uV7GGESXsmFEAbFEkW8/n5Ns5xVNZ8bY=
Received: by 10.67.98.9 with SMTP id a9mr4618888ugm.1185734150156;
        Sun, 29 Jul 2007 11:35:50 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.103.54])
        by mx.google.com with ESMTPS id k5sm9041910nfh.2007.07.29.11.35.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jul 2007 11:35:49 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 62BBC2A6E01; Sun, 29 Jul 2007 20:35:46 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54131>

Some systems do not provide zlib development headers and libraries in
default search path of the compiler.  For these systems we should allow
specifying the location by --with-zlib=PATH or by setting ZLIB_PATH in
the makefile.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---

You can also fetch this patch as d669d5f17feb3b406862fd83b42998b2353da44f from
git://schiele.dyndns.org/git

 Makefile     |    8 +++++++-
 configure.ac |    3 +++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 73b487f..21bf5c7 100644
--- a/Makefile
+++ b/Makefile
@@ -372,7 +372,7 @@ BUILTIN_OBJS = \
 	builtin-pack-refs.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
-EXTLIBS = -lz
+EXTLIBS =
 
 #
 # Platform specific tweaks
@@ -517,6 +517,12 @@ ifndef NO_CURL
 	endif
 endif
 
+ifdef ZLIB_PATH
+	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
+	EXTLIBS += -L$(ZLIB_PATH)/lib $(CC_LD_DYNPATH)$(ZLIB_PATH)/lib
+endif
+EXTLIBS += -lz
+
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
diff --git a/configure.ac b/configure.ac
index 50d2b85..b2f1965 100644
--- a/configure.ac
+++ b/configure.ac
@@ -75,6 +75,9 @@ GIT_ARG_SET_PATH(shell)
 # Define PERL_PATH to provide path to Perl.
 GIT_ARG_SET_PATH(perl)
 #
+# Define ZLIB_PATH to provide path to zlib.
+GIT_ARG_SET_PATH(zlib)
+#
 # Declare the with-tcltk/without-tcltk options.
 AC_ARG_WITH(tcltk,
 AS_HELP_STRING([--with-tcltk],[use Tcl/Tk GUI (default is YES)])
-- 
1.5.2.3
