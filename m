Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEC13AF3
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23415 invoked by uid 109); 16 Jan 2024 14:37:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jan 2024 14:37:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28751 invoked by uid 111); 16 Jan 2024 14:37:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jan 2024 09:37:57 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Jan 2024 09:37:57 -0500
From: Jeff King <peff@peff.net>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rebase: Fix documentation about used shell in -x
Message-ID: <20240116143757.GA2119690@coredump.intra.peff.net>
References: <20240116141842.193151-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240116141842.193151-1-nik.borisov@suse.com>

On Tue, Jan 16, 2024 at 04:18:42PM +0200, Nikolay Borisov wrote:

> The shell used when using the -x option is the one pointed to by the
> SHELL_PATH constant at build time. This erroneous statement in the
> documentation sent me on a 10 minute wild goose chase wondering why my
> $SHELL was pointing to /bin/bash and my /bin/sh to dash and git was
> using dash and not bash.

Good catch. It originally used $SHELL when the documentation was added
in cd035b1cef (rebase -i: add exec command to launch a shell command,
2010-08-10). But that was lost when it was converted to C (which is
perhaps a regression, but nobody seems to have noticed or cared until
now, and at this point we should stick with the new behavior).

(I don't have an exact date since the conversion was somewhat piecemeal,
but it was done by 2018).

Since then, we use the code in run-command.c's prepare_shell_cmd().

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 25516c45d8b8..08cf52daf39e 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -964,7 +964,7 @@ non-0 status) to give you an opportunity to fix the problem. You can
>  continue with `git rebase --continue`.
>  
>  The "exec" command launches the command in a shell (the one specified
> -in `$SHELL`, or the default shell if `$SHELL` is not set), so you can
> +by the build-time SHELL_PATH variable, usually /bin/sh), so you can
>  use shell features (like "cd", ">", ";" ...). The command is run from
>  the root of the working tree.

Avoiding $SHELL is obviously correct, but I think mentioning SHELL_PATH
is a little hairy. It is not used on Windows; see 776297548e (Do not use
SHELL_PATH from build system in prepare_shell_cmd on Windows, 2012-04-17).
Maybe it makes sense to just say:

  ...in a shell (the default one, usually /bin/sh), ...

It might even make sense to just drop the parenthetical phrase entirely.
Git executes lots of things using a shell, and it is always "the default
one", but we don't bother saying so in most places.

-Peff
