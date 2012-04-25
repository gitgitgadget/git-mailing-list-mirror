From: Mathieu Boespflug <mboes@tweag.net>
Subject: git rebase interactive does not respect merge options
Date: Wed, 25 Apr 2012 12:53:10 -0400
Message-ID: <20120425165310.GA4806@santiago>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 18:54:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN5Ta-0003BN-FW
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 18:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647Ab2DYQxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 12:53:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60843 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab2DYQxw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 12:53:52 -0400
Received: by yhmm54 with SMTP id m54so293109yhm.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 09:53:52 -0700 (PDT)
Received: by 10.50.45.133 with SMTP id n5mr3503037igm.34.1335372832144;
        Wed, 25 Apr 2012 09:53:52 -0700 (PDT)
Received: from santiago ([216.252.87.5])
        by mx.google.com with ESMTPS id i7sm20707471igq.11.2012.04.25.09.53.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Apr 2012 09:53:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196322>

Hi,

I have the following issue with git rebase -i: it does not seem to
respect any merge options that I pass it.

Say I'm in the following scenario. I made a bunch of commits in master,
and I would like to interactively rebase these commits on top of
origin/master. Say I want to drop a few commits that introduced only
whitespace changes. Dropping these commits might cause conflicts during
rebasing of later commits, because these later commits might affect the
same lines than the ones that were affected by the whitespace change.
Now, to avoid having to resolve these conflicts by hand, I would expect
to be able to

$ git rebase -X ignore-space-change -i origin/master

According to git-rebase(1), passing -X implies --merge and
--strategy=recursive. But these flags seem to be ignored, even if
passed explicitly. Likewise, if I specify

$ git rebase -X ours -i origin/master

or

$ git rebase -X theirs -i origin/master

I still get conflicts, which I have to resolve by hand. Passing -p makes
no difference either.

A cursory look through the source of /usr/lib/git-core/git-rebase
suggests to me git-rebase forks to either git-rebase--merge or
git-rebase--interactive to do much of the work, the two being mutually
exclusive. If this is the case, shouldn't the documentation at least
reflect that one has to pass either --interactive or --merge on the
command line, but the two together won't work?

I submit, however, that being able to specify a merge strategy during
interactive rebasing is terribly useful. Not being able to do means that
to drop commits without having to resolve conflicts by hand I have to do
split my rebasing into chunks of non-interactive

$ git rebase -s <strategy> -X <strategy-option> --onto <newbase> <upstream>

... which is significantly more cumbersome.

Thanks,

-- Mathieu
