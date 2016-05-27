From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Require 0 context lines in git-blame algorithm
Date: Fri, 27 May 2016 13:59:03 -0700
Message-ID: <xmqqtwhjp694.fsf@gitster.mtv.corp.google.com>
References: <1464358592-5409-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 27 22:59:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Oqf-0001bq-LI
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 22:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbcE0U7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 16:59:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751575AbcE0U7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 16:59:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EA7F1DC90;
	Fri, 27 May 2016 16:59:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9bzQqgofiF1uVWDtpEswXEuO8+o=; b=wFk2Ck
	XUmTQ36gIZ/xKp1zMsmS4BWZzCYpC75jUJinq83WNmxz0BWWo6qb3TzP8GKX/RFa
	1ubdQzud08aFtixWykUHWcSo2QM0RmgRsT+zTlBiaNWDOlQ6mdXkKT0H7JK5RqYk
	TkdpUKr/DZfF5FbQb/Mn5GZo+/LUMAOEPwomg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gdAuLYjc5AGK+omEIkyZTXk39LrexT0W
	D4tGy1VoJWr98sLXNaXmpRK04TDVaGlYEUxJlLknWgCeT7gOtEF9g621iHcBI4tr
	nBev+4ohZ6f3Fz3PUixawnw+pYw2kKW5DXG0M8FdoWzTmxvDxAme4xIN1xqH3ife
	v57Ig39XfKE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 96DA01DC8E;
	Fri, 27 May 2016 16:59:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 207631DC8D;
	Fri, 27 May 2016 16:59:05 -0400 (EDT)
In-Reply-To: <1464358592-5409-1-git-send-email-dak@gnu.org> (David Kastrup's
	message of "Fri, 27 May 2016 16:16:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8E6AADC-244D-11E6-8EF6-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295795>

David Kastrup <dak@gnu.org> writes:

> Previously, the core part of git blame -M required 1 context line.
> There is no rationale to be found in the code (one guess would be that
> the old blame algorithm was unable to deal with immediately adjacent
> regions), and it causes artifacts like discussed in the thread
> <URL:http://thread.gmane.org/gmane.comp.version-control.git/255289/>

The only thing that remotely hints why we thought a non-zero context
was a good idea was this:

http://thread.gmane.org/gmane.comp.version-control.git/28336/focus=28580

in which I said:

 | we may need to use a handful surrounding context lines for
 | better identification of copy source by the "ciff" algorithm but
 | that is a minor implementation detail.

But I do not think the amount of context affects the quality of the
match.  So it could be that it was completely a misguided attempt
since the very beginning, cee7f245 (git-pickaxe: blame rewritten.,
2006-10-19), which allowed the caller to specify context when
calling compare_buffer(), the function that corresponds to
diff_hunks() in today's code.

> ---
>  builtin/blame.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

I totally forgot about the discussion around $gmane/255289; thanks
for bringing this back again.

As usual, we'd need your sign-off to use this patch.

Thanks.


> diff --git a/builtin/blame.c b/builtin/blame.c
> index 21f42b0..a3f6874 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -134,7 +134,7 @@ struct progress_info {
>  	int blamed_lines;
>  };
>  
> -static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
> +static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
>  		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
>  {
>  	xpparam_t xpp = {0};
> @@ -142,7 +142,6 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
>  	xdemitcb_t ecb = {NULL};
>  
>  	xpp.flags = xdl_opts;
> -	xecfg.ctxlen = ctxlen;
>  	xecfg.hunk_func = hunk_func;
>  	ecb.priv = cb_data;
>  	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
> @@ -980,7 +979,7 @@ static void pass_blame_to_parent(struct scoreboard *sb,
>  	fill_origin_blob(&sb->revs->diffopt, target, &file_o);
>  	num_get_patch++;
>  
> -	if (diff_hunks(&file_p, &file_o, 0, blame_chunk_cb, &d))
> +	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d))
>  		die("unable to generate diff (%s -> %s)",
>  		    oid_to_hex(&parent->commit->object.oid),
>  		    oid_to_hex(&target->commit->object.oid));
> @@ -1129,7 +1128,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
>  	 * file_p partially may match that image.
>  	 */
>  	memset(split, 0, sizeof(struct blame_entry [3]));
> -	if (diff_hunks(file_p, &file_o, 1, handle_split_cb, &d))
> +	if (diff_hunks(file_p, &file_o, handle_split_cb, &d))
>  		die("unable to generate diff (%s)",
>  		    oid_to_hex(&parent->commit->object.oid));
>  	/* remainder, if any, all match the preimage */
