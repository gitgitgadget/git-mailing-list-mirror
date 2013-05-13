From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/4] get_packed_refs: reload packed-refs file when it
 changes
Date: Mon, 13 May 2013 04:43:54 +0200
Message-ID: <5190536A.5090606@alum.mit.edu>
References: <20130507023610.GA22053@sigill.intra.peff.net> <20130507024313.GC22940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 13 04:44:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubik7-0006nn-GF
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 04:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643Ab3EMCn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 22:43:59 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:55968 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753281Ab3EMCn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 May 2013 22:43:58 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-01-5190536dd1c0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 18.61.02380.D6350915; Sun, 12 May 2013 22:43:57 -0400 (EDT)
Received: from [192.168.69.140] (p57A25404.dip0.t-ipconnect.de [87.162.84.4])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4D2hsK8014241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 12 May 2013 22:43:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130507024313.GC22940@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqJsbPCHQYNE/dYuuK91MFg29V5gt
	5t3dxWTxo6WH2YHF49LL72wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xvYZN1gK
	FhpU9Oy+wNbAOFWti5GTQ0LARGLb2rusELaYxIV769m6GLk4hAQuM0psufaWBcI5yyQxv/MR
	E0gVr4C2xNzHK8BsFgFViYafixhBbDYBXYlFPc1gcVGBMIlV65cxQ9QLSpyc+YQFxBYRkJX4
	fngjWD2zQLrE27Z3YHFhgWCJtQtPgdULCWRKXP/xHWwOp4C1xJfJO9i7GDmA6tUl1s8TgmiV
	l9j+dg7zBEaBWUg2zEKomoWkagEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwSvdSU
	0k2MkGDm28HYvl7mEKMAB6MSD+8C5QmBQqyJZcWVuYcYJTmYlER5DwQChfiS8lMqMxKLM+KL
	SnNSiw8xSnAwK4nw7nUDyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiU
	JHi9g4AaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFxGl8MjFSQFA/Q3liQdt7i
	gsRcoChE6ylGS45ZW5+8ZuRYeQVEfrz34jWjEEtefl6qlDjvFJAGAZCGjNI8uHWwlPaKURzo
	e2HeOJAqHmA6hJv6CmghE9DCMx79IAtLEhFSUg2M1hIs61/esT8VcOb7whf/b68+mPZJmSd0
	nmTuu/8iZedZmn6U/4nynFzh29wdwbvE+Q5j5Y0HnLKFZhu+Csd7HVr5jqlJ0u9X 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224076>

On 05/07/2013 04:43 AM, Jeff King wrote:
> Once we read the packed-refs file into memory, we cache it
> to save work on future ref lookups. However, our cache may
> be out of date with respect to what is on disk if another
> process is simultaneously packing the refs. Normally it
> is acceptable for us to be a little out of date, since there
> is no guarantee whether we read the file before or after the
> simultaneous update. However, there is an important special
> case: our packed-refs file must be up to date with respect
> to any loose refs we read. Otherwise, we risk the following
> race condition:
> 
>   0. There exists a loose ref refs/heads/master.
> 
>   1. Process A starts and looks up the ref "master". It
>      first checks $GIT_DIR/master, which does not exist. It
>      then loads (and caches) the packed-refs file to see if
>      "master" exists in it, which it does not.
> 
>   2. Meanwhile, process B runs "pack-refs --all --prune". It
>      creates a new packed-refs file which contains
>      refs/heads/master, and removes the loose copy at
>      $GIT_DIR/refs/heads/master.
> 
>   3. Process A continues its lookup, and eventually tries
>      $GIT_DIR/refs/heads/master.  It sees that the loose ref
>      is missing, and falls back to the packed-refs file. But
>      it examines its cached version, which does not have
>      refs/heads/master. After trying a few other prefixes,
>      it reports master as a non-existent ref.
> 
> There are many variants (e.g., step 1 may involve process A
> looking up another ref entirely, so even a fully qualified
> refname can fail). One of the most interesting ones is if
> "refs/heads/master" is already packed. In that case process
> A will not see it as missing, but rather will report
> whatever value happened to be in the packed-refs file before
> process B repacked (which might be an arbitrarily old
> value).
> 
> We can fix this by making sure we reload the packed-refs
> file from disk after looking at any loose refs. That's
> unacceptably slow, so we can check it's stat()-validity as a
> proxy, and read it only when it appears to have changed.
> 
> Reading the packed-refs file after performing any loose-ref
> system calls is sufficient because we know the ordering of
> the pack-refs process: it always makes sure the newly
> written packed-refs file is installed into place before
> pruning any loose refs. As long as those operations by B
> appear in their executed order to process A, by the time A
> sees the missing loose ref, the new packed-refs file must be
> in place.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I hooked the refreshing into get_packed_refs, since then all callers get
> it for free. It makes me a little nervous, though, just in case some
> caller really cares about calling get_packed_refs but not having the
> list of packed-refs change during the call. peel_ref looks like such a
> function, but isn't, for reasons I'll explain in a followup patch.
> 
> Clone also looks like such a caller, as it calls get_packed_refs once
> for each upstream ref it adds (it puts them in the packed-refs list, and
> then writes them all out at the end). But it's OK because there is no
> packed-refs file for it to refresh from.
> 
> An alternative would be to move the refreshing to an explicit
> refresh_packed_refs() function, and call it from a few places
> (resolve_ref, and later from do_for_each_ref).

