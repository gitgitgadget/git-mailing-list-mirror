Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A96A01C
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713642; cv=none; b=KrUIT5wFKNKoN7zizy5KdAPB61quqNXVZ4MsEBSh9PyIYiKyn9+baNmyc8nc3WV3mpzNkOZMqpJdrzrsrqJVAYKH3QgJ8fTNUEKkXS5w/Qf2RZBDJfecN/BXgD8dnYAh9zT7d9CHAkAfu0ox7CFoFzLk9Twnr1VkKX4ANt/dHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713642; c=relaxed/simple;
	bh=wo1MBwdv263ZJ23jkT5v2ltu8vhGqXIxm+Zwg/mYaaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDZv3FcDDY+oQTD0BmTUgnsqeMcek+BNCHcmtQ/wY/4neSVNcRPVnVE1xwy2kYzXnrLjJnH4/4cjdEpxYBxcbUvLqeQD8S6n0nRyq9KxmBOpwcFzMUqnNG6HdOV4r5hQanBG/1D26r5D0hn1u02F5fZqsQWT2Yx9jtl5jwBY2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18089 invoked by uid 109); 29 Mar 2024 12:00:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Mar 2024 12:00:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18538 invoked by uid 111); 29 Mar 2024 12:00:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Mar 2024 08:00:38 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 Mar 2024 08:00:38 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Han Young <hanyang.tony@bytedance.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t4126: fix "funny directory name" test on Windows (again)
Message-ID: <20240329120038.GB15842@coredump.intra.peff.net>
References: <xmqqttl2qml9.fsf@gitster.g>
 <xmqqfrwlltjn.fsf@gitster.g>
 <xmqqsf0bz5oj.fsf@gitster.g>
 <20240328103254.GA898963@coredump.intra.peff.net>
 <20240328114038.GA1394725@coredump.intra.peff.net>
 <CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
 <xmqqa5miuutd.fsf@gitster.g>
 <xmqqh6gqt674.fsf_-_@gitster.g>
 <xmqqil15srub.fsf@gitster.g>
 <xmqqwmplvbsa.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmplvbsa.fsf_-_@gitster.g>

On Thu, Mar 28, 2024 at 10:37:25PM -0700, Junio C Hamano wrote:

> Even though "git update-index --cacheinfo" ought to be filesystem
> agnostic, somehow
> 
>     $ git update-index --add --cacheinfo "100644,$empty_blob,funny /empty"
> 
> fails only there.  That unfortunately makes the approach of the
> previous step unworkable.
> 
> Resurrect the earlier approach to protect the test with a
> prerequisite to make sure we do not needlessly fail the CI.

I think this is a reasonable path forward. Looking at the patch
itself...

> -test_expect_success 'parsing a patch with no-contents and a funny pathname' '
> +test_expect_success 'setup patches in dir ending in SP' '
> +	test_when_finished "rm -fr \"funny \"" &&
> +	mkdir "funny " &&
> +	>"funny /empty" &&
> +	git add "funny /empty" &&
> +	git diff HEAD -- "funny /" >sample.patch &&
> +	git diff -R HEAD -- "funny /" >elpmas.patch &&
>  	git reset --hard &&
> -	empty_blob=$(test_oid empty_blob) &&
> -	echo "$empty_blob" >expect &&
>  
> -	git update-index --add --cacheinfo "100644,$empty_blob,funny /empty" &&
> -	git diff --cached HEAD -- "funny /" >sample.patch &&
> -	git diff --cached -R HEAD -- "funny /" >elpmas.patch &&
> -	git reset &&
> +	if  grep "a/funny /empty b/funny /empty" sample.patch &&
> +	    grep "b/funny /empty a/funny /empty" elpmas.patch
> +	then
> +		test_set_prereq DIR_ENDS_WITH_SP
> +	else
> +		# Win test???
> +		ls -l
> +	fi
> +'

It is a little funny that we set our prereq based only on the emptiness
of the patches. That is certainly what happens on Windows, but it is a
weird thing to expect. It implies that "mkdir" and "git add" returned
success, but the latter without actually adding the index entry. That's
what happens now, but given that such paths are forbidden by the
filesystem, I'm not sure it's a good thing to rely on.

If we think that Windows is the only problematic platform, should we
just use !MINGW as the prereq?

If we think there may be other platforms and would rather test the
actual behavior, then we should probably be more careful. If "mkdir"
fails above, we'd fail the test, rather than just not set the prereq.
To solve that you can put the whole &&-chain into an if, but probably
using a lazy prereq block might be more readable. I guess it is a little
inefficient, though, because we have to actually add/diff to see if
things are working.

IMHO just using !MINGW would be simple, efficient, and effective
(especially with "--cached", where we know that the problem is not the
filesystem but our own is_valid_win32_path()).

One other possible variant: we could skip the add/diff altogether and
just include the patch as a test vector. After all, people on Windows
could be sent such a patch without regard to their filesystem. That
doesn't solve the whole issue, though, as "git apply" would fail (even
with --cached) because of the verify_path() call.

But you could still check the error output to confirm that we parsed the
patch correctly. That lets every platform check the main bug fix, and
more capable platforms test the whole process.

Like:

-- >8 --
apply_funny_path () {
	expect=$1; shift
	path=$1; shift
	if git apply --cached --stat --check --apply "$@" 2>err
	then
		if test "$expect" = "missing"
		then
			test_must_fail git rev-parse --verify "$path"
		else
			git rev-parse --verify ":$path" >actual &&
			echo "$expect" >expect &&
			test_cmp expect actual
		fi
	else
		# some platforms (like Windows) do not allow path entries with
		# trailing spaces, even just in the index. But we should
		# at least be able to verify that we parsed the patch
		# correctly.
		if test "$expect" = "missing"
		then
			echo "error: $path: does not exist in index"
		else
			echo "error: invalid path '$path'"
		fi >expect &&
		test_cmp expect err
	fi
}

test_expect_success 'apply with no-contents and a funny pathname' '
	empty=$(git rev-parse --verify :empty) &&
	cat >sample.patch <<-EOF &&
	diff --git a/funny /empty b/funny /empty
	new file mode 100644
	index 0000000..$empty
	EOF
	cat >elpmas.patch <<-EOF &&
	diff --git b/funny /empty a/funny /empty
	deleted file mode 100644
	index e69de29..$empty
	EOF

	apply_funny_path $empty "funny /empty" sample.patch &&
	apply_funny_path missing "funny /empty" elpmas.patch &&
	apply_funny_path $empty "funny /empty" -R elpmas.patch &&
	apply_funny_path missing "funny /empty" -R sample.patch
'
-- 8< --

I didn't test it on Windows, but I did check that it does the right
thing with a manual:

diff --git a/read-cache.c b/read-cache.c
index d1aef437aa..b75aeb0be8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -976,6 +976,8 @@ static enum verify_path_result verify_path_internal(const char *path,
 	if (has_dos_drive_prefix(path))
 		return PATH_INVALID;
 
+	if (strchr(path, ' '))
+		return PATH_INVALID;
 	if (!is_valid_path(path))
 		return PATH_INVALID;
 

-Peff
