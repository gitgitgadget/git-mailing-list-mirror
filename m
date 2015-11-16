From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] push: add recurseSubmodules config option
Date: Mon, 16 Nov 2015 18:13:14 -0500
Message-ID: <CAPig+cRRBhRsjMTLK3YVPRLMJd0kTDPycTPXFQ1S-XxsTzaiBQ@mail.gmail.com>
References: <1447680294-13395-1-git-send-email-mac@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Mike Crowe <mac@mcrowe.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:13:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZySxc-0003Sh-0x
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 00:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbbKPXNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 18:13:16 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36535 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbbKPXNP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 18:13:15 -0500
Received: by vkbs1 with SMTP id s1so1582994vkb.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 15:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=f5yey5FADT3/A578ZNidgXZrGbMsAq740qCz+NUCyiM=;
        b=q61e20beDvIk63KMtorB4LQ8f1irhQQCzuXYwXQOQFOtGkW14eN6/JCHBMuGtBq7tQ
         IHMOes4tdm9suprZUaje7BZO89FL9HWX8wfaCMCH/99jj6VrRGnCnFI/6OXixx1SrFUf
         mAF9UtRKsQAFT8A/hlRB9QpOyPxr2V15MbjJQr79Tnv/az80fJ+BcIc6QEn2IXwuv3O3
         agqJ+Vd5KSWZ65gqJxkmRO4yCq6k8o142kvFfuzYmbCb3LC63Q5YfuSLPre3mhNpxmyT
         TMAHteT9YzWMsmVGirfh/enjwa9qXGat+YModibpBfVhQcIdlby6hHS0H1j8kCYLgrUU
         CxEw==
X-Received: by 10.31.174.213 with SMTP id x204mr466755vke.115.1447715594994;
 Mon, 16 Nov 2015 15:13:14 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 16 Nov 2015 15:13:14 -0800 (PST)
In-Reply-To: <1447680294-13395-1-git-send-email-mac@mcrowe.com>
X-Google-Sender-Auth: 39c0quYNIN8gqwbwidH1XD-sd4o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281363>

On Mon, Nov 16, 2015 at 8:24 AM, Mike Crowe <mac@mcrowe.com> wrote:
> The --recurse-submodules command line parameter has existed for some
> time but it has no config file equivalent.
>
> Following the style of the corresponding parameter for git fetch, let's
> invent push.recurseSubmodules to provide a default for this
> parameter. This also requires the addition of --recurse-submodules=no to
> allow the configuration to be overridden on the command line when
> required.
>
> The most straightforward way to implement this appears to be to make
> push use code in submodule-config in a similar way to fetch.
>
> Signed-off-by: Mike Crowe <mac@mcrowe.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -2226,6 +2226,19 @@ push.gpgSign::
> +push.recurseSubmodules::
> +       Make sure all submodule commits used by the revisions to be pushed
> +       are available on a remote-tracking branch. If the value is 'check'
> +       then Git will verify that all submodule commits that changed in the
> +       revisions to be pushed are available on at least one remote of the
> +       submodule. If any commits are missing the push will be aborted and
> +       exit with non-zero status. If the value is 'on-demand' then all
> +       submodules that changed in the revisions to be pushed will be
> +       pushed. If on-demand was not able to push all necessary revisions
> +       it will also be aborted and exit with non-zero status. You may
> +       override this configuration at time of push by specifying
> +       '--recurse-submodules=check|on-demand|no'.

Does this configuration variable also support 'no' as a value? If so,
then it probably ought to be documented. If not, shouldn't it do so to
allow a configuration file to override a 'check' or 'on-demand' value
specified in a more global git configuration file?

>  rebase.stat::
>         Whether to show a diffstat of what changed upstream since the last
>         rebase. False by default.
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> @@ -257,7 +257,7 @@ origin +master` to force a push to the `master` branch). See the
> ---recurse-submodules=check|on-demand::
> +--recurse-submodules=check|on-demand|no::
>         Make sure all submodule commits used by the revisions to be
>         pushed are available on a remote-tracking branch. If 'check' is
>         used Git will verify that all submodule commits that changed in
> @@ -267,6 +267,8 @@ origin +master` to force a push to the `master` branch). See the
>         all submodules that changed in the revisions to be pushed will
>         be pushed. If on-demand was not able to push all necessary
>         revisions it will also be aborted and exit with non-zero status.
> +       A value of 'no' is used to override the push.recurseSubmodules
> +       variable when no submodule recursion is required.

Does this deserve a --no-recurse-submodules alias for consistency with
how other options are turned off?

>  --[no-]verify::
>         Toggle the pre-push hook (see linkgit:githooks[5]).  The
> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> @@ -64,7 +64,15 @@ test_expect_success 'push fails if submodule commit not on remote' '
>                 cd work &&
>                 git add gar/bage &&
>                 git commit -m "Third commit for gar/bage" &&
> -               test_must_fail git push --recurse-submodules=check ../pub.git master
> +               # the push should fail with --recurse-submodules=check
> +               # on the command line...
> +               test_must_fail git push --recurse-submodules=check ../pub.git master &&
> +
> +               # ...or if specified in the configuration..
> +               git config push.recurseSubmodules check &&
> +               test_must_fail git push ../pub.git master &&
> +
> +               git config --unset push.recurseSubmodules

If something above this line fails, then 'git config --unset' will not
be invoked, so the expected cleanup won't happen. Typically, to ensure
cleanup, you'd use test_config(), however that function doesn't work
in subshells. Probably the easiest fix, in this case, is to set the
config variable as a one-shot and drop 'git config' and 'git config
--unset' altogether:

    test_must_fail git -c push.recurseSubmodules check \
        push ../pub.git master

>         )
>  '
>
> @@ -79,6 +87,119 @@ test_expect_success 'push succeeds after commit was pushed to remote' '
> +test_expect_success 'push succeeds if submodule commit not on remote but using on-demand from config' '
> +       (
> +               cd work/gar/bage &&
> +               >recurse-on-demand-from-config &&
> +               git add recurse-on-demand-from-config &&
> +               git commit -m "Recurse on-demand from config junk"
> +       ) &&
> +       (
> +               cd work &&
> +               git add gar/bage &&
> +               git commit -m "Recurse on-demand on command line for gar/bage" &&
> +               git config push.recurseSubmodules on-demand &&
> +               git push ../pub.git master &&
> +               git config --unset push.recurseSubmodules &&

Ditto regarding 'git config --unset' cleanup not being run there is a
failure above this. Same for following tests.

> +               # Check that the supermodule commit got there
> +               git fetch ../pub.git &&
> +               git diff --quiet FETCH_HEAD master
> +               # Check that the submodule commit got there too
> +               cd gar/bage &&
> +               git diff --quiet origin/master master
> +       )
> +'
