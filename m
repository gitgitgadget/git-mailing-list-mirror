From: Andrew Myrick <amyrick@apple.com>
Subject: Re: Regression: git-svn clone failure
Date: Tue, 22 Dec 2009 15:50:12 -0800
Message-ID: <B39991E2-D632-4FD5-B5DA-0B6B502BBFC8@apple.com>
References: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com> <20091222192115.GA10313@dcvr.yhbt.net> <B82A784D-C8D7-4DDF-AE63-390C7AE1CC2D@apple.com> <1261516416.23944.44.camel@denix>
Mime-Version: 1.0 (Apple Message framework v1130)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 00:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNEUn-0004yi-JM
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 00:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZLVXuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 18:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbZLVXuQ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 18:50:16 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:63877 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbZLVXuO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 18:50:14 -0500
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out3.apple.com (Postfix) with ESMTP id B09B87DDD90E;
	Tue, 22 Dec 2009 15:50:12 -0800 (PST)
X-AuditID: 11807136-b7bafae000000e8d-a5-4b315b347291
Received: from agility.apple.com (agility.apple.com [17.201.24.116])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay15.apple.com (Apple SCV relay) with SMTP id B5.5D.03725.43B513B4; Tue, 22 Dec 2009 15:50:12 -0800 (PST)
In-Reply-To: <1261516416.23944.44.camel@denix>
X-Mailer: Apple Mail (2.1130)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135607>


On Dec 22, 2009, at 1:13 PM, Sam Vilain wrote:

> On Tue, 2009-12-22 at 11:38 -0800, Andrew Myrick wrote:
>> Worked like a charm; the fetch is proceeding now.  Thanks, Eric!
>> 
>> Do you know what the "svn cherry-pick ignored" warnings mean, and if it's
>> something I should be concerned about?  This particular project is missing
>> up to 65 commits at some revisions.
> 
> With git, merge parent relationships imply (conceptually, anyway) that
> all of the changes reachable from that branch are included in the
> commit.  If someone is doing cherry-picking, then they are specifically
> excluding some commits, so adding a merge parent to that branch isn't
> right.  This is what the warning is saying.  It's happening every commit
> because that section of code doesn't know whether a mergeinfo record is
> new or not.
> 
> This wasn't happening with the old code, because it was simply not
> detecting them correctly and adding merge parents anyway.

This makes perfect sense now.  Thank you for clarifying.  Unfortunately, I don't think the patch you provided will help my particular problem.  Allow me to elaborate.

As I mentioned before, my project's integration model is to create a separate branch for every change.  Specifically, we create a branch from a recent internal tag.  So, the model for a simple bug fix looks something like this:

            F---G  branch1
          /           \
        D  tag1  \    E  tag2
       /                 \  /
A---B                 C  trunk

Revision B on trunk was tagged with tag1.  A bug was found in that version, so a branch was created from tag1, a fix was committed to the branch, and then the branch was merged back to trunk.  Finally, trunk is tagged with tag2.

The "missing commit" messages show up when git svn fetch is fetching revision C.  It warns the there is a cherry-pick from branch1, and states that commits D and F are missing.  These commits are just copies, however; there is no code change.  The svn:mergeinfo property on trunk also only points at commit G.  Should git-svn be ignoring commits D and F, which are copy operations, not code changes?

Also of note is that we very, very rarely cherry-pick commits, and never directly from a branch to trunk.  Branches are always integrated back to trunk in their entirety.

-Andrew