From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] attr.c::path_matches(): special case paths that end with
 a slash
Date: Tue, 26 Mar 2013 11:39:30 -0700
Message-ID: <1364323171-20299-4-git-send-email-gitster@pobox.com>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com, peff@peff.net, avila.jn@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 19:40:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKYn6-0002XY-EH
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 19:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760135Ab3CZSjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 14:39:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760128Ab3CZSjj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 14:39:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B1EDA86E;
	Tue, 26 Mar 2013 14:39:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rv1W
	A/3FkaPTBaTa8PoovIxkeVI=; b=lmAjiKbCzDylfoanmqCq1eQe7P8SINWDx3CY
	8oHJjHAJ8mtYgUwPA7Qv/nq8QF6dkAXUEmjE9CC7WbAuGOZrvBsjTC8hvjCuVt7j
	zYh0OuByj0NElimYEitsIv4i8kgOEueTXX+uBhk8qIawgo81p9bniD3AQ51oXF1z
	vxboQxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	k1ponjfPigy2i17ioB8juM5hjthaUSxAqvGImxmZiFtI73b/GDnqeu2lvx4oa8kY
	p/uEmisih3tklBalN+Aw72N3Nu/t2OWpbsv1UaacMrZoc0yqWke8xScFU3rQz2JU
	W1MMw6XqhIUCyiM9vBOU83chArHunKvdJBhfhERUlxw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F400FA86D;
	Tue, 26 Mar 2013 14:39:38 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6ED60A86C; Tue, 26 Mar 2013
 14:39:38 -0400 (EDT)
X-Mailer: git-send-email 1.8.2-350-g3df87a1
In-Reply-To: <1364323171-20299-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 839D7898-9644-11E2-B2C4-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219179>

The function is given a string that ends with a slash to signal that
the path is a directory to make sure that a pattern that ends with a
slash (i.e. MUSTBEDIR) can tell directories and non-directories
apart.  However, the pattern itself (pat->pattern and
pat->patternlen) that came from such a MUSTBEDIR pattern is
represented as a string that ends with a slash, but patternlen does
not count that trailing slash. A MUSTBEDIR pattern "element/" is
represented as a counted string <"element/", 7> and this must match
match pathname "element/".

Because match_basename() wants to see pathname "element" to match
against the pattern <"element/", 7>, reduce the length of the path
to exclude the trailing slash when calling match_basename().

A similar adjustment for match_pathname() might be needed, but I
didn't look into it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 4cfe0ee..00a0016 100644
--- a/attr.c
+++ b/attr.c
@@ -661,14 +661,14 @@ static int path_matches(const char *pathname, int pathlen,
 {
 	const char *pattern = pat->pattern;
 	int prefix = pat->nowildcardlen;
+	int isdir = (pathlen && pathname[pathlen - 1] == '/');
 
-	if ((pat->flags & EXC_FLAG_MUSTBEDIR) &&
-	    ((!pathlen) || (pathname[pathlen-1] != '/')))
+	if ((pat->flags & EXC_FLAG_MUSTBEDIR) && !isdir)
 		return 0;
 
 	if (pat->flags & EXC_FLAG_NODIR) {
 		return match_basename(pathname + basename_offset,
-				      pathlen - basename_offset,
+				      pathlen - basename_offset - isdir,
 				      pattern, prefix,
 				      pat->patternlen, pat->flags);
 	}
-- 
1.8.2-350-g3df87a1
