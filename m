From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 6/6] clone: add tests for cloning with empty path
Date: Thu, 30 Jul 2015 14:18:02 -0400
Message-ID: <CAPig+cQ5wR8xp8erAHBzEMEs62ddULrrML53GNVuuie3kd9EvA@mail.gmail.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438185076-28870-1-git-send-email-ps@pks.im>
	<1438185076-28870-7-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Thu Jul 30 20:18:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKsPD-000658-0x
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 20:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbbG3SSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 14:18:05 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35335 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbbG3SSE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 14:18:04 -0400
Received: by ykdu72 with SMTP id u72so40715513ykd.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=18HF8O45INCDokU2xyFyRBWjSFOSPEWJdCGIhb7Bsng=;
        b=B05GxfFPHL+veDu4zslh3+wzcWFSInaKp3UFtdWco0XNNhswTLpTNq2pHKQvGMgaL1
         8wDR+bKM/jTxkuZQrqA9zFAkYFUT7m75nZR3PZ8VjbG6RGr7eWlVSh0hzT6YW6wxokxv
         EL4AXMaVvSxx0psiPQeeFqkxuQYuhgAlU3Pe3k6ORYtIbMDDT1jWbbX5yDY7NpyDuZkT
         i3SV70lovC1DLH115/FHG54t1oLYOPlStKP4i0B/z3MPUYuYZyCwq8v4WNAR3CqjBCYz
         GPB+B+D1k0bM6GnpjQmblggacJ6EbXAKcModY0sqhe0LFPOWTClfZev7vERICZZyLR4K
         XZKQ==
X-Received: by 10.170.97.9 with SMTP id o9mr52683673yka.84.1438280282859; Thu,
 30 Jul 2015 11:18:02 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 30 Jul 2015 11:18:02 -0700 (PDT)
In-Reply-To: <1438185076-28870-7-git-send-email-ps@pks.im>
X-Google-Sender-Auth: orKB1Y5YHWnZtlsfWe9sp9vpXZ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275023>

On Wed, Jul 29, 2015 at 11:51 AM, Patrick Steinhardt <ps@pks.im> wrote:
> Test behavior of `git clone` when working with an empty path
> component. This may be the case when cloning a file system's root
> directory or from a remote server's root.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
> index 553a3f6..acfa133 100755
> --- a/t/t1509-root-worktree.sh
> +++ b/t/t1509-root-worktree.sh
> @@ -237,6 +237,45 @@ test_foobar_foobar
>
>  test_expect_success 'cleanup' 'rm -rf /.git'
>
> +say "clone .git at root without reponame"
> +
> +test_expect_success 'go to /' 'cd /'
> +test_expect_success 'setup' '
> +       echo "Initialized empty Git repository in /.git/" > expected &&
> +       git init > result &&
> +       test_cmp expected result
> +'

I'd say something here about current style omitting the space after
the redirection operator (>), however, this script uniformly includes
the space, and being consistent with the existing style is important,
so I won't mention it. ;-)

> +test_clone_expect_dir() {
> +       URL="$1"
> +       DIR="$2"
> +       echo "Cloning into '$DIR'..." >expected
> +       echo "warning: You appear to have cloned an empty repository." >>expected

    echo >expected <<-\EOF
    Cloning into...
    warning: You appear...
    EOF

is more readable and maintainable.

> +       git clone "$URL" 2>result >result

    git clone "$URL" >result 2>&1

> +       rm -r "$DIR"
> +       test_cmp expected result
> +}

While not mandatory since it works as expected in its current form, it
would be nice to see a fully intact &&-chain in this function. That
way, if someone some day adds code which doesn't impact 'result' but
which might somehow fail, then the failure will be noticed.

> +
> +test_expect_success 'go to /clones' 'mkdir /clones && cd /clones'
> +test_expect_success 'simple clone of /' '
> +       echo "fatal: No directory name could be guessed." > expected &&
> +       echo "Please specify a directory on the command line" >> expected &&

    cat >expected <<-\EOF
    fatal: No directory...
    Please specify...
    EOF

> +       test_expect_code 128 git clone / 2>result >result &&

    test_expect_code 128 git clone / >result 2>&1 &&

> +       test_cmp expected result'
> +
> +test_expect_success 'clone with file://' '
> +       test_clone_expect_dir file://127.0.0.1/ 127.0.0.1'
> +test_expect_success 'clone with file://user@' '
> +       test_clone_expect_dir file://user@127.0.0.1/ 127.0.0.1'
> +test_expect_success 'clone with file://user:password@' '
> +       test_clone_expect_dir file://user:password@127.0.0.1/ 127.0.0.1'
> +test_expect_success 'clone with file://:port' '
> +       test_clone_expect_dir file://127.0.0.1:9999/ 127.0.0.1'
> +test_expect_success 'clone with file://user:password@:port' '
> +       test_clone_expect_dir file://user:password@127.0.0.1:9999/ 127.0.0.1'
> +
> +test_expect_success 'cleanup' 'rm -rf /.git /clones'
> +
>  say "auto bare gitdir"
>
>  # DESTROYYYYY!!!!!
> --
> 2.5.0
