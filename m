From: Jeff King <peff@peff.net>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 06:24:22 -0400
Message-ID: <20130319102422.GB6341@sigill.intra.peff.net>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
 <20130316114118.GA1940@sigill.intra.peff.net>
 <87fvzrajmr.fsf@pctrast.inf.ethz.ch>
 <20130319093034.GA29997@sigill.intra.peff.net>
 <20130319095943.GA6031@sigill.intra.peff.net>
 <20130319100800.GA6341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:24:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHtiy-00032A-CV
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424Ab3CSKY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:24:28 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58164 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756262Ab3CSKY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:24:27 -0400
Received: (qmail 27221 invoked by uid 107); 19 Mar 2013 10:26:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 06:26:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 06:24:22 -0400
Content-Disposition: inline
In-Reply-To: <20130319100800.GA6341@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218495>

On Tue, Mar 19, 2013 at 06:08:00AM -0400, Jeff King wrote:

> @@ -538,6 +539,8 @@ static void resolve_delta(struct object_entry *delta_obj,
>  
>  	delta_obj->real_type = base->obj->real_type;
>  	delta_obj->delta_depth = base->obj->delta_depth + 1;
> +	if (deepest_delta < delta_obj->delta_depth)
> +		deepest_delta = delta_obj->delta_depth;
>  	delta_obj->base_object_no = base->obj - objects;
>  	delta_data = get_data_from_pack(delta_obj);
>  	base_data = get_base_data(base);
> 
> and valgrind reports an uninitialized value in the conditional. But we
> can see that deepest_delta is static, and therefore always has some
> value. And delta_obj->delta_depth is set in the line above. So both
> should have some known value, unless they are computed from unknown
> values. In that case, shouldn't valgrind have previously noticed when we
> accessed those unknown values?

Ah, indeed. Putting:

  fprintf(stderr, "%lu\n", base->obj->delta_depth);

before the conditional reveals that base->obj->delta_depth is
uninitialized, which is the real problem. I'm sure there is some
perfectly logical explanation for why valgrind can't detect its use
during the assignment, but I'm not sure what it is.

At any rate, doing this:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ed4c3bb..73686af 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -538,6 +538,8 @@ static void resolve_delta(struct object_entry *delta_obj,
 	void *base_data, *delta_data;
 
 	delta_obj->real_type = base->obj->real_type;
+	if (!is_delta_type(base->obj->type))
+		base->obj->delta_depth = 0;
 	delta_obj->delta_depth = base->obj->delta_depth + 1;
 	if (deepest_delta < delta_obj->delta_depth)
 		deepest_delta = delta_obj->delta_depth;

makes the warning go away. It looks like the delta_depth value was
introduced in 38a4556 (index-pack: start learning to emulate
"verify-pack -v", 2011-06-03), and it used only for showing the chain
depths with --verify-stat. So it is almost certainly not related to
Stefan's original problem, but it does mean we've probably been
computing bogus chain lengths.

There may be a more reasonable place to set base->obj->delta_depth than
right here; I'll see if I can cook up a real patch.

-Peff
