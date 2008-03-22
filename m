From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Re: Recording cherry-picked commits
Date: Sat, 22 Mar 2008 17:37:33 +0100
Message-ID: <ae63f8b50803220937k78571fbdl1eeb60966ec7aa40@mail.gmail.com>
References: <ae63f8b50803210533n12645fb3w9a8be601c4cc394@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 17:38:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd6ja-0004ph-Ub
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 17:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbYCVQhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 12:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbYCVQhg
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 12:37:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:56844 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbYCVQhf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 12:37:35 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2587789fkr.5
        for <git@vger.kernel.org>; Sat, 22 Mar 2008 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=lu1SYmlcTKX4gVsbhEUV3SWq/Pn0mVFFAVbJ/Bu/4zk=;
        b=PWt6vStIPrGFvFWCYaz9EWgcXfH8zCHqCHR24kHQnZqpEJZt8Rp4aHhgEwPR5a3FM0eDJZqoirt3fmgyin+AjOYu6JsvcawE6x3old36bVTe1YTHPGosnJGLIWV5AZp5zQ7NTB7SeEkXOx6TIDJjIAncNvCWQfT6Fnz5eFfvBg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=plwO3T4CXLMGymyROvDmDJvLg6B4vGfWkObdLaPk47s+i/iNZVF6/fnMLM/jXx34LuBBpXhiQ4GseTRlO0DO1K+5huX9JXgdsxGzSpnRkF42VuJiDwzK4jGLQy01We7PyjQe3uUWvohpeWsN3v7yHq3CsdlTru6paBZUuCEDVN0=
Received: by 10.78.138.14 with SMTP id l14mr8205461hud.63.1206203853975;
        Sat, 22 Mar 2008 09:37:33 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Sat, 22 Mar 2008 09:37:33 -0700 (PDT)
In-Reply-To: <ae63f8b50803210533n12645fb3w9a8be601c4cc394@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 13f3f496f186f2b1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77822>

What about using a hidden ".gitcherry" file in the current branch to
store the commits that have been applied?  With the simple shell
scripts below I'm able to achieve the same effect as svnmerge:


Wrapper around git-cherry-pick:
------------------------------------------------------------------------
#! /bin/sh -e

# Write the commit in .gitcherry, stage .gitcherry for commit and call
# git-cherry-pick.  If a conflict occurs, resolve it and invoke this script with
# --continue, in order to commit with the original author and commit message

if test "$1" = "--continue" ; then
    cont=1
    commit=$(tail -1 .gitcherry)
else
    cont=0
    commit=$1
fi

if test $cont = 0 ; then
    echo $commit >> .gitcherry
    git add .gitcherry
    git cherry-pick $commit
else
    git commit -c $commit
fi
-------------------------------------------------------------------------


Wrapper around git-cherry:
------------------------------------------------------------------------
#! /bin/sh -e

# List all commits with git-cherry and exclude all the ones that are specified
# in .gitcherry.  For each commit, invoke 'git show' to print the commit message

for commit in $(git-cherry $* | sed -ne 's/^+ //p' | grep -v -f .gitcherry) ; do
    git show -s --pretty=format:"%H %s" $commit
done
------------------------------------------------------------------------

WDYT?
-- 
Jean-Baptiste Quenot
http://caraldi.com/jbq/blog/
