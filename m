From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Fix compilation when NO_CURL is defined
Date: Mon, 15 Oct 2007 19:48:30 -0400
Message-ID: <20071015234830.GA9694@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 02:06:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhZg0-0003L4-24
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 01:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937AbXJOXsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 19:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756031AbXJOXsh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 19:48:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44766 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670AbXJOXsg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 19:48:36 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhZfZ-0007NZ-M4; Mon, 15 Oct 2007 19:48:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 99BC020FBAE; Mon, 15 Oct 2007 19:48:30 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61053>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

There were a few places which did not cope well without curl.  This
fixes all of them.  We still need to link against the walker.o part
of the library as some parts of transport.o still call into there
even though we don't have HTTP support enabled.

If compiled with NO_CURL=1 we now get the following useful error
message:

  $ git-fetch http://www.example.com/git
  error: git was compiled without libcurl support.
  fatal: Don't know how to fetch from http://www.example.com/git

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I think this is a better version of Dscho's original attempt at
 making NO_CURL=YesPlease actually work again with the builtin
 fetch series.

 Makefile    |    6 +++---
 transport.c |   23 +++++++----------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 62bdac6..40f10b7 100644
--- a/Makefile
+++ b/Makefile
@@ -310,7 +310,7 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o bundle.o
+	transport.o bundle.o walker.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
@@ -528,7 +528,7 @@ else
 	endif
 	BUILTIN_OBJS += builtin-http-fetch.o
 	EXTLIBS += $(CURL_LIBCURL)
-	LIB_OBJS += http.o walker.o http-walker.o
+	LIB_OBJS += http.o http-walker.o
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
@@ -905,7 +905,7 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(LIB_OBJS) $(BUILTIN_OBJS) walker.o: $(LIB_H)
+$(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 $(DIFF_OBJS): diffcore.h
 
diff --git a/transport.c b/transport.c
index 6fe6ec8..46da754 100644
--- a/transport.c
+++ b/transport.c
@@ -1,7 +1,9 @@
 #include "cache.h"
 #include "transport.h"
 #include "run-command.h"
+#ifndef NO_CURL
 #include "http.h"
+#endif
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "walker.h"
@@ -368,6 +370,7 @@ static int disconnect_walker(struct transport *transport)
 	return 0;
 }
 
+#ifndef NO_CURL
 static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
 	const char **argv;
 	int argc;
@@ -400,7 +403,6 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	return !!err;
 }
 
-#ifndef NO_CURL
 static int missing__target(int code, int result)
 {
 	return	/* file:// URL -- do we ever use one??? */
@@ -504,21 +506,6 @@ static int fetch_objs_via_curl(struct transport *transport,
 	return fetch_objs_via_walker(transport, nr_objs, to_fetch);
 }
 
-#else
-
-static struct ref *get_refs_via_curl(const struct transport *transport)
-{
-	die("Cannot fetch from '%s' without curl ...", transport->url);
-	return NULL;
-}
-
-static int fetch_objs_via_curl(struct transport *transport,
-				 int nr_objs, struct ref **to_fetch)
-{
-	die("Cannot fetch from '%s' without curl ...", transport->url);
-	return -1;
-}
-
 #endif
 
 struct bundle_transport_data {
@@ -733,9 +720,13 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	} else if (!prefixcmp(url, "http://")
 	        || !prefixcmp(url, "https://")
 	        || !prefixcmp(url, "ftp://")) {
+#ifdef NO_CURL
+		error("git was compiled without libcurl support.");
+#else
 		ret->get_refs_list = get_refs_via_curl;
 		ret->fetch = fetch_objs_via_curl;
 		ret->push = curl_transport_push;
+#endif
 		ret->disconnect = disconnect_walker;
 
 	} else if (is_local(url) && is_file(url)) {
-- 
1.5.3.4.1155.gfe96ee
