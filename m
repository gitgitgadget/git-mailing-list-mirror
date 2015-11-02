From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http.c: use CURLOPT_RANGE for range requests
Date: Mon, 2 Nov 2015 17:10:27 -0500
Message-ID: <20151102221027.GA13996@sigill.intra.peff.net>
References: <1446492986-32350-1-git-send-email-dturner@twopensource.com>
 <20151102201831.GA10722@sigill.intra.peff.net>
 <87mvuwcbql.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 23:10:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtNJC-0006zR-FL
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 23:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbbKBWKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 17:10:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:51696 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751845AbbKBWKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 17:10:30 -0500
Received: (qmail 18878 invoked by uid 102); 2 Nov 2015 22:10:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 16:10:30 -0600
Received: (qmail 17775 invoked by uid 107); 2 Nov 2015 22:10:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 17:10:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Nov 2015 17:10:27 -0500
Content-Disposition: inline
In-Reply-To: <87mvuwcbql.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280728>

On Mon, Nov 02, 2015 at 10:50:10PM +0100, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   4. Fix all of the callers. I suspect this would involve calling
> >      fstat(fileno(fh)) to get a real off_t.
> 
> You can also use ftello which returns off_t.

Thanks, I forgot about that function. That would probably be the sanest
path forward.

I think it is as simple as this (on top of David's patch):

-- >8 --
Subject: [PATCH] http: use off_t to store partial file size

When we try to resume transfer of a partially-downloaded
object or pack, we fopen() the existing file for append,
then use ftell() to get the current position. We use a
"long", which can hold only 2GB on a 32-bit system, even
though packfiles may be larger than that.

Let's switch to using off_t, which should hold any file size
our system is capable of storing. We need to use ftello() to
get the off_t. This is in POSIX and hopefully available
everywhere; if not, we should be able to wrap it by falling
back to ftell(), which would presumably return "-1" on such
a large file (and we would simply skip resuming in that case).

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 5f36846..42f29ce 100644
--- a/http.c
+++ b/http.c
@@ -1205,7 +1205,7 @@ static int http_request(const char *url,
 		curl_easy_setopt(slot->curl, CURLOPT_FILE, result);
 
 		if (target == HTTP_REQUEST_FILE) {
-			long posn = ftell(result);
+			off_t posn = ftello(result);
 			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
 					 fwrite);
 			if (posn > 0)
@@ -1581,7 +1581,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url)
 {
-	long prev_posn = 0;
+	off_t prev_posn = 0;
 	struct strbuf buf = STRBUF_INIT;
 	struct http_pack_request *preq;
 
@@ -1613,7 +1613,7 @@ struct http_pack_request *new_http_pack_request(
 	 * If there is data present from a previous transfer attempt,
 	 * resume where it left off
 	 */
-	prev_posn = ftell(preq->packfile);
+	prev_posn = ftello(preq->packfile);
 	if (prev_posn>0) {
 		if (http_is_verbose)
 			fprintf(stderr,
@@ -1668,7 +1668,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	int prevlocal;
 	char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read = 0;
-	long prev_posn = 0;
+	off_t prev_posn = 0;
 	struct http_object_request *freq;
 
 	freq = xcalloc(1, sizeof(*freq));
-- 
2.6.2.627.g377c1c5
