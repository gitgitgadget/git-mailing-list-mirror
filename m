From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 12:38:20 +0200
Message-ID: <20080723103820.GE15243@artemis.madism.org>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="RE3pQJLXZi4fr8Xo";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 12:39:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLbkj-0000JQ-W2
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 12:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYGWKiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 06:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbYGWKiZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 06:38:25 -0400
Received: from pan.madism.org ([88.191.52.104]:45643 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbYGWKiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 06:38:23 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 853483A5BB;
	Wed, 23 Jul 2008 12:38:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7CEDB1426D2; Wed, 23 Jul 2008 12:38:20 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080723101415.GA23769@atjola.homenet>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89626>


--RE3pQJLXZi4fr8Xo
Content-Type: multipart/mixed; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 10:14:15AM +0000, Bj=C3=B6rn Steinbrink wrote:
> Here's how to reproduce:
>=20
> #!/bin/bash
>=20
> [ -d git-bug ] || \
> 	git clone git://git.kernel.org/pub/scm/git/git git-bug
> cd git-bug
>=20
> git update-ref refs/remotes/origin/html 5ba2c22
> git update-ref refs/remotes/origin/man 2857e17
> git update-ref refs/remotes/origin/maint 2d9c572
> git update-ref refs/remotes/origin/master 93310a4
> git update-ref refs/remotes/origin/next 559998f
> git update-ref refs/remotes/origin/pu 010581c8
>=20
> git reset --hard origin/master
>=20
> sleep 1
>=20
> git reflog expire --expire=3D0 --all
>=20
> git repack -A -d -f --depth=3D10 --window=3D10
> git prune
>=20
> git config core.deltaBaseCacheLimit 100
>=20
> git fetch

  interestingly, replacing git-index-pack with:

#!/bin/sh
exec valgrind --log-file=3Dtrace.$$ $(dirname $0)/git-index-pack2 "$@"

  it yields a different error in the console:
    remote: Counting objects: 461, done.
    remote: Compressing objects: 100% (141/141), done.
    remote: Total 263 (delta 227), reused 155 (delta 121)
    Receiving objects: 100% (263/263), 95.55 KiB | 71 KiB/s, done.
    fatal: serious inflate inconsistency
    fatal: index-pack failed
    git fetch  2,63s user 0,08s system 51% cpu 5,275 total

the valgrind log is attached, and my index-pack.c as well since I did
the c->data =3D NULL change which may mess up line counts.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="index-pack.c"

#include "cache.h"
#include "delta.h"
#include "pack.h"
#include "csum-file.h"
#include "blob.h"
#include "commit.h"
#include "tag.h"
#include "tree.h"
#include "progress.h"
#include "fsck.h"

static const char index_pack_usage[] =
"git index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";

struct object_entry
{
	struct pack_idx_entry idx;
	unsigned long size;
	unsigned int hdr_size;
	enum object_type type;
	enum object_type real_type;
};

union delta_base {
	unsigned char sha1[20];
	off_t offset;
};

struct base_data {
	struct base_data *base;
	struct base_data *child;
	struct object_entry *obj;
	void *data;
	unsigned long size;
};

/*
 * Even if sizeof(union delta_base) == 24 on 64-bit archs, we really want
 * to memcmp() only the first 20 bytes.
 */
#define UNION_BASE_SZ	20

#define FLAG_LINK (1u<<20)
#define FLAG_CHECKED (1u<<21)

struct delta_entry
{
	union delta_base base;
	int obj_no;
};

static struct object_entry *objects;
static struct delta_entry *deltas;
static struct base_data *base_cache;
static size_t base_cache_used;
static int nr_objects;
static int nr_deltas;
static int nr_resolved_deltas;

static int from_stdin;
static int strict;
static int verbose;

static struct progress *progress;

/* We always read in 4kB chunks. */
static unsigned char input_buffer[4096];
static unsigned int input_offset, input_len;
static off_t consumed_bytes;
static SHA_CTX input_ctx;
static uint32_t input_crc32;
static int input_fd, output_fd, pack_fd;

static int mark_link(struct object *obj, int type, void *data)
{
	if (!obj)
		return -1;

	if (type != OBJ_ANY && obj->type != type)
		die("object type mismatch at %s", sha1_to_hex(obj->sha1));

	obj->flags |= FLAG_LINK;
	return 0;
}

/* The content of each linked object must have been checked
   or it must be already present in the object database */
static void check_object(struct object *obj)
{
	if (!obj)
		return;

	if (!(obj->flags & FLAG_LINK))
		return;

	if (!(obj->flags & FLAG_CHECKED)) {
		unsigned long size;
		int type = sha1_object_info(obj->sha1, &size);
		if (type != obj->type || type <= 0)
			die("object of unexpected type");
		obj->flags |= FLAG_CHECKED;
		return;
	}
}

static void check_objects(void)
{
	unsigned i, max;

	max = get_max_object_index();
	for (i = 0; i < max; i++)
		check_object(get_indexed_object(i));
}


/* Discard current buffer used content. */
static void flush(void)
{
	if (input_offset) {
		if (output_fd >= 0)
			write_or_die(output_fd, input_buffer, input_offset);
		SHA1_Update(&input_ctx, input_buffer, input_offset);
		memmove(input_buffer, input_buffer + input_offset, input_len);
		input_offset = 0;
	}
}

/*
 * Make sure at least "min" bytes are available in the buffer, and
 * return the pointer to the buffer.
 */
static void *fill(int min)
{
	if (min <= input_len)
		return input_buffer + input_offset;
	if (min > sizeof(input_buffer))
		die("cannot fill %d bytes", min);
	flush();
	do {
		ssize_t ret = xread(input_fd, input_buffer + input_len,
				sizeof(input_buffer) - input_len);
		if (ret <= 0) {
			if (!ret)
				die("early EOF");
			die("read error on input: %s", strerror(errno));
		}
		input_len += ret;
		if (from_stdin)
			display_throughput(progress, consumed_bytes + input_len);
	} while (input_len < min);
	return input_buffer;
}

static void use(int bytes)
{
	if (bytes > input_len)
		die("used more bytes than were available");
	input_crc32 = crc32(input_crc32, input_buffer + input_offset, bytes);
	input_len -= bytes;
	input_offset += bytes;

	/* make sure off_t is sufficiently large not to wrap */
	if (consumed_bytes > consumed_bytes + bytes)
		die("pack too large for current definition of off_t");
	consumed_bytes += bytes;
}

static char *open_pack_file(char *pack_name)
{
	if (from_stdin) {
		input_fd = 0;
		if (!pack_name) {
			static char tmpfile[PATH_MAX];
			snprintf(tmpfile, sizeof(tmpfile),
				 "%s/tmp_pack_XXXXXX", get_object_directory());
			output_fd = xmkstemp(tmpfile);
			pack_name = xstrdup(tmpfile);
		} else
			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
		if (output_fd < 0)
			die("unable to create %s: %s\n", pack_name, strerror(errno));
		pack_fd = output_fd;
	} else {
		input_fd = open(pack_name, O_RDONLY);
		if (input_fd < 0)
			die("cannot open packfile '%s': %s",
			    pack_name, strerror(errno));
		output_fd = -1;
		pack_fd = input_fd;
	}
	SHA1_Init(&input_ctx);
	return pack_name;
}

static void parse_pack_header(void)
{
	struct pack_header *hdr = fill(sizeof(struct pack_header));

	/* Header consistency check */
	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
		die("pack signature mismatch");
	if (!pack_version_ok(hdr->hdr_version))
		die("pack version %"PRIu32" unsupported",
			ntohl(hdr->hdr_version));

	nr_objects = ntohl(hdr->hdr_entries);
	use(sizeof(struct pack_header));
}

static void bad_object(unsigned long offset, const char *format,
		       ...) NORETURN __attribute__((format (printf, 2, 3)));

static void bad_object(unsigned long offset, const char *format, ...)
{
	va_list params;
	char buf[1024];

	va_start(params, format);
	vsnprintf(buf, sizeof(buf), format, params);
	va_end(params);
	die("pack has bad object at offset %lu: %s", offset, buf);
}

static void prune_base_data(struct base_data *retain)
{
	struct base_data *b = base_cache;
	for (b = base_cache;
	     base_cache_used > delta_base_cache_limit && b;
	     b = b->child) {
		if (b->data && b != retain) {
			free(b->data);
			b->data = NULL;
			base_cache_used -= b->size;
		}
	}
}

static void link_base_data(struct base_data *base, struct base_data *c)
{
	if (base)
		base->child = c;
	else
		base_cache = c;

	c->base = base;
	c->child = NULL;
	base_cache_used += c->size;
	prune_base_data(c);
}

static void unlink_base_data(struct base_data *c)
{
	struct base_data *base = c->base;
	if (base)
		base->child = NULL;
	else
		base_cache = NULL;
	if (c->data) {
		free(c->data);
		c->data = NULL;
		base_cache_used -= c->size;
	}
}

static void *unpack_entry_data(unsigned long offset, unsigned long size)
{
	z_stream stream;
	void *buf = xmalloc(size);

	memset(&stream, 0, sizeof(stream));
	stream.next_out = buf;
	stream.avail_out = size;
	stream.next_in = fill(1);
	stream.avail_in = input_len;
	inflateInit(&stream);

	for (;;) {
		int ret = inflate(&stream, 0);
		use(input_len - stream.avail_in);
		if (stream.total_out == size && ret == Z_STREAM_END)
			break;
		if (ret != Z_OK)
			bad_object(offset, "inflate returned %d", ret);
		stream.next_in = fill(1);
		stream.avail_in = input_len;
	}
	inflateEnd(&stream);
	return buf;
}

static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_base)
{
	unsigned char *p, c;
	unsigned long size;
	off_t base_offset;
	unsigned shift;
	void *data;

	obj->idx.offset = consumed_bytes;
	input_crc32 = crc32(0, Z_NULL, 0);

	p = fill(1);
	c = *p;
	use(1);
	obj->type = (c >> 4) & 7;
	size = (c & 15);
	shift = 4;
	while (c & 0x80) {
		p = fill(1);
		c = *p;
		use(1);
		size += (c & 0x7fUL) << shift;
		shift += 7;
	}
	obj->size = size;

	switch (obj->type) {
	case OBJ_REF_DELTA:
		hashcpy(delta_base->sha1, fill(20));
		use(20);
		break;
	case OBJ_OFS_DELTA:
		memset(delta_base, 0, sizeof(*delta_base));
		p = fill(1);
		c = *p;
		use(1);
		base_offset = c & 127;
		while (c & 128) {
			base_offset += 1;
			if (!base_offset || MSB(base_offset, 7))
				bad_object(obj->idx.offset, "offset value overflow for delta base object");
			p = fill(1);
			c = *p;
			use(1);
			base_offset = (base_offset << 7) + (c & 127);
		}
		delta_base->offset = obj->idx.offset - base_offset;
		if (delta_base->offset >= obj->idx.offset)
			bad_object(obj->idx.offset, "delta base offset is out of bound");
		break;
	case OBJ_COMMIT:
	case OBJ_TREE:
	case OBJ_BLOB:
	case OBJ_TAG:
		break;
	default:
		bad_object(obj->idx.offset, "unknown object type %d", obj->type);
	}
	obj->hdr_size = consumed_bytes - obj->idx.offset;

	data = unpack_entry_data(obj->idx.offset, obj->size);
	obj->idx.crc32 = input_crc32;
	return data;
}

