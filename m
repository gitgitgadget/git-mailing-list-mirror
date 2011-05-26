From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] remove unnecessary test and dead diagnostic
Date: Thu, 26 May 2011 16:34:20 +0200
Message-ID: <87mxi95y4z.fsf@rho.meyering.net>
References: <87tych5zrh.fsf@rho.meyering.net>
	<20110526141130.GB18520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 16:34:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPbdx-0003NF-GR
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 16:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758005Ab1EZOe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 10:34:28 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:57209 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757998Ab1EZOe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 10:34:28 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id ABBD89401FF
	for <git@vger.kernel.org>; Thu, 26 May 2011 16:34:21 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 5282A60355; Thu, 26 May 2011 16:34:20 +0200 (CEST)
In-Reply-To: <20110526141130.GB18520@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2011 10:11:30 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174515>

Jeff King wrote:
> On Thu, May 26, 2011 at 03:59:14PM +0200, Jim Meyering wrote:
>
>> * sha1_file.c (index_stream): Don't check for size_t < 0.
>> read_in_full does not return an indication of failure.
>
> Are you sure about that?
>
>   $ sed -n '/read_in_full/,/^}/p' wrapper.c
>   ssize_t read_in_full(int fd, void *buf, size_t count)
>   {
>           char *p = buf;
>           ssize_t total = 0;
>
>           while (count > 0) {
>                   ssize_t loaded = xread(fd, p, count);

Argh.  I went in with blinders on, thinking that the caller was
right in using a type of size_t, and then read this "xread" name and
assumed that it would exit upon failure.

Thanks for catching that.
Here's a better patch:

-- >8 --
Subject: [PATCH] use the correct type (ssize_t, not size_t) for read-style function

* sha1_file.c (index_stream): Using an unsigned type,
we would fail to detect a read error and then proceed to
try to write (size_t)-1 bytes.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5fc877f..8a85217 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2731,11 +2731,11 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
 	write_or_whine(fast_import.in, fast_import_cmd, len,
 		       "index-stream: feeding fast-import");
 	while (size) {
 		char buf[10240];
 		size_t sz = size < sizeof(buf) ? size : sizeof(buf);
-		size_t actual;
+		ssize_t actual;

 		actual = read_in_full(fd, buf, sz);
 		if (actual < 0)
 			die_errno("index-stream: reading input");
 		if (write_in_full(fast_import.in, buf, actual) != actual)
--
1.7.5.2.660.g9f46c
