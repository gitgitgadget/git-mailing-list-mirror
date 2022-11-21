Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7B5C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 18:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiKUSuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 13:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKUSud (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 13:50:33 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8502C67E9
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 10:50:32 -0800 (PST)
Received: (qmail 12346 invoked by uid 109); 21 Nov 2022 18:50:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 18:50:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26358 invoked by uid 111); 21 Nov 2022 18:50:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 13:50:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 13:50:31 -0500
From:   Jeff King <peff@peff.net>
To:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v3 2/2] git-jump: invoke emacs/emacsclient
Message-ID: <Y3vId3rOmmkJnkGj@coredump.intra.peff.net>
References: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
 <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <b4ad4c083c96d20873a649aab5f39cd061bd662a.1669033620.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4ad4c083c96d20873a649aab5f39cd061bd662a.1669033620.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 12:27:00PM +0000, Yoichi Nakayama via GitGitGadget wrote:

> +open_emacs() {
> +	editor=`git var GIT_EDITOR`
> +	eval "$editor --eval \"(prog1 (switch-to-buffer-other-frame (compilation-start \\\"git jump --stdout $@\\\" 'grep-mode)) (delete-other-windows) (select-frame-set-input-focus (selected-frame)))\""
> +}

I think this subjects the user's arguments to an extra round of
whitespace splitting. E.g., if I do:

  git jump grep 'foo bar'

then the emacs command will see two arguments. The first is "--eval",
and the second is the whole string:

  prog1 (switch-to-buffer-other-frame (compilation-start "git jump --stdout grep foo bar" 'grep-mode)) (delete-other-windows) (select-frame-set-input-focus (selected-frame)))

But now we've lost fact that "foo bar" was a single string, and git-grep
will complain (because it treats "bar" as a file to look in, which does
not exist).

You'll have to either shell-quote the contents, or stuff it in a
tempfile and read it with something like "cat /path/to/tempfile" in the
emacs command (though I'm not sure if that would be racy when you're
using something like emacsclient which may exit before the main emacs
process runs the command).

-Peff
