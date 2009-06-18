From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix big left-shifts of unsigned char
Date: Wed, 17 Jun 2009 17:22:27 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906171654310.16802@localhost.localdomain>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain> <E1MH3bD-0004g2-97@fencepost.gnu.org>
 <alpine.LFD.2.01.0906171543120.16802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: "Alfred M. Szmidt" <ams@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 02:23:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH5PO-0006f6-9O
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 02:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbZFRAXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 20:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbZFRAXC
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 20:23:02 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47985 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751340AbZFRAXB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 20:23:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5I0MSun001412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2009 17:22:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5I0MRpR030849;
	Wed, 17 Jun 2009 17:22:28 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0906171543120.16802@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.473 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121788>


Shifting 'unsigned char' or 'unsigned short' left can result in sign 
extension errors, since the C integer promotion rules means that the 
unsigned char/short will get implicitly promoted to a signed 'int' due to 
the shift (or due to other operations).

This normally doesn't matter, but if you shift things up sufficiently, it 
will now set the sign bit in 'int', and a subsequent cast to a bigger type 
(eg 'long' or 'unsigned long') will now sign-extend the value despite the 
original expression being unsigned.

One example of this would be something like

	unsigned long size;
	unsigned char c;

	size += c << 24;

where despite all the variables being unsigned, 'c << 24' ends up being a 
signed entity, and will get sign-extended when then doing the addition in 
an 'unsigned long' type.

Since git uses 'unsigned char' pointers extensively, we actually have this 
bug in a couple of places. 

I may have missed some, but this is the result of looking at

	git grep '[^0-9 	][ 	]*<<[ 	][a-z]' -- '*.c' '*.h'
	git grep '<<[   ]*24'

which catches at least the common byte cases (shifting variables by a 
variable amount, and shifting by 24 bits).

I also grepped for just 'unsigned char' variables in general, and 
converted the ones that most obviously ended up getting implicitly cast 
immediately anyway (eg hash_name(), encode_85()).

In addition to just avoiding 'unsigned char', this patch also tries to use 
a common idiom for the delta header size thing. We had three different 
variations on it: "& 0x7fUL" in one place (getting the sign extension 
right), and "& ~0x80" and "& 0x7f" in two other places (not getting it 
right). Apart from making them all just avoid using "unsigned char" at 
all, I also unified them to then use a simple "& 0x7f".

I considered making a sparse extension which warns about doing implicit 
casts from unsigned types to signed types, but it gets rather complex very 
quickly, so this is just a hack. 

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is _not_ tested in any way. And I got bored with getting rid of 
'unsigned char' variables, so I by no means did all of them, just the 
first few that caugth my grepping eye.

On Wed, 17 Jun 2009, Linus Torvalds wrote:
> 
> And I would suggest that Junio just not take patches from people who 
> aren't able to read the existing DCO. It's not worth the pain. 
> 
> 		Linus
> 

 attr.c                   |    3 +--
 base85.c                 |    2 +-
 builtin-pack-objects.c   |    3 +--
 builtin-unpack-objects.c |    4 ++--
 delta.h                  |    5 ++---
 index-pack.c             |    6 +++---
 patch-delta.c            |    2 +-
 sha1_file.c              |    3 +--
 8 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/attr.c b/attr.c
index 98eb636..f8f6faa 100644
--- a/attr.c
+++ b/attr.c
@@ -35,8 +35,7 @@ static struct git_attr *(git_attr_hash[HASHSIZE]);
 
 static unsigned hash_name(const char *name, int namelen)
 {
-	unsigned val = 0;
-	unsigned char c;
+	unsigned val = 0, c;
 
 	while (namelen--) {
 		c = *name++;
diff --git a/base85.c b/base85.c
index b88270f..b417a15 100644
--- a/base85.c
+++ b/base85.c
@@ -91,7 +91,7 @@ void encode_85(char *buf, const unsigned char *data, int bytes)
 		unsigned acc = 0;
 		int cnt;
 		for (cnt = 24; cnt >= 0; cnt -= 8) {
-			int ch = *data++;
+			unsigned ch = *data++;
 			acc |= ch << cnt;
 			if (--bytes == 0)
 				break;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9742b45..941cc2d 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -653,8 +653,7 @@ static void rehash_objects(void)
 
 static unsigned name_hash(const char *name)
 {
-	unsigned char c;
-	unsigned hash = 0;
+	unsigned c, hash = 0;
 
 	if (!name)
 		return 0;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 9a77323..8e831be 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -422,8 +422,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 static void unpack_one(unsigned nr)
 {
 	unsigned shift;
-	unsigned char *pack, c;
-	unsigned long size;
+	unsigned char *pack;
+	unsigned long size, c;
 	enum object_type type;
 
 	obj_list[nr].offset = consumed_bytes;
diff --git a/delta.h b/delta.h
index 40ccf5a..b9d333d 100644
--- a/delta.h
+++ b/delta.h
@@ -90,12 +90,11 @@ static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
 					       const unsigned char *top)
 {
 	const unsigned char *data = *datap;
-	unsigned char cmd;
-	unsigned long size = 0;
+	unsigned long cmd, size = 0;
 	int i = 0;
 	do {
 		cmd = *data++;
-		size |= (cmd & ~0x80) << i;
+		size |= (cmd & 0x7f) << i;
 		i += 7;
 	} while (cmd & 0x80 && data < top);
 	*datap = data;
diff --git a/index-pack.c b/index-pack.c
index 6e93ee6..0c92baf 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -293,8 +293,8 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size)
 
 static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_base)
 {
-	unsigned char *p, c;
-	unsigned long size;
+	unsigned char *p;
+	unsigned long size, c;
 	off_t base_offset;
 	unsigned shift;
 	void *data;
@@ -312,7 +312,7 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 		p = fill(1);
 		c = *p;
 		use(1);
-		size += (c & 0x7fUL) << shift;
+		size += (c & 0x7f) << shift;
 		shift += 7;
 	}
 	obj->size = size;
diff --git a/patch-delta.c b/patch-delta.c
index ed9db81..ef748ce 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -44,7 +44,7 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 			if (cmd & 0x01) cp_off = *data++;
 			if (cmd & 0x02) cp_off |= (*data++ << 8);
 			if (cmd & 0x04) cp_off |= (*data++ << 16);
-			if (cmd & 0x08) cp_off |= (*data++ << 24);
+			if (cmd & 0x08) cp_off |= ((unsigned) *data++ << 24);
 			if (cmd & 0x10) cp_size = *data++;
 			if (cmd & 0x20) cp_size |= (*data++ << 8);
 			if (cmd & 0x40) cp_size |= (*data++ << 16);
diff --git a/sha1_file.c b/sha1_file.c
index e73cd4f..8f5fe62 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1162,8 +1162,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {
 	unsigned shift;
-	unsigned char c;
-	unsigned long size;
+	unsigned long size, c;
 	unsigned long used = 0;
 
 	c = buf[used++];
