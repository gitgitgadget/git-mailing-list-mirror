From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] add config-mak git command
Date: Wed, 28 Oct 2009 20:24:11 -0400
Message-ID: <20091029002411.GB1057@sigill.intra.peff.net>
References: <20091029002229.GA986@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:24:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3IoO-0000QD-FN
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbZJ2AYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755949AbZJ2AYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:24:09 -0400
Received: from peff.net ([208.65.91.99]:38814 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755947AbZJ2AYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:24:08 -0400
Received: (qmail 13804 invoked by uid 107); 29 Oct 2009 00:27:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 28 Oct 2009 20:27:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Oct 2009 20:24:11 -0400
Content-Disposition: inline
In-Reply-To: <20091029002229.GA986@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131544>

This records the contents of your config.mak at build time
and prints them later.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Sam Vilain <sam@vilain.net>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Nick Edelen <sirnot@gmail.com>
Signed-off-by: "J.H." <warthog9@kernel.org>
Signed-off-by: Brandon Casey <drafnel@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore |    1 +
 Makefile   |    8 ++++++++
 builtin.h  |    1 +
 git.c      |    1 +
 help.c     |    7 +++++++
 5 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1e547e7..cf0d8b9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -191,3 +191,4 @@ cscope*
 Debug/
 Release/
 git-splash
+config-mak.c
diff --git a/Makefile b/Makefile
index 36e1a61..ae4b9fc 100644
--- a/Makefile
+++ b/Makefile
@@ -480,6 +480,7 @@ LIB_OBJS += color.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
 LIB_OBJS += config.o
+LIB_OBJS += config-mak.o
 LIB_OBJS += connect.o
 LIB_OBJS += convert.o
 LIB_OBJS += copy.o
@@ -1931,6 +1932,13 @@ coverage-clean:
 COVERAGE_CFLAGS = $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
 COVERAGE_LDFLAGS = $(CFLAGS)  -O0 -lgcov
 
+config-mak.c: config.mak
+	(echo 'const char *config_mak ='; \
+	 sed < config.mak -e 's/\\/\\\\/g; s/"/\\"/g; s/^/"/; s/$$/\\n"/'; \
+	 echo ';' \
+	) >$@+
+	mv $@+ $@
+
 coverage-build: coverage-clean
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" all
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
diff --git a/builtin.h b/builtin.h
index a2174dc..2ac8f3a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -113,5 +113,6 @@ extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix);
+extern int cmd_config_mak(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/git.c b/git.c
index 86dcfee..01ddf06 100644
--- a/git.c
+++ b/git.c
@@ -368,6 +368,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "verify-pack", cmd_verify_pack },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
+		{ "config-mak", cmd_config_mak, },
 	};
 	int i;
 	static const char ext[] = STRIP_EXTENSION;
diff --git a/help.c b/help.c
index e8db31f..422259a 100644
--- a/help.c
+++ b/help.c
@@ -365,3 +365,10 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	printf("git version %s\n", git_version_string);
 	return 0;
 }
+
+extern const char *config_mak;
+int cmd_config_mak(int argc, const char **argv, const char *prefix)
+{
+	fputs(config_mak, stdout);
+	return 0;
+}
-- 
1.6.5.1.3.g9d77a
