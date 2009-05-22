From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Fri, 22 May 2009 04:02:58 -0400
Message-ID: <20090522080258.GD1409@coredump.intra.peff.net>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com> <4A13BC3C.5070000@viscovery.net> <fcaeb9bf0905200123r3649a7e5vc40ece402379e701@mail.gmail.com> <7v7i0btdwu.fsf@alter.siamese.dyndns.org> <20090521041812.GE8091@sigill.intra.peff.net> <4A159720.3020103@intra2net.com> <20090522075620.GC1409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Fri May 22 10:03:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Pim-00047F-6Z
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 10:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756813AbZEVIDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 04:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756663AbZEVIDA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 04:03:00 -0400
Received: from peff.net ([208.65.91.99]:53011 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756813AbZEVIC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 04:02:58 -0400
Received: (qmail 17083 invoked by uid 107); 22 May 2009 08:03:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 22 May 2009 04:03:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2009 04:02:58 -0400
Content-Disposition: inline
In-Reply-To: <20090522075620.GC1409@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119719>

On Fri, May 22, 2009 at 03:56:20AM -0400, Jeff King wrote:

> Yeah, it is fine because it just passes the result to prep_temp_blob,
> which respects the length. I don't know if it is worth making it more
> safe (arguably it should just be using strbuf_readlink anyway, but that
> does introduce an extra malloc).

And here is the strbuf_readlink version, which actually does make the
source shorter and easier to read.

-- >8 --
Subject: [PATCH] convert bare readlink to strbuf_readlink

This particular readlink call never NUL-terminated its
result, making it a potential source of bugs (though there
is no bug now, as it currently always respects the length
field). Let's just switch it to strbuf_readlink which is
shorter and less error-prone.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index f06876b..ffbe5c4 100644
--- a/diff.c
+++ b/diff.c
@@ -2014,14 +2014,10 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 			die("stat(%s): %s", name, strerror(errno));
 		}
 		if (S_ISLNK(st.st_mode)) {
-			int ret;
-			char buf[PATH_MAX + 1]; /* ought to be SYMLINK_MAX */
-			ret = readlink(name, buf, sizeof(buf));
-			if (ret < 0)
+			struct strbuf sb = STRBUF_INIT;
+			if (strbuf_readlink(&sb, name, st.st_size) < 0)
 				die("readlink(%s)", name);
-			if (ret == sizeof(buf))
-				die("symlink too long: %s", name);
-			prep_temp_blob(name, temp, buf, ret,
+			prep_temp_blob(name, temp, sb.buf, sb.len,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
 				       (one->sha1_valid ?
-- 
1.6.3.1.179.gec578.dirty
