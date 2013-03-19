From: Jeff King <peff@peff.net>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 06:08:00 -0400
Message-ID: <20130319100800.GA6341@sigill.intra.peff.net>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
 <20130316114118.GA1940@sigill.intra.peff.net>
 <87fvzrajmr.fsf@pctrast.inf.ethz.ch>
 <20130319093034.GA29997@sigill.intra.peff.net>
 <20130319095943.GA6031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:08:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHtTC-0008Nl-2z
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138Ab3CSKIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:08:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58144 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab3CSKIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:08:05 -0400
Received: (qmail 27064 invoked by uid 107); 19 Mar 2013 10:09:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 06:09:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 06:08:00 -0400
Content-Disposition: inline
In-Reply-To: <20130319095943.GA6031@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218494>

On Tue, Mar 19, 2013 at 05:59:43AM -0400, Jeff King wrote:

> > Yes, that has been my experience with valgrind false positives, too. But
> > if this is a real problem, it may be different from the OP's issue. It
> > seems to trigger for me in v1.7.10, before Duy's threading patches. It
> > does not seem to be in v1.7.5. I'm bisecting now.
> 
> Hmph. It bisects to Junio's d1a0ed1 (index-pack: show histogram when
> emulating "verify-pack -v", 2011-06-03), which introduces those lines.
> The deepest_delta variable is static, so by definition it is always
> initialized to something. So I guess some objects may not have
> delta_depth set. Still looking.

I'm doubly confused now. The commit in question introduces this:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index aa3c9c6..ed4c3bb 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -70,6 +70,7 @@ static off_t consumed_bytes;
 static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
+static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
@@ -538,6 +539,8 @@ static void resolve_delta(struct object_entry *delta_obj,
 
 	delta_obj->real_type = base->obj->real_type;
 	delta_obj->delta_depth = base->obj->delta_depth + 1;
+	if (deepest_delta < delta_obj->delta_depth)
+		deepest_delta = delta_obj->delta_depth;
 	delta_obj->base_object_no = base->obj - objects;
 	delta_data = get_data_from_pack(delta_obj);
 	base_data = get_base_data(base);

and valgrind reports an uninitialized value in the conditional. But we
can see that deepest_delta is static, and therefore always has some
value. And delta_obj->delta_depth is set in the line above. So both
should have some known value, unless they are computed from unknown
values. In that case, shouldn't valgrind have previously noticed when we
accessed those unknown values?

-Peff