static void *get_data_from_pack(struct object_entry *obj)
{
	off_t from = obj[0].idx.offset + obj[0].hdr_size;
	unsigned long len = obj[1].idx.offset - from;
	unsigned long rdy = 0;
	unsigned char *src, *data;
	z_stream stream;
	int st;

	src = xmalloc(len);
	data = src;
	do {
		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
		if (n <= 0)
			die("cannot pread pack file: %s", strerror(errno));
		rdy += n;
	} while (rdy < len);
	data = xmalloc(obj->size);
	memset(&stream, 0, sizeof(stream));
	stream.next_out = data;
	stream.avail_out = obj->size;
	stream.next_in = src;
	stream.avail_in = len;
	inflateInit(&stream);
	while ((st = inflate(&stream, Z_FINISH)) == Z_OK);
	inflateEnd(&stream);
	if (st != Z_STREAM_END || stream.total_out != obj->size)
		die("serious inflate inconsistency");
	free(src);
	return data;
}

static int find_delta(const union delta_base *base)
{
	int first = 0, last = nr_deltas;

        while (first < last) {
                int next = (first + last) / 2;
                struct delta_entry *delta = &deltas[next];
                int cmp;

                cmp = memcmp(base, &delta->base, UNION_BASE_SZ);
                if (!cmp)
                        return next;
                if (cmp < 0) {
                        last = next;
                        continue;
                }
                first = next+1;
        }
        return -first-1;
}

