From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/23] fetch --prune: prune only based on explicit refspecs
Date: Wed, 30 Oct 2013 06:33:00 +0100
Message-ID: <1383111192-23780-12-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXQ-0007TT-GJ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab3J3Flq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:46 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48310 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753121Ab3J3Flp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:45 -0400
X-AuditID: 1207440e-b7fbc6d000004ad9-ee-52709a5937a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.0E.19161.95A90725; Wed, 30 Oct 2013 01:34:17 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIM014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:15 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqBs5qyDIoOGnksX0rtUsFl1Xupks
	GnqvMFvMu7uLyWLVrWXMFitn3GC0uL1iPrPF085Ki3kvXrBZ/GjpYXbg8vj7/gOTx6V1L5k8
	Dv2Zwu7x7EQ7m8ell9/ZPJ717mH0uHhJ2WNGy2sWj8+b5DwOXH7MFsAVxW2TlFhSFpyZnqdv
	l8Cd8ff0f6aCr3YV32b8ZGtgvGrUxcjJISFgIrF/92w2CFtM4sK99UA2F4eQwGVGifdnrjOC
	JIQErjBJXD2lA2KzCehKLOppZgKxRQTUJCa2HWIBaWAWmMgscXz6IhaQhLCAn0TvrkfMXYwc
	HCwCqhLn+tJBTF4BV4knp4UgdilI3GieygpicwKFP+26yQ6xykWiqf0z+wRG3gWMDKsY5RJz
	SnN1cxMzc4pTk3WLkxPz8lKLdI31cjNL9FJTSjcxQkKWbwdj+3qZQ4wCHIxKPLwGD/KDhFgT
	y4orcw8xSnIwKYnypk0pCBLiS8pPqcxILM6ILyrNSS0+xCjBwawkwjv9OFA5b0piZVVqUT5M
	SpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCV3km0FDBotT01Iq0zJwShDQTByeI4ALZ
	wAO0gQekkLe4IDG3ODMdougUo6KUOG8SSEIAJJFRmgc3AJZcXjGKA/0jDNHOA0xMcN2vgAYz
	AQ3ew5IHMrgkESEl1cAYf3+7k8cmnv9C/PKJVr0y9rVcvDc6QhPzPU5KfT8dIl56/oXRhzi/
	pUuKjHcxXtpVWqPoMLv/bCVTvtFd7VcaTSuvfl5cWloWe2X55CmsJt2ZrnMnZVz2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236974>

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
 Documentation/config.txt        |  4 ++--
 Documentation/fetch-options.txt | 19 ++++++++++++++-----
 builtin/fetch.c                 | 39 +++++++++------------------------------
 t/t5510-fetch.sh                | 10 +++++-----
 4 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab26963..a405806 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2087,8 +2087,8 @@ remote.<name>.vcs::
 
 remote.<name>.prune::
 	When set to true, fetching from this remote by default will also
-	remove any remote-tracking branches which no longer exist on the
-	remote (as if the `--prune` option was give on the command line).
+	remove any remote-tracking references that no longer exist on the
+	remote (as if the `--prune` option was given on the command line).
 	Overrides `fetch.prune` settings, if any.
 
 remotes.<group>::
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 921f6be..12b1d92 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -41,8 +41,14 @@ ifndef::git-pull[]
 
 -p::
 --prune::
-	After fetching, remove any remote-tracking branches which
-	no longer exist	on the remote.
+	After fetching, remove any remote-tracking references that no
+	longer exist on the remote.  Tags are not subject to pruning
+	if they are fetched only because of the default tag
+	auto-following or due to a --tags option.  However, if tags
+	are fetched due to an explicit refspec (either on the command
+	line or in the remote configuration, for example if the remote
+	was cloned with the --mirror option), then they are also
+	subject to pruning.
 endif::git-pull[]
 
 ifdef::git-pull[]
@@ -61,9 +67,12 @@ endif::git-pull[]
 ifndef::git-pull[]
 -t::
 --tags::
-	Request that all tags be fetched from the remote in addition
-	to whatever else is being fetched.  Its effect is similar to
-	that of the refspec `refs/tags/*:refs/tags/*`.
+	Fetch all tags from the remote (i.e., fetch remote tags
+	`refs/tags/*` into local tags with the same name), in addition
+	to whatever else would otherwise be fetched.  Using this
+	option alone does not subject tags to pruning, even if --prune
+	is used (though tags may be pruned anyway if they are also the
+	destination of an explicit refspec; see '--prune').
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 887fa3e..1514b90 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -850,38 +850,17 @@ static int do_fetch(struct transport *transport,
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
1.8.4.1
