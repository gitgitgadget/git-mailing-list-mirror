From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Fri, 18 Aug 2006 00:03:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 18 06:03:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDvaA-0001Nr-7h
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 06:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWHREDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 00:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWHREDi
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 00:03:38 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60194 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932335AbWHREDi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 00:03:38 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4600DRBDY1XE40@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 18 Aug 2006 00:03:37 -0400 (EDT)
In-reply-to: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25618>

On Wed, 16 Aug 2006, Jon Smirl wrote:

> Shawn put together a new version of his import utility that packs all
> of the deltas from a run into a single blob instead of one blob per
> delta. The idea is to put 10 or more deltas into each delta entry
> instead of one. The index format would map the 10 sha1's to a single
> packed delta entry which would be expanded when needed. Note that you
> probably needed multiple entries out of the delta pack to generate the
> revision you were looking for so this is no real loss on extraction.
> 
> I ran it overnight on mozcvs. If his delta pack code is correct this
> is a huge win.
> 
> One entry per delta -  845,42,0150
> Packed deltas - 295,018,474
> 65% smaller

Well, I have to state that I don't believe those results to be right.

Not that I question the results you obtained, but rather that Shawn's 
pack generation is most probably broken.

Since I was highly suspicious looking at the above size difference (it 
is just too good to be true), I did a quick hack to pack-objects.c to 
produce packs with all deltas depending on the same root object into the 
same zlib stream.  In effect I implemented exactly what Shawn pretends 
to have done but directly in pack-objects.c so git-repack could be used 
with existing repositories like the linux kernel in order to validate 
the concept.

Results:

One entry per delta - 122,103,455 
Packed (or grouped) deltas : 108,479,014

Only 11% smaller.

I was really enthousiastic at first when I saw the result you obtained, 
but I no longer believe it can be right.  

Furthermore, such a pack organization has many disadvantages: it 
prevents trivial delta data reuse for incremental push/pull operations 
which is a huge performance penalty (bad for servers), as well as making 
random object extraction from such a pack somewhat more complex.  Those 
disadvantages greatly outweight the 11% size saving IMHO.

A better way to get such a size saving is to increase the window and 
depth parameters.  For example, a window of 20 and depth of 20 can 
usually provide a pack size saving greater than 11% with none of the 
disadvantages mentioned above.

I therefore don't think this idea should be pursued any further.

For completeness you can find my changes to pack-objects below.  Beware 
that this produces packs that cannot be read back so backup your 
repository first before playing with this.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 448461b..bfae892 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -227,7 +227,7 @@ static int encode_header(enum object_typ
 	int n = 1;
 	unsigned char c;
 
-	if (type < OBJ_COMMIT || type > OBJ_DELTA)
+	if (type < 0 || type > OBJ_DELTA)
 		die("bad type %d", type);
 
 	c = (type << 4) | (size & 15);
@@ -332,6 +332,8 @@ static unsigned long write_object(struct
 	return hdrlen + datalen;
 }
 
+#if 0
+
 static unsigned long write_one(struct sha1file *f,
 			       struct object_entry *e,
 			       unsigned long offset)
@@ -349,6 +351,107 @@ static unsigned long write_one(struct sh
 	return offset;
 }
 
+#else
+
+static unsigned count_delta_childs(struct object_entry *e, unsigned long o)
+{
+	unsigned count = 0;
+	struct object_entry *child = e->delta_child;
+	while (child) {
+		count += 1 + count_delta_childs(child, o);
+		if (child->offset)
+			die("object already seen???");
+		child->offset = o;
+		child = child->delta_sibling;
+	}
+	return count;
+}
+
+static unsigned long write_delta_headers(struct sha1file *f, struct object_entry *e, unsigned long *size)
+{
+	unsigned long offset = 0;
+	struct object_entry *child = e->delta_child;
+	while (child) {
+		unsigned char header[10];
+		unsigned hdrlen;
+		hdrlen = encode_header(OBJ_DELTA, child->delta_size, header);
+		*size += child->delta_size;
+		sha1write(f, header, hdrlen);
+		sha1write(f, child->delta, 20);
+		offset += hdrlen + 20;
+		offset += write_delta_headers(f, child, size);
+		child = child->delta_sibling;
+	}
+	return offset;
+}
+
+static void * concat_delta_data(struct object_entry *e, void *buf)
+{
+	struct object_entry *child = e->delta_child;
+	while (child) {
+		char type[10];
+		unsigned long size;
+		void *data = read_sha1_file(child->sha1, type, &size);
+		if (!data)
+			die("unable to read %s", sha1_to_hex(child->sha1));
+		data = delta_against(data, size, child);
+		memcpy(buf, data, child->delta_size);
+		buf += child->delta_size;
+		free(data);
+		written++;
+		written_delta++;
+		buf = concat_delta_data(child, buf);
+		child = child->delta_sibling;
+	}
+	return buf;
+}
+
+static unsigned long write_one(struct sha1file *f,
+			       struct object_entry *e,
+			       unsigned long offset)
+{
+	unsigned char header[10];
+	unsigned count, hdrlen;
+	unsigned long size;
+	void *buf, *p;
+
+	if (e->offset)
+		/* offset starts from header size and cannot be zero
+		 * if it is written already.
+		 */
+		return offset;
+	if (!e->delta) {
+		e->offset = offset;
+		return offset + write_object(f, e);
+	}
+
+	/* find delta root object */
+	while (e->delta)
+		e = e->delta;
+
+	/* count how many deltas depend on it */
+	count = count_delta_childs(e, offset);
+
+	/* write header for object group */
+	hdrlen = encode_header(0, count, header);
+	sha1write(f, header, hdrlen);
+	offset += hdrlen;
+
+	/* write each object's header and find total data size */
+	size = 0;
+	offset += write_delta_headers(f, e, &size);
+
+	/* write concatenated object data buffer */
+	buf = xmalloc(size);
+	p = concat_delta_data(e, buf);	
+	offset += sha1write_compressed(f, buf, p-buf);
+	free(buf);
+
+	return offset;
+}
+
+#endif
+
 static void write_pack_file(void)
 {
 	int i;


Nicolas
