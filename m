From: Jeff King <peff@peff.net>
Subject: Re: "malloc failed"
Date: Thu, 29 Jan 2009 00:56:34 -0500
Message-ID: <20090129055633.GA32609@coredump.intra.peff.net>
References: <878wow7pth.fsf@mcbain.luannocracy.com> <20090128050225.GA18546@coredump.intra.peff.net> <c26bbb3fe074f6f6e0634a4ae8611239@206.71.190.141> <87skn3rn5n.fsf@mcbain.luannocracy.com> <20090129052041.GB31507@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 07:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSPxA-0005Bs-Lo
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 07:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbZA2F4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 00:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbZA2F4h
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 00:56:37 -0500
Received: from peff.net ([208.65.91.99]:49806 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbZA2F4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 00:56:36 -0500
Received: (qmail 29176 invoked by uid 107); 29 Jan 2009 05:56:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 00:56:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 00:56:34 -0500
Content-Disposition: inline
In-Reply-To: <20090129052041.GB31507@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107635>

On Thu, Jan 29, 2009 at 12:20:41AM -0500, Jeff King wrote:

> Ok, that _is_ big. ;) I wouldn't be surprised if there is some corner of
> the code that barfs on a single object that doesn't fit in a signed
> 32-bit integer; I don't think we have any test coverage for stuff that
> big.

Sure enough, that is the problem. With the patch below I was able to
"git add" and commit a 3 gigabyte file of random bytes (so even the
deflated object was 3G).

I think it might be worth applying as a general cleanup, but I have no
idea if other parts of the system might barf on such an object.

-- >8 --
Subject: [PATCH] avoid 31-bit truncation in write_loose_object

The size of the content we are adding may be larger than
2.1G (i.e., "git add gigantic-file"). Most of the code-path
to do so uses size_t or unsigned long to record the size,
but write_loose_object uses a signed int.

On platforms where "int" is 32-bits (which includes x86_64
Linux platforms), we end up passing malloc a negative size.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 360f7e5..8868b80 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2340,7 +2340,8 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 			      void *buf, unsigned long len, time_t mtime)
 {
-	int fd, size, ret;
+	int fd, ret;
+	size_t size;
 	unsigned char *compressed;
 	z_stream stream;
 	char *filename;
-- 
1.6.1.1.259.g8712.dirty
