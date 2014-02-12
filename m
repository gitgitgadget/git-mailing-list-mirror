From: Jeff King <peff@peff.net>
Subject: Re: pack bitmap woes on Windows
Date: Wed, 12 Feb 2014 11:48:28 -0500
Message-ID: <20140212164828.GA24484@sigill.intra.peff.net>
References: <52FB2268.7080906@viscovery.net>
 <87mwhwa3s1.fsf@fencepost.gnu.org>
 <52FB7196.7060209@viscovery.net>
 <87ioska2iu.fsf@fencepost.gnu.org>
 <CACsJy8CW0shw5JYtXScQHMYJ+D18-UJ6HanP-5OCuv87kHbnBg@mail.gmail.com>
 <CABPQNSabAcHEO0+ht7te9ScVigGOoCLdtiD10ye8AqqeLMagLw@mail.gmail.com>
 <CABPQNSZRfnp8aZuKBc=y=iDVdMUo8mKPsLsqg0E+bK1TdNvfkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Duy Nguyen <pclouds@gmail.com>, David Kastrup <dak@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 17:48:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDczD-0002np-VA
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 17:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbaBLQsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 11:48:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:49274 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752339AbaBLQsb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 11:48:31 -0500
Received: (qmail 23556 invoked by uid 102); 12 Feb 2014 16:48:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Feb 2014 10:48:30 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Feb 2014 11:48:28 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSZRfnp8aZuKBc=y=iDVdMUo8mKPsLsqg0E+bK1TdNvfkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241997>

On Wed, Feb 12, 2014 at 03:49:24PM +0100, Erik Faye-Lund wrote:

> It seems the author of a201c20b41a2f0725977bcb89a2a66135d776ba2
> assumes __BYTE_ORDER was guaranteed to always be defined, probably
> fooled by the following check:
> 
> #if !defined(__BYTE_ORDER)
> # error "Cannot determine endianness"
> #endif
> 
> However, that check is only performed if we're NOT building with GCC
> on x86/x64 nor MSVC (which I don't think defined __BYTE_ORDER either)
> 
> The following would make __BYTE_ORDER a guarantee, and show that MinGW
> does not define it:

Yes, that is the problem. Sorry, this got brought up earlier[1], but the
discussion went on and I did not notice that Brian's patch did not get
applied.

After re-reading the discussion, I think the patch below is the best
solution. Can you confirm that it fixes the problem for you?

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/241278

-- >8 --
Subject: ewah: unconditionally ntohll ewah data

Commit a201c20 tried to optimize out a loop like:

  for (i = 0; i < len; i++)
	  data[i] = ntohll(data[i]);

in the big-endian case, because we know that ntohll is a
noop, and we do not need to pay the cost of the loop at all.
However, it mistakenly assumed that __BYTE_ORDER was always
defined, whereas it may not be on systems which do not
define it by default, and where we did not need to define it
to set up the ntohll macro. This includes OS X and Windows.

We could muck with the ordering in compat/bswap.h to make
sure it is defined unconditionally, but it is simpler to
still to just execute the loop unconditionally. That avoids
the application code knowing anything about these magic
macros, and lets it depend only on having ntohll defined.

And since the resulting loop looks like (on a big-endian
system):

  for (i = 0; i < len; i++)
	  data[i] = data[i];

any decent compiler can probably optimize it out.

Original report and analysis by Brian Gernhardt.

Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/ewah_io.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 4a7fae6..f7f700e 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -113,6 +113,7 @@ int ewah_serialize(struct ewah_bitmap *self, int fd)
 int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
 {
 	uint8_t *ptr = map;
+	size_t i;
 
 	self->bit_size = get_be32(ptr);
 	ptr += sizeof(uint32_t);
@@ -135,13 +136,8 @@ int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
 	memcpy(self->buffer, ptr, self->buffer_size * sizeof(uint64_t));
 	ptr += self->buffer_size * sizeof(uint64_t);
 
-#if __BYTE_ORDER != __BIG_ENDIAN
-	{
-		size_t i;
-		for (i = 0; i < self->buffer_size; ++i)
-			self->buffer[i] = ntohll(self->buffer[i]);
-	}
-#endif
+	for (i = 0; i < self->buffer_size; ++i)
+		self->buffer[i] = ntohll(self->buffer[i]);
 
 	self->rlw = self->buffer + get_be32(ptr);
 
-- 
1.8.5.2.500.g8060133