static int find_delta_children(const union delta_base *base,
			       int *first_index, int *last_index)
{
	int first = find_delta(base);
	int last = first;
	int end = nr_deltas - 1;

	if (first < 0)
		return -1;
	while (first > 0 && !memcmp(&deltas[first - 1].base, base, UNION_BASE_SZ))
		--first;
	while (last < end && !memcmp(&deltas[last + 1].base, base, UNION_BASE_SZ))
		++last;
	*first_index = first;
	*last_index = last;
	return 0;
}

static void sha1_object(const void *data, unsigned long size,
			enum object_type type, unsigned char *sha1)
{
	hash_sha1_file(data, size, typename(type), sha1);
	if (has_sha1_file(sha1)) {
		void *has_data;
		enum object_type has_type;
		unsigned long has_size;
		has_data = read_sha1_file(sha1, &has_type, &has_size);
		if (!has_data)
			die("cannot read existing object %s", sha1_to_hex(sha1));
		if (size != has_size || type != has_type ||
		    memcmp(data, has_data, size) != 0)
			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
		free(has_data);
	}
	if (strict) {
		if (type == OBJ_BLOB) {
			struct blob *blob = lookup_blob(sha1);
			if (blob)
				blob->object.flags |= FLAG_CHECKED;
			else
				die("invalid blob object %s", sha1_to_hex(sha1));
		} else {
			struct object *obj;
			int eaten;
			void *buf = (void *) data;

			/*
			 * we do not need to free the memory here, as the
			 * buf is deleted by the caller.
			 */
			obj = parse_object_buffer(sha1, type, size, buf, &eaten);
			if (!obj)
				die("invalid %s", typename(type));
			if (fsck_object(obj, 1, fsck_error_function))
				die("Error in object");
			if (fsck_walk(obj, mark_link, 0))
				die("Not all child objects of %s are reachable", sha1_to_hex(obj->sha1));

			if (obj->type == OBJ_TREE) {
				struct tree *item = (struct tree *) obj;
				item->buffer = NULL;
			}
			if (obj->type == OBJ_COMMIT) {
				struct commit *commit = (struct commit *) obj;
				commit->buffer = NULL;
			}
			obj->flags |= FLAG_CHECKED;
		}
	}
}

