From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Review of current github code [Re: [GSoC] Designing a faster
 index format - Progress report week 6]
Date: Fri, 1 Jun 2012 16:49:02 +0200
Message-ID: <20120601144902.GG6449@tgummerer>
References: <20120528214401.GB6449@tgummerer>
 <87pq9k8i4e.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jun 01 16:49:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaTAD-0003d6-GZ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 16:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933413Ab2FAOtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 10:49:13 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41610 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933368Ab2FAOtI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 10:49:08 -0400
Received: by wgbdr13 with SMTP id dr13so2015087wgb.1
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dj5oToKW2c2wzEdtqgIfpCYGUsTZXasUFz7t4tJe2rI=;
        b=OICcuaD9yVJDZ8p3dGNxB9SgZ3qkRFS3bPR6FB8SZIJWBhj57pxGDmwGwmmsl01Cff
         I0Kb7gvvJhhxpJG9DPqYp4iWkmq+Zfv6kLyfvl6KFjtWoTzZV9WxFrKCVbuO7zLOxx5P
         hqqo3vMVH9z8iOn2mc7Ao4MsLt2rHdLTCJEgImRoWSIHEKxgvXOtdBEUBAvQ90CzPzNN
         aJGnKGqYhx89kzoHX8X3dW5pKvCEjFa+jbrWF56Je3H8f0zYT8bLN8TdztG8ntaT1reC
         WHFeh41a8tfp8dMrhCtLF17x8QYudCbnkCVAJ8eMp4lwlDY2/SJPBYraj2Zv2FE3fV3M
         Y+Nw==
Received: by 10.216.213.219 with SMTP id a69mr2432755wep.16.1338562146903;
        Fri, 01 Jun 2012 07:49:06 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id dg2sm8010302wib.4.2012.06.01.07.49.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Jun 2012 07:49:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87pq9k8i4e.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198992>

On 05/31, Thomas Rast wrote:
> As far as 174fea4 goes: I think you could split it into two separate
> commits, one for the code movement (i.e., refactoring of a large chunk
> of read_index_from into read_index_v2_from), and a second one for the
> introduction of the separate header struct.  Other than that it looks
> good.

Thanks for your review. I rebased the commits now, 174fea4 is now
5eb9c21 and 946888d. There were also two commits to the python code,
which I moved previous of the refactoring commits. (210d1ff and b99fdf8)

> The rest would look like this:
> 
> >  cache.h                |  32 ++++-
> >  read-cache.c           | 315 ++++++++++++++++++++++++++++++++++++++++++++++---
> >  5 files changed, 334 insertions(+), 29 deletions(-)
> 
> The review follows, though note that as usual I have snipped all hunks
> where I didn't have anything to add:
> 
> > @@ -108,6 +108,13 @@ struct cache_header_v2 {
> >  	unsigned int hdr_entries;
> >  };
> >  
> > +struct cache_header_v5 {
> > +	unsigned int hdr_ndir;
> > +	unsigned int hdr_nfile;
> > +	unsigned int hdr_fblockoffset;
> > +	unsigned int hdr_nextension;
> > +};
> > +
> >  #define INDEX_FORMAT_LB 2
> >  #define INDEX_FORMAT_UB 4
> 
> Somewhat confusingly, the non-update to INDEX_FORMAT_UB is correct since
> that is only used by git-update-index to verify that a user request for
> the *write* format is valid, and we don't currently support writing v5.

I left them as they are, since they aren't used in the read code, so I
thought this would be fine.

