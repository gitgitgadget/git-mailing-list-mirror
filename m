From: Junio C Hamano <gitster@pobox.com>
Subject: Re: performance problem: "git commit filename"
Date: Mon, 14 Jan 2008 12:08:44 -0800
Message-ID: <7vodbojhkj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
	<7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org>
	<7vr6glnrvp.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801140902140.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801141132250.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 21:09:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEVcZ-0000kE-TD
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 21:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbYANUIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 15:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYANUIz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 15:08:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbYANUIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 15:08:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D1EE23E6A;
	Mon, 14 Jan 2008 15:08:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C24463E68;
	Mon, 14 Jan 2008 15:08:46 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801141132250.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 14 Jan 2008 11:39:17 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70472>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 14 Jan 2008, Linus Torvalds wrote:
>> 
>> So I think this patch is good, but I think it would be even better if we 
>> just bit the bullet and started looking at having a different in-memory 
>> representation from the on-disk one.
>
> Ok, so here's a possible patch.
>
> It passes all the tests for me, and looks fairly ok, but it's also a bit 
> big.
>
> What makes it big is that I made the in-memory format be in host order, so 
> that we can remove a *lot* of the "htonl/ntohl" switcheroo, and do it just 
> on index file read/write.
>
> The nice thing about this patch is that it would make it a lot easier to 
> do any index handling changes,  because it makes a clear difference 
> between the on-disk and the in-memory formats.
>
> I realize that the patch looks big (195 lines inserted and 148 lines 
> removed), but *most* of the lines are literally those ntohl() 
> simplifications, ie stuff like
>
> 	-       if (S_ISGITLINK(ntohl(ce->ce_mode))) {
> 	+       if (S_ISGITLINK(ce->ce_mode)) {
>
> so while it adds lines (for the "convert from disk" and "convert to disk" 
> format conversions), in  many ways it really simplifies the source code 
> too.
>
> Comments?
>
> This is on top of current master, so it's *before* junios thing that adds 
> a CE_UPTODATE.
>
> With this, the high 16 bits of "ce_flags" are in-memory only, so you could 
> just make CE_UPTODATE be 0x10000, and it automatically ends up never being 
> written to disk (and always "reads" as zero).
>
> 		Linus

> diff --git a/cache.h b/cache.h
> index 39331c2..0aed11e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -94,17 +94,31 @@ struct cache_time {
>   * We save the fields in big-endian order to allow using the
>   * index file over NFS transparently.
>   */
> +struct ondisk_cache_entry {
> +	struct cache_time ctime;
> +	struct cache_time mtime;
> +	unsigned int dev;
> +	unsigned int ino;
> +	unsigned int mode;
> +	unsigned int uid;
> +	unsigned int gid;
> +	unsigned int size;
> +	unsigned char sha1[20];
> +	unsigned short flags;
> +	char name[FLEX_ARRAY]; /* more */
> +};
> +
>  struct cache_entry {
> -	struct cache_time ce_ctime;
> -	struct cache_time ce_mtime;
> +	unsigned int ce_ctime;
> +	unsigned int ce_mtime;
>  	unsigned int ce_dev;
>  	unsigned int ce_ino;
>  	unsigned int ce_mode;
>  	unsigned int ce_uid;
>  	unsigned int ce_gid;
>  	unsigned int ce_size;
> +	unsigned int ce_flags;
>  	unsigned char sha1[20];
> -	unsigned short ce_flags;
>  	char name[FLEX_ARRAY]; /* more */
>  };

If we are using different types anyway, we might want to start
using time_t (a worse alternative is ulong which we use for
timestamps everywhere else, which we probably want to convert to
time_t as well).

Is there still a reason to insist that ce_flags should be a
single field that is multi-purposed for storing stage, namelen
and other flags?  Wouldn't the code become even simpler and
safer if we separated them into individual fields?  For example,
a piece like this:

@@ -2388,7 +2388,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
-	ce->ce_flags = htons(namelen);
+	ce->ce_flags = namelen;
 	if (S_ISGITLINK(mode)) {
 		const char *s = buf;
 
still has that "names longer than 4096 bytes go unchecked,
corrupting stage information" issue.

+static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_entry *ce)
+{
+	ce->ce_ctime = ntohl(ondisk->ctime.sec);
+	ce->ce_mtime = ntohl(ondisk->mtime.sec);
+	ce->ce_dev   = ntohl(ondisk->dev);
+	ce->ce_ino   = ntohl(ondisk->ino);
+	ce->ce_mode  = ntohl(ondisk->mode);
+	ce->ce_uid   = ntohl(ondisk->uid);
+	ce->ce_gid   = ntohl(ondisk->gid);
+	ce->ce_size  = ntohl(ondisk->size);
+	/* On-disk flags are just 16 bits */
+	ce->ce_flags = ntohs(ondisk->flags);
+	hashcpy(ce->sha1, ondisk->sha1);
+	memcpy(ce->name, ondisk->name, ce_namelen(ce)+1);
+}

I presume that the fix to handle names that are longer than 4096
bytes naturally fits here.  We can make the low 12-bits of
ondisk->ce_flags all 1 for such names and we actually
count the strlen to populate ce->ce_namelen.

> +	/*
> +	 * The disk format is actually larger than the in-memory format,
> +	 * due to space for nsec etc, so even though the in-memory one
> +	 * has room for a few  more flags, we can allocate using the same
> +	 * index size
> +	 */
> +	istate->alloc = xmalloc(mmap_size);
> +
> +	src_offset = sizeof(*hdr);
> +	dst_offset = 0;
>  	for (i = 0; i < istate->cache_nr; i++) {
> +		struct ondisk_cache_entry *disk_ce;
>  		struct cache_entry *ce;
>  
> -		ce = (struct cache_entry *)((char *)(istate->mmap) + offset);
> -		offset = offset + ce_size(ce);
> +		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
> +		ce = (struct cache_entry *)((char *)istate->alloc + dst_offset);
> +		convert_from_disk(disk_ce, ce);
>  		istate->cache[i] = ce;
> +
> +		src_offset += ondisk_ce_size(ce);
> +		dst_offset += ce_size(ce);
>  	}
>  	istate->timestamp = st.st_mtime;

I somehow had this impression that it was a huge deal to you
that we do not have to read and populate each cache entry when
reading from the existing index file, and thought that was the
reason why we mmap and access the fields in network byte order.
If that was my misconception, then I agree this is a good change
to make everything else easier to write and much less error
prone.
