From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 00:04:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908232320410.6044@xanadu.home>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 24 06:04:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfQnA-0008QS-96
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 06:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbZHXEEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 00:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbZHXEEN
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 00:04:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29745 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbZHXEEN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 00:04:13 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOV00BHS4MXMU70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 24 Aug 2009 00:04:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0908220106470.6044@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126901>

If all refs sent by the remote repo during a fetch are reachable 
locally, then no further conversation is performed with the remote. This 
check is skipped when the --depth argument is provided to allow the 
deepening of a shallow clone which corresponding remote repo has no 
changed.

However, some additional filtering was added in commit c29727d5 to 
remove those refs which are equal on both sides.  If the remote repo has 
not changed, then the list of refs to give the remote process becomes 
empty and simply attempting to deepen a shallow repo always fails.

Let's stop being smart in that case and simply send the whole list over
when that condition is met.  The remote will do the right thing anyways.

Test cases for this issue are also provided.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Sat, 22 Aug 2009, Nicolas Pitre wrote:

> try out:
> 
> 	git clone --depth=1 git://git.kernel.org/pub/scm/git/git
> 	cd git
> 	git fetch --depth=2
> 
> It then silently fails, except for the return code of 1.

Here's the fix.  Problem wasn't in builtin-fetch-pack.c after all.

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index a8c2ca2..18376d6 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -139,6 +139,36 @@ test_expect_success 'fsck in shallow repo' '
 	)
 '
 
+test_expect_success 'simple fetch in shallow repo' '
+	(
+		cd shallow &&
+		git fetch
+	)
+'
+
+test_expect_success 'no changes expected' '
+	(
+		cd shallow &&
+		git count-objects -v
+	) > count.shallow.2 &&
+	cmp count.shallow count.shallow.2
+'
+
+test_expect_success 'fetch same depth in shallow repo' '
+	(
+		cd shallow &&
+		git fetch --depth=2
+	)
+'
+
+test_expect_success 'no changes expected' '
+	(
+		cd shallow &&
+		git count-objects -v
+	) > count.shallow.3 &&
+	cmp count.shallow count.shallow.3
+'
+
 test_expect_success 'add two more' '
 	add B66 $B65 &&
 	add B67 $B66
@@ -201,4 +231,21 @@ test_expect_success 'pull in shallow repo with missing merge base' '
 	)
 '
 
+test_expect_success 'additional simple shallow deepenings' '
+	(
+		cd shallow &&
+		git fetch --depth=8 &&
+		git fetch --depth=10 &&
+		git fetch --depth=11
+	)
+'
+
+test_expect_success 'clone shallow object count' '
+	(
+		cd shallow &&
+		git count-objects -v
+	) > count.shallow &&
+	grep "^count: 52" count.shallow
+'
+
 test_done
diff --git a/transport.c b/transport.c
index a8df319..ce91387 100644
--- a/transport.c
+++ b/transport.c
@@ -925,11 +925,12 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
 int transport_fetch_refs(struct transport *transport, const struct ref *refs)
 {
 	int rc;
-	int nr_heads = 0, nr_alloc = 0;
+	int nr_heads = 0, nr_alloc = 0, nr_refs = 0;
 	const struct ref **heads = NULL;
 	const struct ref *rm;
 
 	for (rm = refs; rm; rm = rm->next) {
+		nr_refs++;
 		if (rm->peer_ref &&
 		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
 			continue;
@@ -937,6 +938,19 @@ int transport_fetch_refs(struct transport *transport, const struct ref *refs)
 		heads[nr_heads++] = rm;
 	}
 
+	if (!nr_heads) {
+		/*
+		 * When deepening of a shallow repository is requested,
+		 * then local and remote refs are likely to still be equal.
+		 * Just feed them all to the fetch method in that case.
+		 * This condition shouldn't be met in a non-deepening fetch
+		 * (see builtin-fetch.c:quickfetch()).
+		 */
+		heads = xmalloc(nr_refs * sizeof(*heads));
+		for (rm = refs; rm; rm = rm->next)
+			heads[nr_heads++] = rm;
+	}
+
 	rc = transport->fetch(transport, nr_heads, heads);
 	free(heads);
 	return rc;
