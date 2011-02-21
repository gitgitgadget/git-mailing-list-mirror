From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] do not overwrite untracked symlinks
Date: Sun, 20 Feb 2011 23:15:26 -0800
Message-ID: <7vaahpluy9.fsf@alter.siamese.dyndns.org>
References: <201102022025.06140.j6t@kdbg.org>
 <7v7hdixkys.fsf@alter.siamese.dyndns.org> <201102022324.22123.j6t@kdbg.org>
 <201102051918.44848.j6t@kdbg.org> <20110205183351.GA25717@localhost>
 <20110220121343.GA21514@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 21 08:15:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrPzu-000468-MV
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 08:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab1BUHPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 02:15:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab1BUHPl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 02:15:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDCB14939;
	Mon, 21 Feb 2011 02:16:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=erBj8sjA1bykD65cGgVwWcd1QQM=; b=TpvAeh
	gK13Z30uqSn+359Z0URFl60qRMvfRDpFTzfE+iaKRbAv6QLCFNf5Iuj/YiI3Hdlo
	Ozo3c/hYwCwHA4Tna/4AB7vNUd6LgNnbmML8q1jQe6fOV4iwbimtzwQxbyG67J40
	8VcPczK51Fnkb8fA7QiYxt2VvLBsBHsoFMxb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vcUdmffNLDoJxDaOjO7KkpF4sk1wIeel
	zP4zn8YLGvETtt5Jj4cWhJUJ+6Qb0puW8ewxC7RSzFcfsz2RihJ7gvabRKUegxOg
	1ravbF+mrx4y0ciHfDEHIAhet5sKktKjLm7+R7LRngZf8EC7OGgqFunLrvy5fllA
	M02SiASwtIQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9E654938;
	Mon, 21 Feb 2011 02:16:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 68E904937; Mon, 21 Feb 2011
 02:16:39 -0500 (EST)
In-Reply-To: <20110220121343.GA21514@localhost> (Clemens Buchacher's message
 of "Sun\, 20 Feb 2011 13\:13\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8921728E-3D8A-11E0-B82E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167444>

Clemens Buchacher <drizzd@aon.at> writes:

> Git traditionally overwrites untracked symlinks silently. This will
> generally not cause massive data loss, but it is inconsistent with
> the behavior for regular files, which are not silently overwritten.
>
> With this change, git refuses to overwrite untracked symlinks by
> default. If the user really wants to overwrite the untracked
> symlink, he has git-clean and git-checkout -f at his disposal.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
>
> I checked and there are no undesireable side-effects. One test had
> to be modified slightly because it does overwrite an untracked
> symlink.
>
>  symlinks.c                      |    2 +-
>  t/t6035-merge-dir-to-symlink.sh |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/symlinks.c b/symlinks.c
> index 3cacebd..034943b 100644
> --- a/symlinks.c
> +++ b/symlinks.c
> @@ -223,7 +223,7 @@ int check_leading_path(const char *name, int len)
>  	int flags;
>  	int match_len = lstat_cache_matchlen(cache, name, len, &flags,
>  			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
> -	if (flags & (FL_SYMLINK|FL_NOENT))
> +	if (flags & FL_NOENT)
>  		return 0;
>  	else if (flags & FL_DIR)
>  		return -1;

> diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
> index 92e02d5..1de285b 100755
> --- a/t/t6035-merge-dir-to-symlink.sh
> +++ b/t/t6035-merge-dir-to-symlink.sh
> @@ -22,7 +22,7 @@ test_expect_success SYMLINKS 'keep a/b-2/c/d across checkout' '
>  	git reset --hard master &&
>  	git rm --cached a/b &&
>  	git commit -m "untracked symlink remains" &&
> -	 git checkout start^0 &&
> +	 git checkout -f start^0 &&
>  	 test -f a/b-2/c/d
>  '

The title of the test says that checkout must keep a/b-2/c/d; if "git
checkout" without "-f" doesn't do so and you had to change it to "git
checkout -f", it would mean one of two things: (1) you broke "checkout",
or (2) the behaviour the test wanted to keep working turned out to be
unwanted (iow, "git checkout" without "-f" should fail under the initial
condition this test sets up).

I suspect the situation is the latter.

What this test in 6035 does before your patch is:

 0. Prepare a tree with the following path (no intermediate symlinks)

	a/b/c/d
        a/b-2/c/d
        a/x

    and call that "start";

    prepare another tree with the following path

	a/b -> b-2 (symlink)
        a/b-2/c/d
        a/x

    make it a child of the "start".

 1. Detach the head at the second commit (i.e. a/b symlink pointing at
    b-2), and then remove a/b symlink from the index.  Make a commit with
    that index.

    The index at that point has:

	a/b-2/c/d
        a/x

    and in the working tree there is an untracked a/b symlink that point
    at b-2.

 2. Try to switch to "start"'s tree.  To be able to check it out, a
    directory needs to be created at a/b (as we need c/d underneath it),
    but untracked symbolic link in the working tree a/b interferes with
    it, and it _should_ fail.


So instead of testing "with -f, the untracked path is nuked" and still
calling the test to "preserve a/b-2/c/d", shouldn't you rename the test to
make sure the untracked symlink is preserved, and make sure checkout
without "-f" fails?

Of course, in addition to the above, it would be a good idea to add
another test that makes sure that with "checkout -f" the user can get rid
of the untracked symlink and check out what he wanted to check out.

Hmm?
