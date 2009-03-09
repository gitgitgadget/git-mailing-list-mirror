From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] rsync transport: allow local paths, and fix tests
Date: Mon, 9 Mar 2009 19:44:55 +0100 (CET)
Message-ID: <e09cc21658a941d8668be0d44c1d1fee503de3ed.1236624246u.git.johannes.schindelin@gmx.de>
References: <alpine.LNX.1.00.0903091331290.19665@iabervon.org> <cover.1236624246u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 09 19:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgkTd-0008EK-EI
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 19:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbZCISnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 14:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbZCISnr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 14:43:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:42373 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752482AbZCISnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 14:43:46 -0400
Received: (qmail invoked by alias); 09 Mar 2009 18:43:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 09 Mar 2009 19:43:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185qXBXQxI5ebUyvSahawfQr9KxMjYg8jQeMvOvMs
	/g9arWvKgpaQaz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1236624246u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112732>

Earlier, the rsync tests were disabled by default, as they needed a
running rsyncd daemon.  This was only due to the limitation that our
rsync transport only allowed full URLs of the form

	rsync://<host>/<path>

Relaxing the URLs to allow

	rsync:<path>

permitted the change in the tests to run whenever rsync is available,
without requiring a fully configured and running rsyncd.

While at it, the tests were fixed so that they run in directories with a 
space in their name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5510-fetch.sh |   39 ++++++++++++++++++++-------------------
 transport.c      |   23 +++++++++++++++--------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9e679b4..bee3424 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -191,38 +191,39 @@ test_expect_success 'bundle should be able to create a full history' '
 
 '
 
-test "$TEST_RSYNC" && {
+! rsync --help > /dev/null 2> /dev/null &&
+say 'Skipping rsync tests because rsync was not found' || {
 test_expect_success 'fetch via rsync' '
 	git pack-refs &&
 	mkdir rsynced &&
-	cd rsynced &&
-	git init &&
-	git fetch rsync://127.0.0.1$(pwd)/../.git master:refs/heads/master &&
-	git gc --prune &&
-	test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
-	git fsck --full
+	(cd rsynced &&
+	 git init --bare &&
+	 git fetch "rsync:$(pwd)/../.git" master:refs/heads/master &&
+	 git gc --prune &&
+	 test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
+	 git fsck --full)
 '
 
 test_expect_success 'push via rsync' '
-	mkdir ../rsynced2 &&
-	(cd ../rsynced2 &&
+	mkdir rsynced2 &&
+	(cd rsynced2 &&
 	 git init) &&
-	git push rsync://127.0.0.1$(pwd)/../rsynced2/.git master &&
-	cd ../rsynced2 &&
-	git gc --prune &&
-	test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
-	git fsck --full
+	(cd rsynced &&
+	 git push "rsync:$(pwd)/../rsynced2/.git" master) &&
+	(cd rsynced2 &&
+	 git gc --prune &&
+	 test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
+	 git fsck --full)
 '
 
 test_expect_success 'push via rsync' '
-	cd .. &&
 	mkdir rsynced3 &&
 	(cd rsynced3 &&
 	 git init) &&
-	git push --all rsync://127.0.0.1$(pwd)/rsynced3/.git &&
-	cd rsynced3 &&
-	test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
-	git fsck --full
+	git push --all "rsync:$(pwd)/rsynced3/.git" &&
+	(cd rsynced3 &&
+	 test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
+	 git fsck --full)
 '
 }
 
diff --git a/transport.c b/transport.c
index 7bc5a55..3015ed1 100644
--- a/transport.c
+++ b/transport.c
@@ -138,6 +138,11 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 	}
 }
 
+static const char *rsync_url(const char *url)
+{
+	return prefixcmp(url, "rsync://") ? skip_prefix(url, "rsync:") : url;
+}
+
 static struct ref *get_refs_via_rsync(struct transport *transport)
 {
 	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
@@ -153,7 +158,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport)
 		die ("Could not make temporary directory");
 	temp_dir_len = temp_dir.len;
 
-	strbuf_addstr(&buf, transport->url);
+	strbuf_addstr(&buf, rsync_url(transport->url));
 	strbuf_addstr(&buf, "/refs");
 
 	memset(&rsync, 0, sizeof(rsync));
@@ -169,7 +174,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport)
 		die ("Could not run rsync to get refs");
 
 	strbuf_reset(&buf);
-	strbuf_addstr(&buf, transport->url);
+	strbuf_addstr(&buf, rsync_url(transport->url));
 	strbuf_addstr(&buf, "/packed-refs");
 
 	args[2] = buf.buf;
@@ -206,7 +211,7 @@ static int fetch_objs_via_rsync(struct transport *transport,
 	const char *args[8];
 	int result;
 
-	strbuf_addstr(&buf, transport->url);
+	strbuf_addstr(&buf, rsync_url(transport->url));
 	strbuf_addstr(&buf, "/objects/");
 
 	memset(&rsync, 0, sizeof(rsync));
@@ -285,7 +290,7 @@ static int rsync_transport_push(struct transport *transport,
 
 	/* first push the objects */
 
-	strbuf_addstr(&buf, transport->url);
+	strbuf_addstr(&buf, rsync_url(transport->url));
 	strbuf_addch(&buf, '/');
 
 	memset(&rsync, 0, sizeof(rsync));
@@ -306,7 +311,8 @@ static int rsync_transport_push(struct transport *transport,
 	args[i++] = NULL;
 
 	if (run_command(&rsync))
-		return error("Could not push objects to %s", transport->url);
+		return error("Could not push objects to %s",
+				rsync_url(transport->url));
 
 	/* copy the refs to the temporary directory; they could be packed. */
 
@@ -327,10 +333,11 @@ static int rsync_transport_push(struct transport *transport,
 	if (!(flags & TRANSPORT_PUSH_FORCE))
 		args[i++] = "--ignore-existing";
 	args[i++] = temp_dir.buf;
-	args[i++] = transport->url;
+	args[i++] = rsync_url(transport->url);
 	args[i++] = NULL;
 	if (run_command(&rsync))
-		result = error("Could not push to %s", transport->url);
+		result = error("Could not push to %s",
+				rsync_url(transport->url));
 
 	if (remove_dir_recursively(&temp_dir, 0))
 		warning ("Could not remove temporary directory %s.",
@@ -705,7 +712,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->remote = remote;
 	ret->url = url;
 
-	if (!prefixcmp(url, "rsync://")) {
+	if (!prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
-- 
1.6.2.363.g9793e
