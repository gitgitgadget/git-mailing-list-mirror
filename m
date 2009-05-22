From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Fri, 22 May 2009 03:56:20 -0400
Message-ID: <20090522075620.GC1409@coredump.intra.peff.net>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com> <4A13BC3C.5070000@viscovery.net> <fcaeb9bf0905200123r3649a7e5vc40ece402379e701@mail.gmail.com> <7v7i0btdwu.fsf@alter.siamese.dyndns.org> <20090521041812.GE8091@sigill.intra.peff.net> <4A159720.3020103@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Fri May 22 09:56:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7PcJ-00087W-Ul
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 09:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbZEVH4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 03:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbZEVH4U
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 03:56:20 -0400
Received: from peff.net ([208.65.91.99]:50807 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756528AbZEVH4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 03:56:19 -0400
Received: (qmail 17043 invoked by uid 107); 22 May 2009 07:56:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 22 May 2009 03:56:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2009 03:56:20 -0400
Content-Disposition: inline
In-Reply-To: <4A159720.3020103@intra2net.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119718>

On Thu, May 21, 2009 at 08:02:08PM +0200, Thomas Jarosch wrote:

> Speaking of that, there is also one piece of code in diff.c that doesn't do
> NULL-termination after a readlink() call (which never NULL-terminates).
> The current use is 100% fine, though the same maintenance
> argument might apply here, too. Wondering why the buffer
> is allocated as PATH_MAX +1. Hmm.

Yeah, it is fine because it just passes the result to prep_temp_blob,
which respects the length. I don't know if it is worth making it more
safe (arguably it should just be using strbuf_readlink anyway, but that
does introduce an extra malloc).

I grepped and every other call to readlink is already doing this (and
most just use strbuf_readlink anyway).

-- >8 --
Subject: NUL-terminate readlink results

readlink does not terminate its result, but instead returns the length
of the path. This is not an actual bugfix, as the value is currently
only used with its length. However, terminating the string helps make it
safer for future uses.

Signed-off-by: Jeff King <peff@peff.net>
---
This does feel a bit like code churn, but I'm not sure it is any
different than the NULL-terminate all argv proposal.

diff --git a/diff.c b/diff.c
index f06876b..b398360 100644
--- a/diff.c
+++ b/diff.c
@@ -2021,6 +2021,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 				die("readlink(%s)", name);
 			if (ret == sizeof(buf))
 				die("symlink too long: %s", name);
+			buf[ret] = '\0';
 			prep_temp_blob(name, temp, buf, ret,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
