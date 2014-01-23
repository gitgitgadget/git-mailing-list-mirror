From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Wed, 22 Jan 2014 18:05:36 -0800
Message-ID: <20140123020536.GP18964@google.com>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 03:05:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W69fy-0005bY-4L
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 03:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbaAWCFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jan 2014 21:05:43 -0500
Received: from mail-gg0-f171.google.com ([209.85.161.171]:58864 "EHLO
	mail-gg0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbaAWCFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 21:05:40 -0500
Received: by mail-gg0-f171.google.com with SMTP id q4so142603ggn.30
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 18:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=j9SC+X7zdmGKZ9HB/jHk3FRhuJtopV08oOH15Rim70M=;
        b=xT9SXchIcpRAlwwGxnvO1hQzhZ6i6jaJhd/JhJFDHWgBmu3i37+YMe7KyzeU3b1iGd
         anQa6B2KZXDO360TOpiWwOIbmU91mLwq4hFGezacEQxd+h174an24HyEzJyKFPcLTd/g
         4jFbMZZkG2tfAE50jaRnzWz6Zwm4+kThhqLtNaGBdtiaZEGFoRrZ2ajm1gJpDFweAs2h
         3K2ULBfMGsyu1z4JYAOuA6N7FwcXx6JsWaGJ40SzamlPqvChWBiMMDx/10Smk9uLf4zR
         zHj5gLBuRmBYzc0zCYL9Z/574tUNTqOTXNEuoaleThvTs3fOWZDayl/3IUEKPzgjirpp
         9oMQ==
X-Received: by 10.236.98.39 with SMTP id u27mr5192565yhf.27.1390442739255;
        Wed, 22 Jan 2014 18:05:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 44sm30768307yhp.17.2014.01.22.18.05.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 18:05:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131221135953.GH21145@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240894>

Hi,

Jeff King wrote:

> EWAH is a word-aligned compressed variant of a bitset (i.e. a data
> structure that acts as a 0-indexed boolean array for many entries).

I suspect that for some callers it's not word-aligned.

Without the following squashed in, commits 212f2ffb and later fail t531=
0
on some machines[1].

On ARMv5:

	expecting success:=20
		git rev-list --test-bitmap HEAD

	*** Error in `/=ABPKGBUILDDIR=BB/git': realloc(): invalid pointer: 0x0=
08728b0 ***
	Aborted
	not ok 3 - rev-list --test-bitmap verifies bitmaps

On sparc:

	expecting success:=20
		git rev-list --test-bitmap HEAD

	Bus error
	not ok 3 - rev-list --test-bitmap verifies bitmaps

Hopefully it's possible to get the alignment right in the caller
and tweak the signature to require that instead of using unaligned
reads like this.  There's still something wrong after this patch ---
the new result is a NULL pointer dereference in t5310.7 "enumerate
--objects (full bitmap)".

  (gdb) run
  Starting program: /home/jrnieder/src/git/git rev-list --objects --use=
-bitmap-index HEAD
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/sparc-linux-gnu/libthread_db.so=
=2E1".
  537ea4d3eb79c95f602873b1167c480006d2ac2d
[...]
  ec635144f60048986bc560c5576355344005e6e7

  Program received signal SIGSEGV, Segmentation fault.
  0x001321c0 in sha1_to_hex (sha1=3D0x0) at hex.c:68
  68                      unsigned int val =3D *sha1++;
  (gdb) bt
  #0  0x001321c0 in sha1_to_hex (sha1=3D0x0) at hex.c:68
  #1  0x000b839c in show_object_fast (sha1=3D0x0, type=3DOBJ_TREE, excl=
ude=3D0, name_hash=3D0, found_pack=3D0x2b8480, found_offset=3D4338) at =
builtin/rev-list.c:270
  #2  0x00158abc in show_objects_for_type (objects=3D0x2b2498, type_fil=
ter=3D0x2b0fb0, object_type=3DOBJ_TREE, show_reach=3D0xb834c <show_obje=
ct_fast>) at pack-bitmap.c:640
  #3  0x001592d0 in traverse_bitmap_commit_list (show_reachable=3D0xb83=
4c <show_object_fast>) at pack-bitmap.c:818
  #4  0x000b894c in cmd_rev_list (argc=3D2, argv=3D0xffffd688, prefix=3D=
0x0) at builtin/rev-list.c:369
  #5  0x00014024 in run_builtin (p=3D0x256e38 <commands+1020>, argc=3D4=
, argv=3D0xffffd688) at git.c:314
  #6  0x00014330 in handle_builtin (argc=3D4, argv=3D0xffffd688) at git=
=2Ec:487
  #7  0x000144a8 in run_argv (argcp=3D0xffffd5ec, argv=3D0xffffd5a0) at=
 git.c:533
  #8  0x000146fc in main (argc=3D4, av=3D0xffffd684) at git.c:616
  (gdb) frame 2
  #2  0x00158abc in show_objects_for_type (objects=3D0x2b2498, type_fil=
ter=3D0x2b0fb0, object_type=3DOBJ_TREE, show_reach=3D0xb834c <show_obje=
ct_fast>) at pack-bitmap.c:640
  640                             show_reach(sha1, object_type, 0, hash=
, bitmap_git.pack, entry->offset);
  (gdb) p entry->nr
  $1 =3D 4294967295

Line numbers are in the context of 8e6341d9.  Ideas?

[1] ARMv5 and sparc:
https://buildd.debian.org/status/logs.php?pkg=3Dgit&suite=3Dexperimenta=
l

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index aed0da6..696a8ec 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -110,25 +110,38 @@ int ewah_serialize(struct ewah_bitmap *self, int =
fd)
 	return ewah_serialize_to(self, write_helper, (void *)(intptr_t)fd);
 }
=20
+#define get_be32(p) ( \
+	(*((unsigned char *)(p) + 0) << 24) | \
+	(*((unsigned char *)(p) + 1) << 16) | \
+	(*((unsigned char *)(p) + 2) <<  8) | \
+	(*((unsigned char *)(p) + 3) <<  0) )
+
+#define get_be64(p) ( \
+	((uint64_t) get_be32(p) << 32) | \
+	get_be32((unsigned char *)(p) + 4) )
+
 int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
 {
-	uint32_t *read32 =3D map;
-	eword_t *read64;
+	unsigned char *p =3D map;
 	size_t i;
=20
-	self->bit_size =3D ntohl(*read32++);
-	self->buffer_size =3D self->alloc_size =3D ntohl(*read32++);
+	self->bit_size =3D get_be32(p);
+	p +=3D 4;
+	self->buffer_size =3D self->alloc_size =3D get_be32(p);
+	p +=3D 4;
 	self->buffer =3D ewah_realloc(self->buffer,
 		self->alloc_size * sizeof(eword_t));
=20
 	if (!self->buffer)
 		return -1;
=20
-	for (i =3D 0, read64 =3D (void *)read32; i < self->buffer_size; ++i)
-		self->buffer[i] =3D ntohll(*read64++);
+	for (i =3D 0; i < self->buffer_size; ++i) {
+		self->buffer[i] =3D get_be64(p);
+		p +=3D 8;
+	}
=20
-	read32 =3D (void *)read64;
-	self->rlw =3D self->buffer + ntohl(*read32++);
+	self->rlw =3D self->buffer + get_be32(p);
+	p +=3D 4;
=20
 	return (3 * 4) + (self->buffer_size * 8);
 }
