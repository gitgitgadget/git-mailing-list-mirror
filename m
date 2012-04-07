From: Jeff King <peff@peff.net>
Subject: rs/commit-list-sort-in-batch
Date: Sat, 7 Apr 2012 03:27:25 -0400
Message-ID: <20120407072724.GA818@sigill.intra.peff.net>
References: <7vwr5szi7z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 09:27:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGQ3Y-0000VF-Pb
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 09:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087Ab2DGH11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 03:27:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53197
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab2DGH11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 03:27:27 -0400
Received: (qmail 20523 invoked by uid 107); 7 Apr 2012 07:27:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Apr 2012 03:27:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Apr 2012 03:27:25 -0400
Content-Disposition: inline
In-Reply-To: <7vwr5szi7z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194938>

On Fri, Apr 06, 2012 at 02:02:56PM -0700, Junio C Hamano wrote:

> * rs/commit-list-sort-in-batch (2012-04-02) 3 commits
>  - revision: insert unsorted, then sort in prepare_revision_walk()
>  - commit: use mergesort() in commit_list_sort_by_date()
>  - add mergesort() for linked lists

Looks like you applied these patches right on v1.7.9. However, they need
Thomas's 5e8617f to compile, which comes later. There's no textual
conflict, but test-mergesort.c need strbuf_getwholeline_fd, which is
made public by 5e8617f.

However, I don't think there's any reason to prefer the fd version over
the stdio one (in fact, it is much less efficient). So this could be
squashed in to the first patch instead of rebasing:

diff --git a/test-mergesort.c b/test-mergesort.c
index 02441ab..1dd82fd 100644
--- a/test-mergesort.c
+++ b/test-mergesort.c
@@ -28,7 +28,7 @@ int main(int argc, const char **argv)
 	struct strbuf sb = STRBUF_INIT;
 
 	for (;;) {
-		if (strbuf_getwholeline_fd(&sb, 0, '\n'))
+		if (strbuf_getwholeline(&sb, stdin, '\n'))
 			break;
 		line = xmalloc(sizeof(struct line));
 		line->text = strbuf_detach(&sb, NULL);

-Peff
