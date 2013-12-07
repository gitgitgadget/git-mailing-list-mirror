From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 11/21] pack-objects: use bitmaps when packing objects
Date: Sat, 07 Dec 2013 16:47:20 +0100
Message-ID: <87zjock6if.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124510.GK10757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 16:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpK6n-0000f1-3A
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 16:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab3LGPrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 10:47:37 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52100 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755158Ab3LGPrg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 10:47:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 1E3D24D6510;
	Sat,  7 Dec 2013 16:47:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WaV-ORJsbxWy; Sat,  7 Dec 2013 16:47:21 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 9A8D34D64C4;
	Sat,  7 Dec 2013 16:47:20 +0100 (CET)
In-Reply-To: <20131114124510.GK10757@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 07:45:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238986>

This week's nits...

I found this harder to read than the previous patch, but I think it's
mostly because the existing code is already a bit tangled.  I think the
second item below is worth fixing, though.


Jeff King <peff@peff.net> writes:

> +static off_t write_reused_pack(struct sha1file *f)
> +{
> +	uint8_t buffer[8192];

We usually just call this 'unsigned char'.  I can see why this would be
more portable, but git would already fall apart badly on an architecture
where char is not 8 bits.

> +	off_t to_write;
> +	int fd;
> +
> +	if (!is_pack_valid(reuse_packfile))
> +		return 0;
> +
> +	fd = git_open_noatime(reuse_packfile->pack_name);
> +	if (fd < 0)
> +		return 0;
> +
> +	if (lseek(fd, sizeof(struct pack_header), SEEK_SET) == -1) {
> +		close(fd);
> +		return 0;
> +	}

You do an error return if any of the syscalls in this routine fails, but
there is only one caller and it immediately dies:

} +			packfile_size = write_reused_pack(f);
} +			if (!packfile_size)
} +				die_errno("failed to re-use existing pack");

So if you just died here, when the error happens, you could take the
chance to tell the user _which_ syscall failed.

> +
> +	if (reuse_packfile_offset < 0)
> +		reuse_packfile_offset = reuse_packfile->pack_size - 20;
> +
> +	to_write = reuse_packfile_offset - sizeof(struct pack_header);
> +
> +	while (to_write) {
> +		int read_pack = xread(fd, buffer, sizeof(buffer));
> +
> +		if (read_pack <= 0) {
> +			close(fd);
> +			return 0;

Similar to the above, but this one may also clobber the 'errno' during
close(), which can lead to misleading messages.

> +		}
> +
> +		if (read_pack > to_write)
> +			read_pack = to_write;
> +
> +		sha1write(f, buffer, read_pack);

Not your fault, but sha1write() is an odd function -- it purportedly is

  int sha1write(struct sha1file *f, const void *buf, unsigned int count);

but it can only return 0.  This goes back all the way to c38138c
(git-pack-objects: write the pack files with a SHA1 csum, 2005-06-26).

> +		to_write -= read_pack;
> +	}
> +
> +	close(fd);
> +	written += reuse_packfile_objects;
> +	return reuse_packfile_offset - sizeof(struct pack_header);
> +}
[...]
> -static int add_object_entry(const unsigned char *sha1, enum object_type type,
> -			    const char *name, int exclude)
> +static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
> +			      int flags, uint32_t name_hash,
> +			      struct packed_git *found_pack, off_t found_offset)
>  {
[...]
> -	for (p = packed_git; p; p = p->next) {
> -		off_t offset = find_pack_entry_one(sha1, p);
> -		if (offset) {
> -			if (!found_pack) {
> -				if (!is_pack_valid(p)) {
> -					warning("packfile %s cannot be accessed", p->pack_name);
> -					continue;
> +	if (!found_pack) {
> +		for (p = packed_git; p; p = p->next) {
> +			off_t offset = find_pack_entry_one(sha1, p);
> +			if (offset) {
> +				if (!found_pack) {
> +					if (!is_pack_valid(p)) {
> +						warning("packfile %s cannot be accessed", p->pack_name);
> +						continue;
> +					}
> +					found_offset = offset;
> +					found_pack = p;
>  				}
> -				found_offset = offset;
> -				found_pack = p;
> +				if (exclude)
> +					break;
> +				if (incremental)
> +					return 0;
> +				if (local && !p->pack_local)
> +					return 0;
> +				if (ignore_packed_keep && p->pack_local && p->pack_keep)
> +					return 0;
>  			}
> -			if (exclude)
> -				break;
> -			if (incremental)
> -				return 0;
> -			if (local && !p->pack_local)
> -				return 0;
> -			if (ignore_packed_keep && p->pack_local && p->pack_keep)
> -				return 0;
>  		}
>  	}

This function makes my head spin, and you're indenting it yet another
level.

If it's not too much work, can you split it into the three parts that it
really is?  IIUC it boils down to

  do we have this already?
      possibly apply 'exclude', then return
  are we coming from a call path that doesn't tell us which pack to take
  it from?
      find _all_ instances in packs
      check if any of them are local .keep packs
          if so, return
  construct a packlist entry to taste

>  	entry = packlist_alloc(&to_pack, sha1, index_pos);
> -	entry->hash = hash;
> +	entry->hash = name_hash;
>  	if (type)
>  		entry->type = type;
>  	if (exclude)
>  		entry->preferred_base = 1;
>  	else
>  		nr_result++;
> +
> +	if (flags & OBJECT_ENTRY_NO_TRY_DELTA)
> +		entry->no_try_delta = 1;
> +
>  	if (found_pack) {
>  		entry->in_pack = found_pack;
>  		entry->in_pack_offset = found_offset;
> @@ -859,10 +932,21 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  
>  	display_progress(progress_state, to_pack.nr_objects);
>  
> +	return 1;
> +}

-- 
Thomas Rast
tr@thomasrast.ch
