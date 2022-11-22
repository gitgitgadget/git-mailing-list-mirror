Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DE1C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiKVSab (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiKVSa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:30:29 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C7C86A6E
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:30:28 -0800 (PST)
Received: (qmail 18744 invoked by uid 109); 22 Nov 2022 18:30:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Nov 2022 18:30:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5515 invoked by uid 111); 22 Nov 2022 18:30:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Nov 2022 13:30:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Nov 2022 13:30:27 -0500
From:   Jeff King <peff@peff.net>
To:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v4 1/2] git-jump: add an optional argument '--stdout'
Message-ID: <Y30VQzJ93h98hVhH@coredump.intra.peff.net>
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
 <446777d300d73498bd7da709fad75731a13d0d59.1669126703.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <446777d300d73498bd7da709fad75731a13d0d59.1669126703.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 02:18:22PM +0000, Yoichi Nakayama via GitGitGadget wrote:

> @@ -64,11 +67,31 @@ mode_ws() {
>  	git diff --check "$@"
>  }
>  
> +use_stdout=
> +while test $# -gt 0; do
> +	case "$1" in
> +	--stdout)
> +		use_stdout=t
> +		shift
> +		;;
> +	--*)
> +		usage >&2
> +		exit 1
> +		;;
> +	*)
> +		break
> +		;;
> +	esac
> +done
>  if test $# -lt 1; then
>  	usage >&2
>  	exit 1
>  fi
>  mode=$1; shift
> +if test "$use_stdout" = "t"; then
> +	"mode_$mode" "$@"
> +	exit 0
> +fi

Thanks, this looks pretty good. I think we'd want this on top.

-- >8 --
Subject: git-jump: move valid-mode check earlier

We check if the "mode" argument supplied by the user is valid by seeing
if we have a mode_$mode function defined. But we don't do that until
after creating the tempfile. This is wasteful (we create a tempfile but
never use it), and makes it harder to add new options (the recent stdout
option exits before creating the tempfile, so it misses the check and
"git jump --stdout foo" will produce "git-jump: 92: mode_foo: not found"
rather than the regular usage message).

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/git-jump/git-jump | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index babb3b5c68..cc97b0dcf0 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -88,14 +88,15 @@ if test $# -lt 1; then
 	exit 1
 fi
 mode=$1; shift
+type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
+
 if test "$use_stdout" = "t"; then
 	"mode_$mode" "$@"
 	exit 0
 fi
 
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
 "mode_$mode" "$@" >"$tmp"
 test -s "$tmp" || exit 0
 open_editor "$tmp"
-- 
2.38.1.970.g3b99f132c8

