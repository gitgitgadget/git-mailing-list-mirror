From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git submodule -b ... of current HEAD fails
Date: Wed, 8 Dec 2010 17:45:08 -0600
Message-ID: <20101208234508.GB8865@burratino>
References: <20101201171814.GC6439@ikki.ethgen.de>
 <20101201185046.GB27024@burratino>
 <4CF80B71.3010309@web.de>
 <7vipz5nqd0.fsf@alter.siamese.dyndns.org>
 <4CFFFA05.6070609@web.de>
 <4D001292.3020503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>, mlevedahl@gmail.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 09 00:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQTmV-0005GL-Dy
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 00:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab0LHXue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 18:50:34 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36212 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab0LHXud (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 18:50:33 -0500
Received: by qwa26 with SMTP id 26so1900208qwa.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 15:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mCzwe6OEJvzcHGbD094Eaqd8QerJqR5QFBEbhUnN3xc=;
        b=wozMp3517bwjtKPOlq5A9BnHOqxbz3ma4je/Wjsa/0vqyS/yMJyXDaO9jm6WvVqP50
         krvtKJUAmqDV+o8mJdyxwl13vaYG9JzeR4k9abLa/U7JOkzRlhN+I1kfJm1eEakb+z5X
         UwJok6mLA2LYmwE1uQJptrOe5fO7fVOHo+kr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=deIyTaN2FdN8oxedti8KQtE4xk3ZNnuiUnRtaCbAsbzVlpmbe+S+V435RWqR5okOYN
         Osib9i/Kw8KDazHzteb8+hWADCrQArM3B6seolMGsy7MK5FA6lnx3HsbCXu2C3kOgVxj
         0rJB2xw7JepUCbuIQkTTi17jLXwfkRoeWnuHY=
Received: by 10.229.247.68 with SMTP id mb4mr7463028qcb.151.1291851921822;
        Wed, 08 Dec 2010 15:45:21 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id k15sm715551qcu.11.2010.12.08.15.45.19
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 15:45:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D001292.3020503@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163244>

Jens Lehmann wrote:
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -241,7 +241,9 @@ cmd_add()
>  			# ash fails to wordsplit ${branch:+-b "$branch"...}
>  			case "$branch" in
>  			'') git checkout -f -q ;;
> -			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
> +			?*) if [ "$(git branch)" != "* $branch"  ]; then

Agh.  The command to use is "git symbolic-ref -q HEAD", I suppose.

Maybe we can simplify by relying on "git clone".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-submodule.sh           |   16 ++++++----------
 t/t7400-submodule-basic.sh |    8 +++++++-
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d937f0b..6fd09e7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -219,17 +219,13 @@ cmd_add()
 		esac
 		git config submodule."$path".url "$url"
 	else
-
-		module_clone "$path" "$realrepo" "$reference" || exit
+		brancharg=${branch:+"-b $(git rev-parse --sq-quote "$branch")"}
+		refarg=${reference:+"$(git rev-parse --sq-quote "$reference")"}
 		(
-			clear_local_git_env
-			cd "$path" &&
-			# ash fails to wordsplit ${branch:+-b "$branch"...}
-			case "$branch" in
-			'') git checkout -f -q ;;
-			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
-			esac
-		) || die "Unable to checkout submodule '$path'"
+			export realrepo path &&
+			eval "git clone $brancharg $refarg" '"$realrepo" "$path"'
+		) ||
+		die "Clone of '$realrepo' into submodule path '$path' failed"
 	fi
 
 	git add $force "$path" ||
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2c49db9..77088cc 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -114,7 +114,6 @@ test_expect_success 'submodule add --branch' '
 	echo "refs/heads/initial" >expect-head &&
 	cat <<-\EOF >expect-heads &&
 	refs/heads/initial
-	refs/heads/master
 	EOF
 	>empty &&
 
@@ -131,6 +130,13 @@ test_expect_success 'submodule add --branch' '
 	test_cmp empty untracked
 '
 
+test_expect_success 'submodule add --branch succeeds even when branch is at HEAD' '
+	(
+		cd addtest &&
+		git submodule add -b master "$submodurl" submod-existing-branch
+	)
+'
+
 test_expect_success 'submodule add with ./ in path' '
 	echo "refs/heads/master" >expect &&
 	>empty &&