static void *get_base_data(struct base_data *c)
{
	if (!c->data) {
		struct object_entry *obj = c->obj;

		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
			void *base = get_base_data(c->base);
			void *raw = get_data_from_pack(obj);
			c->data = patch_delta(
				base, c->base->size,
				raw, obj->size,
				&c->size);
			free(raw);
			if (!c->data)
				bad_object(obj->idx.offset, "failed to apply delta");
		} else
			c->data = get_data_from_pack(obj);

		base_cache_used += c->size;
		prune_base_data(c);
	}
	return c->data;
}

static void resolve_delta(struct object_entry *delta_obj,
			  struct base_data *base_obj, enum object_type type)
{
	void *delta_data;
	unsigned long delta_size;
	union delta_base delta_base;
	int j, first, last;
	struct base_data result;

	delta_obj->real_type = type;
	delta_data = get_data_from_pack(delta_obj);
	delta_size = delta_obj->size;
	result.data = patch_delta(get_base_data(base_obj), base_obj->size,
			     delta_data, delta_size,
			     &result.size);
	free(delta_data);
	if (!result.data)
		bad_object(delta_obj->idx.offset, "failed to apply delta");
	sha1_object(result.data, result.size, type, delta_obj->idx.sha1);
	nr_resolved_deltas++;

	result.obj = delta_obj;
	link_base_data(base_obj, &result);

	hashcpy(delta_base.sha1, delta_obj->idx.sha1);
	if (!find_delta_children(&delta_base, &first, &last)) {
		for (j = first; j <= last; j++) {
			struct object_entry *child = objects + deltas[j].obj_no;
			if (child->real_type == OBJ_REF_DELTA)
				resolve_delta(child, &result, type);
		}
	}

	memset(&delta_base, 0, sizeof(delta_base));
	delta_base.offset = delta_obj->idx.offset;
	if (!find_delta_children(&delta_base, &first, &last)) {
		for (j = first; j <= last; j++) {
			struct object_entry *child = objects + deltas[j].obj_no;
			if (child->real_type == OBJ_OFS_DELTA)
				resolve_delta(child, &result, type);
		}
	}

	unlink_base_data(&result);
}

static int compare_delta_entry(const void *a, const void *b)
{
	const struct delta_entry *delta_a = a;
	const struct delta_entry *delta_b = b;
	return memcmp(&delta_a->base, &delta_b->base, UNION_BASE_SZ);
}

/* Parse all objects and return the pack content SHA1 hash */
static void parse_pack_objects(unsigned char *sha1)
{
	int i;
	struct delta_entry *delta = deltas;
	struct stat st;

	/*
	 * First pass:
	 * - find locations of all objects;
	 * - calculate SHA1 of all non-delta objects;
	 * - remember base (SHA1 or offset) for all deltas.
	 */
	if (verbose)
		progress = start_progress(
				from_stdin ? "Receiving objects" : "Indexing objects",
				nr_objects);
	for (i = 0; i < nr_objects; i++) {
		struct object_entry *obj = &objects[i];
		void *data = unpack_raw_entry(obj, &delta->base);
		obj->real_type = obj->type;
		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
			nr_deltas++;
			delta->obj_no = i;
			delta++;
		} else
			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
		free(data);
		display_progress(progress, i+1);
	}
	objects[i].idx.offset = consumed_bytes;
	stop_progress(&progress);

	/* Check pack integrity */
	flush();
	SHA1_Final(sha1, &input_ctx);
	if (hashcmp(fill(20), sha1))
		die("pack is corrupted (SHA1 mismatch)");
	use(20);

	/* If input_fd is a file, we should have reached its end now. */
	if (fstat(input_fd, &st))
		die("cannot fstat packfile: %s", strerror(errno));
	if (S_ISREG(st.st_mode) &&
			lseek(input_fd, 0, SEEK_CUR) - input_len != st.st_size)
		die("pack has junk at the end");

	if (!nr_deltas)
		return;

	/* Sort deltas by base SHA1/offset for fast searching */
	qsort(deltas, nr_deltas, sizeof(struct delta_entry),
	      compare_delta_entry);

	/*
	 * Second pass:
	 * - for all non-delta objects, look if it is used as a base for
	 *   deltas;
	 * - if used as a base, uncompress the object and apply all deltas,
	 *   recursively checking if the resulting object is used as a base
	 *   for some more deltas.
	 */
	if (verbose)
		progress = start_progress("Resolving deltas", nr_deltas);
	for (i = 0; i < nr_objects; i++) {
		struct object_entry *obj = &objects[i];
		union delta_base base;
		int j, ref, ref_first, ref_last, ofs, ofs_first, ofs_last;
		struct base_data base_obj;

		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA)
			continue;
		hashcpy(base.sha1, obj->idx.sha1);
		ref = !find_delta_children(&base, &ref_first, &ref_last);
		memset(&base, 0, sizeof(base));
		base.offset = obj->idx.offset;
		ofs = !find_delta_children(&base, &ofs_first, &ofs_last);
		if (!ref && !ofs)
			continue;
		base_obj.data = get_data_from_pack(obj);
		base_obj.size = obj->size;
		base_obj.obj = obj;
		link_base_data(NULL, &base_obj);

		if (ref)
			for (j = ref_first; j <= ref_last; j++) {
				struct object_entry *child = objects + deltas[j].obj_no;
				if (child->real_type == OBJ_REF_DELTA)
					resolve_delta(child, &base_obj, obj->type);
			}
		if (ofs)
			for (j = ofs_first; j <= ofs_last; j++) {
				struct object_entry *child = objects + deltas[j].obj_no;
				if (child->real_type == OBJ_OFS_DELTA)
					resolve_delta(child, &base_obj, obj->type);
			}
		unlink_base_data(&base_obj);
		display_progress(progress, nr_resolved_deltas);
	}
}

