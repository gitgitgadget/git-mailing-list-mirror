X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch.sh printed protocol fix
Date: Wed, 25 Oct 2006 11:52:09 -0700
Message-ID: <7v4ptsb546.fsf@assigned-by-dhcp.cox.net>
References: <4ac8254d0610250303n60a6006bsa4d77aba7255485f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 18:52:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30092>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcnrK-0000bW-Et for gcvg-git@gmane.org; Wed, 25 Oct
 2006 20:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161115AbWJYSwL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 14:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWJYSwL
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 14:52:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:48630 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1030275AbWJYSwK
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 14:52:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025185210.RWIH18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 14:52:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eirs1V0181kojtg0000000 Wed, 25 Oct 2006
 14:51:53 -0400
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Sender: git-owner@vger.kernel.org

"Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:

> As a feature I wished for (ftp:// support in git-fetch) was added in 1.4.3
> I tested that feature and found a minor logging issue. The mini-patch
> below fixes that.  AFAIK the pattern expansion feature I've used should
> be available in any current /bin/sh. If not we will have to find another
> way to print the protocol part of the used fetch URL.

Yes, we also have supported https:// that way for a long time.

> --- git-core-1.4.3.2/git-fetch.sh	2006-10-24 07:29:47.000000000 +0200
> +++ git-core-1.4.3.2.tma/git-fetch.sh	2006-10-25 11:44:34.000000000 +0200
> @@ -310,7 +310,7 @@
> 	  done
>  	  expr "z$head" : "z$_x40\$" >/dev/null ||
> 	      die "Failed to fetch $remote_name from $remote"
> -	  echo >&2 Fetching "$remote_name from $remote" using http
> +	  echo >&2 Fetching "$remote_name from $remote" using ${remote%%:*}
> 	  git-http-fetch -v -a "$head" "$remote/" || exit
> 	  ;;
>       rsync://*)

As you noticed, we stayed away from using ${parameter#word} or
${parameter%word} substitutions so far, to be as compatible with
vanilla shells as possible (I know even dash which is pretty
much the most minimal supports it -- the syntax is in POSIX).  I
am a bit reluctant to take this implementation right now.  We
tend to use colon-form of "expr" for things like this.

It might make sense to do a survey of userbase at some point to
see if everybody's shell that works with the current set of
scripts understands the substring substitution, and after
finding it out switch many invocations of expr to substring
substitutions.

For now I'd take the patch but change it to match others to use
expr.

Next time around, please sign your patch.

-- >8 -- 
From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Date: Wed, 25 Oct 2006 12:03:06 +0200
Subject: [PATCH] git-fetch.sh printed protocol fix

We have supported https:// protocol for some time and in 1.4.3
added ftp:// protocol.  The transfer were still reported to be
over http.

[jc: Tuncer used substring parameter substitution ${remote%%:*}
 but I am deferring it to a later day.  We should replace
 colon-expr with substring substitution after everybody's shell
 can grok it someday, but we are not in a hurry. ]

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-fetch.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 79222fb..9eedf8b 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -287,6 +287,7 @@ fetch_main () {
       # There are transports that can fetch only one head at a time...
       case "$remote" in
       http://* | https://* | ftp://*)
+	  proto=`expr "$remote" : '\([^:]*\):'`
 	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 	      curl_extra_args="-k"
 	  fi
@@ -310,7 +311,7 @@ fetch_main () {
 	  done
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
 	      die "Failed to fetch $remote_name from $remote"
-	  echo >&2 Fetching "$remote_name from $remote" using http
+	  echo >&2 "Fetching $remote_name from $remote using $proto"
 	  git-http-fetch -v -a "$head" "$remote/" || exit
 	  ;;
       rsync://*)
-- 
1.4.3.2.gc1a4

