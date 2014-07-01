From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] test-dump-cache-tree: Improve output format and exit code
Date: Tue, 1 Jul 2014 00:43:09 -0400
Message-ID: <CAPig+cSKiB3b-gufaOx4=rWBjWWyGiqx-M85+2UAGq-BUkkLHA@mail.gmail.com>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com>
	<1404173597-24713-2-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 06:43:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1puW-0000Ig-6P
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 06:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbaGAEnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 00:43:11 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:42097 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbaGAEnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 00:43:10 -0400
Received: by mail-yh0-f48.google.com with SMTP id b6so5587755yha.21
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 21:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m+jABpvBcB8ugSj/8wKEHdR68sN5TBdC5T073LYJRrg=;
        b=YkqhI8hyOIph4GScz4TdvkCLa7VhazykRfqCgtmEIR4UuSDTFLdG8ndcdtg7iJOB/E
         eV63KLDzT4hxyA+qPZoQV0IyYZI7wCfvQ0XYk9l9wi7xVL8Flj1YKcLGGSB34UvEk9Q7
         H0tnq74qmP4Qu8riavDLHmwEwGeRa7hxBGQbAI6qH/g/84svhuatC1Sfd4AeF1OLfoTI
         G9XMzoG4nbBoYsyn6sz7NX73Yn6FERJtZTqnciYn8pJW/PuXsz6gstlKdmcAgwTW3s4f
         rdXG6lK/lbJhg1q2cFl7KJL8pCNYAbilEQWaxbSfQvnrNlTeVjLSGChd6zuLhTF9Hqbr
         ByOg==
X-Received: by 10.236.71.65 with SMTP id q41mr19520051yhd.84.1404189789358;
 Mon, 30 Jun 2014 21:43:09 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Mon, 30 Jun 2014 21:43:09 -0700 (PDT)
In-Reply-To: <1404173597-24713-2-git-send-email-dturner@twitter.com>
X-Google-Sender-Auth: AmKJhOD20lhjkCpCyD_CbTmMLbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252710>

On Mon, Jun 30, 2014 at 8:13 PM, David Turner <dturner@twopensource.com> wrote:
> Make test-dump-cache-tree more useful for testing.  Do not treat known
> invalid trees as errors (and do not produce non-zero exit code),
> because we can fall back to the non-cache-tree codepath.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  t/t0090-cache-tree.sh  | 28 +++++++++++++++++++++++++---
>  test-dump-cache-tree.c | 24 ++++++++++++------------
>  2 files changed, 37 insertions(+), 15 deletions(-)
>
> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 7c60675..5383258 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -21,10 +21,13 @@ test_shallow_cache_tree () {
>         cmp_cache_tree expect
>  }
>
> +# Test that the cache-tree for a given directory is invalid.
> +# If no directory is given, check that the root is invalid
>  test_invalid_cache_tree () {
> -       echo "invalid                                   (0 subtrees)" >expect &&
> -       printf "SHA #(ref)  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >>expect &&
> -       cmp_cache_tree expect
> +       test-dump-cache-tree >actual &&
> +       sed -e "s/$_x40/SHA/" -e "s/[0-9]* subtrees//g" <actual >filtered &&
> +       expect=$(printf "invalid                                  $1 ()\n") &&
> +       fgrep "$expect" filtered
>  }
>
>  test_no_cache_tree () {
> @@ -49,6 +52,25 @@ test_expect_success 'git-add invalidates cache-tree' '
>         test_invalid_cache_tree
>  '
>
> +test_expect_success 'git-add in subdir invalidates cache-tree' '
> +       test_when_finished "git reset --hard; git read-tree HEAD" &&
> +       mkdir dirx &&
> +       echo "I changed this file" > dirx/foo &&

Style: drop whitespace after >

> +       git add dirx/foo &&
> +       test_invalid_cache_tree
> +'
> +
> +test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
> +       git tag no-children

Broken &&-chain.

> +       test_when_finished "git reset --hard no-children; git read-tree HEAD" &&
> +       mkdir dir1 dir2 &&
> +       test_commit dir1/a &&
> +       test_commit dir2/b &&
> +       echo "I changed this file" > dir1/a &&

Style: drop whitespace after >

> +       git add dir1/a &&
> +       test_invalid_cache_tree dir1/
> +'
> +
>  test_expect_success 'update-index invalidates cache-tree' '
>         test_when_finished "git reset --hard; git read-tree HEAD" &&
>         echo "I changed this file" > foo &&
> diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
> index 47eab97..ad42ca1 100644
> --- a/test-dump-cache-tree.c
> +++ b/test-dump-cache-tree.c
> @@ -6,12 +6,12 @@
>  static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
>  {
>         if (it->entry_count < 0)
> -               printf("%-40s %s%s (%d subtrees)\n",
> -                      "invalid", x, pfx, it->subtree_nr);
> +               printf("%-40s %s (%d subtrees)%s\n",
> +                      "invalid", pfx, it->subtree_nr, x);
>         else
> -               printf("%s %s%s (%d entries, %d subtrees)\n",
> -                      sha1_to_hex(it->sha1), x, pfx,
> -                      it->entry_count, it->subtree_nr);
> +               printf("%s %s (%d entries, %d subtrees)%s\n",
> +                      sha1_to_hex(it->sha1), pfx,
> +                      it->entry_count, it->subtree_nr, x);
>  }
>
>  static int dump_cache_tree(struct cache_tree *it,
> @@ -25,19 +25,19 @@ static int dump_cache_tree(struct cache_tree *it,
>                 /* missing in either */
>                 return 0;
>
> -       if (it->entry_count < 0) {
> +       if (it->entry_count < 0)
> +               /* invalid */
>                 dump_one(it, pfx, "");
> -               dump_one(ref, pfx, "#(ref) ");
> -               if (it->subtree_nr != ref->subtree_nr)
> -                       errs = 1;
> -       }
>         else {
> -               dump_one(it, pfx, "");
>                 if (hashcmp(it->sha1, ref->sha1) ||
>                     ref->entry_count != it->entry_count ||
>                     ref->subtree_nr != it->subtree_nr) {
> -                       dump_one(ref, pfx, "#(ref) ");
> +                       /* claims to be valid but is lying */
> +                       dump_one(ref, pfx, " #(error)");
>                         errs = 1;
> +               } else {
> +                       /* is actually valid */
> +                       dump_one(it, pfx, "");
>                 }
>         }
>
> --
> 2.0.0.390.gcb682f8
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
