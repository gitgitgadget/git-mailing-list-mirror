From: Jeff King <peff@peff.net>
Subject: [PATCH] dumb-http: do not pass NULL path to parse_pack_index
Date: Tue, 27 Jan 2015 15:02:27 -0500
Message-ID: <20150127200226.GA19618@peff.net>
References: <1422372041-16474-1-git-send-email-charles@hashpling.org>
 <20150127181220.GA17067@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 21:02:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGCLK-0002Ru-2O
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 21:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbbA0UCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 15:02:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:42454 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751020AbbA0UC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 15:02:28 -0500
Received: (qmail 9807 invoked by uid 102); 27 Jan 2015 20:02:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Jan 2015 14:02:28 -0600
Received: (qmail 3935 invoked by uid 107); 27 Jan 2015 20:02:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Jan 2015 15:02:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jan 2015 15:02:27 -0500
Content-Disposition: inline
In-Reply-To: <20150127181220.GA17067@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263085>

On Tue, Jan 27, 2015 at 01:12:20PM -0500, Jeff King wrote:

> It looks like the culprit is 7b64469 (Allow parse_pack_index on
> temporary files, 2010-04-19). It added a new "idx_path" parameter to
> parse_pack_index, which we pass as NULL.  That causes its call to
> check_packed_git_idx to fail (because it has no idea what file we are
> talking about!).

This is not quite right. That refactoring commit correctly passes the
result of sha1_pack_index_name() for the newly-added parameter. It's the
_next_ commit which then erroneously passes NULL. :)

Here's my fix with a proper commit message. I tweaked the title on your
test, as I didn't find the original very descriptive. I also bumped the
call to sha1_pack_index_name() into the caller, as that makes more sense
to me after reading the older commits (and there are literally no other
callers outside of this function).

-- >8 --
Once upon a time, dumb http always fetched .idx files
directly into their final location, and then checked their
validity with parse_pack_index. This was refactored in
commit 750ef42 (http-fetch: Use temporary files for
pack-*.idx until verified, 2010-04-19), which uses the
following logic:

  1. If we have the idx already in place, see if it's
     valid (using parse_pack_index). If so, use it.

  2. Otherwise, fetch the .idx to a tempfile, check
     that, and if so move it into place.

  3. Either way, fetch the pack itself if necessary.

However, it got step 1 wrong. We pass a NULL path parameter
to parse_pack_index, so an existing .idx file always looks
broken. Worse, we do not treat this broken .idx as an
opportunity to re-fetch, but instead return an error,
ignoring the pack entirely. This can lead to a dumb-http
fetch failing to retrieve the necessary objects.

This doesn't come up much in practice, because it must be a
packfile that we found out about (and whose .idx we stored)
during an earlier dumb-http fetch, but whose packfile we
_didn't_ fetch. I.e., we did a partial clone of a
repository, didn't need some packfiles, and now a followup
fetch needs them.

Discovery and tests by Charles Bailey <charles@hashpling.org>.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm happy to flip the authorship on this. You have more lines in it than
I do. :)

As I mentioned before, I think we could treat a broken .idx file
differently (by deleting and refetching), but I doubt it matters in
practice. The only reason this came up at all is that our test for
"broken" was bogus, and it may be better to let a user diagnose and
deal with breakage.

 http.c                     |  2 +-
 t/t5550-http-fetch-dumb.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 040f362..f2373c0 100644
--- a/http.c
+++ b/http.c
@@ -1240,7 +1240,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	int ret;
 
 	if (has_pack_index(sha1)) {
-		new_pack = parse_pack_index(sha1, NULL);
+		new_pack = parse_pack_index(sha1, sha1_pack_index_name(sha1));
 		if (!new_pack)
 			return -1; /* parse_pack_index() already issued error message */
 		goto add_pack;
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ac71418..6da9422 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -165,6 +165,24 @@ test_expect_success 'fetch notices corrupt idx' '
 	)
 '
 
+test_expect_success 'fetch can handle previously-fetched .idx files' '
+	git checkout --orphan branch1 &&
+	echo base >file &&
+	git add file &&
+	git commit -m base &&
+	git --bare init "$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git &&
+	git push "$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git branch1 &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git repack -d &&
+	git checkout -b branch2 branch1 &&
+	echo b2 >>file &&
+	git commit -a -m b2 &&
+	git push "$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git branch2 &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git repack -d &&
+	git --bare init clone_packed_branches.git &&
+	git --git-dir=clone_packed_branches.git fetch "$HTTPD_URL"/dumb/repo_packed_branches.git branch1:branch1 &&
+	git --git-dir=clone_packed_branches.git fetch "$HTTPD_URL"/dumb/repo_packed_branches.git branch2:branch2
+'
+
 test_expect_success 'did not use upload-pack service' '
 	grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act
 	: >exp
-- 
2.3.0.rc1.287.g761fd19
