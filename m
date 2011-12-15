From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t5704 (bundle): rewrite for larger coverage
Date: Thu, 15 Dec 2011 15:16:32 -0600
Message-ID: <20111215211632.GB16160@elie.hsd1.il.comcast.net>
References: <20111208175913.GK2394@elie.hsd1.il.comcast.net>
 <1323967528-10537-1-git-send-email-artagnon@gmail.com>
 <1323967528-10537-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Joey Hess <joey@kitenet.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:16:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbIfa-000125-5m
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759438Ab1LOVQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:16:45 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:42500 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759376Ab1LOVQp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 16:16:45 -0500
Received: by wgbds13 with SMTP id ds13so1771375wgb.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 13:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4+yO+wpXAxYxou04J5HUjEbUZmJRCw0X413cciKo4zE=;
        b=uvkAFnFy3luXqHNYksw+5PJK/R/6oAIDyZy/29B6bxkK2X3oZ8119NKfSNFuemhUjz
         R6jC/5fhxVYQVuZqoX+79pEqp54IBcEvzo8I2TIL4wbz/txDQLHyLqDaTT+jUZJ5snkF
         82WQuHemCR/nlHJSPyZda1u/LH7zlBF9iwgnM=
Received: by 10.180.92.42 with SMTP id cj10mr8139929wib.64.1323983803756;
        Thu, 15 Dec 2011 13:16:43 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hn15sm10120141wib.22.2011.12.15.13.16.39
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 13:16:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323967528-10537-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187234>

Hi,

Ramkumar Ramachandra wrote:

> Rewrite

Always a scary word.  Very rarely justified, especially when the
original and rewritten versions of something are not going to be able
to coexist for a period while the bugs are ironed out.  It doesn't
leave me optimistic.

>         the git-bundle testsuite to exercise more of its
> functionality.

Luckily, this goal suggests that I am going to see some new tests
added, without the existing coverage being removed or mangled, so
maybe I can ignore the fears awakened by the word "Rewrite".  Let's
see...

[...]
> --- a/t/t5704-bundle.sh
> +++ b/t/t5704-bundle.sh
> @@ -1,56 +1,99 @@
>  #!/bin/sh
>  
> -test_description='some bundle related tests'
> +test_description='Test git-bundle'

Why?

>  . ./test-lib.sh
>  
>  test_expect_success 'setup' '
> +	git config core.logAllRefUpdates false &&

Why?

> +	test_commit initial &&
> +	git checkout -b branch &&
> +	test_commit second &&
> +	test_commit third &&
> +	git checkout master &&
> +	test_commit fourth file
> +'

No explicit tags in the setup this time.  Now all commits are referred
to by tags, which worsens the coverage, since if some future change
caused commits not referred to by a tag to be dropped, it would be
missed.  Paraphrasing

	>file &&
	git add file &&
	test_tick &&
	git commit -m initial &&
	git tag -m initial initial

to

	test_commit initial file

when not preparing to make some other change in the same place and if
the original was not too confusing feels like gratuitous churn.

[...]
> +test_expect_success 'create succeeds' '
> +	git bundle create bundle second third &&
> +	cat >expect <<-\EOF &&
> +	OBJID	refs/tags/third
> +	OBJID	refs/tags/second
> +	EOF
> +	{
> +		git ls-remote bundle |
> +		sed "s/$_x40/OBJID/g"
> +	} >actual &&
> +	test_cmp expect actual
> +'

A new test.  What assertion is it testing?  Why censor out the
object names when comparing the expected object names to the
actual ones, instead of computing the appropriate object names
for the expected result?  Is this new test useful, or does it
cover ground already tested in t5510-fetch.sh?

> +test_expect_success 'verify succeeds' '
> +	git bundle create bundle second third &&
> +	git bundle verify bundle
>  '

A test for "git bundle verify" is a welcome addition.

> +test_expect_success 'list-heads succeeds' '
> +	git bundle create bundle second third &&
> +	cat >expect <<-\EOF &&
> +	OBJID refs/tags/second
> +	OBJID refs/tags/third
> +	EOF
> +	{
> +		git bundle list-heads bundle |
> +		sed "s/$_x40/OBJID/g"
> +	} >actual &&
> +	test_cmp expect actual
> +'
> +

Based on 'git grep -e "git bundle list-heads" -- t', there don't seem
to be any existing tests for "git bundle list-heads" except for
t5510-fetch.sh, but I'm not sure what this adds on top of that one.

> -test_expect_success 'tags can be excluded by rev-list options' '
> -
> -	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
> -	git ls-remote bundle > output &&
> -	! grep tag output

Dropped?

> +test_expect_success 'create dies on invalid bundle filename' '
> +	mkdir adir &&
> +	test_expect_code 128 git bundle create adir --all
> +'

How is "invalid bundle filename" a clearer explanation than "bundle
file cannot be created"?

>  
> +test_expect_success 'disallow stray command-line options' '
> +	test_must_fail git bundle create --junk bundle second third
>  '

Ok.  Might also be useful to check that no "--junk" or "bundle" file
is created.

> +test_expect_failure 'disallow stray command-line arguments' '
> +	git bundle create bundle second third &&
> +	test_must_fail git bundle verify bundle junk
> +'

In this case, "stray command-line arguments" actually means "extra
arguments to 'verify'", I guess?

What happens if I run "git bundle verify *.bundle" in a directory
with multiple bundles?  What should happen?

> +test_expect_success 'create accepts rev-list options to narrow refs' '
> +	git bundle create bundle --all -- file &&

I don't understand what "options to narrow refs" means.  Does that
mean options like --remotes=origin which yield refs from some subset
of the ref namespace, unlike --all?

[...]
> +test_expect_success 'unbundle succeeds' '

A test for "git bundle unbundle" is a welcome addition.

[...]
>  test_expect_failure 'bundle --stdin' '
> -
>  	echo master | git bundle create stdin-bundle.bdl --stdin &&
>  	git ls-remote stdin-bundle.bdl >output &&
>  	grep master output
> -
>  '

Seems like a gratuitous change to mix into a patch that introduces
functional changes.

I found this hard to review, since it doesn't seem very focussed ---
it mixes style cleanups, removal of code, and introduction of new
code.  I'd be way happier to see a new patch that just adds new tests
to the script without potentially breaking anything on the way.  Then
if the style cleanups still seem important to you, they can be
reviewed as a separate patch.

Hoping that clarifies a little,
Jonathan
