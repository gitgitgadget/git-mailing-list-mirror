From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 11:23:45 -0700
Message-ID: <20130327182345.GD28148@google.com>
References: <20130327122216.5de0c336@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Wed Mar 27 19:24:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKv1G-0005o4-RP
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab3C0SXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:23:50 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34437 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab3C0SXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:23:49 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so708009pad.39
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 11:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fJAh1ZhXKTfFbKrZhhhRmxuyxKPXWsOOQm5soskonB0=;
        b=MFuYxyw6LPOiiFfbu7F0dMeK0PFz2+hJ2+qxAjKthur/+G5ah9moOYkSWGk2Pa5SdF
         mKNQ5OoRsqflPq7i/024aYBjClyd75y4Pj4APItrVvB6fNaaoPEjoEU9oO1JNHrxTF47
         eCXf20Hekfm/C8+pHyp5CTxt+ZjELAb3AoFV7YkoR9yitB2HLb42B2gcg8S90o6g0TYR
         2jd3Nhqar5fxCuCUXERQuRw1h5NapIbiLTLWrQuS75BoHk4DKzvxnqBlTn+n3pbgOJld
         QzkzxsQsSATTMGGySbbXF2sCgEHk9nWirGmzMVs2aWZwwNBxtWFt9kwGZrFf2//RZS0A
         55tA==
X-Received: by 10.66.172.36 with SMTP id az4mr31184614pac.103.1364408629459;
        Wed, 27 Mar 2013 11:23:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ky10sm7551483pab.23.2013.03.27.11.23.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 11:23:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130327122216.5de0c336@hoelz.ro>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219297>

Rob Hoelz wrote:

> --- a/remote.c
> +++ b/remote.c
> @@ -465,7 +465,11 @@ static void alias_all_urls(void)
>  		if (!remotes[i])
>  			continue;
>  		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
> -			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
> +			char *copy = xstrdup(remotes[i]->pushurl[j]);
> +			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites_push);
> +			if (!strcmp(copy, remotes[i]->pushurl[j]))
> +				remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
> +			free(copy);

Interesting.

Suppose I configure

	[url "git://anongit.myserver.example.com/"]
		insteadOf = myserver.example.com:
	[url "myserver:"]
		pushInsteadOf = myserver.example.com:

The above code would make the insteadOf rule apply instead of
pushInsteadOf, even when pushing.  Perhaps something like the
following would work?

			const char *url = remotes[i]->pushurl[j];
			remotes[i]->pushurl[j] = alias_url(url, &rewrites_push);
			if (remotes[i]->pushurl[j] == url)
				/* No url.*.pushinsteadof configuration matched. */
				remotes[i]->pushurl[j] = alias_url(url, &rewrites);

> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -244,6 +244,83 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
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
> +	test_config "url.file://$TRASH/ro/.insteadOf" ro: &&
> +	test_config "url.file://$TRASH/rw/.pushInsteadOf" rw: &&
> +	test_config remote.r.url ro:wrong &&
> +	test_config remote.r.pushurl rw:testrepo &&
> +	git push r refs/heads/master:refs/remotes/origin/master &&
> +	(
> +		cd rw/testrepo &&
> +		echo "$the_commit commit	refs/remotes/origin/master" > expected &&
> +		git for-each-ref refs/remotes/origin > actual &&
> +		test_cmp expected actual
> +	)

Looks good.  The usual style in git tests is to include no space
after >redirection operators:

		git for-each-ref refs/remotes/origin >actual &&

Hope that helps,
Jonathan
