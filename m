From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] strbuf: improve API
Date: Wed, 1 Jun 2016 17:07:13 -0400
Message-ID: <20160601210713.GA18118@sigill.intra.peff.net>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <20160601074218.GB14096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 01 23:07:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8DMK-0003nU-QV
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 23:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbcFAVHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 17:07:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:47538 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751076AbcFAVHR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 17:07:17 -0400
Received: (qmail 28634 invoked by uid 102); 1 Jun 2016 21:07:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 17:07:16 -0400
Received: (qmail 5209 invoked by uid 107); 1 Jun 2016 21:07:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 17:07:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 17:07:13 -0400
Content-Disposition: inline
In-Reply-To: <20160601074218.GB14096@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296165>

On Wed, Jun 01, 2016 at 03:42:18AM -0400, Jeff King wrote:

> I have no idea if those ideas would work. But I wouldn't want to start
> looking into either of them without some idea of how much time we're
> actually spending on strbuf mallocs (or how much time we would spend if
> strbufs were used in some proposed sites).

So I tried to come up with some numbers.

Here's an utterly silly use of strbufs, but one that I think should
over-emphasize the effect of any improvements we make:

diff --git a/Makefile b/Makefile
index 7a0551a..72b968a 100644
--- a/Makefile
+++ b/Makefile
@@ -579,6 +579,7 @@ PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += remote-testsvn.o
+PROGRAM_OBJS += foo.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
diff --git a/foo.c b/foo.c
index e69de29..b62dd97 100644
--- a/foo.c
+++ b/foo.c
@@ -0,0 +1,18 @@
+#include "git-compat-util.h"
+#include "strbuf.h"
+
+int main(void)
+{
+	const char *str = "this is a string that we'll repeatedly insert";
+	size_t len = strlen(str);
+
+	int i;
+	for (i = 0; i < 1000000; i++) {
+		struct strbuf buf = STRBUF_INIT;
+		int j;
+		for (j = 0; j < 500; j++)
+			strbuf_add(&buf, str, len);
+		strbuf_release(&buf);
+	}
+	return 0;
+}

That takes about 3.5 seconds to run git-foo on my machine.  Here's where
perf says the time goes:

# Children      Self  Command  Shared Object      Symbol                    
# ........  ........  .......  .................  ..........................
#
    35.62%    34.58%  git-foo  git-foo            [.] strbuf_add            
    22.70%    22.14%  git-foo  git-foo            [.] strbuf_grow           
    19.85%    19.04%  git-foo  libc-2.22.so       [.] __memcpy_avx_unaligned
     9.47%     9.17%  git-foo  git-foo            [.] main                  
     4.88%     4.68%  git-foo  git-foo            [.] memcpy@plt            
     3.21%     3.12%  git-foo  libc-2.22.so       [.] realloc               
     1.75%     1.71%  git-foo  libc-2.22.so       [.] _int_realloc          
     1.42%     0.00%  git-foo  [unknown]          [.] 0x676e697274732061    
     0.82%     0.79%  git-foo  git-foo            [.] xrealloc              
     0.61%     0.59%  git-foo  git-foo            [.] memory_limit_check    
     0.45%     0.00%  git-foo  [unknown]          [.] 0000000000000000      
     0.32%     0.00%  git-foo  [unknown]          [.] 0x0000000000000fff    
     0.32%     0.32%  git-foo  [unknown]          [k] 0x00007f591b44a2f0    
     0.31%     0.31%  git-foo  [unknown]          [k] 0x0000000000404719    
     0.30%     0.00%  git-foo  [unknown]          [.] 0x0000000000001ffe    
     0.30%     0.30%  git-foo  libc-2.22.so       [.] _int_free             
     0.30%     0.28%  git-foo  libc-2.22.so       [.] _int_malloc           

So malloc and free are pretty low. It looks like realloc is more,
probably because of the memcpys it has to do. I don't think that would
be much better in a stack-based system (because we'd realloc there,
too). What would help is simply using a larger initial size (for _this_
made-up benchmark; I'm not convinced it would be all that good in the
real world).

But either way, most of the time is actually spent in the strbuf
functions themselves (interesting, if you replace strbuf_add with
strbuf_addf, we spend much more time dealing with the formatted input).
We can probably micro-optimize them some.

Here's a short and hacky patch to inline strbuf_grow, and to use
compiler intrinsics to do the overflow checks (which obviously isn't
portable, but we can easily hide it behind a macro and fall back to the
existing scheme):

diff --git a/strbuf.c b/strbuf.c
index 1ba600b..4f163cb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -55,19 +55,25 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 	sb->buf[sb->len] = '\0';
 }
 
-void strbuf_grow(struct strbuf *sb, size_t extra)
+static inline void strbuf_grow_inline(struct strbuf *sb, size_t extra)
 {
 	int new_buf = !sb->alloc;
-	if (unsigned_add_overflows(extra, 1) ||
-	    unsigned_add_overflows(sb->len, extra + 1))
+	if (__builtin_add_overflow(extra, sb->len, &extra) ||
+	    __builtin_add_overflow(extra, 1, &extra))
 		die("you want to use way too much memory");
 	if (new_buf)
 		sb->buf = NULL;
-	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	ALLOC_GROW(sb->buf, extra, sb->alloc);
 	if (new_buf)
 		sb->buf[0] = '\0';
 }
 
+void strbuf_grow(struct strbuf *sb, size_t extra)
+{
+	strbuf_grow_inline(sb, extra);
+}
+#define strbuf_grow strbuf_grow_inline
+
 void strbuf_trim(struct strbuf *sb)
 {
 	strbuf_rtrim(sb);

That drops my best-of-five for git-foo from:

  real    0m3.377s
  user    0m3.376s
  sys     0m0.000s

to:

  real    0m3.107s
  user    0m3.104s
  sys     0m0.000s

So that's at least measurable. Again, though, I'm not convinced it
actually matters much in the real world. But from what I see here, I'd
be surprised if the stack-buffer thing actually generates measurable
improvements here _or_ in the real world.

-Peff
