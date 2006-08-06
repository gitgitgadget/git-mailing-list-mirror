From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fast-import and unique objects.
Date: Sun, 6 Aug 2006 14:03:24 -0400
Message-ID: <20060806180323.GA19120@spearce.org>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com> <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 06 20:03:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9myN-0000Rx-01
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 20:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWHFSDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 14:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWHFSDa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 14:03:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:64998 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750966AbWHFSD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 14:03:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9my7-0003W5-Vd; Sun, 06 Aug 2006 14:03:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 18FAC20FB77; Sun,  6 Aug 2006 14:03:24 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24987>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/6/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> >This model has a lot of object duplication. I generated 949,305
> >revisions, but only 754,165 are unique. I'll modify my code to build a
> >hash of the objects it has seen and then not send the duplicates to
> >fast-import. Those 195,140 duplicated objects may be what is tripping
> >index-pack up.
> 
> New run is finished with duplicate removal.
> 
> Time to run is unchanged, still 2hrs. Run time is IO bound not CPU.
> Pack file is 845MB instead of 934MB.
> git-index-pack works now, it takes 4 CPU minutes to run.
> Index file is 18MB.

I'm attaching a new version of fast-import.c which generates the
index, and does duplicate removal.  However I think that it might
be slightly faster for you to do the duplicate removal in Python
as it saves the user-kernel-user copy of the file data.  Even so,
this new version should save you those 4 CPU minutes as the index
will be generated from the in-memory SHA1s rather than needing to
recompute them.

I've changed the calling convention:

  - It now takes the pack's base name as its first parameter. It
    appends ".pack" and ".idx" to form the actual file names its
    writing to.

  - It expects an estimated object count as its second parameter.
    In your case this would be something around 760000.  This tells
    it how large of an object table to allocate, with each entry
    being 24 bytes + 1 pointer (28 or 32 bytes).  Overshooting
	this number will cause it to degrade by allocating one
	overflow entry at a time from malloc.

So the new version should take about 20 MB of memory and should
produce a valid pack and index in the same time as it does only
the pack now.  Plus it won't generate duplicates.
 
> So it looks like the first stage code is working. Next I need to
> modify cvs2svn to keep track of the sha-1 through it's sorting process
> instead of file:revision.

When you get down to tree writing and commit writing we might want
to do something similiar with the trees and commits.  I can modify
fast-import to also store those off into a pack.

-- 
Shawn.

--tKW2IUtsqtDRztdT
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="fast-import.c"

#include "builtin.h"
#include "cache.h"
#include "object.h"
#include "blob.h"
#include "delta.h"
#include "pack.h"
#include "csum-file.h"

static int max_depth = 10;
static unsigned long object_count;
static unsigned long duplicate_count;
static unsigned long packoff;
static unsigned long overflow_count;
static int packfd;
static int current_depth;
static void *lastdat;
static unsigned long lastdatlen;
static unsigned char lastsha1[20];
static unsigned char packsha1[20];

struct object_entry
{
	struct object_entry *next;
	unsigned long offset;
	unsigned char sha1[20];
};

struct overflow_object_entry
{
	struct overflow_object_entry *next;
	struct object_entry oe;
};

struct object_entry *pool_start;
struct object_entry *pool_next;
struct object_entry *pool_end;
struct overflow_object_entry *overflow;
struct object_entry *table[1 << 16];

static struct object_entry* new_object(unsigned char *sha1)
{
	if (pool_next != pool_end) {
		struct object_entry *e = pool_next++;
		memcpy(e->sha1, sha1, sizeof(e->sha1));
		return e;
	} else {
		struct overflow_object_entry *e;

		e = xmalloc(sizeof(struct overflow_object_entry));
		e->next = overflow;
		memcpy(e->oe.sha1, sha1, sizeof(e->oe.sha1));
		overflow = e;
		overflow_count++;
		return &e->oe;
	}
}

static struct object_entry* insert_object(unsigned char *sha1)
{
	unsigned int h = sha1[0] << 8 | sha1[1];
	struct object_entry *e = table[h];
	struct object_entry *p = 0;

	while (e) {
		if (!memcmp(sha1, e->sha1, sizeof(e->sha1)))
			return e;
		p = e;
		e = e->next;
	}

