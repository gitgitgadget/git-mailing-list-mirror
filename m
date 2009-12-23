From: Sam Vilain <sam@vilain.net>
Subject: Re: Regression: git-svn clone failure
Date: Wed, 23 Dec 2009 13:09:05 +1300
Message-ID: <4B315FA1.1060902@vilain.net>
References: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com> <20091222192115.GA10313@dcvr.yhbt.net> <B82A784D-C8D7-4DDF-AE63-390C7AE1CC2D@apple.com> <1261516416.23944.44.camel@denix> <B39991E2-D632-4FD5-B5DA-0B6B502BBFC8@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 01:09:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNEmz-0002qu-Fu
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 01:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbZLWAJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 19:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbZLWAJK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 19:09:10 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:43994 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbZLWAJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 19:09:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 0516C31C7A;
	Wed, 23 Dec 2009 13:09:06 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0VHXgRJLlJQq; Wed, 23 Dec 2009 13:09:05 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 3021031BF7;
	Wed, 23 Dec 2009 13:09:05 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <B39991E2-D632-4FD5-B5DA-0B6B502BBFC8@apple.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135608>

Andrew Myrick wrote:
> This makes perfect sense now.  Thank you for clarifying.  Unfortunately, I don't think the patch you provided will help my particular problem.  Allow me to elaborate.
>
> As I mentioned before, my project's integration model is to create a separate branch for every change.  Specifically, we create a branch from a recent internal tag.  So, the model for a simple bug fix looks something like this:
>
>             F---G  branch1
>           /           \
>         D  tag1  \    E  tag2
>        /                 \  /
> A---B                 C  trunk
>
> Revision B on trunk was tagged with tag1.  A bug was found in that version, so a branch was created from tag1, a fix was committed to the branch, and then the branch was merged back to trunk.  Finally, trunk is tagged with tag2.
>
> The "missing commit" messages show up when git svn fetch is fetching revision C.  It warns the there is a cherry-pick from branch1, and states that commits D and F are missing.  These commits are just copies, however; there is no code change.  The svn:mergeinfo property on trunk also only points at commit G.  Should git-svn be ignoring commits D and F, which are copy operations, not code changes?
>
> Also of note is that we very, very rarely cherry-pick commits, and never directly from a branch to trunk.  Branches are always integrated back to trunk in their entirety.
>   

Ok. Yes, I can see that. I guess what the code needs to do then is
figure out if the missing changes didn't touch the tree, and exclude
them if that happens.

in the check_cherry_pick function, try putting at the end something like;

for my $commit (keys %commits) {
if (has_no_changes($commit)) {
delete $commits{$commit};
}
}

Before the return. has_no_changes should be:

sub has_no_changes {
my $commit = shift;
# merges should always have no changes, but more
# importantly $commit~1 won't be defined for them, so
# don't proceed if that is the case.
my $num_parents = split / /, command_oneline(
qw(rev-list --parents -1 -m), $commit,
);
return 0 if $num_parents > 1;
return (command_oneline("rev-parse", "$commit^{tree}")
eq command_oneline("rev-parse", "$commit~1^{tree}"));
}

has_no_changes should also be memoized. Cherry picking a single commit
from a large unrelated branch will be slow (using cat-file --batch could
help here, but that's not something I can hack out off the cuff like
this), the first time, then it will remember whether particular commits
have changes or not.

Good luck,
Sam