I think this will be necessary, because otherwise there are too many
places where the packed-refs cache can be invalidated and re-read.

As a test, I changed your stat_validity_check() to return 0 *all* of the
time when a file exists.  I think this simulates a hyperactive
repository in which the packed-refs file changes every time it is
checked.  With this change, hundreds of tests in the test suite fail.

I haven't had time to dig into the failures.  One example is

git-upload-pack: refs.c:542: do_for_each_ref_in_dir: Assertion
`dir->sorted == dir->nr' failed.

This suggests that the packed ref cache was invalidated while somebody
was iterating over it, resulting perhaps in illegal memory references.

Maybe my test is misguided.  But I definitely would not proceed on this
patch until the situation has been understood better.

Michael

>  refs.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 5a14703..6afe8cc 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -708,6 +708,7 @@ static struct ref_cache {
>  	struct ref_cache *next;
>  	struct ref_entry *loose;
>  	struct ref_entry *packed;
> +	struct stat_validity packed_validity;
>  	/* The submodule name, or "" for the main repo. */
>  	char name[FLEX_ARRAY];
>  } *ref_cache;
> @@ -717,6 +718,7 @@ static void clear_packed_ref_cache(struct ref_cache *refs)
>  	if (refs->packed) {
>  		free_ref_entry(refs->packed);
>  		refs->packed = NULL;
> +		stat_validity_clear(&refs->packed_validity);
>  	}
>  }
>  
> @@ -878,17 +880,25 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
>  
>  static struct ref_dir *get_packed_refs(struct ref_cache *refs)
>  {
> +	const char *packed_refs_file;
> +
> +	if (*refs->name)
> +		packed_refs_file = git_path_submodule(refs->name, "packed-refs");
> +	else
> +		packed_refs_file = git_path("packed-refs");
> +
> +	if (refs->packed &&
> +	    !stat_validity_check(&refs->packed_validity, packed_refs_file))
> +		clear_packed_ref_cache(refs);
> +
>  	if (!refs->packed) {
> -		const char *packed_refs_file;
>  		FILE *f;
>  
>  		refs->packed = create_dir_entry(refs, "", 0, 0);
> -		if (*refs->name)
> -			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
> -		else
> -			packed_refs_file = git_path("packed-refs");
> +
>  		f = fopen(packed_refs_file, "r");
>  		if (f) {
> +			stat_validity_update(&refs->packed_validity, fileno(f));
>  			read_packed_refs(f, get_ref_dir(refs->packed));
>  			fclose(f);
>  		}
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
