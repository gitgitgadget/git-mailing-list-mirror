From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: Remove some direct access to .git/logs
Date: Mon, 27 Jul 2015 14:47:20 -0700
Message-ID: <xmqqlhe1gtnb.fsf@gitster.dls.corp.google.com>
References: <1438028034-23609-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 23:47:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJqF7-0005JM-U5
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 23:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbbG0VrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 17:47:25 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33827 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbbG0VrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 17:47:24 -0400
Received: by pdbbh15 with SMTP id bh15so58404127pdb.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UFoSoh6A+j6G1rvliplk6yEI792EHaUc9+2IAgW8TFw=;
        b=psOohAPq+AC5aziA6ck3g8uyqZFjVijcYI/Hqnh/I0jfSmOXLEufBVr+DY7fUcKPks
         R6rmLvkoNWvsmTSrKeNhhgPtBUuTm9oron8r56lRdFT/PlGmxiEW4sLMRV8tLBwB8+9H
         HejlUAjm2nAaufKLL7kZhI3KybpzLbYlfvEE4sgO84LQIHQ+XqJYksPcsWKXvHAlMVtt
         6zCN7mhWsTL6fHuediE0Ve69oWJBg9jvfbUKKuYYczF4xf/abfsITjw/QxDqnElk2m5K
         Z5jbbB1SQS3kBK0V1vjKJ7KDIzA02Ss4LJXgauhn2qDoP8xuUvPeiSaGY3GXjYBmWVYJ
         ym1w==
X-Received: by 10.70.3.98 with SMTP id b2mr72742210pdb.107.1438033644305;
        Mon, 27 Jul 2015 14:47:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id wc8sm6375708pab.45.2015.07.27.14.47.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 14:47:21 -0700 (PDT)
In-Reply-To: <1438028034-23609-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 27 Jul 2015 16:13:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274714>

David Turner <dturner@twopensource.com> writes:

> -: a repository with working tree always has reflog these days...
> -: >.git/logs/refs/heads/master
> +rm -f .git/logs/refs/heads/master

This looks quite different from how other tests are updated (which
looked a lot more sensible).  The original has the effect of (1)
ensuring that the log exists/is enabled for 'master' branch and (2)
that log is emptied.  The updated has a quite different effect,
but only when you are using filesystem based backend.

>  test_expect_success \
>  	"create $m (logged by touch)" \
>  	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
> -	 git update-ref HEAD '"$A"' -m "Initial Creation" &&
> +	 git update-ref --create-reflog HEAD '"$A"' -m "Initial Creation" &&
>  	 test '"$A"' = $(cat .git/'"$m"')'

And this update compensates for the earlier "remove 'master' reflog"
(where it should have been "ensure creation and empty it") by
creating, but it is unclear what would happen when we start using
different ref backends.  Earlier we did not remove reflog from the
backend, and we say "create" here---it would hopefully not error
out, but it does not quite feel right.  Perhaps create and
immediately prune all instead?  That feels like more in line with
the way the other change in this patch do things.

> -	test_line_count = 4 .git/logs/refs/heads/master
> +	git reflog refs/heads/master >output &&
> +	test_line_count = 4 output
>  '

These all look sensible.

> diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
> index 6f47c0d..d568b35 100755
> --- a/t/t1411-reflog-show.sh
> +++ b/t/t1411-reflog-show.sh
> @@ -138,7 +138,7 @@ test_expect_success '--date magic does not override explicit @{0} syntax' '
>  : >expect
>  test_expect_success 'empty reflog file' '
>  	git branch empty &&
> -	: >.git/logs/refs/heads/empty &&
> +	git reflog expire --expire=all refs/heads/empty &&

This one is what I was talking about in the earlier part of this
message.  This looks very sensible.

>  test_expect_success 'fails silently when using -q with deleted reflogs' '
>  	ref=$(git rev-parse HEAD) &&
> -	: >.git/logs/refs/test &&
> -	git update-ref -m "message for refs/test" refs/test "$ref" &&
> +	git update-ref --create-reflog -m "message for refs/test" refs/test "$ref" &&

I cannot tell without enough pre-context, but I assume that we know
there is no reflog for refs/test when this test piece starts---in
which case this change looks sensible.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 467e6c1..dc76754 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -961,13 +961,13 @@ test_expect_success 'rebase -i produces readable reflog' '
>  	set_fake_editor &&
>  	git rebase -i --onto I F branch-reflog-test &&
>  	cat >expect <<-\EOF &&
> -	rebase -i (start): checkout I
> -	rebase -i (pick): G
> -	rebase -i (pick): H
>  	rebase -i (finish): returning to refs/heads/branch-reflog-test
> +	rebase -i (pick): H
> +	rebase -i (pick): G
> +	rebase -i (start): checkout I
>  	EOF

;-)

> -	tail -n 4 .git/logs/HEAD |
> -	sed -e "s/.*	//" >actual &&
> +	git reflog HEAD -n4 |

This may happen to work but teaches a bad habit to readers.  Always
order your command line by starting with dashed-options, then refs
and then pathspecs.

> diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
> index 9ac7940..db9774e 100755
> --- a/t/t7509-commit.sh
> +++ b/t/t7509-commit.sh
> @@ -90,22 +90,10 @@ sha1_file() {
>  remove_object() {
>  	rm -f $(sha1_file "$*")
>  }
> -no_reflog() {
> -	cp .git/config .git/config.saved &&
> -	echo "[core] logallrefupdates = false" >>.git/config &&
> -	test_when_finished "mv -f .git/config.saved .git/config" &&
> -
> -	if test -e .git/logs
> -	then
> -		mv .git/logs . &&
> -		test_when_finished "mv logs .git/"
> -	fi
> -}
>  
>  test_expect_success '--amend option with empty author' '
>  	git cat-file commit Initial >tmp &&
>  	sed "s/author [^<]* </author  </" tmp >empty-author &&
> -	no_reflog &&
>  	sha=$(git hash-object -t commit -w empty-author) &&
>  	test_when_finished "remove_object $sha" &&
>  	git checkout $sha &&
> @@ -119,7 +107,6 @@ test_expect_success '--amend option with empty author' '
>  test_expect_success '--amend option with missing author' '
>  	git cat-file commit Initial >tmp &&
>  	sed "s/author [^<]* </author </" tmp >malformed &&
> -	no_reflog &&
>  	sha=$(git hash-object -t commit -w malformed) &&
>  	test_when_finished "remove_object $sha" &&
>  	git checkout $sha &&

I can understand that .git/logs/ cannot be relied upon when you move
your ref backend out of filesystem, but that does not quite explain
why this change makes sense.  Puzzled...
