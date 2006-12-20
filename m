X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit  hooks
Date: Wed, 20 Dec 2006 13:47:05 +0000
Message-ID: <200612201347.13805.andyparkins@gmail.com>
References: <200612201309.02119.andyparkins@gmail.com> <45893AC6.910D5748@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 13:47:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aMz53iuaeTK7BYia+ON5NAb4vLIiHXqtZrwv4VhZgDUWN74ht4BHB/Bf3OYKaOfP0teWY7dtUVUVOONlpOAfxn1y0fu+99xrkBJu2/wfF9Ge2BdTcticJJDLh9cR0Z+X65ajTyoZYPZVW2vn9zpaja5ckMLvu7K0w4ovLQzPiLU=
User-Agent: KMail/1.9.5
In-Reply-To: <45893AC6.910D5748@eudaptics.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34928>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx1nI-0003Fc-8P for gcvg-git@gmane.org; Wed, 20 Dec
 2006 14:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965061AbWLTNrX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 08:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWLTNrX
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 08:47:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:59614 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S965062AbWLTNrW (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 08:47:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2231880uga for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 05:47:20 -0800 (PST)
Received: by 10.67.97.18 with SMTP id z18mr9395035ugl.1166622439994; Wed, 20
 Dec 2006 05:47:19 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id c1sm10646219ugf.2006.12.20.05.47.18; Wed, 20 Dec 2006 05:47:18 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 20 13:29, Johannes Sixt wrote:

> > +       cat "$GITMODULES" |
>
> useless-use-of-cat-syndrome

I tried 

 while
 do 
 done < file1 > file1

And that didn't work.  However, it was racy anyway using the same file, so I 
changed to as it is now, but forgot to switch back to input redirection.

diff --git a/git-commit.sh b/git-commit.sh
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 7718369..74edfe2 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -82,7 +82,6 @@ perl -e '
 WORKINGTOP=$(git-rev-parse --show-cdup)
 GITMODULES="${WORKINGTOP}.gitmodules"
 if [ -f "$GITMODULES" ]; then
-   cat "$GITMODULES" |
    while read subdir hash
    do
        # check if the line is a comment and output it anyway
@@ -101,7 +100,7 @@ if [ -f "$GITMODULES" ]; then
        # dirty
 
        echo "$subdir $(GIT_DIR=$WORKINGTOP$subdir/.git git-rev-parse HEAD)"
-   done > newgitmodules
+   done < "$GITMODULES" > newgitmodules
    # Update
    mv newgitmodules "$GITMODULES"

> > +       while read subdir hash
>
> Wouldn't it be better to have the order of subdir and hash swapped? That
> way subdir may contain blanks, and it gives nicer alignment in the file
> because of the constant length of the hashes.

Unfortunately, it is the hash that is optional.  When you create the file, you 
don't list the hashes, you list the subdirectories.  I suppose I could make 
it so you have to give "000000" or something first?



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
