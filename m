From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 23/23] compat/mingw.h: Fix the MinGW and msvc builds
Date: Sat, 28 Dec 2013 05:00:50 -0500
Message-ID: <20131228100050.GA24929@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221140052.GW21145@sigill.intra.peff.net>
 <CABPQNSa+mtVoMiN_mxVfYW_=JMxO-0Odv5uLnGhknNhDq1yWrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 11:00:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwqhU-0005E6-Gn
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 11:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab3L1KAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 05:00:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:51524 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753693Ab3L1KAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 05:00:52 -0500
Received: (qmail 2536 invoked by uid 102); 28 Dec 2013 10:00:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Dec 2013 04:00:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Dec 2013 05:00:50 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSa+mtVoMiN_mxVfYW_=JMxO-0Odv5uLnGhknNhDq1yWrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239768>

On Wed, Dec 25, 2013 at 11:08:57PM +0100, Erik Faye-Lund wrote:

> On Sat, Dec 21, 2013 at 3:00 PM, Jeff King <peff@peff.net> wrote:
> > From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> >
> > Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  compat/mingw.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/compat/mingw.h b/compat/mingw.h
> > index 92cd728..8828ede 100644
> > --- a/compat/mingw.h
> > +++ b/compat/mingw.h
> > @@ -345,6 +345,7 @@ static inline char *mingw_find_last_dir_sep(const char *path)
> >  #define PATH_SEP ';'
> >  #define PRIuMAX "I64u"
> >  #define PRId64 "I64d"
> > +#define PRIx64 "I64x"
> >
> 
> Please, move this before patch #8, and adjust the commit message.

Yeah, that makes sense. Though I think we can do one better and simply
remove the need for it entirely. The only use of PRIx64 is in a
debugging function that does not get called.

How about squashing the patch below into patch 8 ("ewah: compressed
bitmap implementation"):

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index f104b87..9ced2da 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -381,18 +381,6 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
 		read_new_rlw(it);
 }
 
-void ewah_dump(struct ewah_bitmap *self)
-{
-	size_t i;
-	fprintf(stderr, "%"PRIuMAX" bits | %"PRIuMAX" words | ",
-		(uintmax_t)self->bit_size, (uintmax_t)self->buffer_size);
-
-	for (i = 0; i < self->buffer_size; ++i)
-		fprintf(stderr, "%016"PRIx64" ", (uint64_t)self->buffer[i]);
-
-	fprintf(stderr, "\n");
-}
-
 void ewah_not(struct ewah_bitmap *self)
 {
 	size_t pointer = 0;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 619afaa..43adeb5 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -193,8 +193,6 @@ void ewah_and(
 	struct ewah_bitmap *ewah_j,
 	struct ewah_bitmap *out);
 
-void ewah_dump(struct ewah_bitmap *self);
-
 /**
  * Direct word access
  */
