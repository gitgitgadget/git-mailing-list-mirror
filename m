From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] rebase -i: respect core.abbrev for real
Date: Wed, 21 Jan 2015 22:56:28 -0800
Message-ID: <xmqqsif3uwv7.fsf@gitster.dls.corp.google.com>
References: <CAPig+cQcYXzRwHMRcKQJf-mWq7d9Kgp7KndnEhFs4_mwgLpiiA@mail.gmail.com>
	<1421750552-110075-1-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 07:56:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEBgx-0004vv-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 07:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbbAVG4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 01:56:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750713AbbAVG4a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 01:56:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9CA32793A;
	Thu, 22 Jan 2015 01:56:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xYAlLpo2z5U5GmMnKqIXVEXxLXo=; b=koRQk1
	lQVbfUjXwt0mTFO30nAGz+kyCROs6HOZspYdPyFLZeGZl1bTjWfcocO9c4E6Jq7K
	EyhhYDRUJyIP/nzdThofFjK1wDQk1oPURG193Mwf6YIOGt4jcIxM/hfILF8sJCDY
	m6oIOQyKSkLK1aL4/A5+pu+pQL5ykiclRGDHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yhxUqYmju1n5tHgsLG+nhCbrZUuqODNb
	U5G+JD3q10t9hkVtmMwWI7Li5lcN2k58Rh9efSQSLT6d05iaq66iqNyh9mwIfVk0
	BuOP90ixyAjB+kZ3RvJp0l+rjgeLWiTs5+mbs7Q2dBhgiCbk5mWvSIXg6iCC62xj
	q7CK21q2R+o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C03AE27938;
	Thu, 22 Jan 2015 01:56:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 467F227936;
	Thu, 22 Jan 2015 01:56:29 -0500 (EST)
In-Reply-To: <1421750552-110075-1-git-send-email-kirill.shutemov@linux.intel.com>
	(Kirill A. Shutemov's message of "Tue, 20 Jan 2015 12:42:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA715402-A203-11E4-A505-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262800>

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> I have tried to fix this before: see 568950388be2, but it doesn't
> really work.
>
> I don't know how it happend, but that commit makes interactive rebase to
> respect core.abbrev only during --edit-todo, but not the initial todo
> list edit.
>
> For this time I've included a test-case to avoid this frustration again.

I suspect that the work that introduced expand/collapse could have
gone one step further so that all of the short object names you are
touching in this patch can stay in the full 40-hex name to avoid
ambiguity.  That is, keep the internal representation always use the
full object name, and then always call these three:

    collapse_todo_ids 
    git_sequence_editor
    expand_todo_ids

in this order.

Wouldn't that make the end result a lot cleaner, I wonder?


>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  v2: fix &&-chain in the test-case
> ---
>  git-rebase--interactive.sh    | 4 ++--
>  t/t3404-rebase-interactive.sh | 7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index c6a4629cbc2b..1855e12f1ada 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -962,7 +962,7 @@ else
>  	shortrevisions=$shorthead
>  fi
>  git rev-list $merges_option --pretty=oneline --abbrev-commit \
> -	--abbrev=7 --reverse --left-right --topo-order \
> +	--reverse --left-right --topo-order \
>  	$revisions ${restrict_revision+^$restrict_revision} | \
>  	sed -n "s/^>//p" |
>  while read -r shortsha1 rest
> @@ -1020,7 +1020,7 @@ then
>  			# just the history of its first-parent for others that will
>  			# be rebasing on top of it
>  			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
> -			short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
> +			short=$(git rev-list -1 --abbrev-commit $rev)
>  			sane_grep -v "^[a-z][a-z]* $short" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
>  			rm "$rewritten"/$rev
>  		fi
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8197ed29a9ec..a31f7e0430e1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1039,4 +1039,11 @@ test_expect_success 'short SHA-1 collide' '
>  	)
>  '
>  
> +test_expect_success 'respect core.abbrev' '
> +	git config core.abbrev 12 &&
> +	set_cat_todo_editor &&
> +	test_must_fail git rebase -i HEAD~4 >todo-list &&
> +	test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
> +'
> +
>  test_done