	e = new_object(sha1);
	e->next = 0;
	e->offset = 0;
	if (p)
		p->next = e;
	else
		table[h] = e;
	return e;
}

static ssize_t yread(int fd, void *buffer, size_t length)
{
	ssize_t ret = 0;
	while (ret < length) {
		ssize_t size = xread(fd, (char *) buffer + ret, length - ret);
		if (size < 0) {
			return size;
		}
		if (size == 0) {
			return ret;
		}
		ret += size;
	}
	return ret;
}

static ssize_t ywrite(int fd, void *buffer, size_t length)
{
	ssize_t ret = 0;
	while (ret < length) {
		ssize_t size = xwrite(fd, (char *) buffer + ret, length - ret);
		if (size < 0) {
			return size;
		}
		if (size == 0) {
			return ret;
		}
		ret += size;
	}
	return ret;
}

static unsigned long encode_header(enum object_type type, unsigned long size, unsigned char *hdr)
{
	int n = 1;
	unsigned char c;

	if (type < OBJ_COMMIT || type > OBJ_DELTA)
		die("bad type %d", type);

	c = (type << 4) | (size & 15);
	size >>= 4;
	while (size) {
		*hdr++ = c | 0x80;
		c = size & 0x7f;
		size >>= 7;
		n++;
	}
	*hdr = c;
	return n;
}

static void write_blob(void *dat, unsigned long datlen)
{
	z_stream s;
	void *out, *delta;
	unsigned char hdr[64];
	unsigned long hdrlen, deltalen;

	if (lastdat && current_depth < max_depth) {
		delta = diff_delta(lastdat, lastdatlen,
			dat, datlen,
			&deltalen, 0);
	} else
		delta = 0;

	memset(&s, 0, sizeof(s));
	deflateInit(&s, zlib_compression_level);

	if (delta) {
		current_depth++;
		s.next_in = delta;
		s.avail_in = deltalen;
		hdrlen = encode_header(OBJ_DELTA, deltalen, hdr);
		if (ywrite(packfd, hdr, hdrlen) != hdrlen)
			die("Can't write object header: %s", strerror(errno));
		if (ywrite(packfd, lastsha1, sizeof(lastsha1)) != sizeof(lastsha1))
			die("Can't write object base: %s", strerror(errno));
		packoff += hdrlen + sizeof(lastsha1);
	} else {
		current_depth = 0;
		s.next_in = dat;
		s.avail_in = datlen;
		hdrlen = encode_header(OBJ_BLOB, datlen, hdr);
		if (ywrite(packfd, hdr, hdrlen) != hdrlen)
			die("Can't write object header: %s", strerror(errno));
		packoff += hdrlen;
	}

	s.avail_out = deflateBound(&s, s.avail_in);
	s.next_out = out = xmalloc(s.avail_out);
	while (deflate(&s, Z_FINISH) == Z_OK)
		/* nothing */;
	deflateEnd(&s);

	if (ywrite(packfd, out, s.total_out) != s.total_out)
		die("Failed writing compressed data %s", strerror(errno));
	packoff += s.total_out;

	free(out);
	if (delta)
		free(delta);
}

static void init_pack_header()
{
	const char* magic = "PACK";
	unsigned long version = 2;
	unsigned long zero = 0;

	version = htonl(version);

	if (ywrite(packfd, (char*)magic, 4) != 4)
		die("Can't write pack magic: %s", strerror(errno));
	if (ywrite(packfd, &version, 4) != 4)
		die("Can't write pack version: %s", strerror(errno));
	if (ywrite(packfd, &zero, 4) != 4)
		die("Can't write 0 object count: %s", strerror(errno));
	packoff = 4 * 3;
}

static void fixup_header_footer()
{
	SHA_CTX c;
	char hdr[8];
	unsigned long cnt;
	char *buf;
	size_t n;

	if (lseek(packfd, 0, SEEK_SET) != 0)
		die("Failed seeking to start: %s", strerror(errno));

	SHA1_Init(&c);
	if (yread(packfd, hdr, 8) != 8)
		die("Failed reading header: %s", strerror(errno));
	SHA1_Update(&c, hdr, 8);

	cnt = htonl(object_count);
	SHA1_Update(&c, &cnt, 4);
	if (ywrite(packfd, &cnt, 4) != 4)
		die("Failed writing object count: %s", strerror(errno));

	buf = xmalloc(128 * 1024);
	for (;;) {
		n = xread(packfd, buf, 128 * 1024);
		if (n <= 0)
			break;
		SHA1_Update(&c, buf, n);
	}
	free(buf);

	SHA1_Final(packsha1, &c);
	if (ywrite(packfd, packsha1, sizeof(packsha1)) != sizeof(packsha1))
		die("Failed writing pack checksum: %s", strerror(errno));
}

