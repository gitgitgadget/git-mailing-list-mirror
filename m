From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-am: create a config setting for reject control.
Date: Thu, 28 Oct 2010 21:11:48 -0500
Message-ID: <20101029021148.GC28984@burratino>
References: <1288315650-2488-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 04:12:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBeRn-0008Ue-2J
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 04:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757142Ab0J2CL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 22:11:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40111 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab0J2CL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 22:11:56 -0400
Received: by gyg4 with SMTP id 4so1698507gyg.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 19:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fqiuHdIGZ5TRqQrFk10c4e+5+4uGQKQLeWl6Rz09xQk=;
        b=vzfyz72qRi+sjAwqvKQ/QRkTIrbeGmF8iJkBA3tmjUibC190sJM8vC4sqFvclUqyFc
         lQq+hCRAsDSq+mIPeBsk5y1XxZ1zeUIu/kTKwsD9SWFtpce034Rg2y1KnMlUCU4TpdbW
         6gXogU6TPvaJGyJt2WvYW/sj662pesAb5SWjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jCksQuBGasIL4COxpmeWzQh5JutXwrcmXR0BG1Ngcmv+xl+8AqShsqV3RXX379HA++
         99V4aalA2/sI6fGeH23jXyFEmi3aWXqsNtarYQl0Id+we632U5IJEgI7iSU4Fwjzj/PP
         sIgwTqUPRimu7xABMn7BkENtUYYFK8sRHT8VI=
Received: by 10.90.91.16 with SMTP id o16mr3602995agb.173.1288318315037;
        Thu, 28 Oct 2010 19:11:55 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m46sm1274615yha.44.2010.10.28.19.11.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 19:11:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288315650-2488-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160262>

Paul Gortmaker wrote:

>             This adds a config option for it, and a --no-reject
> so that you can manually override it.

Documentation?  (to put in Documentation/config.txt)  A test or two
would be nice, too --- see 6d8d8e0d for example.

[...]
> +++ b/git-am.sh
> @@ -306,6 +307,11 @@ then
>      keepcr=t
>  fi
>  
> +if test "$(git config --bool --get am.reject)" = true
> +then
> +    reject=t
> +fi

Something like the following is tempting, but I suspect "git rebase"
already copes.  Another potential test. :)

Hope that helps.
Jonathan

diff --git a/git-am.sh b/git-am.sh
index 43a510f..b9fdb5a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -307,10 +307,7 @@ then
     keepcr=t
 fi
 
-if test "$(git config --bool --get am.reject)" = true
-then
-    reject=t
-fi
+reject=config
 
 while test $# != 0
 do
@@ -378,6 +375,17 @@ do
 	shift
 done
 
+if test "$reject" = config
+then
+	if test "$rebasing" != t &&
+	   "$(git config --bool --get am.reject)" = true
+	then
+		reject=t
+	else
+		reject=
+	fi
+fi
+
 if test "$reject" = t
 then
 	git_apply_opt="$git_apply_opt --reject"
