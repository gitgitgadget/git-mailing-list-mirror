From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 12:21:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 20:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSI3I-00076X-V4
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 20:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbXCPTZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 15:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbXCPTZV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 15:25:21 -0400
Received: from x35.xmailserver.org ([64.71.152.41]:49220 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbXCPTZT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 15:25:19 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S21C90A> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Fri, 16 Mar 2007 15:25:16 -0400
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42396>

On Fri, 16 Mar 2007, Linus Torvalds wrote:

> 
> 
> On Fri, 16 Mar 2007, Davide Libenzi wrote:
> >
> > > This one seems to do benchmarking with 8MB buffers if I read it right 
> > > (didn't try).
> > 
> > Yes, I just wanted to have the biggest time spent in inflate(). That why I 
> > use a big buffer.
> 
> Right. But if the biggest time is spent in setup, the big-buffer thing 
> ends up being exactly the wrong thing to test ;)

I modified ztest.c to be able to bench on various data files (you list 
them on the command line), but result are pretty much same.
I cannot measure any sensible difference between the two.
Attached there's ztest.c and the diff, in case you want to try on your 
own.



> > Definitely. The nature of the data matters.
> > Did you try to make a zlib with my patch and oprofile git on real data 
> > with that?
> 
> I haven't actually set it up so that I can build against my own zlib yet. 
> Exactly because I was hoping that somebody would already have a solution 
> ;)

An LD_PRELOAD pointing to your own build should do it.




- Davide




#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <time.h>
#include "zlib.h"


#define MIN_TESTIME (2 * 1000000)
#define INNER_CYCLES 32



#define CHECK_ERR(err, msg) do { \
	if (err != Z_OK) { \
		fprintf(stderr, "%s error: %d\n", msg, err); \
		exit(1); \
	} \
} while (0)



static unsigned long long mintt = MIN_TESTIME;
static uLong incycles = INNER_CYCLES;



static unsigned long long getustime(void) {
	struct timeval tm;

	gettimeofday(&tm, NULL);
	return tm.tv_sec * 1000000ULL + tm.tv_usec;
}

static void do_defl(Byte *cdata, uLong *clen,
		    Byte *udata, uLong uclen) {
	z_stream c_stream; /* compression stream */
	int err;

	c_stream.zalloc = (alloc_func) NULL;
	c_stream.zfree = (free_func) NULL;
	c_stream.opaque = (voidpf) NULL;

	err = deflateInit(&c_stream, Z_BEST_SPEED);
	CHECK_ERR(err, "deflateInit");

	c_stream.next_out = cdata;
	c_stream.avail_out = (uInt) *clen;

	/* At this point, udata is still mostly zeroes, so it should compress
	 * very well:
	 */
	c_stream.next_in = udata;
	c_stream.avail_in = (uInt) uclen;
	err = deflate(&c_stream, Z_FINISH);
	if (err != Z_STREAM_END) {
		fprintf(stderr, "whoops, got %d instead of Z_STREAM_END\n", err);
		exit(1);
	}

	err = deflateEnd(&c_stream);
	CHECK_ERR(err, "deflateEnd");

	*clen = c_stream.next_out - cdata;
}

static void do_infl(Byte *cdata, uLong clen,
		    Byte *udata, uLong *uclen) {
	int err;
	z_stream d_stream; /* decompression stream */

	d_stream.zalloc = (alloc_func) NULL;
	d_stream.zfree = (free_func) NULL;
	d_stream.opaque = (voidpf) NULL;

	d_stream.next_in  = cdata;
	d_stream.avail_in = (uInt) clen;

	err = inflateInit(&d_stream);
	CHECK_ERR(err, "inflateInit");

	d_stream.next_out = udata;            /* discard the output */
	d_stream.avail_out = (uInt) *uclen;
	err = inflate(&d_stream, Z_FULL_FLUSH);
	if (err != Z_STREAM_END) {
		fprintf(stderr, "deflate should report Z_STREAM_END\n");
		exit(1);
	}

	err = inflateEnd(&d_stream);
	CHECK_ERR(err, "inflateEnd");

	*uclen = d_stream.next_out - udata;
}