static int oecmp (const void *_a, const void *_b)
{
	struct object_entry *a = *((struct object_entry**)_a);
	struct object_entry *b = *((struct object_entry**)_b);
	return memcmp(a->sha1, b->sha1, sizeof(a->sha1));
}

static void write_index(const char *idx_name)
{
	struct sha1file *f;
	struct object_entry **idx, **c, **last;
	struct object_entry *e;
	struct overflow_object_entry *o;
	unsigned int array[256];
	int i;

	/* Build the sorted table of object IDs. */
	idx = xmalloc(object_count * sizeof(struct object_entry*));
	c = idx;
	for (e = pool_start; e != pool_next; e++)
		*c++ = e;
	for (o = overflow; o; o = o->next)
		*c++ = &o->oe;
	last = idx + object_count;
	qsort(idx, object_count, sizeof(struct object_entry*), oecmp);

	/* Generate the fan-out array. */
	c = idx;
	for (i = 0; i < 256; i++) {
		struct object_entry **next = c;;
		while (next < last) {
			if ((*next)->sha1[0] != i)
				break;
			next++;
		}
		array[i] = htonl(next - idx);
		c = next;
	}

	f = sha1create("%s", idx_name);
	sha1write(f, array, 256 * sizeof(int));
	for (c = idx; c != last; c++) {
		unsigned int offset = htonl((*c)->offset);
		sha1write(f, &offset, 4);
		sha1write(f, (*c)->sha1, sizeof((*c)->sha1));
	}
	sha1write(f, packsha1, sizeof(packsha1));
	sha1close(f, NULL, 1);
	free(idx);
}

int main(int argc, const char **argv)
{
	const char *base_name = argv[1];
	int est_obj_cnt = atoi(argv[2]);
	char *pack_name;
	char *idx_name;

	pack_name = xmalloc(strlen(base_name) + 6);
	sprintf(pack_name, "%s.pack", base_name);
	idx_name = xmalloc(strlen(base_name) + 5);
	sprintf(idx_name, "%s.idx", base_name);

	packfd = open(pack_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
	if (packfd < 0)
		die("Can't create pack file %s: %s", pack_name, strerror(errno));

	pool_start = xmalloc(est_obj_cnt * sizeof(struct object_entry));
	pool_next = pool_start;
	pool_end = pool_start + est_obj_cnt;

	init_pack_header();
	for (;;) {
		unsigned long datlen;
		int hdrlen;
		void *dat;
		char hdr[128];
		unsigned char sha1[20];
		SHA_CTX c;
		struct object_entry *e;

		if (yread(0, &datlen, 4) != 4)

			break;

		dat = xmalloc(datlen);
		if (yread(0, dat, datlen) != datlen)
			break;

		hdrlen = sprintf(hdr, "blob %lu", datlen) + 1;
		SHA1_Init(&c);
		SHA1_Update(&c, hdr, hdrlen);
		SHA1_Update(&c, dat, datlen);
		SHA1_Final(sha1, &c);

		e = insert_object(sha1);
		if (!e->offset) {
			e->offset = packoff;
			write_blob(dat, datlen);
			object_count++;
			printf("%s\n", sha1_to_hex(sha1));
			fflush(stdout);

			if (lastdat)
				free(lastdat);
			lastdat = dat;
			lastdatlen = datlen;
			memcpy(lastsha1, sha1, sizeof(sha1));
		} else {
			duplicate_count++;
			free(dat);
		}
	}
	fixup_header_footer();
	close(packfd);
	write_index(idx_name);

	fprintf(stderr, "%lu objects, %lu duplicates, %lu pool overflow\n",
		object_count, duplicate_count, overflow_count);

	return 0;
}

--tKW2IUtsqtDRztdT--
