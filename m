From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive-tar: fix sanity check in config parsing
Date: Mon, 14 Jan 2013 04:44:24 -0800
Message-ID: <20130114124424.GA14129@sigill.intra.peff.net>
References: <50F2F1E9.1040700@lsrfire.ath.cx>
 <20130113200044.GA3979@sigill.intra.peff.net>
 <kd0evl$ac0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 13:45:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TujPQ-0001wO-JR
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 13:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505Ab3ANMoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 07:44:37 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:61000 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756438Ab3ANMog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 07:44:36 -0500
Received: (qmail 18972 invoked by uid 107); 14 Jan 2013 12:45:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 07:45:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 04:44:25 -0800
Content-Disposition: inline
In-Reply-To: <kd0evl$ac0$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213486>

On Mon, Jan 14, 2013 at 09:17:57AM +0100, Joachim Schmitz wrote:

> >For the curious, the original version of the patch[1] read:
> >
> >+       if (prefixcmp(var, "tarfilter."))
> >+               return 0;
> >+       dot = strrchr(var, '.');
> >+       if (dot == var + 9)
> >+               return 0;
> >
> >and when I shortened the config section to "tar" in a re-roll of the
> >series, I missed the corresponding change to the offset.
> 
> Wouldn't it then be better ti use strlen("tar") rather than a 3? Or
> at least a comment?

Then you are relying on the two strings being the same, rather than the
string and the length being the same. If you wanted to DRY it up, it
would look like:

diff --git a/archive-tar.c b/archive-tar.c
index d1cce46..a7c0690 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -332,15 +332,17 @@ static int tar_filter_config(const char *var, const char *value, void *data)
 	const char *type;
 	int namelen;
 
-	if (prefixcmp(var, "tar."))
+#define SECTION "tar"
+	if (prefixcmp(var, SECTION "."))
 		return 0;
 	dot = strrchr(var, '.');
-	if (dot == var + 9)
+	if (dot == var + strlen(SECTION))
 		return 0;
 
-	name = var + 4;
+	name = var + strlen(SECTION) + 1;
 	namelen = dot - name;
 	type = dot + 1;
+#undef SECTION
 
 	ar = find_tar_filter(name, namelen);
 	if (!ar) {


(of course there are other variants where you do not use a macro, but
then you need to manually check for the "." after the prefixcmp call).
I dunno. It is technically more robust in that the offsets are computed,
but I think it is a little harder to read. Of course, I wrote the
original so I am probably not a good judge.

We could also potentially encapsulate it in a function. I think the diff
code has a very similar block.

-Peff
