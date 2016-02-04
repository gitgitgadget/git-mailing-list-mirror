From: Kevin Locke <kevin@kevinlocke.name>
Subject: Re: git stash save -u deletes ignored files without stashing them
Date: Wed, 3 Feb 2016 23:40:11 -0800
Message-ID: <20160204074011.GA25382@kevinolos>
References: <566D236D.5090904@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Brade <brade@kde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 08:49:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aREf0-0005Z7-TB
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 08:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbcBDHs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 02:48:59 -0500
Received: from praxis.kevinlocke.name ([205.185.125.39]:42573 "EHLO
	praxis.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcBDHs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 02:48:58 -0500
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Feb 2016 02:48:58 EST
Received: from kevinolos (unknown [IPv6:2001:470:b:136:3430:7a85:b863:24ac])
	(Authenticated sender: kevin@kevinlocke.name)
	by praxis.kevinlocke.name (Postfix) with ESMTPSA id 77C393120442;
	Thu,  4 Feb 2016 00:40:14 -0700 (MST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=kevinlocke.name;
	s=praxis; t=1454571614;
	bh=41gJRn9QLjkTEkNQC0df1YNjRVAZt0rqUVepo0DmX2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hVRx0943mh8lYwpshPYjkpqJkG0D+GleA7RurUFjnHZtXSBSVUtOyTnSrCFBFYruY
	 IlZ59EhtbxRfbjLqDdHwgokzvEXWEe3ZAP3arx6pIkepEOJ2M8k/ssyXx7h49RaXb+
	 HOc1xSGGynbzSo7QpADt+GB+il6scdnfijJKI03I=
Received: by kevinolos (Postfix, from userid 1000)
	id 78E3C4B0E3D; Wed,  3 Feb 2016 23:40:11 -0800 (PST)
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>, git@vger.kernel.org,
	Michael Brade <brade@kde.org>
Content-Disposition: inline
In-Reply-To: <566D236D.5090904@kde.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285403>

On Sun, 2015-12-13 at 7:51, Michael Brade wrote:
> Now node_modules will be deleted even though it was ignored at the time
> of the "git stash save -u". Apparently .gitignore is reverted first,
> then the cleanup is done taking the new state of .gitignore into account
> where node_modules is now untracked and not ignored anymore, thus
> deleting it.

Another effect of this, although obviously less severe, is that it can
create a stash which can not be applied without additional work:

git init
echo test.txt > .gitignore
git add .gitignore
git commit -m init
echo stuff > test.txt
echo > .gitignore
git stash -u

At this point the stash contains test.txt (untracked) and the changes
to .gitignore which unignore the file, but test.txt is also left in
the working directory.  Attempting to apply the stash produces the
following result:

$ git stash apply
test.txt already exists, no checkout
Could not restore untracked files from stash

So the user must remove it themselves, which can be confusing since
the file is not listed in `git stash show`, which doesn't include
untracked files.

Kevin

P.S.  Please CC me on replies.  Thanks!
