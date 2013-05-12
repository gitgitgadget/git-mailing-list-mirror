From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] resolve_ref: close race condition for packed refs
Date: Mon, 13 May 2013 00:56:05 +0200
Message-ID: <51901E05.1080905@alum.mit.edu>
References: <20130507023610.GA22053@sigill.intra.peff.net> <20130507023802.GA22940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 13 00:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbfBg-0003dy-3K
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 00:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab3ELW4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 18:56:12 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:45532 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751578Ab3ELW4L (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 May 2013 18:56:11 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-72-51901e0aa427
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 89.5F.02380.A0E10915; Sun, 12 May 2013 18:56:10 -0400 (EDT)
Received: from [192.168.69.140] (p57A25404.dip0.t-ipconnect.de [87.162.84.4])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4CMu6ZP004787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 12 May 2013 18:56:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130507023802.GA22940@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqMslNyHQYOspZYuuK91MFg29V5gt
	5t3dxWTxo6WH2YHF49LL72wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xpqFt5kL
	OtUqLrfdY29g/CnTxcjJISFgInHhwFRmCFtM4sK99WxdjFwcQgKXGSXOTvjHBOGcZZL4fKCR
	EaSKV0BborXxH1gHi4CqxKaG5UwgNpuArsSinmYwW1QgTGLV+mXMEPWCEidnPmEBsUUEZCW+
	H94INodZIF3ibds7sLiwgJfE/1+zwHqFBDIlVv7rYAOxOQWsJX6/WwQU5wCqV5dYP08IolVe
	YvvbOcwTGAVmIdkwC6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNK
	NzFCgplvB2P7eplDjAIcjEo8vAn7+wKFWBPLiitzDzFKcjApifJ6SUwIFOJLyk+pzEgszogv
	Ks1JLT7EKMHBrCTC68YAlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAo
	SfC6ygI1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiNL4YGKkgKR6gveYg7bzF
	BYm5QFGI1lOMuhwrrzx5zSjEkpeflyolzisFUiQAUpRRmge3Apa6XjGKA30szGsBUsUDTHtw
	k14BLWECWnLGox9kSUkiQkqqgVHSgOvI0x3vT6xzcT1b+3eO4JSl5faCWUt260qISbXNPlS+
	sfFZ6b5ZKqqSn29sfTbdbLbDnO1HD7sUnjuzu1Ijel+waIcI193Ui3xPLxe4tSjt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224069>

On 05/07/2013 04:38 AM, Jeff King wrote:
> When we attempt to resolve a ref, the first thing we do is
> call lstat() to see if it is a symlink or a real ref. If we
> find that the ref is missing, we fall back to looking it up
> in the packed-refs file. If we find the loose ref does exist
> (and is a regular file), we continue with trying to open it.
> 
> However, we do not do the same fallback if our open() call
> fails; we just report the ref as missing.  A "git pack-refs
> --prune" process which is simultaneously running may remove
> the loose ref between our lstat() and open().  In this case,
> we would erroneously report the ref as missing, even though
> we could find it if we checked the packed-refs file.
> 
> This patch solves it by factoring out the fallback code from
> the lstat() case and calling it from both places. We do not
> need to do the same thing for the symlink/readlink code
> path, even though it might receive ENOENT, too, because
> symlinks cannot be packed (so if it disappears after the
> lstat, it is truly being deleted).
> 
> Note that this solves only the part of the race within
> resolve_ref_unsafe. In the situation described above, we may
> still be depending on a cached view of the packed-refs file;
> that race will be dealt with in a future patch.
> 
> Signed-off-by: Jeff King <peff@peff.net>

+1, with trivial suggestions below.

> ---
> 
>  refs.c | 63 ++++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 21 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index de2d8eb..5a14703 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1083,6 +1083,43 @@ static int get_packed_ref(const char *refname, unsigned char *sha1)
>  	return -1;
>  }
>  
> +/*
> + * This should be called from resolve_ref_unsafe when a loose ref cannot be
> + * accessed; err must represent the errno from the last attempt to access the
> + * loose ref, and the other options are forwarded from resolve_safe_unsaefe.

s/resolve_ref_unsaefe/resolve_ref_unsafe/

> + */
> +static const char *handle_loose_ref_failure(int err,
> +					    const char *refname,
> +					    unsigned char *sha1,
> +					    int reading,
> +					    int *flag)
> +{
> +	/*
> +	 * If we didn't get ENOENT, something is broken
> +	 * with the loose ref, and we should not fallback,
> +	 * but instead pretend it doesn't exist.
> +	 */
> +	if (err != ENOENT)
> +		return NULL;
> +
> +	/*
> +	 * The loose reference file does not exist;
> +	 * check for a packed reference.
> +	 */
> +	if (!get_packed_ref(refname, sha1)) {
> +		if (flag)
> +			*flag |= REF_ISPACKED;
> +		return refname;
> +	}
> +
> +	/* The reference is not a packed reference, either. */
> +	if (reading)
> +		return NULL;
> +
> +	hashclr(sha1);
> +	return refname;
> +}
> +
>  const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
>  {
>  	int depth = MAXDEPTH;
> @@ -1107,26 +1144,9 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
>  
>  		git_snpath(path, sizeof(path), "%s", refname);
>  
> -		if (lstat(path, &st) < 0) {
> -			if (errno != ENOENT)
> -				return NULL;
> -			/*
> -			 * The loose reference file does not exist;
> -			 * check for a packed reference.
> -			 */
> -			if (!get_packed_ref(refname, sha1)) {
> -				if (flag)
> -					*flag |= REF_ISPACKED;
> -				return refname;
> -			}
> -			/* The reference is not a packed reference, either. */
> -			if (reading) {
> -				return NULL;
> -			} else {
> -				hashclr(sha1);
> -				return refname;
> -			}
> -		}
> +		if (lstat(path, &st) < 0)
> +			return handle_loose_ref_failure(errno, refname, sha1,
> +							reading, flag);
>  
>  		/* Follow "normalized" - ie "refs/.." symlinks by hand */
>  		if (S_ISLNK(st.st_mode)) {
> @@ -1156,7 +1176,8 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
>  		 */
>  		fd = open(path, O_RDONLY);
>  		if (fd < 0)
> -			return NULL;
> +			return handle_loose_ref_failure(errno, refname, sha1,
> +							reading, flag);

I probably would have separated the rest of the patch, which is a pure
refactoring, from this last chunk, which is a functional change.  But
that's just me.

I suggest adding a comment here mentioning briefly the race condition
that the call to handle_loose_ref_failure() is meant to address;
otherwise somebody not thinking of race conditions might have the clever
idea of "inlining" the call to "return NULL" because it seems redundant
with the check of ENOENT following the lstat() call above.

>  		len = read_in_full(fd, buffer, sizeof(buffer)-1);
>  		close(fd);
>  		if (len < 0)
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
