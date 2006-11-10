X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: shallow clone failed git pull
Date: Fri, 10 Nov 2006 11:28:27 +0530
Message-ID: <45541503.4020604@gmail.com>
References: <4552A865.5000201@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030101040605040004020101"
NNTP-Posting-Date: Fri, 10 Nov 2006 05:59:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type;
        b=Gufh1nZ5LO4uGBAwspHz5daNc3Z7Hr+HvTQn8T+77JRKUJ0jvlwOF/UmE6tAgJylo1gPDLlGwYn9+92N/iGyFPcF4GiRXoKtY7tPH5fo60jkh91xkXzNTK99GzVsverbS/PicPnBagCjq3kQ+IpI11ztEPogCt5IPJ+AgB5y+gM=
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
In-Reply-To: <4552A865.5000201@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31204>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiPPd-0007DT-Cr for gcvg-git@gmane.org; Fri, 10 Nov
 2006 06:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161051AbWKJF6o (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 10 Nov 2006
 00:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966086AbWKJF6o
 (ORCPT <rfc822;git-outgoing>); Fri, 10 Nov 2006 00:58:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:26899 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966046AbWKJF6n
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2006 00:58:43 -0500
Received: by ug-out-1314.google.com with SMTP id m3so442483ugc for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 21:58:42 -0800 (PST)
Received: by 10.78.48.16 with SMTP id v16mr2179587huv.1163138322176; Thu, 09
 Nov 2006 21:58:42 -0800 (PST)
Received: from ?217.172.219.183? ( [156.153.255.234]) by mx.google.com with
 ESMTP id 39sm2549906hug.2006.11.09.21.58.39; Thu, 09 Nov 2006 21:58:42 -0800
 (PST)
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------030101040605040004020101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Aneesh Kumar K.V wrote:
> I was using the pu branch i tried to update the git repository and i got 
> this error.
> 
> alk 9e950efa20dc8037c27509666cba6999da9368e8
> walk 3b6a792f6ace33584897d1af08630c9acc0ce221
> * refs/heads/origin: fast forward to branch 'master' of 
> http://repo.or.cz/r/linux-2.6
>  old..new: 3d42488..088406b
> Auto-following refs/tags/v2.6.19-rc5
> shallow clone with http not supported
> 
> 
> This repository was not cloned with -depth. I only updated the git tools 
> using the pu branch
> 

The attached patch gets it working. I am not sure whether the fix is the right one. I 
am a little bit confused regarding the $depth being incremented. 

-aneesh

--------------030101040605040004020101
Content-Type: text/x-patch;
 name="git-fetch.sh.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-fetch.sh.diff"

diff --git a/git-fetch.sh b/git-fetch.sh
index 8b46e73..6459994 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -21,7 +21,7 @@ update_head_ok=
 exec=
 upload_pack=
 keep=
-depth=
+depth=0
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -304,7 +304,7 @@ fetch_main () {
       # There are transports that can fetch only one head at a time...
       case "$remote" in
       http://* | https://* | ftp://*)
-	  test -n "$depth" && die "shallow clone with http not supported"
+	  [ x"$depth" != x0 ] && die "shallow clone with http not supported"
 	  proto=`expr "$remote" : '\([^:]*\):'`
 	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 	      curl_extra_args="-k"
@@ -325,7 +325,7 @@ fetch_main () {
 	      print "$u";
 	  ' "$head")
 	    head=$(curl -nsfL $curl_extra_args $noepsv_opt "$remote/$remote_name_quoted")
-	    depth=$( expr \( $depth + 1 \) )
+	   # depth=$( expr \( $depth + 1 \) )
 	  done
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
 	      die "Failed to fetch $remote_name from $remote"
@@ -333,7 +333,7 @@ fetch_main () {
 	  git-http-fetch -v -a "$head" "$remote/" || exit
 	  ;;
       rsync://*)
-	  test -n "$depth" && die "shallow clone with rsync not supported"
+	  [ x"$depth" != x0 ] && die "shallow clone with http not supported"
 	  TMP_HEAD="$GIT_DIR/TMP_HEAD"
 	  rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
 	  head=$(git-rev-parse --verify TMP_HEAD)

