From: Daniel Serpell <daniel.serpell@gmail.com>
Subject: Re: [PATCH] Colorized git log
Date: Thu, 21 Apr 2005 21:04:16 -0400
Message-ID: <f0796bb7050421180433eeeb8@mail.gmail.com>
References: <3536.10.10.10.24.1114117965.squirrel@linux1>
	 <20050421224229.GR7443@pasky.ji.cz>
	 <f0796bb7050421174647943f0c@mail.gmail.com>
	 <20050422005452.GZ7443@pasky.ji.cz>
Reply-To: Daniel Serpell <daniel.serpell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 22 03:04:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOmZc-0005Wf-9f
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 03:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVDVBEZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 21:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVDVBEZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 21:04:25 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:49519 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261902AbVDVBER convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 21:04:17 -0400
Received: by wproxy.gmail.com with SMTP id 68so717826wri
        for <git@vger.kernel.org>; Thu, 21 Apr 2005 18:04:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y7PIwYKKQ+8MCeYrn6/xVMN+HRjBEZbMM/PMZDFP5Ohy6jIVr2IAoJAgY6kuOucmIlcvnYGkPWo8zBlw86KBXKANjg8whVyJWbbszKoivHUqa/6IgxX/feLh+sRQ74VmRqF67yvQ/jvfMHhxvLFf3HE8I2WmRbU1acUqDi79p7Q=
Received: by 10.54.15.76 with SMTP id 76mr197439wro;
        Thu, 21 Apr 2005 18:04:16 -0700 (PDT)
Received: by 10.54.18.62 with HTTP; Thu, 21 Apr 2005 18:04:16 -0700 (PDT)
To: GIT Mailing Lists <git@vger.kernel.org>
In-Reply-To: <20050422005452.GZ7443@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi!

On 4/21/05, Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Fri, Apr 22, 2005 at 02:46:19AM CEST, I got a letter
> where Daniel Serpell <daniel.serpell@gmail.com> told me that...
> >
> > This has two problems, solved in two patches:
> 
> could you please sign them off?

Ok, here are, resent (I suppose it's ok tho put all in one e-mail),
and with the comments added.

--------------
Strip space in front of colorized header lines.

Signed-off-by:  Daniel Serpell <daniel.serpell@gmail.com>

+++ b/gitlog.sh
@@ -27,7 +27,7 @@ fi
 base=$(gitXnormid.sh -c $1) || exit 1
 
 rev-tree $base | sort -rn | while read time commit parents; do
-	echo $colheader commit ${commit%:*} $coldefault;
+	echo $colheader""commit ${commit%:*} $coldefault;
 	cat-file commit $commit | \
 		while read key rest; do
 			case "$key" in
@@ -43,10 +43,10 @@ rev-tree $base | sort -rn | while read t
 				dtz=${tz/+/+ }; dtz=${dtz/-/- }
 				pdate="$(date -Rud "1970-01-01 UTC + $sec sec $dtz" 2>/dev/null)"
 				if [ "$pdate" ]; then
-					echo -n $color $key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"
+					echo -n $color$key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"
 					echo $coldefault
 				else
-					echo $color $key $rest $coldefault
+					echo $color$key $rest $coldefault
 				fi
 				;;
 			"")
@@ -56,7 +56,7 @@ rev-tree $base | sort -rn | while read t
 				'
 				;;
 			*)
-				echo $colheader $key $rest $coldefault
+				echo $colheader$key $rest $coldefault
 				;;
 			esac
 
--------------
Uses tput instead of setterm to set colors, seems to work with more
terminals.

Signed-off-by:  Daniel Serpell <daniel.serpell@gmail.com>

gitlog.sh: 6d24d857fb6c2f7e810954adaca1990599906f07
--- a/gitlog.sh
+++ b/gitlog.sh
@@ -11,11 +11,11 @@
 
 if [ "$1" = "-c" ]; then
 	shift
-	colheader=$(setterm -foreground green)
-	colauthor=$(setterm -foreground cyan)
-	colcommitter=$(setterm -foreground magenta)
-	colsignoff=$(setterm -foreground yellow)
-	coldefault=$(setterm -foreground default)
+	colheader="$(tput setaf 2)" # Green, see terminfo(5), "Color Handling"
+	colauthor="$(tput setaf 6)" # Cyan
+	colcommitter="$(tput setaf 5)" # Magenta
+	colsignoff="$(tput setaf 3)" # Yellow
+	coldefault="$(tput op)" # Restore default
 else
 	colheader=
 	colauthor=
