From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] patch-id: make it stable against hunk reordering
Date: Fri, 28 Mar 2014 12:20:13 -0700
Message-ID: <xmqqha6i9lle.fsf@gitster.dls.corp.google.com>
References: <1396009159-2078-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 20:20:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTcKJ-00073E-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 20:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbaC1TUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 15:20:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbaC1TUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 15:20:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 544B177042;
	Fri, 28 Mar 2014 15:20:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nhg4/4T9FAhphL2UoIgPIrtwc2c=; b=E4JSwD
	ks2pgsJz62AGvZv5fa6cbxJdBqwKGs0ZFYpDFBBOLC2YEaJD1YVxjJmJzGuySmQ4
	roRkf3yGVbGl0cjmXGxAWj9cAh3JYgD1H0JTUTRjZYCRV5uUZluTQdTi0vzOt+cw
	81/pXMU3upLVyvxZ6NRgzg4O4wz/UnjKwgixU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sux/+kwiHl9r3C8bXokhgy7O4mBT8J0O
	J2ctdyjQtgCKLaF9TOWNYacEAxzRHyHLpADmY958kK5c+ACdS2bRAGZSQxVeYEh5
	RRI0S6gfa5NrPAUF9DLKsOF9zpLuDmhpPJt33m+JdersrVym13wHyKdBB4mQyk/U
	AXwnGV6c7FM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40A5777041;
	Fri, 28 Mar 2014 15:20:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4869B7703F;
	Fri, 28 Mar 2014 15:20:15 -0400 (EDT)
In-Reply-To: <1396009159-2078-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Fri, 28 Mar 2014 14:30:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FDBBB83A-B6AD-11E3-8723-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245420>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Patch id changes if you reorder hunks in a diff.
> As the result is functionally equivalent, this is surprising to many
> people.
> In particular, reordering hunks is helpful to make patches
> more readable (e.g. API header diff before implementation diff).
> In git, it is often done e.g. using the "-O <orderfile>" option,
> so supporting it better has value.
>
> Hunks within file can be reordered manually provided
> the same pathname can appear more than once in the input.
>
> Change patch-id behaviour making it stable against
> hunk reodering:
> 	- prepend header to each hunk (if not there)
> 		Note: POSIX requires patch to be robust against hunk reordering
> 		provided each diff hunk has a header:
> 		http://pubs.opengroup.org/onlinepubs/7908799/xcu/patch.html
> 		If the patch file contains more than one patch, patch will attempt to
> 		apply each of them as if they came from separate patch files. (In this
> 		case the name of the patch file must be determinable for each diff
> 		listing.)
>
> 	- calculate SHA1 hash for each hunk separately
> 	- sum all hashes to get patch id
>
> Add a new flag --unstable to get the historical behaviour.
>
> Add --stable which is a nop, for symmetry.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Changes from v1: documented motivation for supporting
> hunk reordering (and not just file reordering).
> No code changes.
>
> Junio, you didn't respond so I'm not sure whether I convinced
> you that supporting hunk reordering within file has value.
> So I kept this functionality around for now, if
> you think I should drop this, please let me know explicitly.
> Thanks, and sorry about being dense!

The motivation I read from the exchange was that:

 (1) we definitely want to support a mode that is stable with use of
     "diff -O" (i.e. reordering patches per paths);

 (2) supporting a patch with swapped "hunks" does not have any
     practical value.  When you have a patch to the same file F with
     two hunks starting at lines 20 and 40, manually reordering
     hunks to create a patch that shows the hunk that starts at line
     40 and then the other hunk that starts at line 20 is not a
     useful exercise;

 (3) but supporting a patch that touches the same path more than
     once is in line with what "patch" and "git apply" after
     7a07841c (git-apply: handle a patch that touches the same path
     more than once better, 2008-06-27) do.

In other words, the goal of this change would be to give the same id
for all these three:

    (A) straight-forward:

        diff --git a/foo.c b/foo.c
        --- a/foo.c
        +++ b/foo.c
        @@ -20,1 +20,1 @@

        -foo
        +bar

        @@ -40,1 +40,1 @@

        -frotz
        +xyzzy

    (B) as two patches concatenated together:

        diff --git a/foo.c b/foo.c
        --- a/foo.c
        +++ b/foo.c
        @@ -20,1 +20,1 @@

        -foo
        +bar

        diff --git a/foo.c b/foo.c
        --- a/foo.c
        +++ b/foo.c
        @@ -40,1 +40,1 @@

        -frotz
        +xyzzy

    (C) the same as (B) but with a swapped order:

        diff --git a/foo.c b/foo.c
        --- a/foo.c
        +++ b/foo.c
        @@ -40,1 +40,1 @@

        -frotz
        +xyzzy
        diff --git a/foo.c b/foo.c
        --- a/foo.c
        +++ b/foo.c
        @@ -20,1 +20,1 @@

        -foo
        +bar

Am I reading you correctly?

If that is the case, I think I can buy such a change.  It appears to
me that in addition to changing the way the bytes form multiple
hunks are hashed, it would need to hash the file-level headers
together with each hunk when processing input (A) in order to make
the output consistent with the output for the latter two.

