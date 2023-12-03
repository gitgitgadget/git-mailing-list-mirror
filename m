Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sveZQqCb"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65759E6
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:15:21 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FD9F2D1A2;
	Sun,  3 Dec 2023 08:15:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Cd3dDcMDLjuJ+TC/r9usFgFdCfs4s6ym9zbjQf
	lceso=; b=sveZQqCboapQacZR6Ez+BwsEWv1lgVbLTs7DAnsyuSDh0JMUGQcKoA
	NmVmKHxIzSK32FHlj5l9TTAOzLPHxFEeUq4zGdW0jJjDaGmEZGVLPNWAY34xT6vY
	Y2w/e880W0kf2NZVesmdrdokMH/AGNIcHXvG5tamd9guMqlUyNbgA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 082472D1A1;
	Sun,  3 Dec 2023 08:15:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D419B2D1A0;
	Sun,  3 Dec 2023 08:15:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stan Hu <stanhu@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <christian.couder@gmail.com>
Subject: Re: [PATCH 1/2] completion: refactor existence checks for special refs
In-Reply-To: <20231130202404.89791-2-stanhu@gmail.com> (Stan Hu's message of
	"Thu, 30 Nov 2023 12:24:03 -0800")
References: <20231130202404.89791-1-stanhu@gmail.com>
	<20231130202404.89791-2-stanhu@gmail.com>
Date: Sun, 03 Dec 2023 22:15:15 +0900
Message-ID: <xmqqedg34ecc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 004C7542-91DE-11EE-B9AB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Stan Hu <stanhu@gmail.com> writes:

> In preparation for the reftable backend, this commit introduces a
> '__git_ref_exists' function that continues to use 'test -f' to
> determine whether a given ref exists in the local filesystem.

I do not think git_ref_exists is a good name for what this one does.
The name adds undue cognitive load on readers.  As far as I can
tell, with this helper function, you are interested in handling only
pseudorefs like $GIT_DIR/FOOBAR_HEAD (oh, retitle the patch to call
them "pseudorefs", not "special refs", by the way), and that is why
you can get away with a simple

    [ -f "$__git_repo_path/$ref" ]

without bothering to check the packed-refs file.  The checks this
patch replace to calls to this helper functions in the original make
it clear, simply because they spell out what they are checking, like
"CHERRY_PICK_HEAD", why a mere filesystem check was sufficient, but
once you give an overly generic name like "ref-exists", it becomes
tempting to (ab|mis)use it to check for branches and tags, which is
not your intention at all, and the implementation does not work well
for that purpose.

> Each caller of '__git_ref_exists' must call '__git_find_repo_path`
> first. '_git_restore' already used 'git rev-parse HEAD', but to use
> '__git_ref_exists' insert a '__git_find_repo_path' at the start.

To whom do you think the above piece of information is essential for
them to work?  Whoever updates the completion script, finds existing
use of __git_ref_exists, and thinks the helper would be useful for
their own use.  To them, the above needs be in the in-code comment
to make it discoverable.  It is OK to have it also in the proposed
log message, but it is not as essential, especially if you have it
in-code anyway.

Another thing you would need to make sure that the potential users
of this helpers understand is of course this is meant to be used
only on pseudorefs.  You can of course do so with an additional
in-code comment, but giving a more appropriate name to the helper
would be the easiest and simplest, e.g. __git_pseudoref_exists or
something.

> Reviewed-by: Patrick Steinhardt <ps@pks.im>
> Reviewed-by: Christian Couder <christian.couder@gmail.com>
> Signed-off-by: Stan Hu <stanhu@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 13a39ebd2e..9fbdc13f9a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -122,6 +122,15 @@ __git ()
>  		${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
>  }
>  
> +# Runs git in $__git_repo_path to determine whether a ref exists.
> +# 1: The ref to search
> +__git_ref_exists ()
> +{
> +	local ref=$1
> +
> +	[ -f "$__git_repo_path/$ref" ]
> +}
