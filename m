From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Avoid checking working copy when creating a virtual merge base
Date: Tue, 12 Apr 2016 18:28:29 -0700
Message-ID: <xmqq8u0imh4y.fsf@gitster.mtv.corp.google.com>
References: <1460268820-8308-1-git-send-email-newren@gmail.com>
	<1460268820-8308-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:28:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9bg-00054m-Pr
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbcDMB2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:28:33 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751648AbcDMB2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:28:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF6FE555B3;
	Tue, 12 Apr 2016 21:28:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JMzTxKWmDSOI7x//bXfB7cyz/Ow=; b=DYwNRq
	jAX5cH0pkU2BBBtMZtCmKSGYOXQGxrHOlT8i6Ktvc5HE/GA3dCSp+SGjuZgcgTjW
	4NZbaXDbYBwGEh4K1fcxmPrmSMvKL4zs2QYVDL5Tio81tWSGrxRy8AUghc4GKVoi
	roOKo/OTm726F8uDwy7nbbYemkRraZWTttk3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fyQ45Osee3IG9ocQWuyXrS9gwzfWUxQm
	8s5g1L9VWYSph+ZUeaZMqjQkuIfcTCvunLsePeVXQzze3wnXgcIG7wJlIWUQj4mp
	AOpoCkGzRLjHgFTidn2EeHIoDepXSJxx98WetljcrAfopPEIDewm5daQFfqSkbGZ
	PZi2q47vTgs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E74B8555B2;
	Tue, 12 Apr 2016 21:28:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 69F5E555B1;
	Tue, 12 Apr 2016 21:28:30 -0400 (EDT)
In-Reply-To: <1460268820-8308-3-git-send-email-newren@gmail.com> (Elijah
	Newren's message of "Sat, 9 Apr 2016 23:13:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 079517E2-0117-11E6-B858-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291358>

Elijah Newren <newren@gmail.com> writes:

> There were a few cases in merge-recursive that could result in a check for
> the presence of files in the working copy while trying to create a virtual
> merge base.  These were rare and innocuous, but somewhat illogical.  The
> two cases were:
>
>   * When there was naming conflicts (e.g. a D/F conflict) and we had to
>     pick a new unique name for a file.  Since the new name is somewhat
>     arbitrary, it didn't matter that we consulted the working copy to
>     avoid picking a filename it has, but since the virtual merge base is
>     never checked out, it's a waste of time and slightly odd to do so.
>
>   * When two different files get renamed to the same name (on opposite
>     sides of the merge), we needed to delete the original filenames from
>     the cache and possibly also the working directory.  The caller's check
>     for determining whether to delete from the working directory was a
>     call to would_lose_untracked().  It turns out this didn't matter
>     because remove_file() had logic to avoid modifying the working
>     directory when creating a virtual merge base, but there is no reason
>     for the caller to check the working directory in such circumstances.
>     It's a waste of time, if not also a bit weird.

I think "avoid checking" and "waste of time" are understatements, in
that they make it sound as if the current code is OK and this change
is only to reduce waste.  But doesn't the code misbehave if you had
a file in the working tree whose path happens to be the same as the
one involved in these codepaths (iow, if they did not check these
paths in the working tree, the internal merge may succeed, but it
would unnecessarily fail)?

Subject: merge-recursive: do not check working tree during an internal merge

or something, perhaps?

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d4292de..06d31ed 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -622,7 +622,7 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
>  	base_len = newpath.len;
>  	while (string_list_has_string(&o->current_file_set, newpath.buf) ||
>  	       string_list_has_string(&o->current_directory_set, newpath.buf) ||
> -	       file_exists(newpath.buf)) {
> +	       (!o->call_depth && file_exists(newpath.buf))) {
>  		strbuf_setlen(&newpath, base_len);
>  		strbuf_addf(&newpath, "_%d", suffix++);
>  	}
> @@ -1234,8 +1234,8 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
>  	       a->path, c1->path, ci->branch1,
>  	       b->path, c2->path, ci->branch2);
>  
> -	remove_file(o, 1, a->path, would_lose_untracked(a->path));
> -	remove_file(o, 1, b->path, would_lose_untracked(b->path));
> +	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
> +	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
>  
>  	mfi_c1 = merge_file_special_markers(o, a, c1, &ci->ren1_other,
>  					    o->branch1, c1->path,