static int write_compressed(int fd, void *in, unsigned int size, uint32_t *obj_crc)
{
	z_stream stream;
	unsigned long maxsize;
	void *out;

	memset(&stream, 0, sizeof(stream));
	deflateInit(&stream, zlib_compression_level);
	maxsize = deflateBound(&stream, size);
	out = xmalloc(maxsize);

	/* Compress it */
	stream.next_in = in;
	stream.avail_in = size;
	stream.next_out = out;
	stream.avail_out = maxsize;
	while (deflate(&stream, Z_FINISH) == Z_OK);
	deflateEnd(&stream);

	size = stream.total_out;
	write_or_die(fd, out, size);
	*obj_crc = crc32(*obj_crc, out, size);
	free(out);
	return size;
}

static struct object_entry *append_obj_to_pack(
			       const unsigned char *sha1, void *buf,
			       unsigned long size, enum object_type type)
{
	struct object_entry *obj = &objects[nr_objects++];
	unsigned char header[10];
	unsigned long s = size;
	int n = 0;
	unsigned char c = (type << 4) | (s & 15);
	s >>= 4;
	while (s) {
		header[n++] = c | 0x80;
		c = s & 0x7f;
		s >>= 7;
	}
	header[n++] = c;
	write_or_die(output_fd, header, n);
	obj[0].idx.crc32 = crc32(0, Z_NULL, 0);
	obj[0].idx.crc32 = crc32(obj[0].idx.crc32, header, n);
	obj[1].idx.offset = obj[0].idx.offset + n;
	obj[1].idx.offset += write_compressed(output_fd, buf, size, &obj[0].idx.crc32);
	hashcpy(obj->idx.sha1, sha1);
	return obj;
}

static int delta_pos_compare(const void *_a, const void *_b)
{
	struct delta_entry *a = *(struct delta_entry **)_a;
	struct delta_entry *b = *(struct delta_entry **)_b;
	return a->obj_no - b->obj_no;
}

static void fix_unresolved_deltas(int nr_unresolved)
{
	struct delta_entry **sorted_by_pos;
	int i, n = 0;

	/*
	 * Since many unresolved deltas may well be themselves base objects
	 * for more unresolved deltas, we really want to include the
	 * smallest number of base objects that would cover as much delta
	 * as possible by picking the
	 * trunc deltas first, allowing for other deltas to resolve without
	 * additional base objects.  Since most base objects are to be found
	 * before deltas depending on them, a good heuristic is to start
	 * resolving deltas in the same order as their position in the pack.
	 */
	sorted_by_pos = xmalloc(nr_unresolved * sizeof(*sorted_by_pos));
	for (i = 0; i < nr_deltas; i++) {
		if (objects[deltas[i].obj_no].real_type != OBJ_REF_DELTA)
			continue;
		sorted_by_pos[n++] = &deltas[i];
	}
	qsort(sorted_by_pos, n, sizeof(*sorted_by_pos), delta_pos_compare);

	for (i = 0; i < n; i++) {
		struct delta_entry *d = sorted_by_pos[i];
		enum object_type type;
		int j, first, last;
		struct base_data base_obj;

		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
			continue;
		base_obj.data = read_sha1_file(d->base.sha1, &type, &base_obj.size);
		if (!base_obj.data)
			continue;

		if (check_sha1_signature(d->base.sha1, base_obj.data,
				base_obj.size, typename(type)))
			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
		base_obj.obj = append_obj_to_pack(d->base.sha1, base_obj.data,
			base_obj.size, type);
		link_base_data(NULL, &base_obj);

		find_delta_children(&d->base, &first, &last);
		for (j = first; j <= last; j++) {
			struct object_entry *child = objects + deltas[j].obj_no;
			if (child->real_type == OBJ_REF_DELTA)
				resolve_delta(child, &base_obj, type);
		}

		unlink_base_data(&base_obj);
		display_progress(progress, nr_resolved_deltas);
	}
	free(sorted_by_pos);
}

