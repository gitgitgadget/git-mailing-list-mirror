From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [REROLL PATCH v2 8/8] Remove special casing of http, https and ftp
Date: Wed,  9 Dec 2009 17:26:34 +0200
Message-ID: <1260372394-16427-9-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 16:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIORi-0002on-8x
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbZLIP0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbZLIP0x
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:26:53 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:42222 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497AbZLIP0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:26:41 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 2AE67C7CE2
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:47 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A069CFE772D; Wed, 09 Dec 2009 17:26:46 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 0A04D1C6384
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:45 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134981>

HTTP, HTTPS and FTP are no longer special to transport code. Also
add support for FTPS (curl supports it so it is easy).

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 .gitignore  |    4 ++++
 Makefile    |   27 +++++++++++++++++++++++++--
 transport.c |    8 --------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/.gitignore b/.gitignore
index ac02a58..aa7a8ac 100644
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
index 2ad7e36..87fc7ff 100644
--- a/Makefile
+++ b/Makefile
@@ -424,6 +424,16 @@ BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
 
+ifdef NO_CURL
+REMOTE_CURL_PRIMARY =
+REMOTE_CURL_ALIASES =
+REMOTE_CURL_NAMES =
+else
+REMOTE_CURL_PRIMARY = git-remote-http$X
+REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
+REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
+endif
+
 # what 'all' will build and 'install' will install in gitexecdir,
 # excluding programs for built-in commands
 ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
@@ -1097,7 +1107,7 @@ else
 	else
 		CURL_LIBCURL = -lcurl
 	endif
-	PROGRAMS += git-remote-curl$X git-http-fetch$X
+	PROGRAMS += $(REMOTE_CURL_NAMES) git-http-fetch$X
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
@@ -1676,7 +1686,13 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
+$(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
+	$(QUIET_LNCP)$(RM) $@ && \
+	ln $< $@ 2>/dev/null || \
+	ln -s $< $@ 2>/dev/null || \
+	cp $< $@
+
+$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
@@ -1852,6 +1868,7 @@ endif
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
+
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	{ test "$$bindir/" = "$$execdir/" || \
@@ -1865,6 +1882,12 @@ endif
 		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
 	  done; } && \
+	{ for p in $(REMOTE_CURL_ALIASES); do \
+		$(RM) "$$execdir/$$p" && \
+		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
+		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
+		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
+	  done; } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-doc:
diff --git a/transport.c b/transport.c
index a7d67eb..652bf0b 100644
--- a/transport.c
+++ b/transport.c
@@ -918,14 +918,6 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
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
