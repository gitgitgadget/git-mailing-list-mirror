From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Mon, 18 Mar 2013 16:10:43 -0700
Message-ID: <20130318231043.GD5062@elie.Belkin>
References: <20130318220224.3b23a381@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Tue Mar 19 00:17:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHjJU-000155-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 00:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab3CRXR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 19:17:29 -0400
Received: from mail-da0-f45.google.com ([209.85.210.45]:46086 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab3CRXR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 19:17:29 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so1625730dad.32
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NpmAEUoghBEsmOUiUIDfru+1uXBASReWkvkgghVrhBg=;
        b=wWWGEAOwT/7l7M+XuGn9A1xuoQ/YrzApA3gIJvrq/fYNqpw3lFiHAr4Fc0+N5GKGbg
         EeN0tP2bbucNMLLeP6KOqCZZF8amOizgeuHuo/UuP9BjWxoz3anj9A18faEnXJ+Nmzpd
         86cmYzll7VluAk2j8PPd+7DCvR4EvTKPxNWZeDcYKdOR5kwYCa+tIYlMjM+wn3N4dHp3
         t1xByCqqc2RAy45byVZbOROJzFX2W0/CdR6ksUzQWCu/a/e2rLJ+eijHVzVEtcdCPocx
         GFZwbpea6Je5jcrKW6QR6gMGUMCg/dP+vNk9cRDGdp7/yKdkgRMcYAj8e12wt6dLMEKs
         N/OA==
X-Received: by 10.66.72.37 with SMTP id a5mr12877097pav.193.1363648247957;
        Mon, 18 Mar 2013 16:10:47 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id vd4sm21689098pbc.35.2013.03.18.16.10.45
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 16:10:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130318220224.3b23a381@hoelz.ro>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218465>

Hi,

Rob Hoelz wrote:

> [url "git://github.com/"]
>     insteadOf = github:
> [url "git://github.com/myuser/"]
>     insteadOf = mygithub:
> [url "git@github.com:myuser/"]
>     pushInsteadOf = mygithub:
> [remote "origin"]
>     url     = github:organization/project
>     pushurl = mygithub:project
>
> With the above configuration, the following occurs:
>
> $ git push origin master
> fatal: remote error:
>   You can't push to git://github.com/myuser/project.git
>   Use git@github.com:myuser/project.git
>
> So you can see that pushurl is being followed (it's not attempting to
> push to git://github.com/organization/project), but insteadOf values are
> being used as opposed to pushInsteadOf values for expanding the pushurl
> alias.

At first glance it is not always obvious how overlapping settings like
these should interact.  Thanks for an instructive example that makes
the right behavior obvious.

Test nits:

[...]
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -244,6 +244,87 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
>  	)
>  '
>  
> +test_expect_success 'push with pushInsteadOf and explicit pushurl (pushurl + pushInsteadOf does rewrite in this case)' '
> +	mk_empty &&
> +	rm -rf ro rw &&
> +	TRASH="$(pwd)/" &&
> +	mkdir ro &&
> +	mkdir rw &&
> +	git init --bare rw/testrepo &&
> +	git config "url.file://$TRASH/ro/.insteadOf" ro: &&
> +	git config "url.file://$TRASH/rw/.pushInsteadOf" rw: &&

The surrounding tests don't do this, but I wonder if it would make
sense to use test_config instead of 'git config' here.

That way, the test's settings wouldn't affect other tests, and in
particular if someone later decides to refactor the file by reordering
tests, she could be confident that that would not break anything.

In most of the surrounding tests it does not matter because 'git
config' is run in a subdirectory that is not reused later.  Patches
fixing the exceptions below.

> +	git config remote.r.url ro:wrong &&
> +	git config remote.r.pushurl rw:testrepo &&
> +	git push r refs/heads/master:refs/remotes/origin/master &&
> +	(
> +		cd rw/testrepo &&
> +		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
> +		test "z$r" = "z$the_commit" &&
> +
> +		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
> +	)

To produce more useful "./t5516-fetch-push.sh -v -i" output when the
comparison fails:

	echo "$the_commit commit refs/remotes/origin/master" >expect &&
	(
		cd rw/testrepo &&
		git for-each-ref refs/remotes/origin
	) >actual &&
	test_cmp expect actual

Hope that helps,

Jonathan Nieder (3):
  push test: use test_config where appropriate
  push test: simplify check of push result
  push test: rely on &&-chaining instead of 'if bad; then echo Oops; fi'

 t/t5516-fetch-push.sh | 156 +++++++++++++++++++++-----------------------------
 1 file changed, 65 insertions(+), 91 deletions(-)
