From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 10/16] pack-objects: use bitmaps when packing objects
Date: Tue, 25 Jun 2013 18:18:41 +0530
Message-ID: <CALkWK0kG8VJh9TC8Yh82fg8zCHzevjP0_yghcH7woEML3-MTog@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com> <1372116193-32762-11-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 14:49:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrSgm-0004dK-L4
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 14:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099Ab3FYMtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 08:49:23 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37341 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab3FYMtW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 08:49:22 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so27645505iea.4
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QCsHWz6K/7UeSVuLvAJCe/VSw7nGB8G/40RtXFVKdjk=;
        b=MBGsf0Bdg3639/r4tatl9X+SS/yXRGhX/Z1iTI+4Yy5Xmmi2Ws9BEJ38Udp3UMqV6A
         xr+EWwfVhkyj8Hzy0tkT0oB6VS2FcY+5z7kpVr0mlMY/ZFy0QpDJIhfMD/9rgZ/lbhm6
         9m2V/Fv+obkHE5R8cOTy1BHAQOWGOSE7lw9ecuv2Vsu/+lRZM3bVXLvfMmK7quqiu7pO
         Gt62g1Eq6dv+rBG3flNvgFq/SQKXi9O5gN513pk3bIPtmEHkofr01T6BGbPKUmxLANH0
         QN8emsjuC9H8N/k8tWT5Uzs3lVPlPYTuQyH7j+llu09+vFQCFqcv8Oh7hw5CzDns2N6s
         FHHQ==
X-Received: by 10.42.190.74 with SMTP id dh10mr14047359icb.35.1372164562160;
 Tue, 25 Jun 2013 05:49:22 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 25 Jun 2013 05:48:41 -0700 (PDT)
In-Reply-To: <1372116193-32762-11-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228958>

Vicent Marti wrote:
>         $ time ../git/git pack-objects --all --stdout
>         Counting objects: 3053537, done.
>         Compressing objects: 100% (495706/495706), done.
>         Total 3053537 (delta 2529614), reused 3053537 (delta 2529614)
>
>         real    0m36.686s
>         user    0m34.440s
>         sys     0m2.184s
>
>         $ time ../git/git pack-objects --all --stdout
>         Counting objects: 3053537, done.
>         Compressing objects: 100% (495706/495706), done.
>         Total 3053537 (delta 2529614), reused 3053537 (delta 2529614)
>
>         real    0m7.255s
>         user    0m6.892s
>         sys     0m0.444s

Awesome work!  Can you put up this series on gh:vmg so I can try it
out for myself?

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index b7cab18..469b8da 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> +       if (!strcmp(k, "pack.usebitmaps")) {
> +               bitmap_support = git_config_bool(k, v);
> +               return 0;
> +       }

Not using config_error_nonbool() to indicate an error?

