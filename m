From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cache-tree: invalidate i-t-a paths after generating
 trees
Date: Sun, 09 Dec 2012 22:50:49 -0800
Message-ID: <7v7goqcsdy.fsf@alter.siamese.dyndns.org>
References: <1352459040-14452-1-git-send-email-pclouds@gmail.com>
 <1354939803-8466-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathon Mah <me@JonathonMah.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 07:51:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThxCr-0006Vy-JU
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 07:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab2LJGu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Dec 2012 01:50:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300Ab2LJGu4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2012 01:50:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79DE873E9;
	Mon, 10 Dec 2012 01:50:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8SjR1IooylYh
	AH23ljVil7qCUNs=; b=QZeeXEe/k2We3999hqPFqSsfw2KfqFxrzxAQJ9q3UR4w
	Cx2MGkHNQSPyDUH3ApCpibkCDOb9DH15a0ib+1Ojw3NKPMfXIU8Ji+2bPv/O0081
	XCxRGFSNskmvn14Mngox81LRWJrSnigLzCzo59yK6Ex7qKEzyzPLyAMb7okOIJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SwHf8P
	rYMc2yrP0My9Odjlt1AlisZh1zxqIIUq5gPGYZtpxeXvkBC0vOYjYh1U4PhibpSZ
	DK9QgM4l1J+KED6Baa+yawakkf5P2I055HGFT/3RVMoRVmYJi0EtCgQC7n4JOkIM
	0mjtv92/+qtj3dYKQ5afTK7Vh6//Q3yMYh2k4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6744873E8;
	Mon, 10 Dec 2012 01:50:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74A3673E6; Mon, 10 Dec 2012
 01:50:53 -0500 (EST)
In-Reply-To: <1354939803-8466-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 8 Dec
 2012 11:10:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0F7B0D2-4295-11E2-8CFD-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211251>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/cache-tree.c b/cache-tree.c
> index 28ed657..989a7ff 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -248,6 +248,7 @@ static int update_one(struct cache_tree *it,
>  	int missing_ok =3D flags & WRITE_TREE_MISSING_OK;
>  	int dryrun =3D flags & WRITE_TREE_DRY_RUN;
>  	int i;
> +	int to_invalidate =3D 0;
> =20
>  	if (0 <=3D it->entry_count && has_sha1_file(it->sha1))
>  		return it->entry_count;
> @@ -324,7 +325,13 @@ static int update_one(struct cache_tree *it,
>  			if (!sub)
>  				die("cache-tree.c: '%.*s' in '%s' not found",
>  				    entlen, path + baselen, path);
> -			i +=3D sub->cache_tree->entry_count - 1;
> +			i--; /* this entry is already counted in "sub" */
> +			if (sub->cache_tree->entry_count < 0) {
> +				i -=3D sub->cache_tree->entry_count;
> +				to_invalidate =3D 1;
> +			}
> +			else
> +				i +=3D sub->cache_tree->entry_count;

Hrm.  update_one() is prepared to see a cache-tree whose entry count
is zero (see the context lines in the previous hunk) and the
invariant for the rest of the code is "if 0 <=3D entry_count, the
cached tree is valid; invalid cache-tree has -1 in entry_count.
More importantly, entry_count negated does not in general express
how many entries there are in the subtree and does not tell us how
many index entries to skip.

> @@ -339,8 +346,23 @@ static int update_one(struct cache_tree *it,
>  				mode, sha1_to_hex(sha1), entlen+baselen, path);
>  		}
> =20
> -		if (ce->ce_flags & (CE_REMOVE | CE_INTENT_TO_ADD))
> -			continue; /* entry being removed or placeholder */
> +		/*
> +		 * CE_REMOVE entries are removed before the index is
> +		 * written to disk. Skip them to remain consistent
> +		 * with the future on-disk index.
> +		 */
> +		if (ce->ce_flags & CE_REMOVE)
> +			continue;
> +
> +		/*
> +		 * CE_INTENT_TO_ADD entries exist on on-disk index but
> +		 * they are not part of generated trees. Invalidate up
> +		 * to root to force cache-tree users to read elsewhere.
> +		 */
> +		if (ce->ce_flags & CE_INTENT_TO_ADD) {
> +			to_invalidate =3D 1;
> +			continue;
> +		}

Thanks for documenting these.

> @@ -360,7 +382,7 @@ static int update_one(struct cache_tree *it,
>  	}
> =20
>  	strbuf_release(&buffer);
> -	it->entry_count =3D i;
> +	it->entry_count =3D to_invalidate ? -i : i;

See above.  I am not fundamentally opposed to a change to redefine
entry_count so that it always maintains how many index entries the
subtree covers, even for invalidated subtree, but I do not think
this patch alone is sufficient to maintain such invariant.

>  #if DEBUG
>  	fprintf(stderr, "cache-tree update-one (%d ent, %d subtree) %s\n",
>  		it->entry_count, it->subtree_nr,
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index ec35409..2a4a749 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -62,5 +62,25 @@ test_expect_success 'can "commit -a" with an i-t-a=
 entry' '
>  	git commit -a -m all
>  '
> =20
> +test_expect_success 'cache-tree invalidates i-t-a paths' '
> +	git reset --hard &&
> +	mkdir dir &&
> +	: >dir/foo &&
> +	git add dir/foo &&
> +	git commit -m foo &&
> +
> +	: >dir/bar &&
> +	git add -N dir/bar &&
> +	git diff --cached --name-only >actual &&
> +	echo dir/bar >expect &&
> +	test_cmp expect actual &&
> +
> +	git write-tree >/dev/null &&
> +
> +	git diff --cached --name-only >actual &&
> +	echo dir/bar >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
