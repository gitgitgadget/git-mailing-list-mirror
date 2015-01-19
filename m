From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] transport-helper: do not request symbolic refs to remote helpers
Date: Mon, 19 Jan 2015 10:35:07 +0900
Message-ID: <1421631307-20669-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 02:35:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YD1FZ-00037w-S2
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 02:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbbASBfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 20:35:25 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:47594 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbbASBfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 20:35:24 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YD1FD-0005O0-Gf; Mon, 19 Jan 2015 10:35:07 +0900
X-Mailer: git-send-email 2.2.2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262608>

A typical remote helper will return a `list` of refs containing a symbolic
ref HEAD, pointing to, e.g. refs/heads/master. In the case of a clone, all
the refs are being requested through `fetch` or `import`, including the
symbolic ref.

While this works properly, in some cases of a fetch, like `git fetch url`
or `git fetch origin HEAD`, or any fetch command involving a symbolic ref
without also fetching the corresponding ref it points to, the fetch command
fails with:

  fatal: bad object 0000000000000000000000000000000000000000
  error: <remote> did not send all necessary objects

(in the case the remote helper returned '?' values to the `list` command).

This is because there is only one ref given to fetch(), and it's not
further resolved to something at the end of fetch_with_import().

While this can be somehow handled in the remote helper itself, by adding
a refspec for the symbolic ref, and storing an explicit ref in a private
namespace, and then handling the `import` for that symbolic ref
specifically, very few existing remote helpers are actually doing that.

So, instead of requesting the exact list of wanted refs to remote helpers,
treat symbolic refs differently and request the ref they point to instead.
Then, resolve the symbolic refs values based on the pointed ref.
This assumes there is no more than one level of indirection (a symbolic
ref doesn't point to another symbolic ref).

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 git-remote-testgit.sh     |  8 +++++++-
 t/t5801-remote-helpers.sh | 24 ++++++++++++++++++++++++
 transport-helper.c        | 13 ++++++++-----
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index a9c75a2..752c763 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -1,7 +1,13 @@
 #!/bin/sh
 # Copyright (c) 2012 Felipe Contreras
 
-alias=$1
+# The first argument can be a url when the fetch/push command was a url
+# instead of a configured remote. In this case, use a generic alias.
+if test "$1" = "testgit::$2"; then
+	alias=_
+else
+	alias=$1
+fi
 url=$2
 
 dir="$GIT_DIR/testgit/$alias"
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 2419407..c9d3ed1 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -281,4 +281,28 @@ test_expect_success 'push messages' '
 	)
 '
 
+test_expect_success 'fetch HEAD' '
+	(cd server &&
+	git checkout master &&
+	echo more >>file &&
+	git commit -a -m more
+	) &&
+	(cd local &&
+	git fetch origin HEAD
+	) &&
+	compare_refs server HEAD local FETCH_HEAD
+'
+
+test_expect_success 'fetch url' '
+	(cd server &&
+	git checkout master &&
+	echo more >>file &&
+	git commit -a -m more
+	) &&
+	(cd local &&
+	git fetch "testgit::${PWD}/../server"
+	) &&
+	compare_refs server HEAD local FETCH_HEAD
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 0224687..27c82f7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -356,7 +356,8 @@ static int fetch_with_fetch(struct transport *transport,
 			continue;
 
 		strbuf_addf(&buf, "fetch %s %s\n",
-			    sha1_to_hex(posn->old_sha1), posn->name);
+			    sha1_to_hex(posn->old_sha1),
+			    posn->symref ? posn->symref : posn->name);
 	}
 
 	strbuf_addch(&buf, '\n');
@@ -454,7 +455,8 @@ static int fetch_with_import(struct transport *transport,
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
 
-		strbuf_addf(&buf, "import %s\n", posn->name);
+		strbuf_addf(&buf, "import %s\n",
+			    posn->symref ? posn->symref : posn->name);
 		sendline(data, &buf);
 		strbuf_reset(&buf);
 	}
@@ -487,14 +489,15 @@ static int fetch_with_import(struct transport *transport,
 	 * fast-forward or this is a forced update.
 	 */
 	for (i = 0; i < nr_heads; i++) {
-		char *private;
+		char *private, *name;
 		posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
+		name = posn->symref ? posn->symref : posn->name;
 		if (data->refspecs)
-			private = apply_refspecs(data->refspecs, data->refspec_nr, posn->name);
+			private = apply_refspecs(data->refspecs, data->refspec_nr, name);
 		else
-			private = xstrdup(posn->name);
+			private = xstrdup(name);
 		if (private) {
 			read_ref(private, posn->old_sha1);
 			free(private);
-- 
2.2.2.dirty
