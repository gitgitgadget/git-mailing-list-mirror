From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] do not check truth value of flex arrays
Date: Wed, 28 Jan 2015 12:58:50 -0500
Message-ID: <20150128175850.GB8172@peff.net>
References: <20150128175314.GA13362@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 22:33:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGaEK-0002Cs-Un
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 22:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760597AbbA1Vcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 16:32:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:42774 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761818AbbA1Upd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:45:33 -0500
Received: (qmail 32689 invoked by uid 102); 28 Jan 2015 17:58:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Jan 2015 11:58:52 -0600
Received: (qmail 10533 invoked by uid 107); 28 Jan 2015 17:59:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Jan 2015 12:59:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2015 12:58:50 -0500
Content-Disposition: inline
In-Reply-To: <20150128175314.GA13362@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263119>

There is no point in checking "!ref->name" when ref is a
"struct ref". The name field is a flex-array, and there
always has a non-zero address. This is almost certainly not
hurting anything, but it does cause clang-3.6 to complain.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that even if "ref" is NULL, this is still going to be
"0+offsetof(name)". So short of unsigned pointer wrap-around, I do not
think this check can ever do anything.

 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index dd63bc2..515ac9b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -760,7 +760,7 @@ static int fetch_git(struct discovery *heads,
 
 	for (i = 0; i < nr_heads; i++) {
 		struct ref *ref = to_fetch[i];
-		if (!ref->name || !*ref->name)
+		if (!*ref->name)
 			die("cannot fetch by sha1 over smart http");
 		packet_buf_write(&preamble, "%s %s\n",
 				 sha1_to_hex(ref->old_sha1), ref->name);
-- 
2.3.0.rc1.287.g761fd19
