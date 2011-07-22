From: Jeff King <peff@peff.net>
Subject: Re: [REGRESSION, BISECTED] `git checkout <branch>` started to be
 memory hog
Date: Fri, 22 Jul 2011 11:00:03 -0600
Message-ID: <20110722170001.GB20700@sigill.intra.peff.net>
References: <20110722130518.GA9873@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Jul 22 19:00:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkJ5K-0001QJ-Ct
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 19:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab1GVRAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 13:00:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52814
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab1GVRAP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 13:00:15 -0400
Received: (qmail 21349 invoked by uid 107); 22 Jul 2011 17:00:38 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 13:00:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 11:00:03 -0600
Content-Disposition: inline
In-Reply-To: <20110722130518.GA9873@tugrik.mns.mnsspb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177648>

On Fri, Jul 22, 2011 at 05:05:18PM +0400, Kirill Smelkov wrote:

> It turned out that with Git v1.7.6 memory usage for git-checkout
> linux-3.0.y as seen in top is
> 
>     VIRTmax     RESmax
> 
>     ~338M       ~247M
> 
> and for master
> 
>     VIRTmax     RESmax
>     (both till not killed)
>    ~2200M       ~1000M
> 
> 
> i.e. it looks like when residential memory usage approaches the amount of
> physical RAM, the OOM killer comes into play.
> 
> 
> And I've bisected this to b6691092 ("Add streaming filter API"; Junio C
> Hamano, May 20 2011; merged to next on Jun 30 2011):

Hmm, that series was supposed to _reduce_ memory usage. :)

According to valgrind, we are leaking gigabytes of memory allocated in
git_istream buffers:

  $ cd linux-2.6
  $ rm -vrf *
  $ valgrind --leak-check=full git checkout -f
  [...]
  2,418,940,448 (1,163,660,832 direct, 1,255,279,616 indirect) bytes in 35,271
        blocks are definitely lost in loss record 81 of 81
     at 0x4C2780D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
     by 0x517C62: xmalloc (wrapper.c:35)
     by 0x503112: attach_stream_filter (streaming.c:255)
     by 0x502D61: open_istream (streaming.c:152)
     by 0x4B1B7A: streaming_write_entry (entry.c:130)
     by 0x4B1E0B: write_entry (entry.c:193)
     by 0x4B23F4: checkout_entry (entry.c:318)
     by 0x511DA4: check_updates (unpack-trees.c:223)
     by 0x513D72: unpack_trees (unpack-trees.c:1125)
     by 0x41CCB4: reset_tree (checkout.c:333)
     by 0x41CE32: merge_working_tree (checkout.c:378)
     by 0x41DE6A: switch_branches (checkout.c:737)

This malloc is for the actual git_istream struct. It seems that we never
actually free it when calling close_istream(). And these structs are
quite big; they contain 32K of filter buffers inside a union.

>From my quick look, I came up with the fix below. It removes the leak
and doesn't trigger any memory errors according to valgrind. So it
_must_ be right. :)

-Peff

---
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
