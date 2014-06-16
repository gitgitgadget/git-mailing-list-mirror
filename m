From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/14] rebase: add t3426 for submodule updates
Date: Mon, 16 Jun 2014 05:57:50 -0400
Message-ID: <CAPig+cSU_8USZu3cr=aaOun07jE2BhgLt7yu9ix_AikUpK+pJQ@mail.gmail.com>
References: <539DD029.4030506@web.de>
	<539DD19B.6000504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 16 11:57:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwTfn-0005jJ-Mm
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 11:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbaFPJ5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 05:57:51 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:59623 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbaFPJ5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 05:57:51 -0400
Received: by mail-yk0-f172.google.com with SMTP id 142so3920783ykq.31
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7DCTobJVZBL4zM88HkLkjV6Frzco/PC9ipg7SepqomU=;
        b=x+yqUU//bYD79txKcBUaJZo9UmUG2SDQZc04b+Psy+2qFDXOqOYIS57gBT4cYxuM4k
         F+H6dbcGS0H4VzMIkrA7VCxc3zaEB2IRXMVnNIWCmFqz/ZWNTN/enmI99KYRwC5f0UJR
         UBAbQenMLoAcmnkoHRWeywcJRHSFi72YflKX2aDNmF2hC79Jcjqswrcaurdl4dV5hm4E
         fNh+Pvpg4f/w4bp8Sf9WIXkmhlplFMa7twT3XZqtrNq7O0W4NNH+KY0nWtIRKJ/l3Opr
         FxVkmtzwFuMnVjFMRrgAVSRg8H5EaOsTsI8BtunwYHUGgWU2tafGX742UkwVPgxMZlKH
         FLHw==
X-Received: by 10.236.134.169 with SMTP id s29mr32092589yhi.4.1402912670524;
 Mon, 16 Jun 2014 02:57:50 -0700 (PDT)
Received: by 10.170.36.19 with HTTP; Mon, 16 Jun 2014 02:57:50 -0700 (PDT)
In-Reply-To: <539DD19B.6000504@web.de>
X-Google-Sender-Auth: tBeN5qxEx3gh4vPyOcQRHqjX6M8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251710>

On Sun, Jun 15, 2014 at 1:02 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Test that the rebase command updates the work tree as expected for
> changes which don't result in conflicts. To make that work add two
> helper functions that add a commit only touching files and then
> revert it. This allows to rebase the target commit over these two
> and to compare the result.
>
> Set KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR to
> document that "replace directory with submodule" fails for an
> interactive rebase because a directory "sub1" already exists.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>  t/t3426-rebase-submodule.sh | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100755 t/t3426-rebase-submodule.sh
>
> diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
> new file mode 100755
> index 0000000..019ce52
> --- /dev/null
> +++ b/t/t3426-rebase-submodule.sh
> @@ -0,0 +1,46 @@
> +#!/bin/sh
> +
> +test_description='rebase can handle submodules'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-submodule-update.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +git_rebase () {
> +       git status -su >expected &&
> +       ls -1pR * >>expected &&
> +       git checkout -b ours HEAD &&
> +       echo x >>file1 &&
> +       git add file1 &&
> +       git commit -m add_x &&
> +       git revert HEAD &&
> +       git status -su >actual &&
> +       ls -1pR * >>actual &&
> +       test_cmp expected actual &&
> +       git rebase "$1"
> +}
> +
> +test_submodule_switch "git_rebase"
> +
> +git_rebase_interactive () {
> +       git status -su >expected &&
> +       ls -1pR * >>expected &&
> +       git checkout -b ours HEAD &&
> +       echo x >>file1 &&
> +       git add file1 &&
> +       git commit -m add_x &&
> +       git revert HEAD &&
> +       git status -su >actual &&
> +       ls -1pR * >>actual &&
> +       test_cmp expected actual &&
> +       set_fake_editor &&
> +       echo "fake-editor.sh" >.git/info/exclude

Broken &&-chain.

> +       git rebase -i "$1"
> +}
> +
> +KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
> +# The real reason "replace directory with submodule" fails is because a
> +# directory "sub1" exists, but we reuse the suppression added for merge here
> +test_submodule_switch "git_rebase_interactive"
> +
> +test_done
> --
> 2.0.0.275.gc479268
