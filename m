From: Jeff King <peff@peff.net>
Subject: Re: git-push: forced update of tag shows unabbreviated SHA1
Date: Thu, 31 Jan 2008 05:27:16 -0500
Message-ID: <20080131102716.GC25546@coredump.intra.peff.net>
References: <47A1948F.6080308@viscovery.net> <20080131100625.GB25546@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:27:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKWe6-0002jc-7w
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 11:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbYAaK1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 05:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753929AbYAaK1T
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 05:27:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4315 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815AbYAaK1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 05:27:18 -0500
Received: (qmail 28141 invoked by uid 111); 31 Jan 2008 10:27:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 31 Jan 2008 05:27:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2008 05:27:16 -0500
Content-Disposition: inline
In-Reply-To: <20080131100625.GB25546@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72120>

On Thu, Jan 31, 2008 at 05:06:25AM -0500, Jeff King wrote:

> But getting back to your point: yes, I agree it is a little ugly.
> Rewriting find_unique_abbrev would be necessary for fixing it, and I'm
> not sure it is worth the trouble.

Actually, it looks like we already handle a similar case: the null sha1,
so the change isn't that big (and the null sha1 case folds nicely into
the "missing" case). With the (lightly tested) patch below,
find_unique_abbrev _always_ returns an answer, and for missing objects
will show enough characters that it doesn't match any existing object.

diff --git a/sha1_name.c b/sha1_name.c
index 13e1164..c0e6af1 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -192,26 +192,24 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
 {
-	int status, is_null;
+	int status, missing;
 	static char hex[41];
 
-	is_null = is_null_sha1(sha1);
+	missing = !has_sha1_file(sha1);
 	memcpy(hex, sha1_to_hex(sha1), 40);
 	if (len == 40 || !len)
 		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
 		status = get_short_sha1(hex, len, sha1_ret, 1);
-		if (!status ||
-		    (is_null && status != SHORT_NAME_AMBIGUOUS)) {
+		if ((!missing && !status) ||
+		    (missing && status == SHORT_NAME_NOT_FOUND)) {
 			hex[len] = 0;
 			return hex;
 		}
-		if (status != SHORT_NAME_AMBIGUOUS)
-			return NULL;
 		len++;
 	}
-	return NULL;
+	return hex;
 }
 
 static int ambiguous_path(const char *path, int len)
