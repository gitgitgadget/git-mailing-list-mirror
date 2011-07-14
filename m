From: Phil Hord <hordp@cisco.com>
Subject: rerere affects handling of git-stash-pop merge conflicts
Date: Thu, 14 Jul 2011 13:09:51 -0400
Message-ID: <4E1F22DF.7060209@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 19:10:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhPQe-0003pu-T3
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 19:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130Ab1GNRKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 13:10:18 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:23562 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113Ab1GNRKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 13:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2390; q=dns/txt;
  s=iport; t=1310663417; x=1311873017;
  h=message-id:date:from:mime-version:to:cc:subject:
   content-transfer-encoding;
  bh=xRA6q7MF7KKGYf36+0zdXc6sQ76zbzSRYXHtZtADKnY=;
  b=bq5A67B0sUITfIenwe0luXeBajW3orSSiM3UFRPXjdQznuEJN6ikkiah
   dVu+MehU2iA+fkXD1WXyJdNsX2zSAjRlsqv9jxH8AkJfsiQJNf5G4a5KS
   aV3a0GGzHJb3JB2/ZymUdeD/Mec0vK5tHGcOv8uqHoQ0nC/c4OLWzzqtg
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtMGANghH06rRDoI/2dsb2JhbABTp1VwB6xRniOGOgSSZIUAi20
X-IronPort-AV: E=Sophos;i="4.65,530,1304294400"; 
   d="scan'208";a="2997462"
Received: from mtv-core-3.cisco.com ([171.68.58.8])
  by rcdn-iport-5.cisco.com with ESMTP; 14 Jul 2011 17:10:16 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by mtv-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id p6EHAFJD001106;
	Thu, 14 Jul 2011 17:10:15 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177134>

I was investigating a git-stash-pop anomaly when I ran across this one.
I think this is residual breakage from [1] bb0a484 (mergetool: Skip
autoresolved paths, 2010-08-17).  A similar problem aimed at 'git merge'
was ostensibly fixed by [2] 2f59c9 (mergetool: don't skip modify/remove
conflicts, 2011-02-16).

[1] http://thread.gmane.org/gmane.comp.version-control.git/153420
[2] http://thread.gmane.org/gmane.comp.version-control.git/164622


Summary:
After a 'git stash pop' with conflicts, 'git mergetool' fails to notice
the conflicted files if 'rerere.enabled=true'.  git mergetool
erroneously reports 'no files need merging'.

After a 'git merge' with conflicts, 'git mergetool' seems to work ok in
either case.

Here's my test script:

------8<------ /tmp/stash.sh
#!/bin/bash

#enable/disable rerere for this test
git config --global rerere.enabled ${1:false}

# run the test
rm -rf foo
mkdir foo && cd foo && git init &&
echo A>file && git add file && git commit --quiet -m "A" &&
echo B>file && git stash &&
echo C>file && git add file && git commit --quiet -m "C" &&
git stash pop

git mergetool
------8<------ /tmp/stash.sh

git --version
    git version 1.7.6.178.g55272

# With rerere.enabled=false, it works ok (mergetool offers to
# merge the conflicting file):
./stash.sh false

    Initialized empty Git repository in /tmp/foo/.git/
    Saved working directory and index state WIP on master: ac67a86 A
    HEAD is now at ac67a86 A
    Auto-merging file
    CONFLICT (content): Merge conflict in file
    merge tool candidates: meld opendiff kdiff3 tkdiff xxdiff
    tortoisemerge gvimdiff diffuse ecmerge p4merge araxis bc3 vimdiff
    emerge
    Merging:
    file

    Normal merge conflict for 'file':
      {local}: modified
      {remote}: modified
    Hit return to start merge resolution tool (xxdiff): ^C

# But with rerere.enabled=true, mergetool thinks there is no conflict:
./stash.sh true

    Initialized empty Git repository in /tmp/foo/.git/
    Saved working directory and index state WIP on master: d40e77b A
    HEAD is now at d40e77b A
    Auto-merging file
    CONFLICT (content): Merge conflict in file
    merge tool candidates: meld opendiff kdiff3 tkdiff xxdiff
    tortoisemerge gvimdiff diffuse ecmerge p4merge araxis bc3 vimdiff
    emerge
    No files need merging

Phil
