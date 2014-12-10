From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] read_packed_refs: use skip_prefix instead of static array
Date: Wed, 10 Dec 2014 05:40:36 -0500
Message-ID: <20141210104035.GC24514@peff.net>
References: <20141210103907.GA22186@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 11:40:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyehG-0007Ww-HN
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 11:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbaLJKkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 05:40:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:51009 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753020AbaLJKki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 05:40:38 -0500
Received: (qmail 29640 invoked by uid 102); 10 Dec 2014 10:40:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 04:40:38 -0600
Received: (qmail 8295 invoked by uid 107); 10 Dec 2014 10:40:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 05:40:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 05:40:36 -0500
Content-Disposition: inline
In-Reply-To: <20141210103907.GA22186@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261208>

We want to recognize the packed-refs header and skip to the
"traits" part of the line. We currently do it by feeding
sizeof() a static const array to strncmp. However, it's a
bit simpler to just skip_prefix, which expresses the
intention more directly, and without remembering to account
for the NUL-terminator in each sizeof() call.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 10f8247..c71553f 100644
--- a/refs.c
+++ b/refs.c
@@ -1135,10 +1135,9 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	while (strbuf_getwholeline(&line, f, '\n') != EOF) {
 		unsigned char sha1[20];
 		const char *refname;
-		static const char header[] = "# pack-refs with:";
+		const char *traits;
 
-		if (!strncmp(line.buf, header, sizeof(header)-1)) {
-			const char *traits = line.buf + sizeof(header) - 1;
+		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
 			if (strstr(traits, " fully-peeled "))
 				peeled = PEELED_FULLY;
 			else if (strstr(traits, " peeled "))
-- 
2.2.0.454.g7eca6b7
