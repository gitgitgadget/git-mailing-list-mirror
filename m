From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
	a pack file
Date: Tue, 9 Dec 2008 08:24:02 -0800
Message-ID: <20081209162402.GP31551@spearce.org>
References: <20081209093627.77039a1f@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>, tyler@slide.com
To: Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Dec 09 17:25:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA5Or-0006I9-Qs
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 17:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbYLIQYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2008 11:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbYLIQYG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 11:24:06 -0500
Received: from george.spearce.org ([209.20.77.23]:52645 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbYLIQYF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 11:24:05 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2F29D38200; Tue,  9 Dec 2008 16:24:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081209093627.77039a1f@perceptron>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102638>

Jan Kr=FCger <jk@jk.gs> wrote:
> For fixing a corrupted repository by using backup copies of individua=
l
> files, allow write_sha1_file() to write loose files even if the objec=
t
> already exists in a pack file, but only if the existing entry is mark=
ed
> as corrupted.

Huh.  So I'm digging around sha1_file.c and I'm not yet sure why
your patch makes a difference.

has_sha1_file() calls find_pack_entry() to determine which pack has
the object, and at what offset (if found).  It doesn't care about
the offset, but it does care about the successful match.

find_pack_entry() already considers the bad_object_sha1 for each
pack, before it even tries the binary search within the index.
So if the entry was known to be bad has_sha1_file() will return 0,
unless the object is loose.

Where this breaks down is if the object is being created,
its very likely we didn't attempt to read it in this process.
The bad_object_sha1 table is transient and populated only when
unpacking an object entry fails.  So for example during a merge
if a tree was stored in a pack and is corrupt and the merge
result produces that same tree object we won't write it out with
write_sha1_file() because it exists in a pack, but since we never
read it we also don't know the pack entry is corrupt.

Its horribly inefficient to read every object before we write it
back out.  The best thing to do when faced with corruption is to
stop and repack, overlaying the object database from a known good
copy of the repository so pack-objects can use the good copy when
a corrupt object is identified.

So I agree with you that changing this in write_sha1_file() is a
bad idea for the normal good cases, but I also don't see how this
patch changes anything at all... the code path you introduced is
already implemented.

> diff --git a/sha1_file.c b/sha1_file.c
> index 6c0e251..17085cc 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2373,14 +2373,17 @@ int write_sha1_file(void *buf, unsigned long =
len, const char *type, unsigned cha
>  	char hdr[32];
>  	int hdrlen;
> =20
> -	/* Normally if we have it in the pack then we do not bother writing
> -	 * it out into .git/objects/??/?{38} file.
> -	 */
>  	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
>  	if (returnsha1)
>  		hashcpy(returnsha1, sha1);
> -	if (has_sha1_file(sha1))
> -		return 0;
> +	/* Normally if we have it in the pack then we do not bother writing
> +	 * it out into .git/objects/??/?{38} file. We do, though, if there
> +	 * is no chance that we have an uncorrupted version of the object.
> +	 */
> +	if (has_sha1_file(sha1)) {
> +		if (has_loose_object(sha1) || !has_packed_and_bad(sha1))
> +			return 0;
> +	}
>  	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
>  }

--=20
Shawn.