static int do_filebench(char const *fpath) {
	int fd, err = -1;
	uLong i, n, clen, ulen, size;
	Byte *ubuf, *cbuf, *tbuf;
	unsigned long long ts, te;
	void *addr;
	struct stat stb;

	if ((fd = open(fpath, O_RDONLY)) == -1 ||
	    fstat(fd, &stb)) {
		perror(fpath);
		close(fd);
		return -1;
	}
	size = stb.st_size;
	addr = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
	close(fd);
	if (addr == (void *) -1L) {
		perror("mmap");
		return -1;
	}
	ulen = size;
	clen = size + 4096;
	ubuf = addr;
	if ((tbuf = malloc(ulen + clen)) == NULL) {
		perror("malloc");
		goto err_exit;
	}
	cbuf = tbuf + ulen;

	/* Warming up ... */
	do_defl(cbuf, &clen, ubuf, ulen);
	do_infl(cbuf, clen, tbuf, &ulen);
	if (ulen != size) {
		fprintf(stderr, "size mismatch %lu instead of %lu\n",
			(unsigned long) ulen, (unsigned long) size);
		goto err_exit;
	}
	if (memcmp(tbuf, ubuf, size)) {
		fprintf(stderr, "whoops! we did not get back the same data\n");
		goto err_exit;
	}

	/* Test ... */
	fprintf(stdout, "testing: %s\n", fpath);
	ts = getustime();
	n = 0;
	do {
		for (i = 0; i < incycles; i++) {
			ulen = size;
			do_infl(cbuf, clen, tbuf, &ulen);
		}
		n += i;
		te = getustime();
	} while (te - ts < mintt);

	fprintf(stdout, "\tus time / cycle = %llu\n", (te - ts) / n);
	err = 0;

err_exit:
	free(tbuf);
	munmap(addr, size);

	return err;
}

int main(int ac, char **av) {
	int i;

	for (i = 1; i < ac; i++)
		do_filebench(av[i]);

	return 0;
}



Index: zlib-1.2.3.quilt/inflate.c
===================================================================
--- zlib-1.2.3.quilt.orig/inflate.c	2007-03-15 18:17:19.000000000 -0700
+++ zlib-1.2.3.quilt/inflate.c	2007-03-15 18:31:14.000000000 -0700
@@ -551,6 +551,15 @@
    will return Z_BUF_ERROR if it has not reached the end of the stream.
  */
 
+#define CASE_DECL(n) \
+	case n: \
+	lbl_##n:
+
+#define STATE_CHANGE(s) do { \
+	state->mode = s; \
+	goto lbl_##s; \
+} while (0)
+
 int ZEXPORT inflate(strm, flush)
 z_streamp strm;
 int flush;
@@ -586,10 +595,9 @@
     ret = Z_OK;
     for (;;)
         switch (state->mode) {
-        case HEAD:
+        CASE_DECL(HEAD)
             if (state->wrap == 0) {
-                state->mode = TYPEDO;
-                break;
+		STATE_CHANGE(TYPEDO);
             }
             NEEDBITS(16);
 #ifdef GUNZIP
@@ -597,8 +605,7 @@
                 state->check = crc32(0L, Z_NULL, 0);
                 CRC2(state->check, hold);
                 INITBITS();
-                state->mode = FLAGS;
-                break;
+		STATE_CHANGE(FLAGS);
             }
             state->flags = 0;           /* expect zlib header */
             if (state->head != Z_NULL)
