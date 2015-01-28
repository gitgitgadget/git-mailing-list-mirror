From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] read_and_strip_branch: fix typo'd address-of operator
Date: Wed, 28 Jan 2015 12:57:35 -0500
Message-ID: <20150128175735.GA8172@peff.net>
References: <20150128175314.GA13362@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 21:44:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZTc-0000bO-Bl
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbbA1Uof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 15:44:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:42771 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933272AbbA1UoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:44:18 -0500
Received: (qmail 32634 invoked by uid 102); 28 Jan 2015 17:57:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Jan 2015 11:57:37 -0600
Received: (qmail 10521 invoked by uid 107); 28 Jan 2015 17:58:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Jan 2015 12:58:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2015 12:57:35 -0500
Content-Disposition: inline
In-Reply-To: <20150128175314.GA13362@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263116>

When we are chomping newlines from the end of a strbuf, we
must check "sb.len != 0" before accessing "sb.buf[sb.len - 1]".
However, this code mistakenly checks "&sb.len", which is
always true (it is a part of an auto struct, so the address
is always non-zero). This could lead to us accessing memory
outside the strbuf when we read an empty file.

Signed-off-by: Jeff King <peff@peff.net>
---
This dates back to 8b87cfd (wt-status: move strbuf into
read_and_strip_branch(), 2013-03-16), so it is not a bug that needs
addressed during the -rc period.

This is the most minimal fix, but I kind of wonder if it should just be
using strbuf_rtrim (or even strbuf_trim) in the first place.

 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index b54eac5..29666d0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1140,7 +1140,7 @@ static char *read_and_strip_branch(const char *path)
 	if (strbuf_read_file(&sb, git_path("%s", path), 0) <= 0)
 		goto got_nothing;
 
-	while (&sb.len && sb.buf[sb.len - 1] == '\n')
+	while (sb.len && sb.buf[sb.len - 1] == '\n')
 		strbuf_setlen(&sb, sb.len - 1);
 	if (!sb.len)
 		goto got_nothing;
-- 
2.3.0.rc1.287.g761fd19
