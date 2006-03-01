From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Wed, 01 Mar 2006 10:59:10 +0000
Message-ID: <tnx1wxmig75.fsf@arm.com>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
	<20060227222600.GA11797@spearce.org>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 11:59:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEP3b-0008T7-EX
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 11:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWCAK7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 05:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWCAK7n
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 05:59:43 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:23426 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S964913AbWCAK7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 05:59:42 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k21AxFuc002196;
	Wed, 1 Mar 2006 10:59:15 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Wed, 1 Mar 2006 10:59:15 +0000
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060227222600.GA11797@spearce.org> (Shawn Pearce's message of
 "Mon, 27 Feb 2006 17:26:00 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 01 Mar 2006 10:59:15.0169 (UTC) FILETIME=[2E004D10:01C63D1F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16971>

Shawn Pearce <spearce@spearce.org> wrote:
> Karl Hasselstr?m <kha@treskal.com> wrote:
>> If I make a patch series where more than one patch touches the same
>> line, I get a lot of merge errors when upstream has accepted them and
>> I try to merge them back.
>
> When pg grabs its (possibly remote) parent ("stg pull" aka pg-rebase)
> we try to push down PatchA.  If PatchA fails to push cleanly we'll
> pop it off and try to push PatchA + PatchB.  If that pushes cleanly
> then we fold the content of PatchA into PatchB, effectively making
> PatchA part of PatchB.  If PatchA + PatchB failed to push down
> cleanly then we pop both and retry pushing PatchA + PatchB + PatchC.

How do you solve the situation where only PatchA, PatchC and PatchE
were merged, B and D still pending? Trying combinations of patches is
not a good idea.

As I said, if you have a big number of patches this might be pretty
slow. Have a look at my patch for trying the reversed patches in
reverse order. It seems to solve this problem for most of the
cases. There are cases when this method would fail like adjacent
changes made by third-party patches that break the context of the git
patches and git-apply would fail. An addition to this would be to try
a diff3 merge with the reversed patch but I don't think it's worth
since it would become much slower.

> If that pushes down cleanly then we make PatchA and PatchB officially
> part of PatchC.

I don't agree with this. For example, patches A, B and C change the
same line in file1 but patch A also changes file2 and patch B changed
file3. With your approach, merging A+B+C succeeds and you make A and B
part of C and hence move the changed to file2 and file3 in patch C.

The above can happen when the maintainer only merges part of the patch
or simply decides to merge patch C only and manually solve the
conflict in file1 (since patch C is based on the context from patches
A+B).

-- 
Catalin
