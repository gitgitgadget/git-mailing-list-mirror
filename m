From: Mark Allen <mrallen1@yahoo.com>
Subject: Re: [COGITO PATCH] Fix cg-log and cg-status for non-GNU sed/sort
Date: Sun, 29 May 2005 16:43:26 -0700 (PDT)
Message-ID: <20050529234326.12407.qmail@web41203.mail.yahoo.com>
References: <20050529231652.GX1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 01:41:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXP3-0000aR-HO
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVE2Xng (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVE2Xng
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:43:36 -0400
Received: from web41203.mail.yahoo.com ([66.218.93.36]:37483 "HELO
	web41203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261403AbVE2Xn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:43:27 -0400
Received: (qmail 12409 invoked by uid 60001); 29 May 2005 23:43:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=01RQQ8XEmT2LRst+BNaOvdNZ6lee8x+MDiRO8SGXP3L/sR6TGli3+9+OlnsPiVtR0Fv4JkdkJHy00hp+4YE+Xy5Lw9vtHyEZK090UsDfpW4+4CxAA5ai/kpWq+neDt7t0ZaqY7ZDUt213LqJuZIO3NQwXwQaOLpPiwfHzva6ejI=  ;
Received: from [66.41.38.150] by web41203.mail.yahoo.com via HTTP; Sun, 29 May 2005 16:43:26 PDT
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050529231652.GX1036@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--- Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Mon, May 30, 2005 at 01:00:10AM CEST, I got a letter
> where Mark Allen <mrallen1@yahoo.com> told me that...
> > -                               pdate="$(showdate $date)"
> > +                               pdate="$(date -u -r $date)"
> 
> Hmm, coudlnt' showdate be fixed instead then? And $date is not a file so
> -r $date makes no sense to me - what am I missing?

There is no showdate(1) command on Darwin.  On Darwin, the date(1) command flags are

-u (show UTC)
-r seconds 

So `date -u -r $date` gives output like "Sun May 29 12:07:55 GMT 2005" instead of
1117336545

> I'm lost on this one too. Why do you introduce the -n?

Since I used date(1) above, I get an extra newline now when the date string is printed
out. Using echo -n on the second echo stops that behavior. (This is perhaps a matter of 
taste; some people like lots of whitespace in headers, and some don't.)

> > -                               echo; sed -re '
> > -                                       /
> *Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
> > -                                       /
> *Acked-by:.*/Is//'$colsignoff'&'$coldefault'/
> > -                                       s/./    &/
> > -                               '
> > +                               echo; sed -e "/ *Signed-off-by:.*/s/
> *Signed-off-by:.*/$colsignoff&$coldefault/" -e"/
> > +*Acked-by:.*/s/ *Acked-by:.*/$colsignoff&$coldefault/" -e "s/./    &/"
> > +
> 
> Is it necessary to take away the newlines? What is the real problem,
> actually? Just the I flag?

Is it strictly necessary to take away the newlines? I don't know. To be honest, I didn't 
experiment too much with alternate implementations. But the I flag in the sed script, 
yes that is not understood by non-GNU sed. And the "-r" to sed itself is also
problematic.

> Could you please sign the patch off, and send it as text/plain or inline the
> message body?


Modify cg-log and cg-status to work with non-GNU sed, sort and date

Signed-off-by: Mark Allen <mrallen1@yahoo.com>
---
commit 7e8fbf87acead0ee83afc4647228efdad0bbae2e
tree 50acf8ce23fee4ca6c9493b5f5959093e7579c74
parent d36ed1fd011d349ea2adc00456750b5b3da3a9cd
author Mark Allen <mallen@aeris.local> 1117409841 -0500
committer Mark Allen <mallen@aeris.local> 1117409841 -0500

 cg-log    |   15 +++++++--------
 cg-status |    2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

Index: cg-log
===================================================================
--- 3a65f5fb53367c75f4f76aebed27a83d8679f068/cg-log  (mode:100755)
+++ 50acf8ce23fee4ca6c9493b5f5959093e7579c74/cg-log  (mode:100755)
@@ -148,10 +148,10 @@
                                fi
 
                                date=(${rest#*> })
-                               pdate="$(showdate $date)"
+                               pdate="$(date -u -r $date)"
                                if [ "$pdate" ]; then
-                                       echo -n $color$key $rest | sed "s/>.*/> $pdate/"
-                                       echo $coldefault
+                                       echo -n $color$key $rest | sed "s/>.*/> $pdate/" 
+                                       echo -n $coldefault
                                else
                                        echo $color$key $rest $coldefault
                                fi
@@ -168,11 +168,10 @@
                                if [ -n "$list_files" ]; then
                                        list_commit_files "$tree1" "$tree2"
                                fi
-                               echo; sed -re '
-                                       /
*Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
-                                       / *Acked-by:.*/Is//'$colsignoff'&'$coldefault'/
-                                       s/./    &/
-                               '
+                               echo; sed -e "/ *Signed-off-by:.*/s/
*Signed-off-by:.*/$colsignoff&$coldefault/" 
+                               -e"/ *Acked-by:.*/s/
*Acked-by:.*/$colsignoff&$coldefault/" 
+                               -e "s/./    &/"
+
                                ;;
                        *)
                                echo $colheader$key $rest $coldefault
Index: cg-status
===================================================================
--- 3a65f5fb53367c75f4f76aebed27a83d8679f068/cg-status  (mode:100755)
+++ 50acf8ce23fee4ca6c9493b5f5959093e7579c74/cg-status  (mode:100755)
@@ -15,7 +15,7 @@
 
 {
        git-ls-files -z -t --others --deleted --unmerged $EXCLUDE
-} | sort -z -k 2 | xargs -0 sh -c '
+} | sort -t '\0' -k 2 | xargs -0 sh -c '
 while [ "$1" ]; do
        tag=${1% *};
        filename=${1#* };