> +       if (use_bitmap_index) {
> +               uint32_t size_hint;
> +
> +               if (!prepare_bitmap_walk(&revs, &size_hint)) {
> +                       khint_t new_hash_size = (size_hint * (1.0 / __ac_HASH_UPPER)) + 0.5;

How does this work?  You've taken the inverse of __ac_HASH_UPPER,
multiplied it by the size_hint you get from prepare_bitmap_walk(), and
add 0.5?

> +                       kh_resize_sha1(packed_objects, new_hash_size);

So packed_objects is a hashtable of type kh_sha1_t * (you introduced
in [03/16]) that you're now resizing to new_hash_size.  To find out
what the significance of this new_hash_size is, it looks like I have
to read prepare_bitmap_walk().

> +                       nr_alloc = (size_hint + 63) & ~63;
> +                       objects = xrealloc(objects, nr_alloc * sizeof(struct object_entry *));

Interesting.  The only other place where we realloc the objects in
this file is in pack-objects.c:949, and we do that because nr_object
>= nr_alloc.  What is this 63 magic?

>         if (prepare_revision_walk(&revs))
>                 die("revision walk setup failed");
> +

Stray newline.

> +       if (bitmap_support) {
> +               if (use_internal_rev_list && pack_to_stdout)
> +                       use_bitmap_index = 1;
> +       }
> +

Wait, what does pack_to_stdout have to do with deciding whether or not
to walk the bitmap?

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> new file mode 100644
> index 0000000..090db15
> --- /dev/null
> +++ b/pack-bitmap.c
> +struct stored_bitmap {
> +       unsigned char sha1[20];
> +       struct ewah_bitmap *root;
> +       struct stored_bitmap *xor;
> +       int flags;
> +};

What exactly is this?  What is stored_bitmap *xor?  It looks like some
sort of next-pointer, but why is it named xor?

> +struct bitmap_index {

Okay, the bitmap index.

> +       struct ewah_bitmap *commits;
> +       struct ewah_bitmap *trees;
> +       struct ewah_bitmap *blobs;
> +       struct ewah_bitmap *tags;

I might be asking a really stupid question here, but why do you have
different bitmaps for different object types?  Unless I'm mistaken,
the packfile index doesn't make this differentiation: it sorts and
stores the SHA-1s of the various objects; you request a SHA-1, it does
a binary search and returns the object.

> +       khash_sha1 *bitmaps;

A hashmap keyed with the SHA-1, I presume.

> +       struct packed_git *pack;

You're defining which pack this bitmap index is for, right?

> +       struct {
> +               struct object_array entries;
> +               khash_sha1 *map;
> +       } fake_index;

What is this?

> +       struct bitmap *result;

No clue what this is about.

> +       int entry_count;

No clue what this is, but I'm assuming it can't be important because
it's an int.

> +       char pack_checksum[20];
> +
> +       int version;

Use something invariant like uint32_t?  Also, there is no clear
indication about where this information is going to go (header,
presumably?).  Look at pack.h:

struct pack_idx_header {
	uint32_t idx_signature;
	uint32_t idx_version;
};

> +       unsigned loaded : 1,
> +                        native_bitmaps : 1,
> +                        has_hash_cache : 1;

Booleans, but I don't know what they're doing here even after reading
your bitmap-format.txt.

> +       struct ewah_bitmap *(*read_bitmap)(struct bitmap_index *index);

I'm very confused now.  Each bitmap_index has a specialized read_bitmap()?

> +       void *map;
> +       size_t map_size, map_pos;
> +
> +       uint32_t *delta_hashes;

I'll give up on the rest.

> +static struct bitmap_index bitmap_git;

You could have made the struct static to begin with and ended it with
a } bitmap_git;

> +static struct ewah_bitmap *
> +lookup_stored_bitmap(struct stored_bitmap *st)

Please conform to Linux style and make it easier for us to grep by
putting this in one line?

> +{
> +       struct ewah_bitmap *parent;
> +       struct ewah_bitmap *composed;
> +
> +       if (st->xor == NULL)

if (!st->xor)

> +               return st->root;

Okay, st->xor needs to be set to something for lookup_stored_bitmap()
to do something useful.

> +       composed = ewah_pool_new();
> +       parent = lookup_stored_bitmap(st->xor);

So st->xor is a parent-pointer?  Still doesn't answer my question
about why it is named xor.

> +       ewah_xor(st->root, parent, composed);

I would have loved it if the prototype of this function made it clear
what it was writing like: ewah_xor(st->root, parent, &composed); but
then it expects the caller to do memory allocation, so never mind.

> +       ewah_pool_free(st->root);
> +       st->root = composed;
> +       st->xor = NULL;
> +
> +       return composed;

So lookup_stored_bitmap() just xors st->root with parent (determined
by recursively looking up st->xor)?

> +}
> +
> +static struct ewah_bitmap *
> +_read_bitmap(struct bitmap_index *index)

We usually use the _1 suffix convention for internal functions, not _ prefix.

> +       int bitmap_size;
> +
> +       bitmap_size = ewah_read_mmap(b,
> +               index->map + index->map_pos,
> +               index->map_size - index->map_pos);

Make this a single statement.  Also, why can't I see this on
gh:vmg/libework?  Your [08/16] has diverged from there :/

> +       return b;

So _read_bitmap() mmaps the bitmap and returns it.

> +static struct ewah_bitmap *
> +_read_bitmap_native(struct bitmap_index *index)

The counterpart that calls *_mmap_native() in ewah.  Have to look at
the difference.  In any case, I hope you've used xmmap().

> +static int load_bitmap_header(struct bitmap_index *index)
> +{

I'm going to compare this to sha1_file.c:check_packed_git_idx().

> +       struct bitmap_disk_header *header = (void *)index->map;
> +
> +       if (index->map_size < sizeof(*header))
> +               return error("Corrupted bitmap index (missing header data)");

No munmap()?  Was abstracting out the mmap detail a good idea?

> +       if (memcmp(header->magic, BITMAP_MAGIC_PREFIX, sizeof(BITMAP_MAGIC_PREFIX)) != 0)
> +               return error("Corrupted bitmap index file (wrong header)");

PACK_SIGNATURE, PACK_IDX_SIGNATURE.  Name this BITMAP_IDX_SIGNATURE?

> +       index->version = (int)ntohs(header->version);

You wouldn't have to coerce to int if version were a uint32_t in the
first place.

> +       /* Parse known bitmap format options */
> +       {
> +               uint32_t flags = ntohs(header->options);

Okay.

> +               if ((flags & BITMAP_OPT_FULL_DAG) == 0) {
> +                       return error("Unsupported options for bitmap index file "
> +                               "(Git requires BITMAP_OPT_FULL_DAG)");
> +               }

Unnecessary braces for single statement.

> +               if (flags & BITMAP_OPT_HASH_CACHE)
> +                       index->has_hash_cache = 1;
> +
> +               index->read_bitmap = &_read_bitmap;

So you've set the read_bitmap() function to _read_bitmap().  Let's see why.

> +               /*
> +                * If we are in a little endian machine and the bitmap
> +                * was written in LE, we can mmap it straight into memory
> +                * without having to parse it
> +                */
> +               if ((flags & BITMAP_OPT_LE_BITMAPS)) {
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +                       index->native_bitmaps = 1;
> +                       index->read_bitmap = &_read_bitmap_native;
> +#else
> +                       die("The existing bitmap index is written in little-endian "
> +                               "byte order and cannot be read in this machine.\n"
> +                               "Please re-build the bitmap indexes locally.");
> +#endif
> +               }
> +       }

Okay.

> +       index->entry_count = ntohl(header->entry_count);
> +       memcpy(index->pack_checksum, header->checksum, sizeof(header->checksum));

I might be asking (yet another) really stupid question here, but why
isn't the checksum an unsigned char[20] (i.e. a simple 20-byte SHA-1)?
 We already have infrastructure to deal with SHA-1s, so might as well
reuse it, right?

> +       index->map_pos += sizeof(*header);

You've read the header successfully, and incremented map_pos for other callers.

> +static struct stored_bitmap *
> +store_bitmap(struct bitmap_index *index,
> +       const unsigned char *sha1,
> +       struct ewah_bitmap *bitmap,
> +       struct stored_bitmap *xor_with, int flags)

Why don't you just prepare a struct and send it to this function to
write instead of so many arguments?

> +       stored = xmalloc(sizeof(struct stored_bitmap));
> +       stored->root = bitmap;
> +       stored->xor = xor_with;
> +       stored->flags = flags;
> +       memcpy(stored->sha1, sha1, 20);

Use hashcpy().  You would have had to do none of this if the caller
had passed a readymade struct, no?

> +       hash_pos = kh_put_sha1(index->bitmaps, stored->sha1, &ret);

Okay, you store a SHA-1.

> +       if (ret == 0) {
> +               error("Duplicate entry in bitmap index: %s", sha1_to_hex(sha1));
> +               return NULL;
> +       }

0 is success by convention!

> +       kh_value(index->bitmaps, hash_pos) = stored;

Okay.

> +       return stored;

You're returning allocated memory, that the caller must remember to free.

> +static int
> +load_bitmap_entries_v2(struct bitmap_index *index)

I'm not sure it's a great idea to put a volatile version number in the
function name.

> +{
> +       static const int MAX_XOR_OFFSET = 16;
> +
> +       int i;
> +       struct stored_bitmap *recent_bitmaps[16];

Does this 16 have anything to do with MAX_XOR_OFFSET?

> +       struct bitmap_disk_entry_v2 *entry;
> +
> +       void *index_pos = index->map + index->map_size -
> +               (index->entry_count * sizeof(struct bitmap_disk_entry_v2));

Wait, why did we set map_pos earlier if you're recomputing it here?
And why is this a void *?

> +       for (i = 0; i < index->entry_count; ++i) {
> +               int xor_offset, flags, ret;
> +               struct stored_bitmap *xor_bitmap = NULL;
> +               struct ewah_bitmap *bitmap = NULL;
> +               uint32_t bitmap_pos;
> +
> +               entry = index_pos;
> +               index_pos += sizeof(struct bitmap_disk_entry_v2);

Okay, so I understand that you're parsing one bitmap_disk_entry_v2
struct at a time.

> +               bitmap_pos = ntohl(entry->bitmap_pos);
> +               xor_offset = (int)entry->xor_offset;
> +               flags = (int)entry->flags;

I have no clue why you're casting like this.

> +               if (index->native_bitmaps) {

What is this native versus non-native bitmaps?  Your
bitmap-formats.txt has nothing to say on the matter.

> +                       bitmap = calloc(1, sizeof(struct ewah_bitmap));
> +                       ret = ewah_read_mmap_native(bitmap,
> +                               index->map + bitmap_pos,
> +                               index->map_size - bitmap_pos);

Wait a minute.  Isn't this what you wrapped in _read_bitmap_native()?
Totally confused.

> +               } else {
> +                       bitmap = ewah_pool_new();
> +                       ret = ewah_read_mmap(bitmap,
> +                               index->map + bitmap_pos,
> +                               index->map_size - bitmap_pos);

Did you forget about _read_bitmap()?

> +               if (ret < 0 || xor_offset > MAX_XOR_OFFSET || xor_offset > i) {
> +                       return error("Corrupted bitmap pack index");
> +               }

Unnecessary braces.

> +               if (xor_offset > 0) {
> +                       xor_bitmap = recent_bitmaps[(i - xor_offset) % MAX_XOR_OFFSET];
> +
> +                       if (xor_bitmap == NULL)

if (!xor_bitmap)

> +                               return error("Invalid XOR offset in bitmap pack index");

I haven't seen a single die() until now, and that's a Good sign.

> +               recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
> +                       index, entry->sha1, bitmap, xor_bitmap, flags);

So you fill in the 16 recent bitmaps in this function?

> +static int load_bitmap_index(
> +       struct bitmap_index *index,
> +       const char *path,
> +       struct packed_git *packfile)
> +{
> +       int fd = git_open_noatime(path);

I assume you exposed this static defined in sha1_file.c in an earlier
patch, but I didn't check.

> +       struct stat st;
> +
> +       if (fd < 0) {
> +               return -1;
> +       }

Unnecessary braces.

> +       index->map_size = xsize_t(st.st_size);
> +       index->map = xmmap(NULL, index->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +       close(fd);

I like how similar this is to check_packed_git_idx().  What happened
to your ewah mapping abstractions though?

> +       index->bitmaps = kh_init_sha1();
> +       index->pack = packfile;
> +       index->fake_index.map = kh_init_sha1();

I'll hopefully get to find out what fake_index is here.

> +       if (load_bitmap_header(index) < 0)
> +               return -1;

Okay.  Notice how the format we're parsing is documented tersely as
inline comments in sha1_name.c: you might like to do that too.

> +       if (index->has_hash_cache) {
> +               index->delta_hashes = index->map + index->map_pos;
> +               index->map_pos += (packfile->num_objects * sizeof(uint32_t));
> +       }

Okay.

> +       if ((index->commits = index->read_bitmap(index)) == NULL ||
> +               (index->trees = index->read_bitmap(index)) == NULL ||
> +               (index->blobs = index->read_bitmap(index)) == NULL ||
> +               (index->tags = index->read_bitmap(index)) == NULL)
> +               return -1;

As usual, please use !() instead of explicitly comparing with NULL.
It looks like I'll get to find out why you have four different bitmaps
set to the same thing (?) soon; exciting!

> +       if (load_bitmap_entries_v2(index) < 0)
> +               return -1;
> +
> +       index->loaded = true;

Fine.  This function calls out to various little parsing functions and
sets index->loaded.  It returns -1 instead of error(), because those
little functions report the errors.

> +char *pack_bitmap_filename(struct packed_git *p)

Compare with sha1_name.c:open_pack_index().

> +int open_pack_bitmap(struct packed_git *p)

Okay.

> +void prepare_bitmap_git(void)

Okay.

> +struct include_data {
> +       struct bitmap *base;
> +       struct bitmap *seen;
> +};

I wonder what this is.

> +static inline int bitmap_position_extended(const unsigned char *sha1)

Sorry, I'm stopping here.  It's impossible to review this gigantic
patch in one sitting.

Thanks.
