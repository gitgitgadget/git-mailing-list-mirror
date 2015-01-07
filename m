From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] t4255: test am submodule with diff.submodule
Date: Wed, 7 Jan 2015 15:06:47 -0500
Message-ID: <CAPig+cQUUoTFY41-++Po=LTPWYVH=CWpT7PUKGPyvACjJoPXxQ@mail.gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
	<1420659105-26546-1-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 21:08:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8wsa-000265-7V
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbbAGUGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:06:50 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:33239 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbbAGUGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:06:48 -0500
Received: by mail-yh0-f49.google.com with SMTP id f10so973920yha.36
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 12:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZnKzcoUdlG4iEdJEyDZUQ8tdEuHivbntumcax/pUFt8=;
        b=T7UV2uV5c4Ryh7o4YrZMBGh2pGQWCnG8mtuiULWPSiVeHT2wI0EPiga5nDu5REsobK
         OPGWT5l/ecNiV4qvAaGbcygWAvWbVKkliBoEsMgZODp6eun8Ef7yMYPj6eO2tQgbXFOM
         sR32H3q+n5pzHgXb1++et8hE1Komd7qLNiczJWazWXiGJoMCuMqL+K0ZDgWpNh0sO138
         9aK+BLanMpswjZFEnHZ6E9IRYtx0SEsGk4BpU272mVKvmEPN7ga4q4bGJYKN+uDFuSur
         naJL6q9su1VFwCLPZ+EtQaotBnz376PmmGLHEKCD6O690nBLt1zdTWPo7vhyBWRvCc/F
         r/lA==
X-Received: by 10.170.119.7 with SMTP id l7mr3851635ykb.51.1420661207692; Wed,
 07 Jan 2015 12:06:47 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 7 Jan 2015 12:06:47 -0800 (PST)
In-Reply-To: <1420659105-26546-1-git-send-email-dougk.ff7@gmail.com>
X-Google-Sender-Auth: v3RUHGlEywRqmGXVYzE2sAvo78w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262148>

On Wed, Jan 7, 2015 at 2:31 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
> git am will break when using diff.submodule=log; add some test cases
> to illustrate this breakage as simply as possible.  There are
> currently two ways this can fail:
>
> * With errors ("unrecognized input"), if only change
> * Silently (no submodule change), if other files change
>
> Test for both conditions and ensure without diff.submodule this works.
>
> Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
> Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
> Thanks-to: Junio C Hamano <gitster@pobox.com>

On this project, it's customary to say "Helped-by:" rather than
"Thanks-to:". Also, place your sign-off last.

> ---
> Updated with Eric Sunshine's comments and changes to reduce complexity,
> and also changed to include Junio's suggestions for using test_config,
> test_unconfig, and test_might_fail (since we don't know if a previous
> am failed or not -- we always want to clean up first).

Looking much better. Thanks. A couple minor comments below...

> diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
> index 8bde7db..523accf 100755
> --- a/t/t4255-am-submodule.sh
> +++ b/t/t4255-am-submodule.sh
> @@ -18,4 +18,76 @@ am_3way () {
>  KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
>  test_submodule_switch "am_3way"
>
> +test_expect_success 'setup diff.submodule' '
> +       test_commit one &&
> +       INITIAL=$(git rev-parse HEAD) &&
> +
> +       git init submodule &&
> +       (
> +               cd submodule &&
> +               test_commit two &&
> +               git rev-parse HEAD >../initial-submodule
> +       ) &&
> +       git submodule add ./submodule &&
> +       git commit -m first &&
> +
> +       (
> +               cd submodule &&
> +               test_commit three &&
> +               git rev-parse HEAD >../first-submodule
> +       ) &&
> +       git add submodule &&
> +       test_tick &&

You can drop this test_tick (as I did in my "squash"[1]).

> +       git commit -m second &&
> +       SECOND=$(git rev-parse HEAD) &&
> +
> +       (
> +               cd submodule &&
> +               git mv two.t four.t &&
> +               test_tick &&

And this one (which I overlooked in [1]).

The reason I suggest dropping the test_tick invocations is that they
do not impact these tests at all, yet their presence misleads the
reader into thinking that they are somehow significant.

> +               git commit -m "second submodule" &&
> +               git rev-parse HEAD >../second-submodule
> +       ) &&
> +       test_commit four &&
> +       git add submodule &&
> +       git commit --amend --no-edit &&
> +       THIRD=$(git rev-parse HEAD) &&
> +       git submodule update --init
> +'

[1]: http://article.gmane.org/gmane.comp.version-control.git/261852