> > @@ -132,11 +139,27 @@ struct cache_entry {
> >  	unsigned int ce_size;
> >  	unsigned int ce_flags;
> >  	unsigned char sha1[20];
> > +	int ce_stat_crc;
> 
> This should probably be an unsigned int for correctness.  The docs for
> zlib actually say it has type 'uLong', whatever that might mean.  Don't
> turn it into an unsigned long though, that would be 64 bits at least on
> x86_64 Linux.

I digged a bit in the git code, uint32_t seems to be the right way to
do it. (as in csum-file.h) I converted it to that for now.

> > +	unsigned int ce_namelen;
> 
> You are using this to hack around the issue that we dropped the name
> length out of the flags to save bits.  Perhaps it would be a nice
> cleanup to keep it in the struct "in the open", instead of having the
> odd ce_namelen() wrapper that amounts to a maybe-strlen.

I guess that may better fit in a refactoring patch? I put it in
e73adcf.

> > +struct directory_entry {
> > +	unsigned short de_flags;
> > +	unsigned int de_foffset;
> > +	unsigned int de_cr;
> > +	unsigned int de_ncr;
> > +	unsigned int de_nsubtrees;
> > +	unsigned int de_nfiles;
> > +	unsigned int de_nentries;
> > +	unsigned char sha1[20];
> > +	struct directory_entry *next;
> > +	unsigned int de_pathlen;
> > +	char pathname[FLEX_ARRAY];
> > +};
> 
> Why are the flags out of order compared to the on-disk layout?
> 
> Also, if you make a linked list it would be more natural (to me) to put
> the 'next' member at the top.  I suspect the precedent in 'cache_entry'
> may be from times where that was the ondisk layout, and thus any
> not-on-disk entries had to be at the end.  Perhaps Junio can clarify
> this.

They were in order at the beginning, before I moved the flags to the
end in the ondisk format, and forgot to move them in the struct. It's
in order now.

I also moved the next member to the top. I originally put it at the
end, because it was at the end for the cache_entry too.

> > -extern void read_index_v2_from(struct index_state *, struct stat, void *mmap, int);
> > +extern void read_index_v2(struct index_state *, struct stat, void *mmap, int);
> > +extern void read_index_v5(struct index_state *, struct stat, void *mmap, int);
> 
> You should make up your mind in the refactoring patch ;-)

I thing read_index_v2 makes more sense, since from sounds like we expect
a pathname.

