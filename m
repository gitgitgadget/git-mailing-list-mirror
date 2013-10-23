From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/15] fetch --prune: prune only based on explicit refspecs
Date: Wed, 23 Oct 2013 17:50:44 +0200
Message-ID: <1382543448-2586-12-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:59:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0qH-00074o-9o
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab3JWP7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:59:25 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46039 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751054Ab3JWP7Y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:59:24 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2013 11:59:24 EDT
X-AuditID: 1207440c-b7f566d000004272-20-5267f0aea8a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.63.17010.EA0F7625; Wed, 23 Oct 2013 11:52:14 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLt4009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:52:12 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqLvuQ3qQwb2dmhbTu1azWHRd6Way
	aOi9wmwx7+4uJotVt5YxW6yccYPR4vaK+cwWTzsrLea9eMFm8aOlh9mBy+Pv+w9MHpfWvWTy
	OPRnCrvHsxPtbB6XXn5n83jWu4fR4+IlZY8ZLa9ZPD5vkvM4cPkxWwBXFLdNUmJJWXBmep6+
	XQJ3xt8Nc1gL/tpUnGtja2CcYtjFyMEhIWAicWWZdBcjJ5ApJnHh3nq2LkYuDiGBy4wSXa0b
	2SGcK0wSh+8sZwepYhPQlVjU08wEYosIqElMbDvEAlLELDCRWeL49EUsIAlhAW+Jlr3bmUFs
	FgFVifb5P8AaeAVcJC7e+coOsVlO4uG3WJAwJ1D4wvHprCC2kICzxISFU9knMPIuYGRYxSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRrqJebWaKXmlK6iRESsjw7GL+tkznEKMDBqMTDa9GeFiTE
	mlhWXJl7iFGSg0lJlHfOu/QgIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8O+4C5XhTEiurUovy
	YVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzH3gM1ChalpqdWpGXmlCCkmTg4QQQX
	yAYeoA3XQAp5iwsSc4sz0yGKTjEqSonz7gdJCIAkMkrz4AbAkssrRnGgf4R5b4JU8QATE1z3
	K6DBTECDpyxJAxlckoiQkmpgnMliY/DVIuV198yEeeobQ1cJ79QrXF3O+Kn5zs7FNqpH3n25
	nxfQtmTzR61f2jwmAYa1zLNF10eovC/b8njp9pkXqp7lz+BI0e98fn6j1Okas9vP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236527>

The old behavior of "fetch --prune" was to prune whatever was being
fetched.  In particular, "fetch --prune --tags" caused tags not only
to be fetched, but also to be pruned.  This is inappropriate because
there is only one tags namespace that is shared among the local
repository and all remotes.  Therefore, if the user defines a local
tag and then runs "git fetch --prune --tags", then the local tag is
deleted.  Moreover, "--prune" and "--tags" can also be configured via
fetch.prune / remote.<name>.prune and remote.<name>.tagopt, making it
even less obvious that an invocation of "git fetch" could result in
tag lossage.

Since the command "git remote update" invokes "git fetch", it had the
same problem.

The command "git remote prune", on the other hand, disregarded the
setting of remote.<name>.tagopt, and so its behavior was inconsistent
with that of the other commands.

So the old behavior made it too easy to lose tags.  To fix this
problem, change "fetch --prune" to prune references based only on
refspecs specified explicitly by the user, either on the command line
or via remote.<name>.fetch.  Thus, tags are no longer made subject to
pruning by the --tags option or the remote.<name>.tagopt setting.

However, tags *are* still subject to pruning if they are fetched as
part of a refspec, and that is good.  For example:

* On the command line,

      git fetch --prune 'refs/tags/*:refs/tags/*'

  causes tags, and only tags, to be fetched and pruned, and is
  therefore a simple way for the user to get the equivalent of the old
  behavior of "--prune --tag".

