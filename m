From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 6/8] Remove special casing of http, https and ftp
Date: Fri,  4 Dec 2009 17:56:06 +0200
Message-ID: <1259942168-24869-9-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 17:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaWp-0002SW-Tr
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbZLDP46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756881AbZLDP46
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:56:58 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:34684 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865AbZLDP45 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:56:57 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 5F61AEF46B
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:57:03 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04D5A5CF32; Fri, 04 Dec 2009 17:57:03 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id A4FE5158A6D
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:57:00 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.288.g40e67
In-Reply-To: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134522>

HTTP, HTTPS and FTP are no longer special to transport code. Also
add support for FTPS (curl supports it so it is easy).

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 .gitignore  |    4 ++++
 Makefile    |   24 ++++++++++++++++++++++--
 transport.c |    8 --------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7cc54b4..7c79f97 100644
--- a/.gitignore
+++ b/.gitignore
@@ -107,6 +107,10 @@
 /git-relink
 /git-remote
 /git-remote-curl
+/git-remote-http
+/git-remote-https
+/git-remote-ftp
+/git-remote-ftps
 /git-repack
 /git-replace
 /git-repo-config
diff --git a/Makefile b/Makefile
index 42744a4..1332225 100644
--- a/Makefile
+++ b/Makefile
@@ -424,6 +424,13 @@ BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
 
+#ifdef NO_CURL
+REMOTE_CURL_NAMES =
+#else
+# Yes, this is missing git-remote-http intentionally!
+REMOTE_CURL_NAMES = git-remote-https git-remote-ftp git-remote-ftps
+#endif
+
 # what 'all' will build and 'install' will install in gitexecdir,
 # excluding programs for built-in commands
 ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
@@ -1097,7 +1104,7 @@ else
 	else
 		CURL_LIBCURL = -lcurl
 	endif
-	PROGRAMS += git-remote-curl$X git-http-fetch$X
+	PROGRAMS += git-remote-http$X git-remote-https$X git-remote-ftp$X git-remote-ftps$X git-http-fetch$X
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
@@ -1676,7 +1683,13 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
+$(REMOTE_CURL_NAMES): git-remote-http$X
+	$(QUIET_LNCP)$(RM) $@ && \
+	ln $< $@ 2>/dev/null || \
+	ln -s $< $@ 2>/dev/null || \
+	cp $< $@
+
+git-remote-http$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
@@ -1853,6 +1866,7 @@ endif
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
+
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	{ test "$$bindir/" = "$$execdir/" || \
@@ -1866,6 +1880,12 @@ endif
 		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
 	  done; } && \
+	{ for p in $(REMOTE_CURL_NAMES); do \
+		$(RM) "$$execdir/$$p" && \
+		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
+		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
+		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
+	  done; } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-doc:
diff --git a/transport.c b/transport.c
index 1488cfe..872cc30 100644
--- a/transport.c
+++ b/transport.c
@@ -944,14 +944,6 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 		data->conn = NULL;
 		data->virtual_connected = 0;
-	} else if (!prefixcmp(url, "http://")
-		|| !prefixcmp(url, "https://")
-		|| !prefixcmp(url, "ftp://")) {
-		/* These three are just plain special. */
-		transport_helper_init(ret, "curl");
-#ifdef NO_CURL
-		error("git was compiled without libcurl support.");
-#endif
 	} else {
 		/* Unknown protocol in URL. Pass to external handler. */
 		int len = external_specification_len(url);
-- 
1.6.6.rc1.288.g40e67
