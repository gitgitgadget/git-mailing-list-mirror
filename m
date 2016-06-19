Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A6C20189
	for <e@80x24.org>; Sun, 19 Jun 2016 01:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbcFSBtb (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 21:49:31 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:59312 "EHLO
	homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154AbcFSBta (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 21:49:30 -0400
X-Greylist: delayed 101288 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jun 2016 21:49:30 EDT
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id 2C18C25006C;
	Sat, 18 Jun 2016 18:49:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
	:subject:from:to:cc:date:in-reply-to:references:content-type
	:mime-version:content-transfer-encoding; s=novalis.org; bh=LEFlt
	LrUkeX8ic2OeNS0CjBPYng=; b=Jkwy/dMqEs8oI7+CQaOGxSiglrtn6FOFzmo0Y
	SyXvBskC2y6rFrgy4NdtdTe7rSLcZoADLAO1np42zRWee7KWcZKkjzz59RS0OvuX
	JMrsWpxFSF89Begiyyl3WynbSCq2RiqzATBF3fmCb1MQ7GI7FdR4WuPM04WEVdBe
	+W50IM=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id B514E25006B;
	Sat, 18 Jun 2016 18:49:29 -0700 (PDT)
Message-ID: <1466300967.28660.9.camel@frank>
Subject: Re: [PATCH] pathspec: prevent empty strings as pathspecs
From:	David Turner <novalis@novalis.org>
To:	Emily Xie <emilyxxie@gmail.com>
Cc:	git@vger.kernel.org
Date:	Sat, 18 Jun 2016 21:49:27 -0400
In-Reply-To: <20160619005704.1771-1-emilyxxie@gmail.com>
References: <20160619005704.1771-1-emilyxxie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, 2016-06-18 at 20:57 -0400, Emily Xie wrote:
> For any command that takes a pathspec, passing an empty string will
> execute the command on all files in the current directory. This
> results in unexpected behavior. For example, git add "" adds all
> files to staging, while git rm -rf "" recursively removes all files
> from the working tree and index. This patch prevents such cases by
> throwing an error message whenever an empty string is detected as a
> pathspec.
> 
> Signed-off-by: Emily Xie <emilyxxie@gmail.com>
> Reported-by: David Turner <novalis@novalis.org>
> Mentored-by: Michail Denchev <mdenchev@gmail.com>
> Thanks-to: Sarah Sharp <sarah@thesharps.us> and James Sharp <jamey@minilop.net>
> ---

Overall, lgtm.

The reason for this behavior is that, generally, traversals start at
some tree, and if there are no elements in the pathspec, the recursion
ends with that tree. Because this is a UX issue, fixing it at the
pathspec level seems correct to me.


>  pathspec.c     | 6 +++++-
>  t/t3600-rm.sh  | 4 ++++
>  t/t3700-add.sh | 4 ++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/pathspec.c b/pathspec.c
> index c9e9b6c..11901a2 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -402,8 +402,12 @@ void parse_pathspec(struct pathspec *pathspec,
>  	}
>  
>  	n = 0;
> -	while (argv[n])
> +	while (argv[n]) {
> +		if (*argv[n] == '\0') {
> +			die("Empty string is not a valid pathspec.");
> +		}

nit: git style doesn't use {} on one-statement ifs.  

>  		n++;
> +	}
>  
>  	pathspec->nr = n;
>  	ALLOC_ARRAY(pathspec->items, n);
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index d046d98..1d7dc79 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -791,6 +791,10 @@ test_expect_success 'setup for testing rm messages' '
>  	git add bar.txt foo.txt
>  '
>  
> +test_expect_success 'rm files with empty string pathspec' '
> +  test_must_fail git rm ""
> +'
> +

Maybe check the error message here?

