From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Embed an application manifest on MinGW
Date: Thu, 02 Jun 2011 09:27:52 -0700
Message-ID: <7vfwnsdwqf.fsf@alter.siamese.dyndns.org>
References: <1307010937-2894-1-git-send-email-cesarb@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Cesar Eduardo Barros <cesarb@cesarb.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 18:28:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSAkm-0007ED-08
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 18:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab1FBQ2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 12:28:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab1FBQ2E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 12:28:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA6005571;
	Thu,  2 Jun 2011 12:30:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H/TzGSGvDgUPrOpWEv//H9XOW0g=; b=lIKxCU
	Ov6SkelsCdNeJWWvm8bYysX9bn6z3uchbbpBBQctwkFsSqRsQ36G8JVZnFneCewj
	nw7MEB7tSysiqeQ7UORuVpf2dkYWCwZZSxY8mwP0HmNMogHoOkchfDZ9UNhzeE4M
	w0st2uhd5Bo8tm45JSWBAi+joJOiix1JWxQ8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tXLBw4b0nAZl9byQBgfPqGWK+/0IrEyI
	RK2UfPVnrhuh/+xwjXuTThsPFDtRDktbc/UZfvie9ImVhjSqeBTe433UXh6Xy74H
	Hj4khA+yM/7K60wYeOJqfL0ORO5gMLJ/l5S4gbR9fYO8iSREDGZmnXDD9JxITaAn
	9sL5lB+PxdE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 781A6556F;
	Thu,  2 Jun 2011 12:30:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0A0DD556E; Thu,  2 Jun 2011
 12:30:02 -0400 (EDT)
In-Reply-To: <1307010937-2894-1-git-send-email-cesarb@cesarb.net> (Cesar
 Eduardo Barros's message of "Thu, 2 Jun 2011 07:35:37 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 946D08E2-8D35-11E0-8369-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174959>

Does the output from $WINDRES define any external symbol the rest of the
code can refer to?  If so, you could throw resource.o into one of the .a
file and make sure that the symbol is referred to from main(); perhaps the
definition of main in compat/mingw.h can refer to it.

If you can do that, you wouldn't need any change to the Makefile other
than the rule to build compat/win32/resource.o and conditionally add that
object to LIB_OBJS, perhaps like this (obviously untested as I do not have
access to windows boxes).

 Makefile |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index cbc3fce..0a18e56 100644
--- a/Makefile
+++ b/Makefile
@@ -320,6 +320,7 @@ XGETTEXT = xgettext
 PTHREAD_LIBS = -lpthread
 PTHREAD_CFLAGS =
 GCOV = gcov
+WINDRES = windres
 
 export TCL_PATH TCLTK_PATH
 
@@ -1169,6 +1170,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
+	LIB_OBJS += compat/win32/resource.o
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
@@ -1580,6 +1582,7 @@ ifndef V
 	QUIET_LNCP     = @echo '   ' LN/CP $@;
 	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
+	QUIET_WINDRES  = @echo '   ' WINDRES $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -2022,6 +2025,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+%.o: %.rc
+	$(QUIET_WINDRES)$(WINDRES) $< $@
+compat/win32/resource.o: compat/win32/git.manifest
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
 
