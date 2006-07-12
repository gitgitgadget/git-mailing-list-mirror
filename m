From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Wed, 12 Jul 2006 09:29:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607120921380.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <44B4172B.3070503@stephan-feder.de> <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
 <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
 <Pine.LNX.4.63.0607120226210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607111755180.5623@g5.osdl.org> <7vzmffz5xe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 18:32:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0haQ-0004DC-3e
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 18:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWGLQ3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 12:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWGLQ3P
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 12:29:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750993AbWGLQ3O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 12:29:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6CGTAnW023572
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Jul 2006 09:29:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6CGT9FA014163;
	Wed, 12 Jul 2006 09:29:09 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmffz5xe.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23790>



On Tue, 11 Jul 2006, Junio C Hamano wrote:
> 
> You seem to have forgotten one file (fetch-pack.c) but that was
> trivial.  I'll apply and push it out shortly.

Actually, it was fetch.c, not fetch-pack.c, and I forgot that due to a 
very real (and totally separate) bug.

The makefile doesn't have any dependencies for "fetch.o" and "rsh.o", so 
when you change the headers, they never get rebuilt.

I think fetch.o and rsh.o should either get added to the library files, or 
we need something like this..

(I didn't check that I caught all the appropriate *.o files, but this 
should be better than what we have now).

Even better would be to make the dependancies automatic. The kernel does 
that really well with some GNU Makefile magic, but it also depends on 
magic gcc command line flags ("-Wp,-MD,$(depfile)")

		Linus

---
diff --git a/Makefile b/Makefile
index e75fb13..854e0af 100644
--- a/Makefile
+++ b/Makefile
@@ -236,6 +236,9 @@ BUILTIN_OBJS = \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
 	builtin-update-ref.o builtin-fmt-merge-msg.o
 
+MISC_OBJS = \
+	fetch.o rsh.o http-fetch.o http-push.o
+
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
 
@@ -615,7 +618,7 @@ git-http-push$X: revision.o http.o http-
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
+$(LIB_OBJS) $(BUILTIN_OBJS) $(MISC_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 $(DIFF_OBJS): diffcore.h
 
