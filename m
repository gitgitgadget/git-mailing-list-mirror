From: Phil Hord <hordp@cisco.com>
Subject: Failure and unhelpful error message from 'rebase --preserve-merges'
Date: Wed, 09 Jan 2013 08:19:40 -0500
Message-ID: <50ED6E6C.5020400@cisco.com>
References: <50ED63CB.7060108@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Neil Horman <nhorman@tuxdriver.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 14:29:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsvik-0008VF-Lq
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 14:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757803Ab3AIN3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 08:29:10 -0500
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:65172 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757694Ab3AIN3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 08:29:09 -0500
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2013 08:29:09 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2067; q=dns/txt; s=iport;
  t=1357738149; x=1358947749;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=mU/mcSdyjAj6pMsJuZgUSPANnn8Gpt5pxGFmxM+sWlM=;
  b=URS7XKUINNP8edl5Jg26h1HMLCroekxluM5AlGWlbdoX2WkpkQqkt7fL
   ZyN1RXTF3z53nyCvIT7FaQfQiXgYJozvWOssvTUlYPv9ucb6FTax/1vcw
   I4t12j46GKxe5ETauVknudk3yj7dokeDjS50kOPDTMCZCOwvZitNkMbzl
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlwIAGpt7VCtJV2c/2dsb2JhbABEg0e2N4NTFnOCHwEBBHgBECwWDwkDAgECAUUGDQEHAQGIE7V6kRADiGGNK4Vril6DEg
X-IronPort-AV: E=Sophos;i="4.84,436,1355097600"; 
   d="scan'208";a="160465824"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-2.cisco.com with ESMTP; 09 Jan 2013 13:19:41 +0000
Received: from [10.117.80.101] (rtp-hordp-8914.cisco.com [10.117.80.101])
	by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id r09DJfGp001439;
	Wed, 9 Jan 2013 13:19:41 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50ED63CB.7060108@cisco.com>
X-Enigmail-Version: 1.4.6
X-TagToolbar-Keys: D20130109081940893
X-Forwarded-Message-Id: <50ED63CB.7060108@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213057>

Since 90e1818f9a  (git-rebase: add keep_empty flag, 2012-04-20)
'git rebase --preserve-merges' fails in a case where it used to
succeed, and it does so with an unhelpful error message.

   $ git rebase --preserve-merges master
   error: Commit 452524... is a merge but no -m option was given.
   fatal: cherry-pick failed
   Could not pick 452524f925aecd0439ae5728fca3887292114dd7

I also tried rebase with '-m'
   $ git rebase --preserve-merges -m master
but that also failed.

The same commands worked fine for these same commits in v1.7.9

>From 90e1818f9a I figured out that the rebase-interactive
machinery had dropped one of my merges. I normally would not
notice this when using 'git rebase -p' since it does not invoke $EDITOR
by default; but I can see it if I use this:

   git -c sequence.editor=cat rebase -p master

With that I see my list of commits, including these:

  ...
  pick 184ec4d WIP: DHCP datastore reporting
  # pick 16ca56c Merge ptss into sock-threads
  pick 06aea55 WIP: More work normalizing config handlers
  ...
  pick 452524f Merge branch 'ptss' into sock-threads
  ...
  #
  # Note that empty commits are commented out

The failure points to the 2nd merge commit, but it is not the merge
commit which was commented out. It is a later merge between the same two
branches. I'm not sure how this is related, yet.

But I now know I can work around the problem with this:

    git rebase --keep-empty -p master

I see three problems here, but I don't have any time to go fix them
myself right now.

 1. 'rebase -p' should default to --keep-empty since the user will not
    be given the opportunity to edit the list to uncomment the missing
    commits.

 2. 'rebase --interactive -p' should not drop empty merge commits.

 3. rebase should not die with a cryptic cherry-pick error message,
    although I am not sure what useful thing it could say in this
    particular case. Maybe there are other conditions which will cause
    this same failure even if 1 and 2 are fixed.

Phil
