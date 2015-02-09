From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/blame: destroy initialized commit_info only
Date: Mon, 9 Feb 2015 18:37:08 -0500
Message-ID: <20150209233707.GA20462@peff.net>
References: <1423517287-8354-1-git-send-email-sunshine@sunshineco.com>
 <20150209232435.GB24814@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Dilyan Palauzov <dilyan.palauzov@aegee.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 00:37:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKxtG-0001wm-NO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 00:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761576AbbBIXhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 18:37:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:47049 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759276AbbBIXhK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 18:37:10 -0500
Received: (qmail 11440 invoked by uid 102); 9 Feb 2015 23:37:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Feb 2015 17:37:10 -0600
Received: (qmail 2427 invoked by uid 107); 9 Feb 2015 23:37:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Feb 2015 18:37:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2015 18:37:08 -0500
Content-Disposition: inline
In-Reply-To: <20150209232435.GB24814@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263617>

On Mon, Feb 09, 2015 at 06:24:35PM -0500, Jeff King wrote:

> Clang's address sanitizer has compiler support, so it does get to see
> this memory and could put a canary value in for each loop iteration. But
> it doesn't. Instead, you're supposed to use the "memory sanitizer" to
> catch uninitialized memory.
> 
> I tried that, but got overwhelmed with false positives. Like valgrind,
> it has problems accepting that memory written by zlib is actually
> initialized. But in theory, if we went to the work to annotate some
> false positives, it should be able to find this problem.

I got rid of the false positives here, through a combination of
compiling with NO_OPENSSL (since it otherwise doesn't know that
git_SHA1_Final is initializing hashes), and this patch which lets it
assume that the output of zlib (at least for these cases) is always
initialized:

diff --git a/sha1_file.c b/sha1_file.c
index 30995e6..28c8f84 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1682,6 +1682,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	git_zstream stream;
 	int st;
 
+	memset(delta_head, 0, 20);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = delta_head;
 	stream.avail_out = sizeof(delta_head);
@@ -1973,6 +1974,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	buffer = xmallocz_gently(size);
 	if (!buffer)
 		return NULL;
+	memset(buffer, 0, size);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
 	stream.avail_out = size + 1;


Sadly, though, the test case in question runs to completion. It does not
seem to detect our use of uninitialized memory. :(

-Peff
