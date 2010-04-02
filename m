From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: are hashes calculated from data
Date: Thu, 1 Apr 2010 22:50:06 -0400
Message-ID: <o2q32541b131004011950u6023ef29ocac1d80f2847ef6f@mail.gmail.com>
References: <g2veaacf13c1004011931w70695d1emdceeb977397aee0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Raymond Auge <raymond.auge@liferay.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 04:50:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxWy5-0005MY-GD
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 04:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759015Ab0DBCu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 22:50:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48880 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759070Ab0DBCu1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 22:50:27 -0400
Received: by gwaa18 with SMTP id a18so1182071gwa.19
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iB3lJZ7KrR54bWN83tHrtCJCi/ZMu181zhBAvmgIYGo=;
        b=CreQg3HrLEM4Y+wAI1hI9fwHwWqec+YQdb6H5VRLsJF1MlyRlgjWPEBZIeYroeKBes
         rsmFvU3EBkbeiag/xTRTgMoO0cltC0nM0kKOvbKlwoRh7dU8vYpCBnX6B91+cmAmazCe
         Oy8hFoF+lKh2bhZfXwJYgHbrSFC+ydPTCsSDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=six2K6qkKk6IxhVDUsf6slVt055qP8U8tb0MACtLUMnDDL59NqzxunI0OLlUxiBb04
         7o/oN2zcsXRyVEhDBs0YH1GGzsxDExlp7zMVpgLPbQj+NFVISBuxMSYL49sKMDlcICMF
         k4tTTsb72ENYntZ44/g1afR0vHvIe9VVli/fc=
Received: by 10.150.152.4 with HTTP; Thu, 1 Apr 2010 19:50:06 -0700 (PDT)
In-Reply-To: <g2veaacf13c1004011931w70695d1emdceeb977397aee0d@mail.gmail.com>
Received: by 10.150.254.7 with SMTP id b7mr2429498ybi.293.1270176626138; Thu, 
	01 Apr 2010 19:50:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143774>

On Thu, Apr 1, 2010 at 10:31 PM, Raymond Auge <raymond.auge@liferay.com=
> wrote:
> Given two separate git repositories initialized from the same
> subversion repository, if the hashes are calculated from the data
> alone, then those two repositories could theoretically pull/push
> branches from each other while retaining =A0the ability to commit bac=
k
> to the "origin" subversion repository.
>
> If this is in fact the case, it would make it quite simple for me to
> convince the more ambitious developers on our team to use git locally=
,
> and grow team usage in a passive, viral way.

This *almost* works.  The problem is 'git svn dcommit'.  It eats your
git-created commits, and generates *new* ones by committing back to
svn and then retrieving the newly-created commits.  It's essentially
the same as rebasing, which makes future git merges not really work.

You can minimize the impact of this problem, however.  The easiest way =
is:

- have only a single person use git-svn

- when committing stuff to git-svn, first checkout the *existing*
git-svn branch, then use "git merge --no-ff mybranch", then "git svn
dcommit".  The --no-ff is very important; this makes sure that a *new*
commit is created (a merge commit) for the svn dcommit.  svn dcommit
then creates only a single svn commit that includes all the patches
from the whole branch.

- then do 'git checkout mybranch; git merge git-svn' to get the svn com=
mit back.

At work, we have a cronjob that basically does most of these steps for
us.  Then there's a central git repo that corresponds to the svn repo;
people who want to use git can use that repo and not worry about
git-svn.

Hope this helps.

Have fun,

Avery
