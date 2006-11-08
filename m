X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] clear error message for clone a gitweb URL
Date: Wed, 08 Nov 2006 12:42:22 -0800
Message-ID: <7v7iy5sma9.fsf@assigned-by-dhcp.cox.net>
References: <4551864D.3010301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 20:42:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31157>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhuFf-0004xZ-Nq for gcvg-git@gmane.org; Wed, 08 Nov
 2006 21:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423685AbWKHUmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 15:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423688AbWKHUmZ
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 15:42:25 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:5053 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1423685AbWKHUmY
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 15:42:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061108204223.RTUB20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 15:42:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kLiU1V00Y1kojtg0000000; Wed, 08 Nov 2006
 15:42:29 -0500
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

Liu Yubao <yubao.liu@gmail.com> writes:

> When clone a gitweb URL, git reports "Can't lock ref", it's not clear for users,
> this patch adds clear error message for this case.
>
> diff --git a/fetch.c b/fetch.c
> index c426c04..40c5183 100644
> --- a/fetch.c
> +++ b/fetch.c
> @@ -266,6 +266,14 @@ int pull(int targets, char **target, con
>  		if (!write_ref || !write_ref[i])
>  			continue;
>  
> +		if (*write_ref[i] == '\0') {
> +			if (strncmp(write_ref_log_details, "http", 4) == 0)
> +				error("Can't feed empty ref, seems you are fetching from a gitweb URL, "
> +				      "check it in web browser for git URL.");
> +			else
> +				error("Can't feed empty ref");
> +			goto unlock_and_fail;

You might have got that error by feeding an URL for gitweb, but
I do not think the code, even with your additions, knows enough
to tell that the user's mistake isn't other kinds of errors.

I am afraid that it would cause the user to waste time going
wild goose chase if you say "seems you are...".  The phrasing
makes it sound as if the tool _knows_ with some certainty that
it is more plausible cause of the error than other kinds, while
it certainly doesn't.

I think the reason it does not notice the breakage much earlier
is that git-clone does not notice that gitweb URL gives nonsense
to requests to "http://host/gitweb.cgi/$project/info/refs", so
your patch to git-clone.sh is probably touching the right place,
but I still feel the wording is a bit too strong and definitive
than it should be.

Perhaps...

diff --git a/git-clone.sh b/git-clone.sh
index 3f006d1..7ae69d9 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -46,15 +46,18 @@ Perhaps git-update-server-info needs to
 	do
 		name=`expr "z$refname" : 'zrefs/\(.*\)'` &&
 		case "$name" in
-		*^*)	continue;;
-		esac
+		*^*)	continue ;;
+		'')	false ;;
+		esac &&
 		if test -n "$use_separate_remote" &&
 		   branch_name=`expr "z$name" : 'zheads/\(.*\)'`
 		then
 			tname="remotes/$origin/$branch_name"
 		else
 			tname=$name
-		fi
+		fi || {
+			die "info/refs has nonsense $sha1 $refname, are you pulling from the right repository URL?"
+		}
 		git-http-fetch -v -a -w "$tname" "$name" "$1/" || exit 1
 	done <"$clone_tmp/refs"
 	rm -fr "$clone_tmp"