* For a remote that was configured with the "--mirror" option, the
  configuration is set to include

      [remote "name"]
              fetch = +refs/*:refs/*

  , which causes tags to be subject to pruning along with all other
  references.  This is the behavior that will typically be desired for
  a mirror.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/config.txt        |  2 +-
 Documentation/fetch-options.txt | 15 ++++++++++++---
 builtin/fetch.c                 | 39 +++++++++------------------------------
 t/t5510-fetch.sh                | 10 +++++-----
 4 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d4d93c9..83c1700 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2086,7 +2086,7 @@ remote.<name>.vcs::
 remote.<name>.prune::
 	When set to true, fetching from this remote by default will also
 	remove any remote-tracking branches which no longer exist on the
-	remote (as if the `--prune` option was give on the command line).
+	remote (as if the `--prune` option was given on the command line).
 	Overrides `fetch.prune` settings, if any.
 
 remotes.<group>::
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 0e6d2ac..5d12219 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -41,8 +41,14 @@ ifndef::git-pull[]
 
 -p::
 --prune::
-	After fetching, remove any remote-tracking branches which
-	no longer exist	on the remote.
+	After fetching, remove any remote-tracking branches that
+	no longer exist	on the remote.  Tags are not subject to
+	pruning in the usual case that they are fetched because of the
+	--tags option or remote.<name>.tagopt.  However, if tags are
+	fetched due to an explicit refspec (either on the command line
+	or in the remote configuration, for example if the remote was
+	cloned with the --mirror option), then they are also subject
+	to pruning.
 endif::git-pull[]
 
 ifdef::git-pull[]
@@ -63,7 +69,10 @@ ifndef::git-pull[]
 --tags::
 	This is a short-hand requesting that all tags be fetched from
 	the remote in addition to whatever else is being fetched.  It
-	is similar to using the refspec `refs/tags/*:refs/tags/*`.
+	is similar to using the refspec `refs/tags/*:refs/tags/*`,
+	except that it doesn't subject tags to pruning, regardless of
+	a --prune option or the configuration settings of fetch.prune
+	or remote.<name>.prune.
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7edb1ea..47b63a7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -829,38 +829,17 @@ static int do_fetch(struct transport *transport,
 		goto cleanup;
 	}
 	if (prune) {
-		struct refspec *prune_refspecs;
-		int prune_refspec_count;
-
+		/*
+		 * We only prune based on refspecs specified
+		 * explicitly (via command line or configuration); we
+		 * don't care whether --tags was specified.
+		 */
 		if (ref_count) {
-			prune_refspecs = refs;
-			prune_refspec_count = ref_count;
-		} else {
-			prune_refspecs = transport->remote->fetch;
-			prune_refspec_count = transport->remote->fetch_refspec_nr;
-		}
-
-		if (tags == TAGS_SET) {
-			/*
-			 * --tags was specified.  Pretend that the user also
-			 * gave us the canonical tags refspec
-			 */
-			const char *tags_str = "refs/tags/*:refs/tags/*";
-			struct refspec *tags_refspec, *refspec;
-
-			/* Copy the refspec and add the tags to it */
-			refspec = xcalloc(prune_refspec_count + 1, sizeof(*refspec));
-			tags_refspec = parse_fetch_refspec(1, &tags_str);
-			memcpy(refspec, prune_refspecs, prune_refspec_count * sizeof(*refspec));
-			memcpy(&refspec[prune_refspec_count], tags_refspec, sizeof(*refspec));
-
-			prune_refs(refspec, prune_refspec_count + 1, ref_map);
-
-			/* The rest of the strings belong to fetch_one */
-			free_refspec(1, tags_refspec);
-			free(refspec);
+			prune_refs(refs, ref_count, ref_map);
 		} else {
-			prune_refs(prune_refspecs, prune_refspec_count, ref_map);
+			prune_refs(transport->remote->fetch,
+				   transport->remote->fetch_refspec_nr,
+				   ref_map);
 		}
 	}
 	free_refs(ref_map);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 02e5901..5d4581d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -113,7 +113,7 @@ test_expect_success 'fetch --prune with a namespace keeps other namespaces' '
 	git rev-parse origin/master
 '
 
-test_expect_success 'fetch --prune --tags prunes tags and branches' '
+test_expect_success 'fetch --prune --tags prunes branches but not tags' '
 	cd "$D" &&
 	git clone . prune-tags &&
 	cd prune-tags &&
@@ -125,10 +125,10 @@ test_expect_success 'fetch --prune --tags prunes tags and branches' '
 	git fetch --prune --tags origin &&
 	git rev-parse origin/master &&
 	test_must_fail git rev-parse origin/fake-remote &&
-	test_must_fail git rev-parse sometag
+	git rev-parse sometag
 '
 
-test_expect_success 'fetch --prune --tags with branch does not delete other remote-tracking branches' '
+test_expect_success 'fetch --prune --tags with branch does not prune other things' '
 	cd "$D" &&
 	git clone . prune-tags-branch &&
 	cd prune-tags-branch &&
@@ -137,7 +137,7 @@ test_expect_success 'fetch --prune --tags with branch does not delete other remo
 
 	git fetch --prune --tags origin master &&
 	git rev-parse origin/extrabranch &&
-	test_must_fail git rev-parse sometag
+	git rev-parse sometag
 '
 
 test_expect_success 'fetch --prune --tags with refspec prunes based on refspec' '
@@ -151,7 +151,7 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
 	git fetch --prune --tags origin refs/heads/foo/*:refs/remotes/origin/foo/* &&
 	test_must_fail git rev-parse refs/remotes/origin/foo/otherbranch &&
 	git rev-parse origin/extrabranch &&
-	test_must_fail git rev-parse sometag
+	git rev-parse sometag
 '
 
 test_expect_success 'fetch tags when there is no tags' '
-- 
1.8.4
