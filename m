From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Escape file:// URL's to meet subversion SVN::Ra
 requirements
Date: Wed, 2 Nov 2011 13:20:38 -0500
Message-ID: <20111102182015.GA11401@elie.hsd1.il.comcast.net>
References: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Wed Nov 02 19:20:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLfQn-00049o-2M
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 19:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab1KBSUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 14:20:51 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65077 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab1KBSUv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 14:20:51 -0400
Received: by ggnb2 with SMTP id b2so413505ggn.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZBlo1zGded17vwxiWAW6vZKSZPBjf3Jyw1BoOCtE77Q=;
        b=uqitdLLr3kGdSDeNVm2068xXiGJ5HgHiDKC052AFY7doT2khtx0gPV2oq5a+jewGJc
         eBMVmtd+aH2/rg9UEV8htKHmYmYzRzMK8CAcF2k4HZ3NeA0SCppEheX8ueFwuif89MpZ
         zwXf+PFkcbYZxKWoNvteZhvQ0htnFl86XcIAQ=
Received: by 10.236.129.82 with SMTP id g58mr2166055yhi.54.1320258049284;
        Wed, 02 Nov 2011 11:20:49 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k3sm9473683ann.0.2011.11.02.11.20.46
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Nov 2011 11:20:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184653>

Hi,

Ben Walton wrote:

> After a colleague reported this problem to the subversion list, it
> was determined that the problem is in git, not svn.[1]  The SVN code
> expects URL's and paths to be pre-escaped.

Thanks for your work on this!  I'm not really sure how one can decide
that the problem is not in svn --- some existing functions changed ABI
in such a way as to break existing applications and require code
changes and a recompile.  It would be better for Subversion to
silently fix up paths provided by bad callers, or at least to return a
sensible error code.

So the problem is that nobody who cared was testing prereleases of
subversion and reporting bugs early enough for it to get this fixed
before the 1.7 release.  But yes, that's water under the bridge and
git-svn (and libsvn-perl, and pysvn, and ...) should just adjust to
the new world order.

> [1] http://news.gmane.org/gmane.comp.version-control.subversion.devel

Do you mean
http://thread.gmane.org/gmane.comp.version-control.subversion.devel/132250
?

> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> ---
>  git-svn.perl |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Sounds sensible in principle, though I haven't checked the patch in
detail.  When I run "make test" with svn 1.7 with this patch applied,
I get the following result, unfortunately:

| expecting success: 
|         git svn clone -s "$svnrepo" g &&
|         (
|                 cd g &&
|                 test x`git rev-parse --verify refs/remotes/trunk^0` = \
|                      x`git rev-parse --verify refs/heads/master^0`
|         )
|
| Initialized empty Git repository in /home/jrn/src/git2/t/trash directory.t9145-git-svn-master-branch/g/.git/
| Using higher level of URL: file:///home/jrn/src/git2/t/trash directory.t9145-git-svn-master-branch/svnrepo => file:///home/jrn/src/git2/t/trash%20directory.t9145-git-svn-master-branch/svnrepo
| svn-remote.svn: remote ref '///home/jrn/src/git2/t/trash directory.t9145-git-svn-master-branch/svnrepo/trunk:refs/remotes/trunk' must start with 'refs/'
|
| not ok - 2 git svn clone --stdlayout sets up trunk as master
| #
| #               git svn clone -s "$svnrepo" g &&
| #               (
| #                       cd g &&
| #                       test x`git rev-parse --verify refs/remotes/trunk^0` = \
| #                            x`git rev-parse --verify refs/heads/master^0`
| #               )
| #
|
| # failed 1 among 2 test(s)
| 1..2
| make[3]: *** [t9145-git-svn-master-branch.sh] Error 1

Does it work for you?  This is with a merge of git 1.7.8-rc0 and 1.7.7.2.
