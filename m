From: Brad King <brad.king@kitware.com>
Subject: Re: Move tags to branch
Date: Tue, 05 Oct 2010 13:29:22 -0400
Message-ID: <4CAB6072.2060407@kitware.com>
References: <AANLkTinzGy62ETZdry5y1qTi0djkt9d72_3soCP6K_Qn@mail.gmail.com> <m3mxqtfnrk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 19:29:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3BKZ-0003XX-3G
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 19:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368Ab0JER32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 13:29:28 -0400
Received: from public.kitware.com ([66.194.253.19]:35025 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab0JER32 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 13:29:28 -0400
Received: by public.kitware.com (Postfix, from userid 5001)
	id C25821B37A; Tue,  5 Oct 2010 13:29:26 -0400 (EDT)
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id 27B131B37A;
	Tue,  5 Oct 2010 13:29:23 -0400 (EDT)
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by hythloth (Postfix) with ESMTP id E2D03CE9;
	Tue,  5 Oct 2010 13:29:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100805 Icedove/3.0.6
In-Reply-To: <m3mxqtfnrk.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158217>

On 10/04/2010 09:10 PM, Jakub Narebski wrote:
> Mathieu Malaterre <mathieu.malaterre@gmail.com> writes:
> 
>>   I have been using svn2git to start using git. However svn2git
>> creates tags from HEAD instead of the branch. Is there a way to move
>> tags back to the branch ?
> 
> Isn't it by a chance caused by the fact that Subversion does not
> "enforce" tags to not change?

I've converted repositories with this problem before.  Subversion
"tags" are basically branches.  I usually manufacture a merge commit
to keep the tagged versions alive in history as close to inline as
possible.  For example, if the conversion result is

                      o----v2
                     /
  ...o----B----o----o----C----D  master
      \
       o----v1

because "tags" v1 and v2 have had a couple of commits, I manually
convert it to

                        o----v2
                       /      \
  ...o----B--B'--o----o----C---C'---D  master
      \      /
       o----v1

using git plumbing, grafts, and filter-branch.

B' has B as its first parent, v1 as its second parent, and the same
tree object as B.  Similarly for C', C, and v2.  The commit messages
for B' and C' explain that they were manufactured retroactively during
conversion.

Commits B and C were selected as the artificial "merge points" by
finding the newest commits in a first-parent traversal of master that
were not newer than v1 and v2, respectively.  The committer times for
B' and C' are taken from v1 and v2 (or a time shortly thereafter).

-Brad
