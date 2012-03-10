From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Stop a git commit by a specific author using pre-commit hook
Date: Sat, 10 Mar 2012 13:41:18 -0600
Message-ID: <4F5BAE5E.5030407@gmail.com>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adrian Cornish <git@bluedreamer.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 20:41:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6SAU-0000iQ-3A
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 20:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab2CJTlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 14:41:23 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41491 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab2CJTlV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 14:41:21 -0500
Received: by mail-yw0-f46.google.com with SMTP id m54so1642012yhm.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 11:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sBS8fhoClLjbQuGIXLKA4AIM1HC97swa9QE7C1GvFx0=;
        b=bhjSzoaDKr7zbPOHN3saFGrkN5d3FJMrGLGone5JJ5xavxtUEOHL1BT+H5bKUJNGz9
         6BaB27PHzUlM2W67eq9rVi+EsBmve1sjjHGTXhAQZK+cSargPWMSdCp46Q6bgNWWg7Ae
         Td2dRRhwo0bvVvp+26cMw7Vl3MEAwngUIBSmTa+AnjwXTgISxCVX3opKdVKtOgRZWDpa
         bUyFcc3KXCTu1AZSyN1BtUwE8PwfrivjQIsrBJyE+XRfxTkjoa9/FGxK610u+N98aZkf
         XuYJGLGBNkJC7QMQAhSnMw+fZb9hAMLfWGcfRoOj+eMIMYL3DN7F1pFTwadubhjPbIPQ
         20jg==
Received: by 10.60.29.72 with SMTP id i8mr2628930oeh.1.1331408480833;
        Sat, 10 Mar 2012 11:41:20 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id 4sm5334959oex.0.2012.03.10.11.41.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 11:41:19 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192785>

On 3/8/2012 7:15 PM, Adrian Cornish wrote:
> My plan is to use git to keep track of changes in /etc but when
> committing I want to have the person making the change specify
> themselves as author by adding the --author option on the commandline.
>
> So I would like to stop accidental commits as root.
>
> I tried creating this pre-commit hook but it is not working - git var
> is still returning root even if I specify the author on commit line.
>
> AUTHOR=`git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/\1/p'`
> if [ "$AUTHOR" == "root<root@localhost>" ];
> then
>     echo "Please commit under your own user name instead of \"$AUTHOR\":"
>     echo 'git commit --author="Adrian"'
>     echo "or if your name is not already in logs use full ident"
>     echo 'git commit --author="Adrian Cornish<a@localhost>"'
>     exit 1
> fi
> exit 0

We use whoami in our pre-commit hook to see who the user is that is 
doing the commit.  I think you could also use GIT_COMMITTER_NAME or 
linux $USER environment variables.  Either way, the --author seems like 
an unnecessary and unreliable way to get the username.  You're relying 
on the user to remember or obey that step.  By doing --author, you also 
seem to be implying that the git commit author value may not be the same 
as the user doing the commit so that would also ruin the original commit 
author data audit trail.  I haven't used these particular git 
environment variables, but I suspect they are dependent upon the user 
having their gitconfig filled out properly, so the linux whoami and 
$USER are probably more reliable.  If people can su to root then $USER 
will not work because it will still be set to their original user name 
(before they did su to root).  Therefore, "whoami" seems like your best 
solution.

v/r,
neal
