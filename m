From: Mark Allen <mrallen1@yahoo.com>
Subject: Re: [COGITO PATCH] Fix cg-log and cg-status for non-GNU sed/sort
Date: Mon, 30 May 2005 18:19:25 -0700 (PDT)
Message-ID: <20050531011925.94043.qmail@web41213.mail.yahoo.com>
References: <20050529234911.GZ1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 03:18:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcvNP-0003eE-Uw
	for gcvg-git@gmane.org; Tue, 31 May 2005 03:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVEaBTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 21:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVEaBTf
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 21:19:35 -0400
Received: from web41213.mail.yahoo.com ([66.218.93.46]:18786 "HELO
	web41213.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261854AbVEaBT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 21:19:28 -0400
Received: (qmail 94045 invoked by uid 60001); 31 May 2005 01:19:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ai51VYQYwLyV+GfqYTlOcGEE4HXSD/M/BiAxRMB+vtXngK/7ATVBrR0HJzA/6vtnnxmZdcLU9YHmh9y4aU2LJxAlcO5Lw2+ayaFX4cibAVYA3NxQFm68z3ZlfN8H8JLSj6DendC1Zyb63F2zf4DwEjaLMB0bXytil+pNYAnYJ1U=  ;
Received: from [209.98.144.212] by web41213.mail.yahoo.com via HTTP; Mon, 30 May 2005 18:19:25 PDT
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050529234911.GZ1036@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--- Petr Baudis <pasky@ucw.cz> wrote:
> I think we don't really need -r anyway. Could you please try with the
> 'i' flag instead of 'I'? (The manpage is somewhat unclear on the
> difference and portability.) Also, could you try if it works with the
> newlines?

I tried with an i\ which is what the sed on Darwin wants, and it didn't work very well...
so, I just removed the I and i\ and that worked pretty nicely. I shaved off the -r and
made for a simpler patch.

I also added $has_gnudate to cg-Xlib and modified the logic in showdate to use the
appropriate command depending on whether $has_gnudate is true or false.

Finally, I stripped the -z from sort because it seems to do the right thing anyway
without it and it makes the sort on Darwin unhappy.

Anyway, here's another try, this against the tip of the most recent cogito tree.

---

Modify cg-log, cg-Xlib and cg-status for non-GNU sed, sort and date.

Signed-off-by: Mark Allen <mrallen1@yahoo.com>

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -42,9 +42,13 @@ mktemp () {
 showdate () {
        date="$1"
        sec=${date[0]}; tz=${date[1]}
-       dtz=${tz/+/}
-       lsec=$(expr $dtz / 100 \* 3600 + $dtz % 100 \* 60 + $sec)
-       pdate="$(date -Rud "1970-01-01 UTC + $lsec sec" 2>/dev/null)"
+       if [ ! "$has_gnudate" ]; then 
+               pdate="$(date -u -r ${date[0]} 2>/dev/null)"
+       else
+               dtz=${tz/+/}
+               lsec=$(expr $dtz / 100 \* 3600 + $dtz % 100 \* 60 + $sec)
+               pdate="$(date -Rud "1970-01-01 UTC + $lsec sec" 2>/dev/null)"
+       fi
 
        echo "${pdate/+0000/$tz}"
 }
@@ -137,3 +141,4 @@ fi
 
 export BROKEN_MKTEMP=1
 del=$($(which mktemp) -t 2>/dev/null) && { rm $del; export BROKEN_MKTEMP=; }
+has_gnudate=$(date -Rud "1970-01-01 UTC" 2>/dev/null)
diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -190,8 +190,7 @@ $revls | $revsort | while read time comm
                                date=(${rest#*> })
                                pdate="$(showdate $date)"
                                if [ "$pdate" ]; then
-                                       echo -n $color$key $rest | sed "s/>.*/> 
$pdate/"
-                                       echo $coldefault
+                                       echo -n $color$key $rest | sed "s/>.*/> 
$pdate$coldefault/"
                                else
                                        echo $color$key $rest $coldefault
                                fi
@@ -208,9 +207,9 @@ $revls | $revsort | while read time comm
                                if [ -n "$list_files" ]; then
                                        list_commit_files "$tree1" "$tree2"
                                fi
-                               echo; sed -re '
-                                       / *Signed-off-by:.*/Is//'$colsignoff'&'$
coldefault'/
-                                       / *Acked-by:.*/Is//'$colsignoff'&'$colde
fault'/
+                               echo; sed -e '
+                                       / *Signed-off-by:.*/s//'$colsignoff'&'$c
oldefault'/
+                                       / *Acked-by:.*/s//'$colsignoff'&'$coldef
ault'/
                                        s/./    &/
                                '
                                ;;
diff --git a/cg-status b/cg-status
--- a/cg-status
+++ b/cg-status
@@ -41,7 +41,7 @@ fi
 
 {
        git-ls-files -z -t --others --deleted --unmerged $EXCLUDE
-} | sort -z -k 2 | xargs -0 sh -c '
+} | sort -k 2 | xargs -0 sh -c '
 while [ "$1" ]; do
        tag=${1% *};
        filename=${1#* };
