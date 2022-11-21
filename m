Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E147C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 18:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiKUSie (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 13:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUSib (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 13:38:31 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F0BC6D16
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 10:38:29 -0800 (PST)
Received: (qmail 12325 invoked by uid 109); 21 Nov 2022 18:38:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 18:38:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26229 invoked by uid 111); 21 Nov 2022 18:38:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 13:38:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 13:38:28 -0500
From:   Jeff King <peff@peff.net>
To:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v3 1/2] git-jump: add an optional argument '--stdout'
Message-ID: <Y3vFpNbWswu/8gjb@coredump.intra.peff.net>
References: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
 <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <ccfea26de333ac5a08a5df4c9b790811067bd437.1669033620.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccfea26de333ac5a08a5df4c9b790811067bd437.1669033620.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 12:26:59PM +0000, Yoichi Nakayama via GitGitGadget wrote:

> From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
> 
> It can be used with M-x grep on Emacs.

Thanks, I like what this feature is doing overall, but I have some small
nits about the implementation.

> +You can use the optional argument '--stdout' to print the listing to
> +standard output instead of feeding it to the editor. You can use the
> +argument with M-x grep on Emacs:
> +
> +--------------------------------------------------
> +# In Emacs, M-x grep and invoke "git jump --stdout <mode>"
> +Run grep (like this): git jump --stdout diff
> +--------------------------------------------------

This example confused me because it says "run grep", but then runs a
diff jump. But maybe this is because it means to run the emacs grep
command? I don't use emacs, so it may make more sense to somebody who
does.

> @@ -69,6 +72,12 @@ if test $# -lt 1; then
>  	exit 1
>  fi
>  mode=$1; shift
> +if test "$mode" = "--stdout"; then
> +	mode=$1; shift
> +	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
> +	"mode_$mode" "$@" 2>/dev/null
> +	exit 0
> +fi

Because this happens after we check that "$1" isn't empty and call
shift, it may not notice if the mode is missing when we do this second
shift. I.e., with your patch I get:

  $ ./git-jump --stdout
  ./git-jump: 76: shift: can't shift that many

when I should get the usage message. We can fix that by parsing out
--stdout before we try to read the mode. It's a little more code, but I
think it nicely sets us up if we ever want to parse more options.

It's also unfortunate that we have to repeat the ugly "type" check
above, which also happens again later, after we make the temp file. I
see why you did it this way; the stdout code path does not want to make
the tempfile. But the code before your patch was silly to do it this
way; we should always have been checking the parameters before making a
tempfile.

I was also puzzled why the stdout mode redirects stderr from the mode
function. Wouldn't the user want to see any errors?

So together, it might look something like this (instead of, rather than
on top of your patch):

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index b9cc602ebf..05a0ff1430 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -67,15 +67,38 @@ mode_ws() {
 	git diff --check "$@"
 }
 
+use_stdout=
+while test $# -gt 0; do
+	case "$1" in
+	--stdout)
+		use_stdout=t
+		shift
+		;;
+	--*)
+		usage >&2
+		exit 1
+		;;
+	*)
+		break
+		;;
+	esac
+done
+
 if test $# -lt 1; then
 	usage >&2
 	exit 1
 fi
+
 mode=$1; shift
+type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
+
+if test "$use_stdout" = "t"; then
+	"mode_$mode" "$@"
+	exit 0
+fi
 
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
 "mode_$mode" "$@" >"$tmp"
 test -s "$tmp" || exit 0
 open_editor "$tmp"

Though I'd perhaps break some of the shuffling into a preparatory patch.
I'm happy to do that separately if you prefer.

-Peff
