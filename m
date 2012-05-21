From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 13:45:25 -0400
Message-ID: <20120521174525.GA22643@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 21 19:46:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWWgg-0007BE-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 19:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019Ab2EURpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 13:45:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50969
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932986Ab2EURpa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 13:45:30 -0400
Received: (qmail 4152 invoked by uid 107); 21 May 2012 17:45:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 13:45:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 13:45:25 -0400
Content-Disposition: inline
In-Reply-To: <4FB9F92D.8000305@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198119>

On Mon, May 21, 2012 at 10:13:33AM +0200, Michael Haggerty wrote:

> I just noticed that the remove_duplicates() function in
> builtin/fetch-pack.c is O(N^2) in the number of heads.  Empirically,
> this function takes on the order of 25 seconds to process 100k
> references.
> 
> I know that 100k heads is kindof absurd.  Perhaps handling this many
> heads is unrealistic for other reasons.  But I vaguely recall numbers
> like this being mentioned on the mailing list.

The rails/rails network repository at GitHub (i.e., a master repo with
all of the objects and refs for all of the forks) has about 400K refs,
and has been the usual impetus for me finding and fixing these sorts of
quadratic problems.

I've never triggered this one, though, because it relies not just on
having a repo with a lot of refs, but actually fetching all of them at
one time (which we don't tend to do).

But it would be nice to fix it. There is a similar case in filter_refs,
which I mentioned here:

  http://article.gmane.org/gmane.comp.version-control.git/186994

> It would be pretty trivial to reduce the work to O(N) by using a hash
> set to keep track of the references that have already been seen.

I don't think there is any reason we can't sort the list of heads, and
then we can get rid of the duplicates with an O(n) traversal, like the
(largely untested) patch below.

> I don't plan to work on this, but I thought I would point it out in
> case it is causing somebody pain.

I'll clean up the patch and make one for the filter_refs case, too.

-Peff

---
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index b6cc75e..7efcf2f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -859,25 +859,23 @@ static struct ref *do_fetch_pack(int fd[2],
 	return ref;
 }
 
+static int compare_heads(const void *a, const void *b)
+{
+	return strcmp(*(const char **)a, *(const char **)b);
+}
+
 static int remove_duplicates(int nr_heads, char **heads)
 {
 	int src, dst;
 
-	for (src = dst = 0; src < nr_heads; src++) {
-		/* If heads[src] is different from any of
-		 * heads[0..dst], push it in.
-		 */
-		int i;
-		for (i = 0; i < dst; i++) {
-			if (!strcmp(heads[i], heads[src]))
-				break;
-		}
-		if (i < dst)
-			continue;
-		if (src != dst)
-			heads[dst] = heads[src];
-		dst++;
-	}
+	if (!nr_heads)
+		return 0;
+
+	qsort(heads, nr_heads, sizeof(*heads), compare_heads);
+
+	for (src = dst = 1; src < nr_heads; src++)
+		if (strcmp(heads[src], heads[dst-1]))
+			heads[dst++] = heads[src];
 	return dst;
 }
 
