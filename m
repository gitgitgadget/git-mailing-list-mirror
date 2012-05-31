From: Thomas Rast <trast@student.ethz.ch>
Subject: Review of current github code [Re: [GSoC] Designing a faster index format - Progress report week 6]
Date: Thu, 31 May 2012 17:50:25 +0200
Message-ID: <87pq9k8i4e.fsf@thomas.inf.ethz.ch>
References: <20120528214401.GB6449@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <trast@student.ethz.ch>,
	<gitster@pobox.com>, <mhagger@alum.mit.edu>, <pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 17:50:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa7dy-0007vy-Mf
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 17:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611Ab2EaPua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 11:50:30 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:19187 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932567Ab2EaPu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 11:50:29 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 31 May
 2012 17:50:26 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 31 May
 2012 17:50:26 +0200
In-Reply-To: <20120528214401.GB6449@tgummerer> (Thomas Gummerer's message of
	"Mon, 28 May 2012 23:44:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198924>

Hi,

Thomas has again been busy hacking, and the reading side is now capable
of reading a v5 index into the (existing) array-of-cache_entry format.
It is actually already measurably faster than both v4 and v[23] on the
Webkit index:

  Test                      this tree      
  -----------------------------------------
  0002.1: v[23]: ls-files   0.13(0.11+0.02)
  0002.4: v4: ls-files      0.11(0.08+0.02)
  0002.5: v5: ls-files      0.09(0.06+0.02)

I made up a hacky perf script on the spot, it's pasted at the far end of
this email.  It would most likely still be slower than v4 if we didn't
switch away from SHA1, though -- we haven't really spent much time
looking into the speed, except for one particular avoidance of name
copies that translated into a roughly 30% speedup.

As before, what follows is a review of the WIP code on github at

  git://github.com/tgummerer/git.git index-v5

I looked at version fed977b, however I will pretend it consists of just
two commits (as far as the C code is concerned):

* (174fea4) Refactoring to accomodate other index versions
* All others (174fea4..fed977b), squashed

I'm doing this because the history is still not in "submission-style"
shape, as discussed in

  http://thread.gmane.org/gmane.comp.version-control.git/198283/focus=198412

and Junio's reply to it.


As far as 174fea4 goes: I think you could split it into two separate
commits, one for the code movement (i.e., refactoring of a large chunk
of read_index_from into read_index_v2_from), and a second one for the
introduction of the separate header struct.  Other than that it looks
good.


The rest would look like this:

>  cache.h                |  32 ++++-
>  read-cache.c           | 315 ++++++++++++++++++++++++++++++++++++++++++++++---
>  5 files changed, 334 insertions(+), 29 deletions(-)

The review follows, though note that as usual I have snipped all hunks
where I didn't have anything to add:

> @@ -108,6 +108,13 @@ struct cache_header_v2 {
>  	unsigned int hdr_entries;
>  };
>  
> +struct cache_header_v5 {
> +	unsigned int hdr_ndir;
> +	unsigned int hdr_nfile;
> +	unsigned int hdr_fblockoffset;
> +	unsigned int hdr_nextension;
> +};
> +
>  #define INDEX_FORMAT_LB 2
>  #define INDEX_FORMAT_UB 4

Somewhat confusingly, the non-update to INDEX_FORMAT_UB is correct since
that is only used by git-update-index to verify that a user request for
the *write* format is valid, and we don't currently support writing v5.

> @@ -132,11 +139,27 @@ struct cache_entry {
>  	unsigned int ce_size;
>  	unsigned int ce_flags;
>  	unsigned char sha1[20];
> +	int ce_stat_crc;

This should probably be an unsigned int for correctness.  The docs for
zlib actually say it has type 'uLong', whatever that might mean.  Don't
turn it into an unsigned long though, that would be 64 bits at least on
x86_64 Linux.

> +	unsigned int ce_namelen;

You are using this to hack around the issue that we dropped the name
length out of the flags to save bits.  Perhaps it would be a nice
cleanup to keep it in the struct "in the open", instead of having the
odd ce_namelen() wrapper that amounts to a maybe-strlen.

> +struct directory_entry {
> +	unsigned short de_flags;
> +	unsigned int de_foffset;
> +	unsigned int de_cr;
> +	unsigned int de_ncr;
> +	unsigned int de_nsubtrees;
> +	unsigned int de_nfiles;
> +	unsigned int de_nentries;
> +	unsigned char sha1[20];
> +	struct directory_entry *next;
> +	unsigned int de_pathlen;
> +	char pathname[FLEX_ARRAY];
> +};

Why are the flags out of order compared to the on-disk layout?

Also, if you make a linked list it would be more natural (to me) to put
the 'next' member at the top.  I suspect the precedent in 'cache_entry'
may be from times where that was the ondisk layout, and thus any
not-on-disk entries had to be at the end.  Perhaps Junio can clarify
this.

> -extern void read_index_v2_from(struct index_state *, struct stat, void *mmap, int);
> +extern void read_index_v2(struct index_state *, struct stat, void *mmap, int);
> +extern void read_index_v5(struct index_state *, struct stat, void *mmap, int);

You should make up your mind in the refactoring patch ;-)

> diff --git a/read-cache.c b/read-cache.c
> index 750fbfa..fc8033a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -397,8 +397,9 @@ int df_name_compare(const char *name1, int len1, int mode1,
>  
>  int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
>  {
> -	int len1 = flags1 & CE_NAMEMASK;
> -	int len2 = flags2 & CE_NAMEMASK;
> +	/* TODO: This possibly can be replaced with something faster */
> +	int len1 = strlen(name1);
> +	int len2 = strlen(name2);
>  	int len = len1 < len2 ? len1 : len2;
>  	int cmp;

Now that you have the ce_namelen entry, shouldn't you use that here?

If it is not filled in correctly by the other readers, you'd have to
patch them, preferably in an earlier patch where you introduce this
field (only -- not doing any v5 work yet).

> +static int verify_hdr_v5(void *mmap)
> +{
> +	uint32_t crc;
> +	uint32_t* filecrc;
> +	unsigned int header_size_v5;
> +	struct cache_version_header *hdr;
> +	struct cache_header_v5 *hdr_v5;
> +
> +	hdr = mmap;
> +	hdr_v5 = mmap + sizeof(*hdr);
> +	/* Size of the header + the size of the extensionoffsets */
> +	header_size_v5 = sizeof(*hdr_v5) + hdr_v5->hdr_nextension * 4;
> +	/* Initialize crc */
> +	crc = crc32(0, (Bytef*)hdr, sizeof(*hdr));
> +	crc = crc32(crc, (Bytef*)hdr_v5, header_size_v5);

Can't you crc32() this block in one go?

> +	filecrc = mmap + sizeof(*hdr) + header_size_v5;
> +	if (crc != ntohl(*filecrc))
> +		return error("bad index file header crc signature");
> +	return 0;
> +}
> +
>  static int read_index_extension(struct index_state *istate,
>  				const char *ext, void *data, unsigned long sz)
>  {
> @@ -1315,23 +1361,71 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
>  {
>  	struct cache_entry *ce = xmalloc(cache_entry_size(len));
>  
> -	ce->ce_ctime.sec = ntoh_l(ondisk->ctime.sec);
> -	ce->ce_mtime.sec = ntoh_l(ondisk->mtime.sec);
> +	ce->ce_ctime.sec  = ntoh_l(ondisk->ctime.sec);
> +	ce->ce_mtime.sec  = ntoh_l(ondisk->mtime.sec);
>  	ce->ce_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
>  	ce->ce_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
> -	ce->ce_dev   = ntoh_l(ondisk->dev);
> -	ce->ce_ino   = ntoh_l(ondisk->ino);
> -	ce->ce_mode  = ntoh_l(ondisk->mode);
> -	ce->ce_uid   = ntoh_l(ondisk->uid);
> -	ce->ce_gid   = ntoh_l(ondisk->gid);
> -	ce->ce_size  = ntoh_l(ondisk->size);
> -	ce->ce_flags = flags;
> +	ce->ce_dev        = ntoh_l(ondisk->dev);
> +	ce->ce_ino        = ntoh_l(ondisk->ino);
> +	ce->ce_mode       = ntoh_l(ondisk->mode);
> +	ce->ce_uid        = ntoh_l(ondisk->uid);
> +	ce->ce_gid        = ntoh_l(ondisk->gid);
> +	ce->ce_size       = ntoh_l(ondisk->size);
> +	ce->ce_flags      = flags;
> +	ce->ce_namelen    = len;

AFAICS all but the last one only change the alignment of the
assignments.  Only the last addition is a true change, related to the
addition of the ce_namelen field.  It would be far easier on the
reviewers if you first did the alignment cleanup (it can then be checked
to be a no-change patch simply with --ignore-space-change), and then the
ce_namelen, before any v5 work.

> +static struct directory_entry *read_directories_v5(unsigned int dir_offset,
> +				unsigned int ndir,
> +				void *mmap,
> +				int mmap_size)
> +{
> +	int i;
> +	uint32_t crc;
> +	uint32_t* filecrc;
> +	struct directory_entry *entries = NULL;
> +	struct directory_entry *current = NULL;
> +
> +	for (i = 0; i < ndir; i++) {
> +		struct ondisk_directory_entry *disk_de;
> +		struct directory_entry *de;
> +		unsigned int data_len; 
> +		unsigned int len;
> +		char *name;
> +
> +		name = (char *)mmap + dir_offset;
> +		len = strlen(name);
> +		disk_de = (struct ondisk_directory_entry *)
> +				((char *)mmap + dir_offset + len + 1);
> +		de = directory_entry_from_ondisk(disk_de, name, len);
> +
> +		if (entries == NULL) {
> +			entries = de;
> +			current = de;
> +		} else {
> +			current->next = de;
> +			current = current->next;
> +			current->next = NULL;
> +		}
> +
> +		/* Length of pathname + nul byte for termination + size of
> +		 * members of ondisk_directory_entry. (Just using the size
> +		 * of the stuct doesn't work, because there may be padding
> +		 * bytes for the struct)
> +		 */

Style nit: 

> +		data_len = len + 1
> +			+ sizeof(disk_de->flags)
> +			+ sizeof(disk_de->foffset)
> +			+ sizeof(disk_de->cr)
> +			+ sizeof(disk_de->ncr)
> +			+ sizeof(disk_de->nsubtrees)
> +			+ sizeof(disk_de->nfiles)
> +			+ sizeof(disk_de->nentries)
> +			+ sizeof(disk_de->sha1);

How does this differ from

  data_len = len + 1 + sizeof(struct ondisk_directory_entry);

?

> +
> +		crc = crc32(0, (Bytef*)(mmap + dir_offset), data_len);
> +		filecrc = mmap + dir_offset + data_len;
> +		if (crc != ntoh_l(*filecrc))
> +			goto unmap;

The CRC checking code in general is a bit noisy on my eyes, increasing
the risk that I would miss a mistake in one of the calls.  I wonder if
you could refactor it as something like

  static int check_crc32_chunk(void *data, size_t len, unsigned int expected_crc);

Then again the pointer math would still be on the caller side.  Sigh.

> +
> +		dir_offset += data_len + 4; /* crc code */
> +	}
> +
> +	return entries;
> +unmap:
> +	munmap(mmap, mmap_size);
> +	errno = EINVAL;
> +	die("directory crc doesn't match for '%s'", current->pathname);
> +}

I can see there's precedent for this in read_index_v2 (as of your patch;
it used to be in read_index_from); but what's the point of setting errno
immediately before not using it and exiting?

That's all for today.  Thanks for reading.


---- t/perf/p0002-index-v5.sh ----
#!/bin/sh

test_description="Tests index versions [23]/4/5"

. ./perf-lib.sh

test_perf_large_repo

test_perf 'v[23]: ls-files' '
	git ls-files >/dev/null
'

test_expect_success 'convert to v5' '
	$GIT_BUILD_DIR/git-convert-index.py
'

test_expect_success 'convert to v4' '
	git update-index --index-version=4
'

test_perf 'v4: ls-files' '
	git ls-files >/dev/null
'

test_perf 'v5: ls-files' '
	GIT_INDEX_FILE=.git/index-v5 git ls-files >/dev/null
'

test_done
----- t/perf/p0002-index-v5.sh ----

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
