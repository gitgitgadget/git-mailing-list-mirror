From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/8] Make the "traditionally-supported" URLs a special case
Date: Thu, 3 Sep 2009 22:13:49 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 04:14:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjOJW-0002pu-Fn
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 04:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbZIDCNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 22:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756525AbZIDCNs
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 22:13:48 -0400
Received: from iabervon.org ([66.92.72.58]:41089 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756266AbZIDCNr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 22:13:47 -0400
Received: (qmail 2355 invoked by uid 1000); 4 Sep 2009 02:13:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 02:13:49 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127675>

Instead of trying to make http://, https://, and ftp:// URLs
indicative of some sort of pattern of transport helper usage, make
them a special case which runs the "curl" helper, and leave the
mechanism by which arbitrary helpers will be chosen entirely to future
work.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile           |   17 ++---------------
 transport-helper.c |    7 ++-----
 transport.c        |    2 +-
 transport.h        |    2 +-
 4 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index 263e191..3ac12ec 100644
--- a/Makefile
+++ b/Makefile
@@ -972,8 +972,7 @@ else
 	else
 		CURL_LIBCURL = -lcurl
 	endif
-	CURL_SYNONYMS = git-remote-https$X git-remote-ftp$X
-	PROGRAMS += git-remote-http$X $(CURL_SYNONYMS) git-http-fetch$X
+	PROGRAMS += git-remote-curl$X git-http-fetch$X
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
@@ -1483,16 +1482,10 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-git-remote-http$X: remote-curl.o http.o http-walker.o $(GITLIBS)
+git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(CURL_SYNONYMS): git-remote-http$X
-	$(QUIET_LNCP)$(RM) $@ && \
-	ln $< $@ 2>/dev/null || \
-	ln -s $< $@ 2>/dev/null || \
-	cp $< $@
-
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
@@ -1674,12 +1667,6 @@ endif
 		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
 	  done; } && \
-	{ for p in $(CURL_SYNONYMS); do \
-		$(RM) "$$execdir/$$p" && \
-		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
-	  done; } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-doc:
diff --git a/transport-helper.c b/transport-helper.c
index 43fdc0a..4684877 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -152,13 +152,10 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 	return ret;
 }
 
-int transport_helper_init(struct transport *transport)
+int transport_helper_init(struct transport *transport, const char *name)
 {
 	struct helper_data *data = xcalloc(sizeof(*data), 1);
-	char *eom = strchr(transport->url, ':');
-	if (!eom)
-		return -1;
-	data->name = xstrndup(transport->url, eom - transport->url);
+	data->name = name;
 
 	transport->data = data;
 	transport->get_refs_list = get_refs_list;
diff --git a/transport.c b/transport.c
index f2bd998..4cb8077 100644
--- a/transport.c
+++ b/transport.c
@@ -823,7 +823,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	} else if (!prefixcmp(url, "http://")
 	        || !prefixcmp(url, "https://")
 	        || !prefixcmp(url, "ftp://")) {
-		transport_helper_init(ret);
+		transport_helper_init(ret, "curl");
 #ifdef NO_CURL
 		error("git was compiled without libcurl support.");
 #else
diff --git a/transport.h b/transport.h
index bfd542f..c14da6f 100644
--- a/transport.h
+++ b/transport.h
@@ -80,6 +80,6 @@ int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
 
 /* Transport methods defined outside transport.c */
-int transport_helper_init(struct transport *transport);
+int transport_helper_init(struct transport *transport, const char *name);
 
 #endif
-- 
1.6.4.2.419.gc86f8