Alternatively, you could hash the header for the same path only once
when processing input like (B) or (C) and mix.  That would also give
you the same result as processing (A) in a straight-forward way.

>  builtin/patch-id.c | 71 ++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 55 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 3cfe02d..253ad87 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -1,17 +1,14 @@
>  #include "builtin.h"
>  
> -static void flush_current_id(int patchlen, unsigned char *id, git_SHA_CTX *c)
> +static void flush_current_id(int patchlen, unsigned char *id, unsigned char *result)
>  {
> -	unsigned char result[20];
>  	char name[50];
>  
>  	if (!patchlen)
>  		return;
>  
> -	git_SHA1_Final(result, c);
>  	memcpy(name, sha1_to_hex(id), 41);
>  	printf("%s %s\n", sha1_to_hex(result), name);
> -	git_SHA1_Init(c);
>  }
>  
>  static int remove_space(char *line)
> @@ -56,10 +53,30 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
>  	return 1;
>  }
>  
> -static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct strbuf *line_buf)
> +static void flush_one_hunk(unsigned char *result, git_SHA_CTX *ctx)
>  {
> -	int patchlen = 0, found_next = 0;
> +	unsigned char hash[20];
> +	unsigned short carry = 0;
> +	int i;
> +
> +	git_SHA1_Final(hash, ctx);
> +	git_SHA1_Init(ctx);
> +	/* 20-byte sum, with carry */
> +	for (i = 0; i < 20; ++i) {
> +		carry += result[i] + hash[i];
> +		result[i] = carry;
> +		carry >>= 8;
> +	}
> +}
> +static int get_one_patchid(unsigned char *next_sha1, unsigned char *result,
> +			   struct strbuf *line_buf, int stable)
> +{
> +	int patchlen = 0, found_next = 0, hunks = 0;
>  	int before = -1, after = -1;
> +	git_SHA_CTX ctx, header_ctx;
> +
> +	git_SHA1_Init(&ctx);
> +	hashclr(result);
>  
>  	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
>  		char *line = line_buf->buf;
> @@ -99,6 +116,18 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  			if (!memcmp(line, "@@ -", 4)) {
>  				/* Parse next hunk, but ignore line numbers.  */
>  				scan_hunk_header(line, &before, &after);
> +				if (stable) {
> +					if (hunks) {
> +						flush_one_hunk(result, &ctx);
> +						memcpy(&ctx, &header_ctx,
> +						       sizeof ctx);
> +					} else {
> +						/* Save ctx for next hunk.  */
> +						memcpy(&header_ctx, &ctx,
> +						       sizeof ctx);
> +					}
> +				}
> +				hunks++;
>  				continue;
>  			}
>  
> @@ -107,7 +136,10 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  				break;
>  
>  			/* Else we're parsing another header.  */
> +			if (stable && hunks)
> +				flush_one_hunk(result, &ctx);
>  			before = after = -1;
> +			hunks = 0;
>  		}
>  
>  		/* If we get here, we're inside a hunk.  */
> @@ -119,39 +151,46 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  		/* Compute the sha without whitespace */
>  		len = remove_space(line);
>  		patchlen += len;
> -		git_SHA1_Update(ctx, line, len);
> +		git_SHA1_Update(&ctx, line, len);
>  	}
>  
>  	if (!found_next)
>  		hashclr(next_sha1);
>  
> +	flush_one_hunk(result, &ctx);
> +
>  	return patchlen;
>  }
>  
> -static void generate_id_list(void)
> +static void generate_id_list(int stable)
>  {
> -	unsigned char sha1[20], n[20];
> -	git_SHA_CTX ctx;
> +	unsigned char sha1[20], n[20], result[20];
>  	int patchlen;
>  	struct strbuf line_buf = STRBUF_INIT;
>  
> -	git_SHA1_Init(&ctx);
>  	hashclr(sha1);
>  	while (!feof(stdin)) {
> -		patchlen = get_one_patchid(n, &ctx, &line_buf);
> -		flush_current_id(patchlen, sha1, &ctx);
> +		patchlen = get_one_patchid(n, result, &line_buf, stable);
> +		flush_current_id(patchlen, sha1, result);
>  		hashcpy(sha1, n);
>  	}
>  	strbuf_release(&line_buf);
>  }
>  
> -static const char patch_id_usage[] = "git patch-id < patch";
> +static const char patch_id_usage[] = "git patch-id [--stable | --unstable] < patch";
>  
>  int cmd_patch_id(int argc, const char **argv, const char *prefix)
>  {
> -	if (argc != 1)
> +	int stable;
> +	if (argc == 2 && !strcmp(argv[1], "--stable"))
> +		stable = 1;
> +	else if (argc == 2 && !strcmp(argv[1], "--unstable"))
> +		stable = 0;
> +	else if (argc == 1)
> +		stable = 1;
> +	else
>  		usage(patch_id_usage);
>  
> -	generate_id_list();
> +	generate_id_list(stable);
>  	return 0;
>  }
