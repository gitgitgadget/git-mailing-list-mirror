From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch --all: pass --tags/--no-tags through to each remote
Date: Sat, 1 Sep 2012 07:32:07 -0400
Message-ID: <20120901113206.GB11445@sigill.intra.peff.net>
References: <7vr4qmn8va.fsf@alter.siamese.dyndns.org>
 <1346473533-24175-1-git-send-email-ComputerDruid@gmail.com>
 <20120901112251.GA11445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <ossi@kde.org>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 13:32:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7lw1-0004dF-8J
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 13:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab2IALcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 07:32:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50827 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755423Ab2IALcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 07:32:09 -0400
Received: (qmail 27161 invoked by uid 107); 1 Sep 2012 11:32:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Sep 2012 07:32:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2012 07:32:07 -0400
Content-Disposition: inline
In-Reply-To: <20120901112251.GA11445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204627>

Since the array struct stores a "const char **" argv member
(for compatibility with most of our argv-taking functions),
we have to cast away the const-ness when freeing its
elements.

However, we used the wrong type when doing so.  It doesn't
make a difference since free() take a void pointer anyway,
but it can be slightly confusing to a reader.

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed this while I was adding the other free in argv_array_pop...

 argv-array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/argv-array.c b/argv-array.c
index 55e8443..256741d 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -63,7 +63,7 @@ void argv_array_clear(struct argv_array *array)
 	if (array->argv != empty_argv) {
 		int i;
 		for (i = 0; i < array->argc; i++)
-			free((char **)array->argv[i]);
+			free((char *)array->argv[i]);
 		free(array->argv);
 	}
 	argv_array_init(array);
-- 
1.7.12.rc3.8.g89db099
