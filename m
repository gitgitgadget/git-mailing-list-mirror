From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: [PATCH 2/2] post-receive-email: defend against non UTF-8
 i18n.logoutputencoding setting
Date: Wed, 14 Mar 2012 23:36:09 +0400
Message-ID: <20120314233609.04a2a37b@zappedws>
References: <20120308115119.GA2604@burratino>
	<20120308115957.GB2750@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Gerrit Pape <pape@smarden.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Jensen <jon@endpoint.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 20:46:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7u9s-0003wg-To
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416Ab2CNTqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 15:46:48 -0400
Received: from fallback2.mail.ru ([94.100.176.87]:48367 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759505Ab2CNTqr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 15:46:47 -0400
X-Greylist: delayed 631 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Mar 2012 15:46:47 EDT
Received: from smtp11.mail.ru (smtp11.mail.ru [94.100.176.85])
	by fallback2.mail.ru (mPOP.Fallback_MX) with ESMTP id 286939E32805
	for <git@vger.kernel.org>; Wed, 14 Mar 2012 23:36:37 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=MlFgrKozwvHiexHvIuqsv/kB9Z4ifIZNitRtZj2hQHU=;
	b=TQNkT9tPe5dOTLZG7dpIA4nIf5GGq7xgYDiaU2uOQxPyoBFfKCH1qjCgH8pAIWD4J/l9j1jGS7dtftMepI2trSzOLk0a1O8rnxP1eJ9ObjuRryCdTi7cEvNnIIdS33Xm;
Received: from [91.77.41.216] (port=57416 helo=zappedws)
	by smtp11.mail.ru with esmtps (envelope-from <zapped@mail.ru>)
	id 1S7tza-0007Wj-SK; Wed, 14 Mar 2012 23:36:15 +0400
In-Reply-To: <20120308115957.GB2750@burratino>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193156>

I'd like to remind then following aspect
> My proposition was in to send email message in explicitly defined
> custom encoding. Why? In development process under Windows non-UTF-8
> encoding is used (cp1251 in my case). So, filenames have this
> encoding, and as we know Git stores their names as is - in cp1251 -
> without a conversion. And filenames are also used in diff-stat (with
> core.quotepath= false, BTW, I did not take into account this config)
> without any conversion. So if we'll make all text in UTF-8 but
> filenames are still non-UTF-8, email would look corrupted.
this is citation from 
http://thread.gmane.org/gmane.comp.version-control.git/181737/focus=183076

> Johannes Sixt wrote:
> > Am 9/20/2011 12:42, schrieb Shumkin Alexey:
> 
> >> 1. post-send-mail uses description file of a repo
> >> 2. gitweb also uses this file and AFAIK it assumes one to be in
> >> UTF-8 (I do not know whether it can be changed there but I tested
> >> gitweb once long time ago)
> >> 3. So if i18n.logoutputencoding is not UTF-8 we get a message
> >> composed with mixed encodings. This fact oblidge us to encode
> >> headers (as quoted printable at least) and synchronize body
> >> message that contain repo description (in UTF-8) and diffstat (in
> >> i18n.logoutputencoding).
> [...]
> > In this case, it may make sense to have a separate setting, but you
> > should call git like this:
> >
> >    git -c "i18n.logoutputencoding=$emailcharset" show ...
> >    git -c "i18n.logoutputencoding=$emailcharset" rev-list
> > --pretty ...
> 
> Something like this, I suppose?
> 
> This teaches post-receive-email to use plumbing where possible and to
> explicitly declare what encoding it expects output to use.
> 
> Based on an advice from Alexey Shumkin and Johannes Sixt, but all bugs
> are mine.  Making the email charset configurable is left as an
> exercise for the interested reader.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  contrib/hooks/post-receive-email |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/contrib/hooks/post-receive-email
> b/contrib/hooks/post-receive-email index dc184d0b..b59e03cd 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -464,7 +464,7 @@ generate_delete_branch_email()
>  	echo "       was  $oldrev"
>  	echo ""
>  	echo $LOGBEGIN
> -	git show -s --pretty=oneline $oldrev
> +	git diff-tree --encoding=UTF-8 -s --pretty=oneline $oldrev
>  	echo $LOGEND
>  }
>  
> @@ -540,11 +540,11 @@ generate_atag_email()
>  		# performed on them
>  		if [ -n "$prevtag" ]; then
>  			# Show changes since the previous release
> -			git rev-list --pretty=short
> "$prevtag..$newrev" | git shortlog
> +			git shortlog --encoding=UTF-8
> "$prevtag..$newrev" else
>  			# No previous tag, show all the changes
> since time # began
> -			git rev-list --pretty=short $newrev | git
> shortlog
> +			git shortlog --encoding=UTF-8 "$newrev"
>  		fi
>  		;;
>  	*)
> @@ -564,7 +564,7 @@ generate_delete_atag_email()
>  	echo "       was  $oldrev"
>  	echo ""
>  	echo $LOGBEGIN
> -	git show -s --pretty=oneline $oldrev
> +	git diff-tree --encoding=UTF-8 -s --pretty=oneline $oldrev
>  	echo $LOGEND
>  }
>  
> @@ -610,7 +610,7 @@ generate_general_email()
>  	echo ""
>  	if [ "$newrev_type" = "commit" ]; then
>  		echo $LOGBEGIN
> -		git show --no-color --root -s --pretty=medium $newrev
> +		git diff-tree --encoding=UTF-8 --root -s
> --pretty=oneline $newrev echo $LOGEND
>  	else
>  		# What can we do here?  The tag marks an object that
> is not @@ -629,7 +629,7 @@ generate_delete_general_email()
>  	echo "       was  $oldrev"
>  	echo ""
>  	echo $LOGBEGIN
> -	git show -s --pretty=oneline $oldrev
> +	git diff-tree --encoding=UTF-8 -s --pretty=oneline $oldrev
>  	echo $LOGEND
>  }
>  
