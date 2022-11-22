Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32A3C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiKVSyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKVSyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:54:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDD36037F
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:54:11 -0800 (PST)
Received: (qmail 18769 invoked by uid 109); 22 Nov 2022 18:54:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Nov 2022 18:54:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5652 invoked by uid 111); 22 Nov 2022 18:54:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Nov 2022 13:54:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Nov 2022 13:54:10 -0500
From:   Jeff King <peff@peff.net>
To:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
Message-ID: <Y30a0ulfxyE7dnYi@coredump.intra.peff.net>
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
 <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 02:18:23PM +0000, Yoichi Nakayama via GitGitGadget wrote:

> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index babb3b5c68d..bfd759aa4b2 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -26,6 +26,17 @@ open_editor() {
>  	eval "$editor -q \$1"
>  }
>  
> +open_emacs() {
> +	# Supported editor values are:
> +	# - emacs
> +	# - emacsclient
> +	# - emacsclient -t
> +	editor=`git var GIT_EDITOR`
> +	# Wait for completion of the asynchronously executed process
> +	# to avoid race conditions in case of "emacsclient".
> +	eval "$editor --eval \"(prog1 (switch-to-buffer-other-frame (compilation-start \\\"cat $@\\\" 'grep-mode)) (delete-other-windows) (while (get-buffer-process (current-buffer)) (sleep-for 0.1)) (select-frame-set-input-focus (selected-frame)))\""
> +}

Hmm, I know I suggested using a temporary file since "cat $tmpfile"
should be pretty safe. But it does still have problems if your tmp
directory has spaces. Or even other metacharacters, which I think will
be interpreted by the eval, since $@ is expanded in the outermost level
of the shell.

Those are fairly unlikely, but we could handle it. I think you'd need
something like:

	open_emacs() {
		quoted_args=
		for i in "$@"; do
			quoted_args="$quoted_args '$(printf %s "$i" | sed "s/'/'\\\\''/g")'"
		done
		eval "$editor --eval \"...\\\"cat \$quoted_args\\\"...\""
	}

which you can test with:

	cat >fake-emacs <<-\EOF
	#!/bin/sh
	echo "fake-emacs got args: "
	for i in "$@"; do
		echo "arg: $i"
	done
	EOF
	chmod +x fake-emacs

	editor=./fake-emacs
	open_emacs 'multiple args' 'with spaces'
	open_emacs '$dollar is ok because we use single-quotes'
	open_emacs "but 'single quotes' themselves need quoted"

Though it's possible you also need to be adding an extra layer of
quoting due to emacs parsing the string. So you'd probably need to
additionally escape double-quotes and backslashes, perhaps by changing
the sed invocation to:

  sed -e 's/\\/\\\\/g' \
      -e "s/'/'\\\\''/g" \
      -e 's/"/\\"/g'

Which is kind of horrific, but I think is bullet-proof.

Like I said, it's not that likely that somebody's tempfile path would
need all that (though spaces aren't totally out of the question,
especially on Windows). But...

If we have bullet-proof quoting, then you could go back to skipping the
tempfile for emacs, which avoids the race and sleep that you have here.

> @@ -98,4 +109,8 @@ tmp=`mktemp -t git-jump.XXXXXX` || exit 1
>  type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
>  "mode_$mode" "$@" >"$tmp"
>  test -s "$tmp" || exit 0
> +if git var GIT_EDITOR | grep emacs >/dev/null; then
> +	open_emacs "$tmp"
> +	exit 0
> +fi
>  open_editor "$tmp"

If we are going to use a tempfile, this logic should probably get
stuffed into open_editor itself, like:

  open_editor() {
          editor=`git var GIT_EDITOR`
          case "$editor" in
          *emacs*)
                  ...do-the-emacs-thing...
          *)
                  # assume anything else is vi-compatible
                  eval "$editor -q \$1"
          esac
  }

but if you take the quoting suggestion above, then open_emacs() would
continue to be a top-level thing, before we even create the tempfile.

-Peff
