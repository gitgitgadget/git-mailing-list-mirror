From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Mon, 25 Aug 2014 09:35:50 -0400
Message-ID: <20140825133550.GE17288@peff.net>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Arjun Sreedharan <arjun024@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 15:35:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLuRB-00075i-Bm
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 15:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbaHYNfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 09:35:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:58405 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932450AbaHYNfw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 09:35:52 -0400
Received: (qmail 12403 invoked by uid 102); 25 Aug 2014 13:35:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 08:35:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 09:35:50 -0400
Content-Disposition: inline
In-Reply-To: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255824>

On Sun, Aug 24, 2014 at 07:47:24PM +0530, Arjun Sreedharan wrote:

> diff --git a/bisect.c b/bisect.c
> index d6e851d..c96aab0 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -215,10 +215,13 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>  	}
>  	qsort(array, cnt, sizeof(*array), compare_commit_dist);
>  	for (p = list, i = 0; i < cnt; i++) {
> -		struct name_decoration *r = xmalloc(sizeof(*r) + 100);
> +		char name[100];
> +		sprintf(name, "dist=%d", array[i].distance);
> +		int name_len = strlen(name);
> +		struct name_decoration *r = xmalloc(sizeof(*r) + name_len);

This allocation should be name_len + 1 for the NUL-terminator, no?

It looks like add_name_decoration in log-tree already handles half of
what you are adding here. Can we just make that available globally (it
is manipulating the already-global "struct decoration name_decoration")?

I also notice that we do not set r->type at all, meaning the decoration
lookup code in log-tree will access uninitialized memory (worse, it will
use it as a pointer offset into the color list; I got a segfault when I
tried to run "git rev-list --bisect-all v1.8.0..v1.9.0").

I think we need this:

diff --git a/bisect.c b/bisect.c
index d6e851d..e2a7682 100644
--- a/bisect.c
+++ b/bisect.c
@@ -219,6 +219,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		struct object *obj = &(array[i].commit->object);
 
 		sprintf(r->name, "dist=%d", array[i].distance);
+		r->type = 0;
 		r->next = add_decoration(&name_decoration, obj, r);
 		p->item = array[i].commit;
 		p = p->next;

at a minimum.

It looks like this was a regression caused by eb3005e (commit.h: add
'type' to struct name_decoration, 2010-06-19). Which makes me wonder if
anybody actually _uses_ --bisect-all (which AFAICT is the only way to
trigger the problem), but since it's public, I guess we should keep it.

I think the sane thing here is to stop advertising name_decoration as a
global, and make all callers use add_name_decoration. That makes it
easier for callers like this one, and would have caught the regression
caused be eb3005e (the compiler would have noticed that we were not
passing a type parameter to the function).

-Peff
