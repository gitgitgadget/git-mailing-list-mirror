From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase -m: skip cherry-picked commits more reliably
Date: Tue, 23 Nov 2010 22:03:13 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1011232156510.17721@debian>
References: <1290467372-6487-1-git-send-email-Knut.Franke@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Knut Franke <Knut.Franke@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 24 04:03:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL5dX-00061G-QJ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 04:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610Ab0KXDDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 22:03:05 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52408 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab0KXDDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 22:03:04 -0500
Received: by qwb7 with SMTP id 7so319566qwb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 19:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=gUhBCp3n5eIoR+pZkuR/Q9hOQ6/6dzfvSf7LBwBPw0s=;
        b=uHZ0S3bLCX1fBnN0zl0ihUb2w5yHsg8//vF5ty8AAtDZcoraWlWqhupuvrRgH2/2Nj
         oAUo3QYm5MUggm8b9GxvI/cNPdZTJSesIwIiqKc4vyURIQ8V2c20wGoRFkHxlX3C9JHg
         pA5ZicFdgtYTxfpBu2G7dWxezSTdyvxNksPWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=jVAm6zrN9k5BCIC8tDZWwstm7aLfbvt7LPShoS4ria4wDaVXjbqRrn5x5WUb5DkDop
         LY83oGcBbw8/0+wj1Lhvc0GSABj+y+sdOYWZGeLCZEJ/NQOCEVPAmSjf3IsFXxcsJd5f
         a3GENX0bVdc56tocSPiWwK1T88fOQrCm2pLDI=
Received: by 10.229.109.213 with SMTP id k21mr7022960qcp.69.1290567781107;
        Tue, 23 Nov 2010 19:03:01 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id nb14sm4099121qcb.12.2010.11.23.19.03.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 19:03:00 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <1290467372-6487-1-git-send-email-Knut.Franke@gmx.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162041>



On Tue, 23 Nov 2010, Knut Franke wrote:

> Unlike ordinary and interactive rebase, rebase -m halts with a conflict
> if two conflicting patches have been applied to both source and target
> branch (e.g. by cherry-picking). Fix this by using git rev-list
> --cherry-pick to generate the list of patches to apply.

I think the idea is sound, but...

Until I saw your patch I had not thought about the impact of the
--cherry-pick option (thanks!). I think there is a bug in the existing
rebase code related to it when rebase is used with the --onto option.

I will try to explain how I think it currently works.

Let's say we have the below history, where E is a cherry-pick of e.

      .-c
     /
a---b---d---e---f
         \
          .-g---E


If we now run 'git rebase --onto c f E', the revisions that will be
applied onto 'c' are given by 'git format-patch
--ignore-if-in-upstream f..E'. In this case that would be only 'g' and
NOT 'E'.

What I think we really want to do is to remove any patches in
upstream..branch that also exist in branch..onto. I don't know how to
do that efficiently, though. (And am I even right about it?)

I think this may be quite a serious bug, since it might go unnoticed
that a patch was dropped. If the <upstream> ref is later removed, the
patch might be completely gone from history without the user noticing.


If the above is correct, is it better to fix that problem first before
applying your patch? On the other hand, your patch does not really
make things worse (except for duplicating the buggy code)...

With the current implementation, my patch in
http://thread.gmane.org/gmane.comp.version-control.git/161381/ would
also make things worse when there are cherry-picks between <upstream>
and <branch>. The above should be fixed before I re-submit.


> 
> Also adapt t3406 a) to catch this case and b) not to expect
> "Already applied" messages which can't be emitted easily if duplicates
> are removed already when storing the patches.
> 
> Signed-off-by: Knut Franke <Knut.Franke@gmx.de>
> ---
>  git-rebase.sh             |   29 +++++++++++++++++++----------
>  t/t3406-rebase-message.sh |   14 +++++++-------
>  2 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 10a238a..aa42744 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -552,15 +552,14 @@ then
>  	exit 0
>  fi
>  
> -if test -n "$rebase_root"
> -then
> -	revisions="$onto..$orig_head"
> -else
> -	revisions="$upstream..$orig_head"
> -fi
> -
>  if test -z "$do_merge"
>  then
> +	if test -n "$rebase_root"
> +	then
> +		revisions="$onto..$orig_head"
> +	else
> +		revisions="$upstream..$orig_head"
> +	fi
>  	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
>  		--src-prefix=a/ --dst-prefix=b/ \
>  		--no-renames $root_flag "$revisions" |
> @@ -587,11 +586,21 @@ echo "$orig_head" > "$dotest/orig-head"
>  echo "$head_name" > "$dotest/head-name"
>  echo "$GIT_QUIET" > "$dotest/quiet"
>  
> +if test -n "$rebase_root"
> +then
> +	revisions="$onto...$orig_head"
> +else
> +	revisions="$upstream...$orig_head"
> +fi
> +
>  msgnum=0
> -for cmt in `git rev-list --reverse --no-merges "$revisions"`
> +for cmt in `git rev-list --reverse --no-merges --cherry-pick "$revisions"`
>  do
> -	msgnum=$(($msgnum + 1))
> -	echo "$cmt" > "$dotest/cmt.$msgnum"
> +	if test $(git merge-base "$cmt" "$orig_head") = "$cmt"
> +	then
> +		msgnum=$(($msgnum + 1))
> +		echo "$cmt" > "$dotest/cmt.$msgnum"
> +	fi
>  done
>  
>  echo 1 >"$dotest/msgnum"
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 85fc7c4..41cb039 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -5,8 +5,10 @@ test_description='messages from rebase operation'
>  . ./test-lib.sh
>  
>  quick_one () {
> -	echo "$1" >"file$1" &&
> -	git add "file$1" &&
> +	fileno=$2
> +	test -z "$fileno" && fileno=$1
> +	echo "$1" >"file$fileno" &&
> +	git add "file$fileno" &&
>  	test_tick &&
>  	git commit -m "$1"
>  }
> @@ -16,21 +18,19 @@ test_expect_success setup '
>  	git branch topic &&
>  	quick_one X &&
>  	quick_one A &&
> -	quick_one B &&
> +	quick_one B A &&
>  	quick_one Y &&
>  
>  	git checkout topic &&
>  	quick_one A &&
> -	quick_one B &&
> +	quick_one B A &&
>  	quick_one Z &&
>  	git tag start
>  
>  '
>  
>  cat >expect <<\EOF
> -Already applied: 0001 A
> -Already applied: 0002 B
> -Committed: 0003 Z
> +Committed: 0001 Z
>  EOF
>  
>  test_expect_success 'rebase -m' '
> -- 
> 1.7.3.2
> 
> 
