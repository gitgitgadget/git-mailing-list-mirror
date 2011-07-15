From: Phil Hord <hordp@cisco.com>
Subject: Re: rerere affects handling of git-stash-pop merge conflicts
Date: Fri, 15 Jul 2011 16:19:37 -0400
Message-ID: <4E20A0D9.4030404@cisco.com>
References: <4E1F22DF.7060209@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 22:19:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhorS-0002UI-Nv
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 22:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388Ab1GOUTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 16:19:41 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:55295 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab1GOUTk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 16:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=3730; q=dns/txt;
  s=iport; t=1310761180; x=1311970780;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=DhINMOqiLV4TQRRCFo1DtkkGM+16hpS1wrNdnrJ3B7U=;
  b=HO6jx6UNoqtXxSb2Qtw9BzKPcJTHgdFVBlZGfBg3PsDqSbQMuFwduFcv
   FpbR9/ObeJl6gAYZnT2+WOvd1Eth+qnC+k9cqTpEeu7Kfo8pqKZwP5KO2
   kGMo8TK+cSw3KMH0yHkZbHbphF+s0zDCIxVa0ygRNLPtwOFgkndAWxoOy
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqEFAFWgIE6Q/khR/2dsb2JhbABUp29wB60uniaGOgSSZoUBi24
X-IronPort-AV: E=Sophos;i="4.67,210,1309737600"; 
   d="scan'208";a="102636693"
Received: from ams-core-1.cisco.com ([144.254.72.81])
  by ams-iport-1.cisco.com with ESMTP; 15 Jul 2011 20:19:39 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by ams-core-1.cisco.com (8.14.3/8.14.3) with ESMTP id p6FKJcSP031481;
	Fri, 15 Jul 2011 20:19:38 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <4E1F22DF.7060209@cisco.com>
X-TagToolbar-Keys: D20110715161937679
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177224>

git rerere is misleading us after a conflicted 'git stash pop'.  There 
_is_ an unresolved merge conflict, but .git/MERGE_RR exists and is 
empty, even though there is no previously recorded resolution.
This causes git mergetool to skip over our conflicted file since he now 
uses 'git rerere remaining' to find the unresolved conflicts.

I think one of these is true, but I'm not sure which one.

   A. rerere _should not_ be triggered at all by "stash pop" conflicts
or
   B. rerere _should_ be correctly and completely triggered by "stash 
pop" conflicts
or
   C. 'git mergetool' should not be expected to work after a failed "git 
stash pop"

I'm hoping the right answer is B, but I would also accept A.

fwiw - 'git stash pop' calls 'merge-recursive' at the end, and this is 
where the problem appears.  I have not decoded git-merge-recursive's use 
there enough to figure out where it's gone wrong.

Phil


On 07/14/2011 01:09 PM, Phil Hord wrote:
> I was investigating a git-stash-pop anomaly when I ran across this one.
> I think this is residual breakage from [1] bb0a484 (mergetool: Skip
> autoresolved paths, 2010-08-17).  A similar problem aimed at 'git merge'
> was ostensibly fixed by [2] 2f59c9 (mergetool: don't skip modify/remove
> conflicts, 2011-02-16).
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/153420
> [2] http://thread.gmane.org/gmane.comp.version-control.git/164622
>
>
> Summary:
> After a 'git stash pop' with conflicts, 'git mergetool' fails to notice
> the conflicted files if 'rerere.enabled=true'.  git mergetool
> erroneously reports 'no files need merging'.
>
> After a 'git merge' with conflicts, 'git mergetool' seems to work ok in
> either case.
>
> Here's my test script:
>
> ------8<------ /tmp/stash.sh
> #!/bin/bash
>
> #enable/disable rerere for this test
> git config --global rerere.enabled ${1:false}
>
> # run the test
> rm -rf foo
> mkdir foo&&  cd foo&&  git init&&
> echo A>file&&  git add file&&  git commit --quiet -m "A"&&
> echo B>file&&  git stash&&
> echo C>file&&  git add file&&  git commit --quiet -m "C"&&
> git stash pop
>
> git mergetool
> ------8<------ /tmp/stash.sh
>
> git --version
>      git version 1.7.6.178.g55272
>
> # With rerere.enabled=false, it works ok (mergetool offers to
> # merge the conflicting file):
> ./stash.sh false
>
>      Initialized empty Git repository in /tmp/foo/.git/
>      Saved working directory and index state WIP on master: ac67a86 A
>      HEAD is now at ac67a86 A
>      Auto-merging file
>      CONFLICT (content): Merge conflict in file
>      merge tool candidates: meld opendiff kdiff3 tkdiff xxdiff
>      tortoisemerge gvimdiff diffuse ecmerge p4merge araxis bc3 vimdiff
>      emerge
>      Merging:
>      file
>
>      Normal merge conflict for 'file':
>        {local}: modified
>        {remote}: modified
>      Hit return to start merge resolution tool (xxdiff): ^C
>
> # But with rerere.enabled=true, mergetool thinks there is no conflict:
> ./stash.sh true
>
>      Initialized empty Git repository in /tmp/foo/.git/
>      Saved working directory and index state WIP on master: d40e77b A
>      HEAD is now at d40e77b A
>      Auto-merging file
>      CONFLICT (content): Merge conflict in file
>      merge tool candidates: meld opendiff kdiff3 tkdiff xxdiff
>      tortoisemerge gvimdiff diffuse ecmerge p4merge araxis bc3 vimdiff
>      emerge
>      No files need merging
>
> Phil
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
