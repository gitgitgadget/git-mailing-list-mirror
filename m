From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge markers
Date: Fri, 22 Jan 2016 10:15:32 -0800
Message-ID: <xmqqmvrxv5tn.fsf@gitster.mtv.corp.google.com>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
	<c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 19:15:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMgFI-0005fk-Gs
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 19:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbcAVSPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 13:15:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754845AbcAVSPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 13:15:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3EE3B3EB16;
	Fri, 22 Jan 2016 13:15:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XdN59qNIrVnqKX00AeIyUU6QZ4Q=; b=cXfJW6
	B4Nt38XbWNqj8BU3dWAMGtM5A1AWDE0y2UXaZn9FO9RrTUTy6iqJq3F3ZQGOezLF
	iS/njbC4JEebqQSKNj+V3XI5FyOwXIHUy0i3bDve47H18YExSJTUdFSe3gs2Qxed
	RaAXswNKNRfRMNnA4t3glGibN5ZyLkbpav3DE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CjSIqJCZMuzCJk+tGW3zGNOYZaFYyPFR
	/e7R418x+BCIJ2EUFtVyBlz3Pxp/tF5dje9yYJ+PJzCBiMNt62zC1tBeBsYxpdvq
	qhAYl5Mg6QifRsXSQ2dIgtFOAzMGS//qwIkgZg1v16U0Sikvp/ncyofPILQ2CZ8o
	q3ehSJ6QMG4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 359173EB15;
	Fri, 22 Jan 2016 13:15:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 73BC63EB14;
	Fri, 22 Jan 2016 13:15:33 -0500 (EST)
In-Reply-To: <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 22 Jan 2016 18:01:25 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 20A5C5F6-C134-11E5-B6B0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284576>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The original version of this patch also modified ll_merge(), but that
> was incorrect: low-level merge operates on blobs, not on working files.
> Therefore, the data passed to the low-level merge, as well as its
> result, is expected to have LF-only line endings.
>
> It is the duty of ll_merge()'s *caller* (in case of Git's `merge`
> command, the merge_content() function) to convert the merge result into
> the correct working file contents, and ll_merge() should not muck with
> line endings at all.

Hmph, aren't there people who use CRLF throughout their set-up (that
is, it is normal for both of their blobs and working tree files to
use CRLF line endings)?  Or is such a setting illegal and unsupported?

If such a set-up is supported, using "<<<\r\n" etc. instead of the
usual "<<<\n" would be the correct thing to do.

In a setting where people use whatever they like on the filesystem
but their blobs are standardized to use LF, you are right.  Contents
that come from the filesystem and from the object store should be
made to the internal format, by using convert_to_git() as necessary,
and adding the markers with "<<<\n" without CR, and writing out the
result as CRLF (or whatever their local convention is) is absolutely
the right thing to do.

It's just I am not sure what our stance is about storing CRLF blobs.
IIRC, in the meeting we met in person the last time I thought I
heard some from the Windows camp talk against use of any of the
core.crlf and other settings, saying that it is much better using
the platform native convention throughout, and I got an impression
that it is a recommended practice at least in some circles.

Would the approach taken by this patch still work for them, too?

> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/merge-file.c  |  1 +
>  t/t6023-merge-file.sh | 14 ++++++++++++++
>  xdiff/xdiff.h         |  1 +
>  xdiff/xmerge.c        | 29 +++++++++++++++++++----------
>  4 files changed, 35 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 5544705..9ce830a 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -81,6 +81,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>  					argv[i]);
>  	}
>  
> +	xmp.crlf = eol_for_path(names[0], NULL, 0) == EOL_CRLF;
>  	xmp.ancestor = names[1];
>  	xmp.file1 = names[0];
>  	xmp.file2 = names[2];
> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
> index 190ee90..a131749 100755
> --- a/t/t6023-merge-file.sh
> +++ b/t/t6023-merge-file.sh
> @@ -346,4 +346,18 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
>  	 printf "line1\nline2\nline3x\nline3y" >expect.txt &&
>  	 test_cmp expect.txt output.txt'
>  
> +test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
> +	test_must_fail git -c core.eol=crlf merge-file -p \
> +		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> +	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
> +'
> +
> +test_expect_success 'conflict markers heed gitattributes over core.eol=crlf' '
> +	git config core.eol crlf &&
> +	echo "*.txt eol=lf" >>.gitattributes &&
> +	test_must_fail git -c core.eol=crlf merge-file -p \
> +		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> +	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 0
> +'
> +
>  test_done
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index c033991..a5bea4a 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -122,6 +122,7 @@ typedef struct s_xmparam {
>  	int level;
>  	int favor;
>  	int style;
> +	int crlf;
>  	const char *ancestor;	/* label for orig */
>  	const char *file1;	/* label for mf1 */
>  	const char *file2;	/* label for mf2 */
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 625198e..4ff0db4 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -146,7 +146,7 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
>  static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>  			      xdfenv_t *xe2, const char *name2,
>  			      const char *name3,
> -			      int size, int i, int style,
> +			      int size, int i, int style, int crlf,
>  			      xdmerge_t *m, char *dest, int marker_size)
>  {
>  	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
> @@ -161,7 +161,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>  			      dest ? dest + size : NULL);
>  
>  	if (!dest) {
> -		size += marker_size + 1 + marker1_size;
> +		size += marker_size + 1 + crlf + marker1_size;
>  	} else {
>  		memset(dest + size, '<', marker_size);
>  		size += marker_size;
> @@ -170,6 +170,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>  			memcpy(dest + size + 1, name1, marker1_size - 1);
>  			size += marker1_size;
>  		}
> +		if (crlf)
> +			dest[size++] = '\r';
>  		dest[size++] = '\n';
>  	}
>  
> @@ -180,7 +182,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>  	if (style == XDL_MERGE_DIFF3) {
>  		/* Shared preimage */
>  		if (!dest) {
> -			size += marker_size + 1 + marker3_size;
> +			size += marker_size + 1 + crlf + marker3_size;
>  		} else {
>  			memset(dest + size, '|', marker_size);
>  			size += marker_size;
> @@ -189,6 +191,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>  				memcpy(dest + size + 1, name3, marker3_size - 1);
>  				size += marker3_size;
>  			}
> +			if (crlf)
> +				dest[size++] = '\r';
>  			dest[size++] = '\n';
>  		}
>  		size += xdl_orig_copy(xe1, m->i0, m->chg0, 1,
> @@ -196,10 +200,12 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>  	}
>  
>  	if (!dest) {
> -		size += marker_size + 1;
> +		size += marker_size + 1 + crlf;
>  	} else {
>  		memset(dest + size, '=', marker_size);
>  		size += marker_size;
> +		if (crlf)
> +			dest[size++] = '\r';
>  		dest[size++] = '\n';
>  	}
>  
> @@ -207,7 +213,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>  	size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
>  			      dest ? dest + size : NULL);
>  	if (!dest) {
> -		size += marker_size + 1 + marker2_size;
> +		size += marker_size + 1 + crlf + marker2_size;
>  	} else {
>  		memset(dest + size, '>', marker_size);
>  		size += marker_size;
> @@ -216,6 +222,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>  			memcpy(dest + size + 1, name2, marker2_size - 1);
>  			size += marker2_size;
>  		}
> +		if (crlf)
> +			dest[size++] = '\r';
>  		dest[size++] = '\n';
>  	}
>  	return size;
> @@ -226,7 +234,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
>  				 const char *ancestor_name,
>  				 int favor,
>  				 xdmerge_t *m, char *dest, int style,
> -				 int marker_size)
> +				 int crlf, int marker_size)
>  {
>  	int size, i;
>  
> @@ -237,8 +245,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
>  		if (m->mode == 0)
>  			size = fill_conflict_hunk(xe1, name1, xe2, name2,
>  						  ancestor_name,
> -						  size, i, style, m, dest,
> -						  marker_size);
> +						  size, i, style, crlf, m,
> +						  dest, marker_size);
>  		else if (m->mode & 3) {
>  			/* Before conflicting part */
>  			size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
> @@ -419,6 +427,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
>  	int level = xmp->level;
>  	int style = xmp->style;
>  	int favor = xmp->favor;
> +	int crlf = xmp->crlf;
>  
>  	if (style == XDL_MERGE_DIFF3) {
>  		/*
> @@ -554,7 +563,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
>  		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
>  						 ancestor_name,
>  						 favor, changes, NULL, style,
> -						 marker_size);
> +						 crlf, marker_size);
>  		result->ptr = xdl_malloc(size);
>  		if (!result->ptr) {
>  			xdl_cleanup_merge(changes);
> @@ -563,7 +572,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
>  		result->size = size;
>  		xdl_fill_merge_buffer(xe1, name1, xe2, name2,
>  				      ancestor_name, favor, changes,
> -				      result->ptr, style, marker_size);
> +				      result->ptr, style, crlf, marker_size);
>  	}
>  	return xdl_cleanup_merge(changes);
>  }
