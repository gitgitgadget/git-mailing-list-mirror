From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] fix git-archive with empty trees
Date: Sun, 10 Mar 2013 22:25:05 -0700
Message-ID: <7vfw02bj9q.fsf@alter.siamese.dyndns.org>
References: <20130311013123.GA11692@sigill.intra.peff.net>
 <20130311045811.GA13510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 11 06:25:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEvEw-0001oz-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 06:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab3CKFZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 01:25:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab3CKFZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 01:25:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AE74A1E2;
	Mon, 11 Mar 2013 01:25:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gBIg1chPr+50tFyY0nfln9U4R+I=; b=IYRJMF
	hFfT8oqUlfvPuG73I25P6QQ0qQLF4UOgHuWMrbdNYgJC6GcROCAvhXNxCWx29GAo
	o0IGgrui7iEg/gGRT/G93JwmkN4ydEw2zYD5QkxPlpVtEFBR3ZEoc5VpEV/X8KRb
	ynxH2gGL7ded+wPITNsgoFUV89+wSannrcuOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n89SK0u4meI5zWqJ0orRslIJ5xR9L6W3
	6mQkntG0dl8VHzKKkytU/VP33EbzDWL9vNVdRKFwWUtqrIrc6NrjNf29ozOUoPQS
	Iv2nQ1oYaUTifIMJco5ySuTjlvFY3am5gk7UomPoqPpubABR34ajBUYIfuLghSMp
	SpQ+o+sNRts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A4AA1E0;
	Mon, 11 Mar 2013 01:25:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A9AAA1DE; Mon, 11 Mar 2013
 01:25:07 -0400 (EDT)
In-Reply-To: <20130311045811.GA13510@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 11 Mar 2013 00:58:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 093D8E38-8A0C-11E2-9534-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217855>

Jeff King <peff@peff.net> writes:

> On Sun, Mar 10, 2013 at 09:31:24PM -0400, Jeff King wrote:
>
>> I noticed that "git archive" will barf when the root tree is empty.
>> [...]
>> I didn't bother even looking at empty subtrees. AFAIK, git should never
>> produce them (it omits the tree entirely if there is no content in it).
>> You would have to fake it using hash-object manually. I suspect it would
>> work just fine, as we already exercise the empty-dir code paths in the
>> tests I did add.
>
> Curious, I went ahead and tested this. It does indeed work as expected.

Interesting.

> The following tests can be squashed into patch 2/2 if we want:

Why not---will do.  Thanks.

> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
> index 395dd58..cdb7d7a 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -80,4 +80,23 @@ test_expect_success 'archive complains about pathspec on empty tree' '
>  	test_must_fail git archive --format=tar HEAD -- foo >/dev/null
>  '
>  
> +test_expect_success 'create a commit with an empty subtree' '
> +	empty_tree=$(git hash-object -t tree /dev/null) &&
> +	root_tree=$(printf "040000 tree $empty_tree\tsub\n" | git mktree)
> +'
> +
> +test_expect_success 'archive empty subtree with no pathspec' '
> +	git archive --format=tar $root_tree >subtree-all.tar &&
> +	make_dir extract &&
> +	"$TAR" xf subtree-all.tar -C extract &&
> +	check_dir extract sub
> +'
> +
> +test_expect_success 'archive empty subtree by direct pathspec' '
> +	git archive --format=tar $root_tree -- sub >subtree-path.tar &&
> +	make_dir extract &&
> +	"$TAR" xf subtree-path.tar -C extract &&
> +	check_dir extract sub
> +'
> +
>  test_done
