From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Creating objects manually and repack
Date: Sat, 5 Aug 2006 01:46:55 -0400
Message-ID: <20060805054655.GB18679@spearce.org>
References: <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org> <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com> <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com> <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org> <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com> <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org> <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com> <46a038f90608042115m71adc8ffo77de7940efa847a8@mail.gmail.com> <9e4733910608042212p6bf56224ye0ecf3f06b2840cf@mail.gmail.com> <20060805052135.GA18679@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 05 07:47:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9F09-0008Ka-KA
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 07:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWHEFrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 01:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161419AbWHEFrF
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 01:47:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:62413 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161163AbWHEFrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 01:47:04 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9Ezw-00072M-TS; Sat, 05 Aug 2006 01:46:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 66C9C20FB77; Sat,  5 Aug 2006 01:46:55 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060805052135.GA18679@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24887>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Shawn Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 8/5/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > >On 8/5/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > >> On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > >> > and you're basically all done. The above would turn each *,v file into 
> > >a
> > >> > *-<sha>.pack/*-<sha>.idx file pair, so you'd have exactly as many
> > >> > pack-files as you have *,v files.
> > >>
> > >> I'll end up with 110,000 pack files.
> > >
> > >Then just do it every 100 files, and you'll only have 1,100 pack
> > >files, and it'll be fine.
> > 
> > This is something that has to be tuned. If you wait too long
> > everything spills out of RAM and you go totally IO bound for days. If
> > you do it too often you end up with too many packs and it takes a day
> > to repack them.
> > 
> > If I had a way to pipe the all of the objects into repack one at a
> > time without repack doing multiple passes none of this tuning would be
> > necessary. In this model the standalone objects never get created in
> > the first place. The fastest IO is IO that has been eliminated.
> 
> I'm almost done with what I'm calling `git-fast-import`.

OK, now I'm done.  I'm attaching the code.  Toss it into the Makefile
as git-fast-import and recompile.

I tested it with the following Perl script, feeding the Perl script
a list of files that I wanted blobs for on STDIN:

	while (<>) {
		chop;
		print pack('L', -s $_);
		open(F, $_);
		my $buf;
		print $buf while read(F,$buf,128*1024) > 0;
		close F;
	}

This gave me an execution order of:

	find . -name '*.c' | perl test.pl | git-fast-import in.pack
	git-index-pack in.pack

at which point in.pack claims to be a completely valid pack with an
index of in.idx.  Move these into .git/objects/pack, generate trees
and commits, and run git-repack -a -d.  If the order you feed the
objects to git-fast-import in is reasonable (do one RCS file at a
time, feed most recent to least recent revisions) you may not get
any major benefit from using -f during your final repack.

The code for git-fast-import could probably be tweaked to accept
trees and commits too, which would permit you to stream the entire
CVS repository into a single pack file.  :-)

I can't help you decompress the RCS files faster, but hopefully
this will help you generate the GIT pack faster.  Hopefully you
can make use of it!

-- 
Shawn.

--DocE+STaALJfprDB
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
static int packfd;
static int current_depth;
static void *lastdat;
static unsigned long lastdatlen;
static unsigned char lastsha1[20];

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

static void write_blob (void *dat, unsigned long datlen)
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
	} else {
		current_depth = 0;
		s.next_in = dat;
		s.avail_in = datlen;
		hdrlen = encode_header(OBJ_BLOB, datlen, hdr);
		if (ywrite(packfd, hdr, hdrlen) != hdrlen)
			die("Can't write object header: %s", strerror(errno));
	}

	s.avail_out = deflateBound(&s, s.avail_in);
	s.next_out = out = xmalloc(s.avail_out);
	while (deflate(&s, Z_FINISH) == Z_OK)
		/* nothing */;
	deflateEnd(&s);

	if (ywrite(packfd, out, s.total_out) != s.total_out)
		die("Failed writing compressed data %s", strerror(errno));

	free(out);
	if (delta)
		free(delta);
}

static void init_pack_header ()
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
}

static void fixup_header_footer ()
{
	SHA_CTX c;
	char hdr[8];
	unsigned char sha1[20];
	unsigned long cnt;
	char *buf;
	size_t n;

	if (lseek(packfd, 0, SEEK_SET) != 0)
		die("Failed seeking to start: %s", strerror(errno));

	SHA1_Init(&c);
	if (yread(packfd, hdr, 8) != 8)
		die("Failed reading header: %s", strerror(errno));
	SHA1_Update(&c, hdr, 8);

fprintf(stderr, "%lu objects\n", object_count);
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

	SHA1_Final(sha1, &c);
	if (ywrite(packfd, sha1, sizeof(sha1)) != sizeof(sha1))
		die("Failed writing pack checksum: %s", strerror(errno));
}

int main (int argc, const char **argv)
{
	packfd = open(argv[1], O_RDWR|O_CREAT|O_TRUNC, 0666);
	if (packfd < 0)
		die("Can't create pack file %s: %s", argv[1], strerror(errno));

	init_pack_header();
	for (;;) {
		unsigned long datlen;
		int hdrlen;
		void *dat;
		char hdr[128];
		unsigned char sha1[20];
		SHA_CTX c;

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

		write_blob(dat, datlen);
		object_count++;
		printf("%s\n", sha1_to_hex(sha1));
		fflush(stdout);

		if (lastdat)
			free(lastdat);
		lastdat = dat;
		lastdatlen = datlen;
		memcpy(lastsha1, sha1, sizeof(sha1));
	}
	fixup_header_footer();
	close(packfd);

	return 0;
}

--DocE+STaALJfprDB--
