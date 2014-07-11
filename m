From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4 v6] cache-tree: subdirectory tests
Date: Fri, 11 Jul 2014 02:03:44 -0400
Message-ID: <CAPig+cQVjy5eBtGLsX3uaTEsHyvyjhqCMFaLDn9Upueis-z1eQ@mail.gmail.com>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
	<1405038686-1138-3-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 08:03:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Tvz-00032p-9r
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 08:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbaGKGDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 02:03:47 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:39348 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbaGKGDq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 02:03:46 -0400
Received: by mail-lb0-f180.google.com with SMTP id w7so472335lbi.11
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 23:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KfgMq5KmP7aqkjPAjhv4Z2RFcKYBb5nRq4CySGE2WcM=;
        b=yEtx+MqfdCZrrHpNv9Ag6nARkwIW3mgFDkRTDkGllhVndoOG/yejp2MW/aJ4wpyfn8
         UjPvex68IaGK6IaHkWUInq/HtmJhM3VXORHRdUQHmuybiHz6T2Z+ZL0iizALJcmy4nkT
         f9BTs/pG1lsPjuBIoizwzwMh7kntlu0wRtU66ZH6PMrBiXjCEJLcGDKfc6hFf4InXryz
         FbEAUQCzwV1eEi7T4sZmNt247nxTRpjZCzKrakxfua//i5lCLPdFiiwvi3QtkCogCBw6
         Ku65wWyYa4NZMOO8SpfYqL00m9DT1fEQJWOy/NAYyDOS04rEazh/tFrFxjKScY7PIGAt
         45nA==
X-Received: by 10.112.155.129 with SMTP id vw1mr42858040lbb.7.1405058625010;
 Thu, 10 Jul 2014 23:03:45 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Thu, 10 Jul 2014 23:03:44 -0700 (PDT)
In-Reply-To: <1405038686-1138-3-git-send-email-dturner@twitter.com>
X-Google-Sender-Auth: aZsT_v5W1jGAf9v8sg0c-6oYxAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253251>

On Thu, Jul 10, 2014 at 8:31 PM, David Turner <dturner@twopensource.com> wrote:
> Add tests to confirm that invalidation of subdirectories neither over-
> nor under-invalidates.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  t/t0090-cache-tree.sh | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 98fb1ab..3a3342e 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -22,9 +22,10 @@ test_shallow_cache_tree () {
>  }
>
>  test_invalid_cache_tree () {
> -       echo "invalid                                   (0 subtrees)" >expect &&
> -       printf "SHA #(ref)  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >>expect &&
> -       cmp_cache_tree expect
> +       printf "invalid                                  %s ()\n" "" "$@" >expect &&
> +       test-dump-cache-tree | \

nit: unnecessary backslash

> +       sed -n -e "s/[0-9]* subtrees//" -e '/#(ref)/d' -e '/^invalid /p' >actual &&
> +       test_cmp expect actual
>  }
>
>  test_no_cache_tree () {
> @@ -49,6 +50,25 @@ test_expect_success 'git-add invalidates cache-tree' '
>         test_invalid_cache_tree
>  '
>
> +test_expect_success 'git-add in subdir invalidates cache-tree' '
> +       test_when_finished "git reset --hard; git read-tree HEAD" &&
> +       mkdir dirx &&
> +       echo "I changed this file" >dirx/foo &&
> +       git add dirx/foo &&
> +       test_invalid_cache_tree
> +'
> +
> +test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
> +       git tag no-children &&
> +       test_when_finished "git reset --hard no-children; git read-tree HEAD" &&
> +       mkdir dir1 dir2 &&
> +       test_commit dir1/a &&
> +       test_commit dir2/b &&
> +       echo "I changed this file" >dir1/a &&
> +       git add dir1/a &&
> +       test_invalid_cache_tree dir1/
> +'
> +
>  test_expect_success 'update-index invalidates cache-tree' '
>         test_when_finished "git reset --hard; git read-tree HEAD" &&
>         echo "I changed this file" >foo &&
> --
> 2.0.0.390.gcb682f8