static void final(const char *final_pack_name, const char *curr_pack_name,
		  const char *final_index_name, const char *curr_index_name,
		  const char *keep_name, const char *keep_msg,
		  unsigned char *sha1)
{
	const char *report = "pack";
	char name[PATH_MAX];
	int err;

	if (!from_stdin) {
		close(input_fd);
	} else {
		fsync_or_die(output_fd, curr_pack_name);
		err = close(output_fd);
		if (err)
			die("error while closing pack file: %s", strerror(errno));
		chmod(curr_pack_name, 0444);
	}

	if (keep_msg) {
		int keep_fd, keep_msg_len = strlen(keep_msg);
		if (!keep_name) {
			snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
				 get_object_directory(), sha1_to_hex(sha1));
			keep_name = name;
		}
		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
		if (keep_fd < 0) {
			if (errno != EEXIST)
				die("cannot write keep file");
		} else {
			if (keep_msg_len > 0) {
				write_or_die(keep_fd, keep_msg, keep_msg_len);
				write_or_die(keep_fd, "\n", 1);
			}
			if (close(keep_fd) != 0)
				die("cannot write keep file");
			report = "keep";
		}
	}

	if (final_pack_name != curr_pack_name) {
		if (!final_pack_name) {
			snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
				 get_object_directory(), sha1_to_hex(sha1));
			final_pack_name = name;
		}
		if (move_temp_to_file(curr_pack_name, final_pack_name))
			die("cannot store pack file");
	}

	chmod(curr_index_name, 0444);
	if (final_index_name != curr_index_name) {
		if (!final_index_name) {
			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
				 get_object_directory(), sha1_to_hex(sha1));
			final_index_name = name;
		}
		if (move_temp_to_file(curr_index_name, final_index_name))
			die("cannot store index file");
	}

	if (!from_stdin) {
		printf("%s\n", sha1_to_hex(sha1));
	} else {
		char buf[48];
		int len = snprintf(buf, sizeof(buf), "%s\t%s\n",
				   report, sha1_to_hex(sha1));
		write_or_die(1, buf, len);

		/*
		 * Let's just mimic git-unpack-objects here and write
		 * the last part of the input buffer to stdout.
		 */
		while (input_len) {
			err = xwrite(1, input_buffer + input_offset, input_len);
			if (err <= 0)
				break;
			input_len -= err;
			input_offset += err;
		}
	}
}

static int git_index_pack_config(const char *k, const char *v, void *cb)
{
	if (!strcmp(k, "pack.indexversion")) {
		pack_idx_default_version = git_config_int(k, v);
		if (pack_idx_default_version > 2)
			die("bad pack.indexversion=%"PRIu32,
				pack_idx_default_version);
		return 0;
	}
	return git_default_config(k, v, cb);
}

int main(int argc, char **argv)
{
	int i, fix_thin_pack = 0;
	char *curr_pack, *pack_name = NULL;
	char *curr_index, *index_name = NULL;
	const char *keep_name = NULL, *keep_msg = NULL;
	char *index_name_buf = NULL, *keep_name_buf = NULL;
	struct pack_idx_entry **idx_objects;
	unsigned char sha1[20];

	git_config(git_index_pack_config, NULL);

	for (i = 1; i < argc; i++) {
		char *arg = argv[i];

		if (*arg == '-') {
			if (!strcmp(arg, "--stdin")) {
				from_stdin = 1;
			} else if (!strcmp(arg, "--fix-thin")) {
				fix_thin_pack = 1;
			} else if (!strcmp(arg, "--strict")) {
				strict = 1;
			} else if (!strcmp(arg, "--keep")) {
				keep_msg = "";
			} else if (!prefixcmp(arg, "--keep=")) {
				keep_msg = arg + 7;
			} else if (!prefixcmp(arg, "--pack_header=")) {
				struct pack_header *hdr;
				char *c;

				hdr = (struct pack_header *)input_buffer;
				hdr->hdr_signature = htonl(PACK_SIGNATURE);
				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));
				if (*c != ',')
					die("bad %s", arg);
				hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
				if (*c)
					die("bad %s", arg);
				input_len = sizeof(*hdr);
			} else if (!strcmp(arg, "-v")) {
				verbose = 1;
			} else if (!strcmp(arg, "-o")) {
				if (index_name || (i+1) >= argc)
					usage(index_pack_usage);
				index_name = argv[++i];
			} else if (!prefixcmp(arg, "--index-version=")) {
				char *c;
				pack_idx_default_version = strtoul(arg + 16, &c, 10);
				if (pack_idx_default_version > 2)
					die("bad %s", arg);
				if (*c == ',')
					pack_idx_off32_limit = strtoul(c+1, &c, 0);
				if (*c || pack_idx_off32_limit & 0x80000000)
					die("bad %s", arg);
			} else
				usage(index_pack_usage);
			continue;
		}

		if (pack_name)
			usage(index_pack_usage);
		pack_name = arg;
	}

	if (!pack_name && !from_stdin)
		usage(index_pack_usage);
	if (fix_thin_pack && !from_stdin)
		die("--fix-thin cannot be used without --stdin");
	if (!index_name && pack_name) {
		int len = strlen(pack_name);
		if (!has_extension(pack_name, ".pack"))
			die("packfile name '%s' does not end with '.pack'",
			    pack_name);
		index_name_buf = xmalloc(len);
		memcpy(index_name_buf, pack_name, len - 5);
		strcpy(index_name_buf + len - 5, ".idx");
		index_name = index_name_buf;
	}
	if (keep_msg && !keep_name && pack_name) {
		int len = strlen(pack_name);
		if (!has_extension(pack_name, ".pack"))
			die("packfile name '%s' does not end with '.pack'",
			    pack_name);
		keep_name_buf = xmalloc(len);
		memcpy(keep_name_buf, pack_name, len - 5);
		strcpy(keep_name_buf + len - 5, ".keep");
		keep_name = keep_name_buf;
	}

	curr_pack = open_pack_file(pack_name);
	parse_pack_header();
	objects = xmalloc((nr_objects + 1) * sizeof(struct object_entry));
	deltas = xmalloc(nr_objects * sizeof(struct delta_entry));
	parse_pack_objects(sha1);
	if (nr_deltas == nr_resolved_deltas) {
		stop_progress(&progress);
		/* Flush remaining pack final 20-byte SHA1. */
		flush();
	} else {
		if (fix_thin_pack) {
			char msg[48];
			int nr_unresolved = nr_deltas - nr_resolved_deltas;
			int nr_objects_initial = nr_objects;
			if (nr_unresolved <= 0)
				die("confusion beyond insanity");
			objects = xrealloc(objects,
					   (nr_objects + nr_unresolved + 1)
					   * sizeof(*objects));
			fix_unresolved_deltas(nr_unresolved);
			sprintf(msg, "completed with %d local objects",
				nr_objects - nr_objects_initial);
			stop_progress_msg(&progress, msg);
			fixup_pack_header_footer(output_fd, sha1,
						 curr_pack, nr_objects);
		}
		if (nr_deltas != nr_resolved_deltas)
			die("pack has %d unresolved deltas",
			    nr_deltas - nr_resolved_deltas);
	}
	free(deltas);
	if (strict)
		check_objects();

	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
	for (i = 0; i < nr_objects; i++)
		idx_objects[i] = &objects[i].idx;
	curr_index = write_idx_file(index_name, idx_objects, nr_objects, sha1);
	free(idx_objects);

	final(pack_name, curr_pack,
		index_name, curr_index,
		keep_name, keep_msg,
		sha1);
	free(objects);
	free(index_name_buf);
	free(keep_name_buf);
	if (pack_name == NULL)
		free(curr_pack);
	if (index_name == NULL)
		free(curr_index);

	return 0;
}

