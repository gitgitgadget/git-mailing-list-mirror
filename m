From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Thu, 29 Jan 2009 14:38:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 14:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSX7X-0004by-2o
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 14:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbZA2NiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 08:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbZA2NiX
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 08:38:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:39442 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751644AbZA2NiW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 08:38:22 -0500
Received: (qmail invoked by alias); 29 Jan 2009 13:38:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 29 Jan 2009 14:38:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GNFNQm1IGcHXQOeFlLUBWhFClBO6+cQ0DjocwdT
	Ra/tNT1KtByHJs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233236267u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107671>

When pushing a branch to a remote repository that the remote side did
not know beforehand, it is often handy to set up the branch tracking
such that

	$ git checkout xyz
	$ git push --track origin xyz:abc
	$ git pull

will pull the branch 'abc' from the remote 'origin' into the branch
'xyz'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This is a companion patch to the one I sent earlier:

	http://article.gmane.org/gmane.comp.version-control.git/13735

 Documentation/git-push.txt |    7 ++++++-
 builtin-push.c             |   42 ++++++++++++++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh      |   11 +++++++++++
 3 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 7d1eced..fa1d54c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [-v | --verbose]
+	   [--repo=<repository>] [-f | --force] [-v | --verbose] [-t | --track]
 	   [<repository> <refspec>...]
 
 DESCRIPTION
@@ -126,6 +126,11 @@ useful if you write an alias or script around 'git-push'.
 	transfer spends extra cycles to minimize the number of
 	objects to be sent and meant to be used on slower connection.
 
+-t::
+--track::
+	Set up tracking information for the pushed branches, so that
+	'git pull' will remember the indicated mapping.
+
 -v::
 --verbose::
 	Run verbosely.
diff --git a/builtin-push.c b/builtin-push.c
index 122fdcf..9fd445d 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -16,6 +16,7 @@ static const char * const push_usage[] = {
 
 static int thin;
 static const char *receivepack;
+static int track;
 
 static const char **refspec;
 static int refspec_nr;
@@ -48,6 +49,41 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
+static void setup_tracking(const char *url)
+{
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	int i;
+
+	for (i = 0; i < refspec_nr; i++) {
+		const char *branch = refspec[i], *colon;
+
+		/* skip non-branches */
+		if (!prefixcmp("refs/", branch)) {
+			if (prefixcmp("refs/heads/", branch))
+				continue;
+			branch += strlen("refs/heads/");
+		}
+		colon = strchrnul(branch, ':');
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "branch.%.*s.remote",
+				(int)(colon - branch), branch);
+		git_config_set(buf.buf, url);
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "branch.%.*s.merge",
+				(int)(colon - branch), branch);
+		strbuf_reset(&buf2);
+		strbuf_addf(&buf2, "%s%s",
+			*colon && !prefixcmp("refs/heads/", colon + 1) ?
+			"" : "refs/heads/",
+			*colon ? colon + 1 : branch);
+		git_config_set(buf.buf, buf2.buf);
+	}
+	strbuf_release(&buf);
+	strbuf_release(&buf2);
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -96,6 +132,8 @@ static int do_push(const char *repo, int flags)
 		if (flags & TRANSPORT_PUSH_VERBOSE)
 			fprintf(stderr, "Pushing to %s\n", remote->url[i]);
 		err = transport_push(transport, refspec_nr, refspec, flags);
+		if (!err && track)
+			setup_tracking(transport->url);
 		err |= transport_disconnect(transport);
 
 		if (!err)
@@ -126,11 +164,15 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
+		OPT_BOOLEAN('t', "track", &track, "set up branch tracking information"),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, options, push_usage, 0);
 
+	if (track && !tags && !argc)
+		die ("Need explicit arguments for branch tracking");
+
 	if (tags)
 		add_refspec("refs/tags/*");
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4426df9..e18b2f6 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -573,4 +573,15 @@ test_expect_success 'push with branches containing #' '
 	git checkout master
 '
 
+test_expect_success 'push --track' '
+
+	git push --track testrepo master &&
+	test ! -z "$(git ls-remote testrepo master)" &&
+	test "testrepo" = $(git config branch.master.remote) &&
+	test "refs/heads/master" = $(git config branch.master.merge) &&
+	git push --track testrepo master:test &&
+	test "refs/heads/test" = $(git config branch.master.merge)
+
+'
+
 test_done
-- 
1.6.1.1.506.gdbe181