> > diff --git a/read-cache.c b/read-cache.c
> > index 750fbfa..fc8033a 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -397,8 +397,9 @@ int df_name_compare(const char *name1, int len1, int mode1,
> >  
> >  int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
> >  {
> > -	int len1 = flags1 & CE_NAMEMASK;
> > -	int len2 = flags2 & CE_NAMEMASK;
> > +	/* TODO: This possibly can be replaced with something faster */
> > +	int len1 = strlen(name1);
> > +	int len2 = strlen(name2);
> >  	int len = len1 < len2 ? len1 : len2;
> >  	int cmp;
> 
> Now that you have the ce_namelen entry, shouldn't you use that here?
> 
> If it is not filled in correctly by the other readers, you'd have to
> patch them, preferably in an earlier patch where you introduce this
> field (only -- not doing any v5 work yet).

Yes, there would be more patching needed, since the function uses the
flags too. The patch is not yet in the repository.

> > +static int verify_hdr_v5(void *mmap)
> > +{
> > +	uint32_t crc;
> > +	uint32_t* filecrc;
> > +	unsigned int header_size_v5;
> > +	struct cache_version_header *hdr;
> > +	struct cache_header_v5 *hdr_v5;
> > +
> > +	hdr = mmap;
> > +	hdr_v5 = mmap + sizeof(*hdr);
> > +	/* Size of the header + the size of the extensionoffsets */
> > +	header_size_v5 = sizeof(*hdr_v5) + hdr_v5->hdr_nextension * 4;
> > +	/* Initialize crc */
> > +	crc = crc32(0, (Bytef*)hdr, sizeof(*hdr));
> > +	crc = crc32(crc, (Bytef*)hdr_v5, header_size_v5);
> 
> Can't you crc32() this block in one go?

Yes, I just thought it's clearer this way, calculating the crc for the
signature + version and the rest of the header_v5. I changed it for now
to one block.

> > +	filecrc = mmap + sizeof(*hdr) + header_size_v5;
> > +	if (crc != ntohl(*filecrc))
> > +		return error("bad index file header crc signature");
> > +	return 0;
> > +}
> > +
> >  static int read_index_extension(struct index_state *istate,
> >  				const char *ext, void *data, unsigned long sz)
> >  {
> > @@ -1315,23 +1361,71 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
> >  {
> >  	struct cache_entry *ce = xmalloc(cache_entry_size(len));
> >  
> > -	ce->ce_ctime.sec = ntoh_l(ondisk->ctime.sec);
> > -	ce->ce_mtime.sec = ntoh_l(ondisk->mtime.sec);
> > +	ce->ce_ctime.sec  = ntoh_l(ondisk->ctime.sec);
> > +	ce->ce_mtime.sec  = ntoh_l(ondisk->mtime.sec);
> >  	ce->ce_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
> >  	ce->ce_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
> > -	ce->ce_dev   = ntoh_l(ondisk->dev);
> > -	ce->ce_ino   = ntoh_l(ondisk->ino);
> > -	ce->ce_mode  = ntoh_l(ondisk->mode);
> > -	ce->ce_uid   = ntoh_l(ondisk->uid);
> > -	ce->ce_gid   = ntoh_l(ondisk->gid);
> > -	ce->ce_size  = ntoh_l(ondisk->size);
> > -	ce->ce_flags = flags;
> > +	ce->ce_dev        = ntoh_l(ondisk->dev);
> > +	ce->ce_ino        = ntoh_l(ondisk->ino);
> > +	ce->ce_mode       = ntoh_l(ondisk->mode);
> > +	ce->ce_uid        = ntoh_l(ondisk->uid);
> > +	ce->ce_gid        = ntoh_l(ondisk->gid);
> > +	ce->ce_size       = ntoh_l(ondisk->size);
> > +	ce->ce_flags      = flags;
> > +	ce->ce_namelen    = len;
> 
> AFAICS all but the last one only change the alignment of the
> assignments.  Only the last addition is a true change, related to the
> addition of the ce_namelen field.  It would be far easier on the
> reviewers if you first did the alignment cleanup (it can then be checked
> to be a no-change patch simply with --ignore-space-change), and then the
> ce_namelen, before any v5 work.

Ok, this is changed in e73adcf. The alignment is done in bbc8928. Hope
understood the alignment cleanup right.

> > +static struct directory_entry *read_directories_v5(unsigned int dir_offset,
> > +				unsigned int ndir,
> > +				void *mmap,
> > +				int mmap_size)
> > +{
> > +	int i;
> > +	uint32_t crc;
> > +	uint32_t* filecrc;
> > +	struct directory_entry *entries = NULL;
> > +	struct directory_entry *current = NULL;
> > +
> > +	for (i = 0; i < ndir; i++) {
> > +		struct ondisk_directory_entry *disk_de;
> > +		struct directory_entry *de;
> > +		unsigned int data_len; 
> > +		unsigned int len;
> > +		char *name;
> > +
> > +		name = (char *)mmap + dir_offset;
> > +		len = strlen(name);
> > +		disk_de = (struct ondisk_directory_entry *)
> > +				((char *)mmap + dir_offset + len + 1);
> > +		de = directory_entry_from_ondisk(disk_de, name, len);
> > +
> > +		if (entries == NULL) {
> > +			entries = de;
> > +			current = de;
> > +		} else {
> > +			current->next = de;
> > +			current = current->next;
> > +			current->next = NULL;
> > +		}
> > +
> > +		/* Length of pathname + nul byte for termination + size of
> > +		 * members of ondisk_directory_entry. (Just using the size
> > +		 * of the stuct doesn't work, because there may be padding
> > +		 * bytes for the struct)
> > +		 */
> 
> Style nit: 
> 
> > +		data_len = len + 1
> > +			+ sizeof(disk_de->flags)
> > +			+ sizeof(disk_de->foffset)
> > +			+ sizeof(disk_de->cr)
> > +			+ sizeof(disk_de->ncr)
> > +			+ sizeof(disk_de->nsubtrees)
> > +			+ sizeof(disk_de->nfiles)
> > +			+ sizeof(disk_de->nentries)
> > +			+ sizeof(disk_de->sha1);
> 
> How does this differ from
> 
>   data_len = len + 1 + sizeof(struct ondisk_directory_entry);
> 
> ?

There is only a single 16-bit entry in struct ondisk_directory_entry
for which the compiler adds padding so the size of the struct is a
multiple of 32-bit. And since I'm not sure every compiler does that,
I had to do it this way. (And adding a -2 magic number doesn't seem
cleaner to me eiter)

> > +
> > +		crc = crc32(0, (Bytef*)(mmap + dir_offset), data_len);
> > +		filecrc = mmap + dir_offset + data_len;
> > +		if (crc != ntoh_l(*filecrc))
> > +			goto unmap;
> 
> The CRC checking code in general is a bit noisy on my eyes, increasing
> the risk that I would miss a mistake in one of the calls.  I wonder if
> you could refactor it as something like
> 
>   static int check_crc32_chunk(void *data, size_t len, unsigned int expected_crc);
> 
> Then again the pointer math would still be on the caller side.  Sigh.

Yes, that makes sense, I changed it.

> > +
> > +		dir_offset += data_len + 4; /* crc code */
> > +	}
> > +
> > +	return entries;
> > +unmap:
> > +	munmap(mmap, mmap_size);
> > +	errno = EINVAL;
> > +	die("directory crc doesn't match for '%s'", current->pathname);
> > +}
> 
> I can see there's precedent for this in read_index_v2 (as of your patch;
> it used to be in read_index_from); but what's the point of setting errno
> immediately before not using it and exiting?

I just copy and pasted it from there, but thinking about it id doesn't
make sense.

> That's all for today.  Thanks for reading.

Thanks a lot for reviewing my code.

--
Thomas