--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="trace.3429"
Content-Transfer-Encoding: quoted-printable

=3D=3D3429=3D=3D Memcheck, a memory error detector.
=3D=3D3429=3D=3D Copyright (C) 2002-2007, and GNU GPL'd, by Julian Seward e=
t al.
=3D=3D3429=3D=3D Using LibVEX rev 1854, a library for dynamic binary transl=
ation.
=3D=3D3429=3D=3D Copyright (C) 2004-2007, and GNU GPL'd, by OpenWorks LLP.
=3D=3D3429=3D=3D Using valgrind-3.3.1-Debian, a dynamic binary instrumentat=
ion framework.
=3D=3D3429=3D=3D Copyright (C) 2000-2007, and GNU GPL'd, by Julian Seward e=
t al.
=3D=3D3429=3D=3D For more details, rerun with: -v
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D My PID =3D 3429, parent PID =3D 3421.  Prog and args are:
=3D=3D3429=3D=3D    /home/madcoder/dev/scm/git/git-index-pack2
=3D=3D3429=3D=3D    --stdin
=3D=3D3429=3D=3D    -v
=3D=3D3429=3D=3D    --fix-thin
=3D=3D3429=3D=3D    --keep=3Dfetch-pack 3421 on artemis
=3D=3D3429=3D=3D    --pack_header=3D2,263
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x5068AF9: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x5068B26: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x5068B86: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x5068B97: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x5068BD9: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Use of uninitialised value of size 8
=3D=3D3429=3D=3D    at 0x5068C2A: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x5068C8F: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x5068C98: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Use of uninitialised value of size 8
=3D=3D3429=3D=3D    at 0x5068E21: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Use of uninitialised value of size 8
=3D=3D3429=3D=3D    at 0x5068E31: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x50689AC: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x5066933: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x5068E57: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x5068E64: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x5068E76: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x506B361: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x5068EAC: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Use of uninitialised value of size 8
=3D=3D3429=3D=3D    at 0x5069CDB: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506B7B0: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x5068EAC: (within /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x506728C: deflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x404BD9: main (index-pack.c:674)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x4035EE: get_base_data (index-pack.c:485)
=3D=3D3429=3D=3D    by 0x403687: get_base_data (index-pack.c:486)
=3D=3D3429=3D=3D    by 0x403711: resolve_delta (index-pack.c:516)
=3D=3D3429=3D=3D    by 0x4038A8: resolve_delta (index-pack.c:543)
=3D=3D3429=3D=3D    by 0x404CF5: main (index-pack.c:762)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Syscall param pread64(count) contains uninitialised byte(s)
=3D=3D3429=3D=3D    at 0x5621353: __pread_nocancel (in /usr/lib/debug/libpt=
hread-2.7.so)
=3D=3D3429=3D=3D    by 0x4034C9: get_data_from_pack (index-pack.c:368)
=3D=3D3429=3D=3D    by 0x4035FB: get_base_data (index-pack.c:496)
=3D=3D3429=3D=3D    by 0x403687: get_base_data (index-pack.c:486)
=3D=3D3429=3D=3D    by 0x403711: resolve_delta (index-pack.c:516)
=3D=3D3429=3D=3D    by 0x4038A8: resolve_delta (index-pack.c:543)
=3D=3D3429=3D=3D    by 0x404CF5: main (index-pack.c:762)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Syscall param pread64(offset) contains uninitialised byte(=
s)
=3D=3D3429=3D=3D    at 0x5621353: __pread_nocancel (in /usr/lib/debug/libpt=
hread-2.7.so)
=3D=3D3429=3D=3D    by 0x4034C9: get_data_from_pack (index-pack.c:368)
=3D=3D3429=3D=3D    by 0x4035FB: get_base_data (index-pack.c:496)
=3D=3D3429=3D=3D    by 0x403687: get_base_data (index-pack.c:486)
=3D=3D3429=3D=3D    by 0x403711: resolve_delta (index-pack.c:516)
=3D=3D3429=3D=3D    by 0x4038A8: resolve_delta (index-pack.c:543)
=3D=3D3429=3D=3D    by 0x404CF5: main (index-pack.c:762)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x4034D9: get_data_from_pack (index-pack.c:372)
=3D=3D3429=3D=3D    by 0x4035FB: get_base_data (index-pack.c:496)
=3D=3D3429=3D=3D    by 0x403687: get_base_data (index-pack.c:486)
=3D=3D3429=3D=3D    by 0x403711: resolve_delta (index-pack.c:516)
=3D=3D3429=3D=3D    by 0x4038A8: resolve_delta (index-pack.c:543)
=3D=3D3429=3D=3D    by 0x404CF5: main (index-pack.c:762)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x506D058: inflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x40352C: get_data_from_pack (index-pack.c:380)
=3D=3D3429=3D=3D    by 0x4035FB: get_base_data (index-pack.c:496)
=3D=3D3429=3D=3D    by 0x403687: get_base_data (index-pack.c:486)
=3D=3D3429=3D=3D    by 0x403711: resolve_delta (index-pack.c:516)
=3D=3D3429=3D=3D    by 0x4038A8: resolve_delta (index-pack.c:543)
=3D=3D3429=3D=3D    by 0x404CF5: main (index-pack.c:762)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x506C597: inflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x40352C: get_data_from_pack (index-pack.c:380)
=3D=3D3429=3D=3D    by 0x4035FB: get_base_data (index-pack.c:496)
=3D=3D3429=3D=3D    by 0x403687: get_base_data (index-pack.c:486)
=3D=3D3429=3D=3D    by 0x403711: resolve_delta (index-pack.c:516)
=3D=3D3429=3D=3D    by 0x4038A8: resolve_delta (index-pack.c:543)
=3D=3D3429=3D=3D    by 0x404CF5: main (index-pack.c:762)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D3429=3D=3D    at 0x506C5E9: inflate (in /usr/lib/libz.so.1.2.3.3)
=3D=3D3429=3D=3D    by 0x40352C: get_data_from_pack (index-pack.c:380)
=3D=3D3429=3D=3D    by 0x4035FB: get_base_data (index-pack.c:496)
=3D=3D3429=3D=3D    by 0x403687: get_base_data (index-pack.c:486)
=3D=3D3429=3D=3D    by 0x403711: resolve_delta (index-pack.c:516)
=3D=3D3429=3D=3D    by 0x4038A8: resolve_delta (index-pack.c:543)
=3D=3D3429=3D=3D    by 0x404CF5: main (index-pack.c:762)
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D ERROR SUMMARY: 146 errors from 23 contexts (suppressed: 8 =
=66rom 1)
=3D=3D3429=3D=3D malloc/free: in use at exit: 50,109 bytes in 17 blocks.
=3D=3D3429=3D=3D malloc/free: 1,223 allocs, 1,206 frees, 18,574,785 bytes a=
llocated.
=3D=3D3429=3D=3D For counts of detected errors, rerun with: -v
=3D=3D3429=3D=3D searching for pointers to 17 not-freed blocks.
=3D=3D3429=3D=3D checked 618,664 bytes.
=3D=3D3429=3D=3D=20
=3D=3D3429=3D=3D LEAK SUMMARY:
=3D=3D3429=3D=3D    definitely lost: 0 bytes in 0 blocks.
=3D=3D3429=3D=3D      possibly lost: 8,100 bytes in 1 blocks.
=3D=3D3429=3D=3D    still reachable: 42,009 bytes in 16 blocks.
=3D=3D3429=3D=3D         suppressed: 0 bytes in 0 blocks.
=3D=3D3429=3D=3D Rerun with --leak-check=3Dfull to see details of leaked me=
mory.

--tMbDGjvJuJijemkf--

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHChwACgkQvGr7W6HudhxHyQCcChWaI5xian2E8x4OEuGKpsre
gZsAoKVOP+qQtgpezk4MVsbpgFZ0cNFe
=WXq5
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
