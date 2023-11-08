Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB0321A6
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA5E1BDA
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 09:21:26 -0800 (PST)
Received: (qmail 17222 invoked by uid 109); 8 Nov 2023 17:21:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Nov 2023 17:21:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1917 invoked by uid 111); 8 Nov 2023 17:21:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Nov 2023 12:21:26 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Nov 2023 12:21:25 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] t9164: fix inability to find basename(1) in hooks
Message-ID: <20231108172125.GD1028115@coredump.intra.peff.net>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699455383.git.ps@pks.im>
 <361f1bd9c88e3e6b7b135ba67b39d3bf4d70e322.1699455383.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <361f1bd9c88e3e6b7b135ba67b39d3bf4d70e322.1699455383.git.ps@pks.im>

On Wed, Nov 08, 2023 at 03:57:27PM +0100, Patrick Steinhardt wrote:

> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
> index c8e6c0733f4..3b64022dc57 100755
> --- a/t/t9164-git-svn-dcommit-concurrent.sh
> +++ b/t/t9164-git-svn-dcommit-concurrent.sh
> @@ -47,9 +47,15 @@ setup_hook()
>  	echo "cnt=$skip_revs" > "$hook_type-counter"
>  	rm -f "$rawsvnrepo/hooks/"*-commit # drop previous hooks
>  	hook="$rawsvnrepo/hooks/$hook_type"
> -	cat > "$hook" <<- 'EOF1'
> +	cat >"$hook" <<-EOF
>  		#!/bin/sh
>  		set -e
> +
> +		PATH=\"$PATH\"
> +		export PATH
> +	EOF

The quoting here is weird. The original escaped the double-quotes
because it was echo-ing and interpolated string:

> -		echo "PATH=\"$PATH\"; export PATH" >>"$hook"

But the here-doc interpolation does not treat double-quotes as special,
and you end up with actual double-quote characters at the beginning and
end of your $PATH variable, wrecking those entries (but I guess it works
some of the time depending on whether those parts of your $PATH are
important).

It also interpolates PATH while making the here-doc. That's what you
want to convince the hook's inner shell to use the same PATH as the
outer shell, but it also means that the inner shell will parse and
evaluate it. I don't think anyone is going to inject '"; rm -rf /' into
their own test runs, but it does mean we'd do the wrong thing if their
$PATH contains double-quotes or backslashes.

Certainly the original suffered from the same issue, so it may not be
worth worrying about. But the more robust way to do it is:

  # export ORIG_PATH, which presumably is not cleared the same way PATH
  # is, so that the hook can access it
  ORIG_PATH=$PATH &&
  export ORIG_PATH &&

  cat >"$hook" <<EOF
  # pull the original path from the caller
  PATH=$ORIG_PATH
  export PATH

  ...do other stuff...
  EOF

That's assuming that environment variables make it intact to the hook at
all (it is not clear to me why the original $PATH doesn't). If they
don't, you'd probably have to stash it in a file like:

  echo "$PATH" >orig-path
  cat >"$hook" <<EOF
  PATH="$(cat orig-path)"
  export PATH
  EOF

-Peff
