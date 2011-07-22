From: Jeff King <peff@peff.net>
Subject: Re: [REGRESSION, BISECTED] `git checkout <branch>` started to be
 memory hog
Date: Fri, 22 Jul 2011 14:36:14 -0600
Message-ID: <20110722203614.GA13232@sigill.intra.peff.net>
References: <20110722130518.GA9873@tugrik.mns.mnsspb.ru>
 <20110722170001.GB20700@sigill.intra.peff.net>
 <7vipquz0d0.fsf@alter.siamese.dyndns.org>
 <20110722173601.GA9422@sigill.intra.peff.net>
 <7vaac6ysd2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Smelkov <kirr@mns.spb.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 22:36:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkMSO-0002hU-A1
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 22:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117Ab1GVUgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 16:36:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42363
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096Ab1GVUgT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 16:36:19 -0400
Received: (qmail 23040 invoked by uid 107); 22 Jul 2011 20:36:47 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 16:36:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 14:36:14 -0600
Content-Disposition: inline
In-Reply-To: <7vaac6ysd2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177665>

On Fri, Jul 22, 2011 at 01:26:17PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Did you want me to write a commit message? I think you might do a better
> > job of writing a coherent one for this particular patch.
> 
> I didn't do a very good job.

How about:

-- >8 --
Subject: [PATCH] streaming: free git_istream upon closing

Kirill Smelkov noticed that post-1.7.6 "git checkout"
started leaking tons of memory. The streaming_write_entry
function properly calls close_istream(), but that function
did not actually free() the allocated git_istream struct.

The git_istream struct is totally opaque to calling code,
and must be heap-allocated by open_istream. Therefore it's
not appropriate for callers to have to free it.

This patch makes close_istream() into "close and de-allocate
all associated resources". We could add a new "free_istream"
call, but there's not much point in letting callers inspect
the istream after close. And this patch's semantics make us
match fopen/fclose, which is well-known and understood.

Signed-off-by: Jeff King <peff@peff.net>
---
 streaming.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/streaming.c b/streaming.c
index 565f000..f3acc5d 100644
--- a/streaming.c
+++ b/streaming.c
@@ -93,7 +93,9 @@ struct git_istream {
 
 int close_istream(struct git_istream *st)
 {
-	return st->vtbl->close(st);
+	int r = st->vtbl->close(st);
+	free(st);
+	return r;
 }
 
 ssize_t read_istream(struct git_istream *st, char *buf, size_t sz)
-- 
1.7.6.rc1.12.g65e2
