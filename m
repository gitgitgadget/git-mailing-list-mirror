From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/18] http*: add http_get_info_packs
Date: Sun, 24 May 2009 13:43:56 -0700
Message-ID: <7veiuetenn.fsf@alter.siamese.dyndns.org>
References: <20090524222003.7da46ff8.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 22:44:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8KYB-0002Ux-09
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 22:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbZEXUn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 16:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbZEXUnz
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 16:43:55 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49204 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350AbZEXUnz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 16:43:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524204356.LIJG18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 May 2009 16:43:56 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id vYjw1b0024aMwMQ03Yjw1h; Sun, 24 May 2009 16:43:56 -0400
X-Authority-Analysis: v=1.0 c=1 a=wUcf7ORwkrMA:10 a=S8WAbUr2HrsA:10
 a=pGLkceISAAAA:8 a=H3olKTBrAvWzWKuA0_0A:9 a=HP3vJ0YqcPbrZao0Wo4A:7
 a=WD4oCHXQ0ta7fwgUZGdMPVcqi5wA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119855>

Tay Ray Chuan <rctay89@gmail.com> writes:

> fetch_index has been moved to http.c, and is not meant to be used
> outside of http.c. It invokes end_url_with_slash with base_url;
> apart from that change, the code is identical.

Move fetch_index() to http.c; this is not meant to be ...

> setup_index has been moved and renamed to fetch_http_pack_index.

Move setup_index() to http.c, and rename it to fetch_http_pack_index(), as
it now is a library function and there are many other kinds of "index" in
git.

It makes me wonder if fetch_index(), even though it is static to http.c,
should be renamed somehow to reduce confusion between it and
fetch_http_pack_index().

You have decl-after-statement and a handful of variable that are no longer
used.  Please squash this in when rerolling.

 http-push.c   |    2 --
 http-walker.c |    1 -
 http.c        |   10 +++-------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/http-push.c b/http-push.c
index b96d7db..74bb48e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -952,8 +952,6 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 
 static int fetch_indices(void)
 {
-	struct slot_results results;
-
 	if (push_verbosely)
 		fprintf(stderr, "Getting pack list\n");
 
diff --git a/http-walker.c b/http-walker.c
index 2aed391..c550fd9 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -567,7 +567,6 @@ static void fetch_alternates(struct walker *walker, const char *base)
 static int fetch_indices(struct walker *walker, struct alt_base *repo)
 {
 	int ret = 0;
-	struct slot_results results;
 
 	if (repo->got_indices)
 		return 0;
diff --git a/http.c b/http.c
index ea46075..c74fa26 100644
--- a/http.c
+++ b/http.c
@@ -914,10 +914,10 @@ int fetch_http_pack_index(struct packed_git **packs_head, unsigned char *sha1,
 
 int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 {
-	int ret = 0;
-	char *url;
+	int ret = 0, i = 0;
+	char *url, *data;
 	struct strbuf buf = STRBUF_INIT;
-	struct http_info_packs_request *req;
+	unsigned char sha1[20];
 
 	end_url_with_slash(&buf, base_url);
 	strbuf_addstr(&buf, "objects/info/packs");
@@ -927,10 +927,6 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 	if (ret != HTTP_OK)
 		goto cleanup;
 
-	char *data;
-	int i = 0;
-	unsigned char sha1[20];
-
 	data = buf.buf;
 	while (i < buf.len) {
 		switch (data[i]) {
