From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: How to commit incomplete changes?
Date: Thu, 15 Dec 2011 16:51:12 -0600
Message-ID: <4EEA79E0.4070700@gmail.com>
References: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Thu Dec 15 23:51:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbK93-0007CR-Qg
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 23:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668Ab1LOWvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 17:51:17 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46929 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606Ab1LOWvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 17:51:16 -0500
Received: by yenm11 with SMTP id m11so1821121yen.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 14:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=awTQu4f9AktgXJfQce+YyWtYIfQmLswOH4v2EnRs198=;
        b=c3O1QS7Zhwj8EXSGuIBqITbD+NAJ9IRX4iSx8pUPXLUuSYOh2bDaKi415ZTti+mU3W
         WJR0SBJnEO+3OwDDI73fTj/BuYW/zK0juahc1np4qmh7eAg/u3pgSuQfiRARf8dg1DZY
         Y+kELy/cSsozTkfIx4Xn6M9eD4fjQmEzK3tQg=
Received: by 10.236.180.227 with SMTP id j63mr8410996yhm.18.1323989475937;
        Thu, 15 Dec 2011 14:51:15 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id 39sm13864319ans.10.2011.12.15.14.51.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 14:51:15 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187251>

On 12/14/2011 5:24 PM, Hallvard B Furuseth wrote:
> Do people have any feelings or conventions for how and when to publish
> a series of commits where the first one(s) break something and the next
> ones clear it up? I've found some discussion, but with vague results.
>
> I'm about to commit some small edits which go together with bigger
> generated changes. It seems both more readable and more cherry-pick-
> friendly to me to keep these in separate commits.
>
> What I've found is I can use a line in the commit message like
> "Incomplete change, requires next commit (update foo/ dir)."
> and, if there is any point, do a no-ff merge past the breakage.
>
A main purpose for the squash and fixup options is (as Randall Schwartz 
put it in his git video http://www.youtube.com/watch?v=8dhZ9BXQgc4) "To 
make it look like you did it all perfectly without making any mistakes" 
(or a reasonable facsimile thereof).  You insights on the cherry-picking 
of fixes is interesting, but makes no sense in the context of 
unpublished work.  Why would you need to cherry-pick fixes to mistakes 
that have not yet been propagated (published)?  If the cherry-picks of 
fixes are for your other already merged local branches then just save 
the pre-squash/fixup version of the branch to another branch, (ie, git 
branch mybranch-b4-fixup) and cherry-pick from that unsquashed copy to 
patch up your other unpublished branches.  Keep in mind that cherry-pick 
is not alway the best way to apply fixes.  A merge or rebase to get the 
fix is the sign of a better workflow in many cases, TBOMK. On the other 
hand, if the bugs have been published then you have no choice but to 
commit the fix separately because you can't rearrage/edit published 
history.  Keep in mind that ideally commits should be logical.  You can 
use the rearrage feature of interactive rebase to squash fixes into the 
feature commit they go to. IOW, I don't think squashing everything into 
a giant commit just to consolidate bugfixes into a single commit makes 
sense if that would mean losing the distinct separation between 
differing feature commits.

I assume by 'generated changes' you mean the automerge in git that is a 
wonderful default for vast systems like the linux kernel in which code 
is unlikely to overlap logically, but very dangerous in legacy 
application systems where changes to the same file can create logical 
bugs despite not being on the 'exact same line of code'.  You are 
supposed to review all your merged files after a merge regardless. 
However, we don't trust ourselves that much in our shop so we force 
conflicts on same-file edits by making "user-date stamp" updates on 
"line 1" (depends on language-dependent comment line rules) in our 
pre-commit hook.  That way we are forced to manually review the merge of 
same-file edits "by hand" thus avoiding "generated results".  Of course, 
unique-file edits can still break things and thus a merge review is 
still in order.

Hope this helps.  I'm not a git workflow expert, but my comments are 
based on experience.  I too am still looking for better ways to manage 
workflow while leveraging the flexibity and agility of git for 
concurrent development.

v/r,
neal
