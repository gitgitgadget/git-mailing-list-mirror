From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] list-objects: pass full pathname to callbacks
Date: Thu, 11 Feb 2016 17:36:34 -0500
Message-ID: <20160211223634.GC641@sigill.intra.peff.net>
References: <20160211222314.GA31625@sigill.intra.peff.net>
 <20160211222836.GE586@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 23:36:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTzqr-0005n0-EY
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 23:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbcBKWgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 17:36:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:40775 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750817AbcBKWgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 17:36:37 -0500
Received: (qmail 24989 invoked by uid 102); 11 Feb 2016 22:36:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:36:37 -0500
Received: (qmail 11853 invoked by uid 107); 11 Feb 2016 22:36:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:36:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2016 17:36:34 -0500
Content-Disposition: inline
In-Reply-To: <20160211222836.GE586@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286015>

On Thu, Feb 11, 2016 at 05:28:36PM -0500, Jeff King wrote:

> +void show_object_with_name(FILE *out, struct object *obj, const char *name)
> [...]
>  	fprintf(out, "%s ", oid_to_hex(&obj->oid));
>  	for (p = name; *p && *p != '\n'; p++)
>  		fputc(*p, out);
>  	fputc('\n', out);

By the way, since I was timing things, I wondered if we would see any
improvement from using putc_unlocked, like:

diff --git a/revision.c b/revision.c
index 82f3ca4..ab72247 100644
--- a/revision.c
+++ b/revision.c
@@ -30,9 +30,11 @@ void show_object_with_name(FILE *out, struct object *obj, const char *name)
 	const char *p;
 
 	fprintf(out, "%s ", oid_to_hex(&obj->oid));
+	flockfile(out);
 	for (p = name; *p && *p != '\n'; p++)
-		fputc(*p, out);
-	fputc('\n', out);
+		putc_unlocked(*p, out);
+	putc_unlocked('\n', out);
+	funlockfile(out);
 }
 
 static void mark_blob_uninteresting(struct blob *blob)

But I couldn't measure any speedup. I imagine if you had 500MB pathnames
you might see some improvement, but I don't think it is even worth the
extra lines of code to worry about such a pathological case.

-Peff
