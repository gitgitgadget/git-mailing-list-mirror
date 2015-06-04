From: Jeff King <peff@peff.net>
Subject: [PATCH] index-pack: fix truncation of off_t in comparison
Date: Thu, 4 Jun 2015 08:35:42 -0400
Message-ID: <20150604123541.GA8888@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 14:35:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0UNC-0001Pj-Ou
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 14:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbbFDMfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 08:35:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:41063 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751955AbbFDMfp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 08:35:45 -0400
Received: (qmail 28172 invoked by uid 102); 4 Jun 2015 12:35:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 07:35:45 -0500
Received: (qmail 31552 invoked by uid 107); 4 Jun 2015 12:35:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 08:35:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jun 2015 08:35:42 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270770>

Commit c6458e6 (index-pack: kill union delta_base to save
memory, 2015-04-18) refactored the comparison functions used
in sorting and binary searching our delta list. The
resulting code does something like:

  int cmp_offsets(off_t a, off_t b)
  {
	  return a - b;
  }

This works most of the time, but produces nonsensical
results when the difference between the two offsets is
larger than what can be stored in an "int". This can lead to
unresolved deltas if the packsize is larger than 2G (even on
64-bit systems, an int is still typically 32 bits):

  $ git clone git://github.com/mozilla/gecko-dev
  Cloning into 'gecko-dev'...
  remote: Counting objects: 4800161, done.
  remote: Compressing objects: 100% (178/178), done.
  remote: Total 4800161 (delta 88), reused 0 (delta 0), pack-reused 4799978
  Receiving objects: 100% (4800161/4800161), 2.21 GiB | 3.26 MiB/s, done.
  Resolving deltas:  99% (3808820/3811944), completed with 0 local objects.
  fatal: pack has 3124 unresolved deltas
  fatal: index-pack failed

We can fix it by doing direct comparisons between the
offsets and returning constants; the callers only care about
the sign of the comparison, not the magnitude.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of nd/slim-index-pack-memory-usage, which introduced the bug (but
it is already in master).

 builtin/index-pack.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3ed53e3..06dd973 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -616,7 +616,9 @@ static int compare_ofs_delta_bases(off_t offset1, off_t offset2,
 	int cmp = type1 - type2;
 	if (cmp)
 		return cmp;
-	return offset1 - offset2;
+	return offset1 < offset2 ? -1 :
+	       offset1 > offset2 ?  1 :
+	       0;
 }
 
 static int find_ofs_delta(const off_t offset, enum object_type type)
@@ -1051,7 +1053,9 @@ static int compare_ofs_delta_entry(const void *a, const void *b)
 	const struct ofs_delta_entry *delta_a = a;
 	const struct ofs_delta_entry *delta_b = b;
 
-	return delta_a->offset - delta_b->offset;
+	return delta_a->offset < delta_b->offset ? -1 :
+	       delta_a->offset > delta_b->offset ?  1 :
+	       0;
 }
 
 static int compare_ref_delta_entry(const void *a, const void *b)
-- 
2.4.2.745.g0aa058d
