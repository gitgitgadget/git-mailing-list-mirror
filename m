From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v3 8/8] Remove special casing of http, https and ftp
Date: Sun,  6 Dec 2009 18:28:51 +0200
Message-ID: <1260116931-16549-9-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 17:29:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHJzO-0006Vu-OC
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 17:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933873AbZLFQ3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 11:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbZLFQ3I
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 11:29:08 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:49891 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857AbZLFQ26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 11:28:58 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 0E292C7538
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:29:03 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A011FC0B3E2; Sun, 06 Dec 2009 18:29:03 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id E32074035
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:29:01 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134677>

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
index b418889..c6684ac 100644
--- a/transport.c
+++ b/transport.c
@@ -935,14 +935,6 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 		data->conn = NULL;
 		data->got_remote_heads = 0;
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
1.6.6.rc1.300.gfbc27
