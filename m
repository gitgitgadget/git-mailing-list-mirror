X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Only warn about missing branch.<n>.merge in pull.
Date: Mon, 18 Dec 2006 12:06:01 +0100
Message-ID: <8aa486160612180306s38c83b17qc3fddf087ccd0460@mail.gmail.com>
References: <20061218091206.GA11284@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 11:06:10 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lt4ffSr+hkwwzkdh6tPKotQGl90ePVOR7KgAwyjeciJrTHQq28VC84K97z4sQ2MbJtYdudD+aHAfNHB8I81+6Wrg47xoenwhVnC3zxI3PxXvwTam52usAhtH+2kdNmcvo2bhNt8PU7VZ+0m3/1NlQfmF4WULesrtR6zJYLp99UA=
In-Reply-To: <20061218091206.GA11284@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34737>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwGJt-0005p6-EP for gcvg-git@gmane.org; Mon, 18 Dec
 2006 12:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753824AbWLRLGG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 06:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbWLRLGF
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 06:06:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:25873 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753824AbWLRLGE (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec
 2006 06:06:04 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1350797wxd for
 <git@vger.kernel.org>; Mon, 18 Dec 2006 03:06:02 -0800 (PST)
Received: by 10.70.66.18 with SMTP id o18mr7237541wxa.1166439961949; Mon, 18
 Dec 2006 03:06:01 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Mon, 18 Dec 2006 03:06:01 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On 12/18/06, Shawn O. Pearce <spearce@spearce.org> wrote:
> Commit 62b339a5 added a warning for git-pull to notify the user when
> they have not configured the setting 'branch.<n>.merge' (where <n>
> is the current branch) and no arguments were given to git-pull to
> specify the branches to merge.
>
> Unfortunately this warning also appears in git-fetch when no
> arguments were supplied, as the warning is being output at the
> same time that the contents of FETCH_HEAD is being determined.
> This causes users who fetch into local tracking branches prior
> to merging to receive unexpected/unnecessary warnings:
>
>   $ git fetch
>   Warning: No merge candidate found because value of config option
>            "branch.sp/topic.merge" does not match any remote branch fetched.
>
> This warning may also cause problems for other Porcelain that use
> git-fetch as "plumbing", as the other Porcelain may not actually
> use (or honor) the branch.<n>.merge configuration option.
>
> Instead we should delay the warning about no matching branches until
> we are actually in git-pull and are trying to setup the call to
> git-merge to actually carry out the merge.  This way direct users
> of git-fetch do not receive these warnings.
>

I think it is a sensible thing to do, but:

[...]

> diff --git a/git-pull.sh b/git-pull.sh
> index e23beb6..d43a565 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -76,7 +76,21 @@ merge_head=$(sed -e '/       not-for-merge   /d' \
>
>  case "$merge_head" in
>  '')
> -       echo >&2 "No changes."
> +       echo >&2 "warning: No branches were selected for merge."
> +       if test $# = 0
> +       then
> +               branch=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
> +               remote=$(git-repo-config --get-all "branch.$branch.remote")

There is only support for one branch.<n>.remote.

> +               if test -z "$remote"
> +               then
> +                       echo >&2 "warning: (Config option 'branch.$branch.remote' not set.)"

It is OK not to have a branch.<n>.remote, it defaults to origin.

> +               fi
> +               merge=$(git-repo-config --get-all "branch.$branch.merge")
> +               if test -z "$merge"
> +               then
> +                       echo >&2 "warning: (Config option 'branch.$branch.merge' not set.)"
> +               fi
> +       fi

I don't like the (), and it's missing the other possibility:

else
   echo >&2 "Warning: config option 'branch.$branch.merge' does not
match any remote branch fetched."

Also we could check that the number of to be merge branches equals to
the number of branch.<n>.merge (I'll do it).

