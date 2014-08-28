From: Jeff King <peff@peff.net>
Subject: Re: [BUG] resolved deltas
Date: Thu, 28 Aug 2014 19:04:11 -0400
Message-ID: <20140828230411.GA20484@peff.net>
References: <53F5D98F.4040700@redhat.com>
 <53F79CE3.60803@gmx.net>
 <53F868F8.9080000@web.de>
 <20140823105640.GA6881@peff.net>
 <20140823110459.GA13087@peff.net>
 <20140823111804.GA17335@peff.net>
 <53FB66D1.709@web.de>
 <20140828220821.GA31545@peff.net>
 <20140828221518.GA18799@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:04:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN8jp-0003Rt-Nm
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 01:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbaH1XEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 19:04:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:32886 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751849AbaH1XEN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 19:04:13 -0400
Received: (qmail 4140 invoked by uid 102); 28 Aug 2014 23:04:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Aug 2014 18:04:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2014 19:04:11 -0400
Content-Disposition: inline
In-Reply-To: <20140828221518.GA18799@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256132>

On Thu, Aug 28, 2014 at 06:15:18PM -0400, Jeff King wrote:

> As I implemented, I realized that even with the mutex, I really was just
> implementing compare_and_swap (and I wrote it that way to make it more
> obvious). So if we wanted to, it would be trivial to replace the
> "claim_delta" function with a true compare-and-swap instruction if the
> compiler and processor support it.

That's something like this on top:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ed9e253..1782a46 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -897,6 +897,10 @@ static int claim_delta(struct object_entry *delta_obj,
 		       enum object_type delta_type,
 		       enum object_type base_type)
 {
+#ifdef __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4
+	return __sync_bool_compare_and_swap(&delta_obj->real_type, delta_type,
+					    base_type);
+#else
 	enum object_type old_type;
 
 	object_entry_lock();
@@ -906,6 +910,7 @@ static int claim_delta(struct object_entry *delta_obj,
 	object_entry_unlock();
 
 	return old_type == delta_type;
+#endif
 }
 
 static struct base_data *find_unresolved_deltas_1(struct base_data *base,


Though I guess gcc's __sync stuff is old, and the new C11 thing is
stdatomic.h. I guess we could support either if we can find the right
preprocessor macros (I am not even sure if the above is correct; the "4"
is for the size of the data type, but this is an enum, so we don't even
know what the right size is...).

However, the above doesn't seem to be any faster for me, so it may not
be worth the hassle.

-Peff
