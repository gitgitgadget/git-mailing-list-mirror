From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] clone: Add an option to set up a mirror
Date: Sat, 2 Aug 2008 21:39:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808022139150.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de> <7vr697l01j.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0808022126270.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 21:36:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPMtl-0006Bw-Dv
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 21:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760626AbYHBTfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 15:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760631AbYHBTfI
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 15:35:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:35989 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760259AbYHBTfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 15:35:06 -0400
Received: (qmail invoked by alias); 02 Aug 2008 19:35:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 02 Aug 2008 21:35:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DycZn59nDfdvMyFj+vopQk/qpr7hqSzkBQ2H1ri
	T89YOha5rNAE/P
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0808022126270.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91171>

The interdiff:

diff --git a/builtin-clone.c b/builtin-clone.c
index a45179c..ecdcefa 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -347,6 +347,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	char branch_top[256], key[256], value[256];
 	struct strbuf reflog_msg;
 	struct transport *transport = NULL;
+	char *src_ref_prefix = "refs/heads/";
 
 	struct refspec refspec;
 
@@ -445,7 +446,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	if (option_bare) {
-		strcpy(branch_top, "refs/heads/");
+		if (option_mirror)
+			src_ref_prefix = "refs/";
+		strcpy(branch_top, src_ref_prefix);
 
 		git_config_set("core.bare", "true");
 	} else {
@@ -455,18 +458,24 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (option_mirror || !option_bare) {
 		/* Configure the remote */
+		if (option_mirror) {
+			snprintf(key, sizeof(key),
+					"remote.%s.mirror", option_origin);
+			git_config_set(key, "true");
+		}
+
 		snprintf(key, sizeof(key), "remote.%s.url", option_origin);
 		git_config_set(key, repo);
 
 		snprintf(key, sizeof(key), "remote.%s.fetch", option_origin);
 		snprintf(value, sizeof(value),
-				"+refs/heads/*:%s*", branch_top);
+				"+%s*:%s*", src_ref_prefix, branch_top);
 		git_config_set_multivar(key, value, "^$", 0);
 	}
 
 	refspec.force = 0;
 	refspec.pattern = 1;
-	refspec.src = "refs/heads/";
+	refspec.src = src_ref_prefix;
 	refspec.dst = branch_top;
 
 	if (path && !is_bundle)
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4b2533f..9cd5ef4 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -76,7 +76,7 @@ test_expect_success 'clone --mirror' '
 	test -f mirror/HEAD &&
 	test ! -f mirror/file &&
 	FETCH="$(cd mirror && git config remote.origin.fetch)" &&
-	test "+refs/heads/*:refs/heads/*" = "$FETCH"
+	test "+refs/*:refs/*" = "$FETCH"
 
 '
 
