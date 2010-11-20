From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/8] svn-fe: Prepare for strbuf use
Date: Sat, 20 Nov 2010 13:22:47 -0600
Message-ID: <20101120192247.GB17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:23:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJt1m-0000Sp-9t
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab0KTTW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:22:57 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35567 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0KTTWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:22:55 -0500
Received: by gxk23 with SMTP id 23so3369563gxk.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xxFIrZpglxxQFv3ha84epqYSdIdDywUmPA0x96ysRzU=;
        b=VaaGzuJcodLmpe390L4pKtdZXQggDWR3rlUmlyt7M4n8Fq1dvVODEqulEpmHGd4Nzt
         jbpd80ILfSk9YABJGXnPDyc0daFrWUVyf2I9iK9AjEbQ/bv0tEQ12YRdA5pKIrgrHscq
         NnCvV2QaCNElHPIK6zyUCGPCR+BJKuaX6ITN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pG/4/yTFgjWrTGNvr2xxtJgdPh2P2N/WfgMHPAAiDkhpm3xpaP86zlvKhywrmZhejf
         wMrTW7zj1AaH8Cebks1NjkmKsUiYEN1Rtw65yu8IgTCIlMrHro9qiZ3XAW98HWTuxX7F
         /5UXke+6WKpWVxtVq/efdWJpn1bDI4E7bsJLY=
Received: by 10.150.205.11 with SMTP id c11mr6022037ybg.304.1290280974656;
        Sat, 20 Nov 2010 11:22:54 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r18sm2001639yba.15.2010.11.20.11.22.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:22:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192153.GA17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161830>

Linking svn-fe strbuf.o will require sha1_name.o and wrapper.o, hence
sha1_file.o, hence libz, pthreads, and most of libgit.  Luckily there
is a separate patch series in flight that would trim down those
dependencies again.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/Makefile |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..9732b03 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -8,11 +8,13 @@ CFLAGS = -g -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-EXTLIBS =
+PTHREAD_LIBS = -lpthread
+EXTLIBS = -lz $(PTHREAD_LIBS)
 
 GIT_LIB = ../../libgit.a
 VCSSVN_LIB = ../../vcs-svn/lib.a
-LIBS = $(VCSSVN_LIB) $(GIT_LIB) $(EXTLIBS)
+XDIFF_LIB = ../../xdiff/lib.a
+LIBS = $(VCSSVN_LIB) $(GIT_LIB) $(XDIFF_LIB) $(EXTLIBS)
 
 QUIET_SUBDIR0 = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1 =
@@ -33,7 +35,7 @@ ifndef V
 endif
 endif
 
-svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
+svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB) $(XDIFF_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
 		$(ALL_LDFLAGS) $(LIBS)
 
@@ -51,11 +53,8 @@ svn-fe.1: svn-fe.txt
 		../contrib/svn-fe/$@
 	$(MV) ../../Documentation/svn-fe.1 .
 
-../../vcs-svn/lib.a: FORCE
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) vcs-svn/lib.a
-
-../../libgit.a: FORCE
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
+../../%.a: FORCE
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $*.a
 
 clean:
 	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
-- 
1.7.2.3