@@ -609,20 +616,17 @@
 #endif
                 ((BITS(8) << 8) + (hold >> 8)) % 31) {
                 strm->msg = (char *)"incorrect header check";
-                state->mode = BAD;
-                break;
+	        STATE_CHANGE(BAD);
             }
             if (BITS(4) != Z_DEFLATED) {
                 strm->msg = (char *)"unknown compression method";
-                state->mode = BAD;
-                break;
+	        STATE_CHANGE(BAD);
             }
             DROPBITS(4);
             len = BITS(4) + 8;
             if (len > state->wbits) {
                 strm->msg = (char *)"invalid window size";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
             state->dmax = 1U << len;
             Tracev((stderr, "inflate:   zlib header ok\n"));
@@ -631,32 +635,30 @@
             INITBITS();
             break;
 #ifdef GUNZIP
-        case FLAGS:
+        CASE_DECL(FLAGS)
             NEEDBITS(16);
             state->flags = (int)(hold);
             if ((state->flags & 0xff) != Z_DEFLATED) {
                 strm->msg = (char *)"unknown compression method";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
             if (state->flags & 0xe000) {
                 strm->msg = (char *)"unknown header flags set";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
             if (state->head != Z_NULL)
                 state->head->text = (int)((hold >> 8) & 1);
             if (state->flags & 0x0200) CRC2(state->check, hold);
             INITBITS();
             state->mode = TIME;
-        case TIME:
+        CASE_DECL(TIME)
             NEEDBITS(32);
             if (state->head != Z_NULL)
                 state->head->time = hold;
             if (state->flags & 0x0200) CRC4(state->check, hold);
             INITBITS();
             state->mode = OS;
-        case OS:
+        CASE_DECL(OS)
             NEEDBITS(16);
             if (state->head != Z_NULL) {
                 state->head->xflags = (int)(hold & 0xff);
@@ -665,7 +667,7 @@
             if (state->flags & 0x0200) CRC2(state->check, hold);
             INITBITS();
             state->mode = EXLEN;
-        case EXLEN:
+        CASE_DECL(EXLEN)
             if (state->flags & 0x0400) {
                 NEEDBITS(16);
                 state->length = (unsigned)(hold);
@@ -677,7 +679,7 @@
             else if (state->head != Z_NULL)
                 state->head->extra = Z_NULL;
             state->mode = EXTRA;
-        case EXTRA:
+        CASE_DECL(EXTRA)
             if (state->flags & 0x0400) {
                 copy = state->length;
                 if (copy > have) copy = have;
@@ -699,7 +701,7 @@
             }
             state->length = 0;
             state->mode = NAME;
-        case NAME:
+        CASE_DECL(NAME)
             if (state->flags & 0x0800) {
                 if (have == 0) goto inf_leave;
                 copy = 0;
@@ -720,7 +722,7 @@
                 state->head->name = Z_NULL;
             state->length = 0;
             state->mode = COMMENT;
-        case COMMENT:
+        CASE_DECL(COMMENT)
             if (state->flags & 0x1000) {
                 if (have == 0) goto inf_leave;
                 copy = 0;
@@ -740,13 +742,12 @@
             else if (state->head != Z_NULL)
                 state->head->comment = Z_NULL;
             state->mode = HCRC;
-        case HCRC:
+        CASE_DECL(HCRC)
             if (state->flags & 0x0200) {
                 NEEDBITS(16);
                 if (hold != (state->check & 0xffff)) {
                     strm->msg = (char *)"header crc mismatch";
-                    state->mode = BAD;
-                    break;
+		    STATE_CHANGE(BAD);
                 }
                 INITBITS();
             }
@@ -755,28 +756,26 @@
                 state->head->done = 1;
             }
             strm->adler = state->check = crc32(0L, Z_NULL, 0);
-            state->mode = TYPE;
-            break;
+	    STATE_CHANGE(TYPE);
 #endif
-        case DICTID:
+        CASE_DECL(DICTID)
             NEEDBITS(32);
             strm->adler = state->check = REVERSE(hold);
             INITBITS();
             state->mode = DICT;
-        case DICT:
+        CASE_DECL(DICT)
             if (state->havedict == 0) {
                 RESTORE();
                 return Z_NEED_DICT;
             }
             strm->adler = state->check = adler32(0L, Z_NULL, 0);
             state->mode = TYPE;
-        case TYPE:
+        CASE_DECL(TYPE)
             if (flush == Z_BLOCK) goto inf_leave;
-        case TYPEDO:
+        CASE_DECL(TYPEDO)
             if (state->last) {
                 BYTEBITS();
-                state->mode = CHECK;
-                break;
+		STATE_CHANGE(CHECK);
             }
             NEEDBITS(3);
             state->last = BITS(1);
@@ -785,39 +784,38 @@
             case 0:                             /* stored block */
                 Tracev((stderr, "inflate:     stored block%s\n",
                         state->last ? " (last)" : ""));
-                state->mode = STORED;
-                break;
+		DROPBITS(2);
+		STATE_CHANGE(STORED);
             case 1:                             /* fixed block */
                 fixedtables(state);
                 Tracev((stderr, "inflate:     fixed codes block%s\n",
                         state->last ? " (last)" : ""));
-                state->mode = LEN;              /* decode codes */
-                break;
+		DROPBITS(2);
+		STATE_CHANGE(LEN);
             case 2:                             /* dynamic block */
                 Tracev((stderr, "inflate:     dynamic codes block%s\n",
                         state->last ? " (last)" : ""));
-                state->mode = TABLE;
-                break;
+		DROPBITS(2);
+		STATE_CHANGE(TABLE);
             case 3:
+		DROPBITS(2);
                 strm->msg = (char *)"invalid block type";
-                state->mode = BAD;
+		STATE_CHANGE(BAD);
             }
-            DROPBITS(2);
             break;
-        case STORED:
+        CASE_DECL(STORED)
             BYTEBITS();                         /* go to byte boundary */
             NEEDBITS(32);
             if ((hold & 0xffff) != ((hold >> 16) ^ 0xffff)) {
                 strm->msg = (char *)"invalid stored block lengths";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
             state->length = (unsigned)hold & 0xffff;
             Tracev((stderr, "inflate:       stored length %u\n",
                     state->length));
             INITBITS();
             state->mode = COPY;
-        case COPY:
+        CASE_DECL(COPY)
             copy = state->length;
             if (copy) {
                 if (copy > have) copy = have;
@@ -832,9 +830,8 @@
                 break;
             }
             Tracev((stderr, "inflate:       stored end\n"));
-            state->mode = TYPE;
-            break;
-        case TABLE:
+	    STATE_CHANGE(TYPE);
+        CASE_DECL(TABLE)
             NEEDBITS(14);
             state->nlen = BITS(5) + 257;
             DROPBITS(5);
@@ -845,14 +842,13 @@
 #ifndef PKZIP_BUG_WORKAROUND
             if (state->nlen > 286 || state->ndist > 30) {
                 strm->msg = (char *)"too many length or distance symbols";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
 #endif
             Tracev((stderr, "inflate:       table sizes ok\n"));
             state->have = 0;
             state->mode = LENLENS;
-        case LENLENS:
+        CASE_DECL(LENLENS)
             while (state->have < state->ncode) {
                 NEEDBITS(3);
                 state->lens[order[state->have++]] = (unsigned short)BITS(3);
@@ -867,13 +863,12 @@
                                 &(state->lenbits), state->work);
             if (ret) {
                 strm->msg = (char *)"invalid code lengths set";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
             Tracev((stderr, "inflate:       code lengths ok\n"));
             state->have = 0;
             state->mode = CODELENS;
-        case CODELENS:
+        CASE_DECL(CODELENS)
             while (state->have < state->nlen + state->ndist) {
                 for (;;) {
                     this = state->lencode[BITS(state->lenbits)];
@@ -891,8 +886,7 @@
                         DROPBITS(this.bits);
                         if (state->have == 0) {
                             strm->msg = (char *)"invalid bit length repeat";
-                            state->mode = BAD;
-                            break;
+			    STATE_CHANGE(BAD);
                         }
                         len = state->lens[state->have - 1];
                         copy = 3 + BITS(2);
@@ -914,17 +908,13 @@
                     }
                     if (state->have + copy > state->nlen + state->ndist) {
                         strm->msg = (char *)"invalid bit length repeat";
-                        state->mode = BAD;
-                        break;
+			STATE_CHANGE(BAD);
                     }
                     while (copy--)
                         state->lens[state->have++] = (unsigned short)len;
                 }
             }
 
-            /* handle error breaks in while */
-            if (state->mode == BAD) break;
-
             /* build code tables */
             state->next = state->codes;
             state->lencode = (code const FAR *)(state->next);
@@ -933,8 +923,7 @@
                                 &(state->lenbits), state->work);
             if (ret) {
                 strm->msg = (char *)"invalid literal/lengths set";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
             state->distcode = (code const FAR *)(state->next);
             state->distbits = 6;
@@ -942,12 +931,11 @@
                             &(state->next), &(state->distbits), state->work);
             if (ret) {
                 strm->msg = (char *)"invalid distances set";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
             Tracev((stderr, "inflate:       codes ok\n"));
             state->mode = LEN;
-        case LEN:
+        CASE_DECL(LEN)
             if (have >= 6 && left >= 258) {
                 RESTORE();
                 inflate_fast(strm, out);
@@ -975,22 +963,19 @@
                 Tracevv((stderr, this.val >= 0x20 && this.val < 0x7f ?
                         "inflate:         literal '%c'\n" :
                         "inflate:         literal 0x%02x\n", this.val));
-                state->mode = LIT;
-                break;
+		STATE_CHANGE(LIT);
             }
             if (this.op & 32) {
                 Tracevv((stderr, "inflate:         end of block\n"));
-                state->mode = TYPE;
-                break;
+		STATE_CHANGE(TYPE);
             }
             if (this.op & 64) {
                 strm->msg = (char *)"invalid literal/length code";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
             state->extra = (unsigned)(this.op) & 15;
             state->mode = LENEXT;
-        case LENEXT:
+        CASE_DECL(LENEXT)
             if (state->extra) {
                 NEEDBITS(state->extra);
                 state->length += BITS(state->extra);
@@ -998,7 +983,7 @@
             }
             Tracevv((stderr, "inflate:         length %u\n", state->length));
             state->mode = DIST;
-        case DIST:
+        CASE_DECL(DIST)
             for (;;) {
                 this = state->distcode[BITS(state->distbits)];
                 if ((unsigned)(this.bits) <= bits) break;
@@ -1017,13 +1002,12 @@
             DROPBITS(this.bits);
             if (this.op & 64) {
                 strm->msg = (char *)"invalid distance code";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
             state->offset = (unsigned)this.val;
             state->extra = (unsigned)(this.op) & 15;
             state->mode = DISTEXT;
-        case DISTEXT:
+        CASE_DECL(DISTEXT)
             if (state->extra) {
                 NEEDBITS(state->extra);
                 state->offset += BITS(state->extra);
@@ -1032,18 +1016,16 @@
 #ifdef INFLATE_STRICT
             if (state->offset > state->dmax) {
                 strm->msg = (char *)"invalid distance too far back";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
 #endif
             if (state->offset > state->whave + out - left) {
                 strm->msg = (char *)"invalid distance too far back";
-                state->mode = BAD;
-                break;
+		STATE_CHANGE(BAD);
             }
             Tracevv((stderr, "inflate:         distance %u\n", state->offset));
             state->mode = MATCH;
-        case MATCH:
+        CASE_DECL(MATCH)
             if (left == 0) goto inf_leave;
             copy = out - left;
             if (state->offset > copy) {         /* copy from window */
@@ -1066,15 +1048,15 @@
             do {
                 *put++ = *from++;
             } while (--copy);
-            if (state->length == 0) state->mode = LEN;
+            if (state->length == 0)
+		STATE_CHANGE(LEN);
             break;
-        case LIT:
+        CASE_DECL(LIT)
             if (left == 0) goto inf_leave;
             *put++ = (unsigned char)(state->length);
             left--;
-            state->mode = LEN;
-            break;
-        case CHECK:
+	    STATE_CHANGE(LEN);
+        CASE_DECL(CHECK)
             if (state->wrap) {
                 NEEDBITS(32);
                 out -= left;
@@ -1090,36 +1072,34 @@
 #endif
                      REVERSE(hold)) != state->check) {
                     strm->msg = (char *)"incorrect data check";
-                    state->mode = BAD;
-                    break;
+		    STATE_CHANGE(BAD);
                 }
                 INITBITS();
                 Tracev((stderr, "inflate:   check matches trailer\n"));
             }
 #ifdef GUNZIP
             state->mode = LENGTH;
-        case LENGTH:
+        CASE_DECL(LENGTH)
             if (state->wrap && state->flags) {
                 NEEDBITS(32);
                 if (hold != (state->total & 0xffffffffUL)) {
                     strm->msg = (char *)"incorrect length check";
-                    state->mode = BAD;
-                    break;
+		    STATE_CHANGE(BAD);
                 }
                 INITBITS();
                 Tracev((stderr, "inflate:   length matches trailer\n"));
             }
 #endif
             state->mode = DONE;
-        case DONE:
+        CASE_DECL(DONE)
             ret = Z_STREAM_END;
             goto inf_leave;
-        case BAD:
+        CASE_DECL(BAD)
             ret = Z_DATA_ERROR;
             goto inf_leave;
-        case MEM:
+        CASE_DECL(MEM)
             return Z_MEM_ERROR;
-        case SYNC:
+        CASE_DECL(SYNC)
         default:
             return Z_STREAM_ERROR;
         }
