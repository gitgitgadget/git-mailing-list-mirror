From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 4/4] cache-tree: Write updated cache-tree after commit
Date: Fri, 11 Jul 2014 19:56:35 -0400
Message-ID: <CAPig+cQpzomDmwVqgDGrP4qC1OujRXu5e1wc=EwX61k_RpLbKg@mail.gmail.com>
References: <1405120947-3142-1-git-send-email-dturner@twitter.com>
	<1405120947-3142-4-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 01:56:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5kgD-0005sh-Am
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 01:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbaGKX4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 19:56:37 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:59132 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbaGKX4h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 19:56:37 -0400
Received: by mail-la0-f51.google.com with SMTP id mc6so1339551lab.24
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 16:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6J2cIRKIYYinWF1HdXlBzhSeEZJ84iWTOgNo6Y7es5I=;
        b=aqoCOuOyzRQwM+F98P45lidqRVNhlLGrC1Wq1hKgwJ4rjf/nyG23Ci0trdUjF81RAP
         KHYEre1LV0UWazFa5zDCWYfJox3h9ikbppnSVaVQYNBhdOU3Ld9FND+XZpzHP7Zt/3SI
         fb0AkGxVdjyjD9tMcTCHT8eFGySXnps/vTUwHgn2z5t84NiHGjGFg2OcPqgeGMoUYmYL
         8SCh6yX3SpXpfWKlP0vIH+1nl9u2dxIZVLXFZLkx+bdow6ijYDtFj0LmfHqFpF+7EPg0
         dEepIApHuEtG0OUM4vZbiMABw+dNJKyBnNVhzdFAuQ186yFzGg0QT2qY2hN+zFx+RVyf
         ttmA==
X-Received: by 10.112.149.200 with SMTP id uc8mr1650509lbb.70.1405122995672;
 Fri, 11 Jul 2014 16:56:35 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Fri, 11 Jul 2014 16:56:35 -0700 (PDT)
In-Reply-To: <1405120947-3142-4-git-send-email-dturner@twitter.com>
X-Google-Sender-Auth: OU-NxPWNjC7uW4gOsj5OSO81BJs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253354>

On Fri, Jul 11, 2014 at 7:22 PM, David Turner <dturner@twopensource.com> wrote:
> During the commit process, update the cache-tree. Write this updated
> cache-tree so that it's ready for subsequent commands.
>
> Add test code which demonstrates that git commit now writes the cache
> tree.  Make all tests test the entire cache-tree, not just the root
> level.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 3a3342e..57f263f 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -90,37 +128,86 @@ test_expect_success 'test-scrap-cache-tree works' '
>
>  test_expect_success 'second commit has cache-tree' '
>         test_commit bar &&
> -       test_shallow_cache_tree
> +       test_cache_tree
> +'
> +
> +test_expect_success 'commit -i gives cache-tree' '
> +       git checkout current &&
> +       cat <<-\EOT >foo.c &&
> +       int foo()
> +       {
> +               return 42;
> +       }
> +       int bar()
> +       {
> +               return 42;
> +       }
> +       EOT
> +       git add foo.c
> +       test_invalid_cache_tree
> +       git commit -m "add a file"
> +       test_cache_tree

Broken &&-chain on all four lines above.

> +       cat <<-\EOT >foo.c &&
> +       int foo()
> +       {
> +               return 43;
> +       }
> +       int bar()
> +       {
> +               return 44;
> +       }
> +       EOT
> +       (echo p; echo 1; echo; echo s; echo n; echo y; echo q) | git commit --interactive -m foo

Broken &&-chain.

Would a printf make this more readable?

    printf "p\n1\n\ns\nn\ny\nq\n" | git commt ... &&

Perhaps not.

> +       test_cache_tree
> +'
> +
> +test_expect_success 'commit in child dir has cache-tree' '
> +       mkdir dir &&
> +       >dir/child.t &&
> +       git add dir/child.t &&
> +       git commit -m dir/child.t &&
> +       test_cache_tree
>  '
>
>  test_expect_success 'reset --hard gives cache-tree' '
>         test-scrap-cache-tree &&
>         git reset --hard &&
> -       test_shallow_cache_tree
> +       test_cache_tree
>  '
>
>  test_expect_success 'reset --hard without index gives cache-tree' '
>         rm -f .git/index &&
>         git reset --hard &&
> -       test_shallow_cache_tree
> +       test_cache_tree
>  '
>
>  test_expect_success 'checkout gives cache-tree' '
>         git tag current &&
>         git checkout HEAD^ &&
> -       test_shallow_cache_tree
> +       test_cache_tree
>  '
>
>  test_expect_success 'checkout -b gives cache-tree' '
>         git checkout current &&
>         git checkout -b prev HEAD^ &&
> -       test_shallow_cache_tree
> +       test_cache_tree
>  '
>
>  test_expect_success 'checkout -B gives cache-tree' '
>         git checkout current &&
>         git checkout -B prev HEAD^ &&
> -       test_shallow_cache_tree
> +       test_cache_tree
> +'
> +
> +test_expect_success 'partial commit gives cache-tree' '
> +       git checkout -b partial no-children &&
> +       test_commit one &&
> +       test_commit two &&
> +       echo "some change" >one.t &&
> +       git add one.t &&
> +       echo "some other change" >two.t &&
> +       git commit two.t -m partial &&
> +       test_cache_tree
>  '
>
>  test_done
> --
> 2.0.0.390.gcb682f8
