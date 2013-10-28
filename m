From: Jim Hill <gjthill@gmail.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Sun, 27 Oct 2013 17:49:24 -0700
Message-ID: <526DB494.8000703@gmail.com>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda> <20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 28 01:49:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vab1h-0004yn-Re
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 01:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab3J1AtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 20:49:23 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:38554 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab3J1AtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 20:49:22 -0400
Received: by mail-pa0-f51.google.com with SMTP id ld10so6395930pab.38
        for <multiple recipients>; Sun, 27 Oct 2013 17:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VyAvO2ruB/LHgTr5mYthfWq/doy/RPoXqaGhYJxXZj0=;
        b=al3REDw5RzRleG0ht/zehKxrpMQqc+RvKGHCdzNdijAjHyua2uo6c383mhfhUqg20y
         cVd/NjWFUd9DH+76qwsQMMC0HbelErI93dysT3BwPvIwFkJCeEp7q2Iwk9oP2bwcTctf
         LKyvfNx+/lWfF5uaqwyqediyRU9D5GGWQRiHVJI6rXRB9aKakLxnioxsXb6pTnb0xK7Y
         snzlUdGsmROohRCYKggDRCHipC40FQqLnhGIS1LP177M2DlVXk6fUmcrkhXjQj8N5Stm
         mf+lAppzZtjrI9XwRrncMzIecPAQlvUjfUeCZGTNOlEqir9wKXLVjdjq0LF6mAXCEk7N
         D/Ig==
X-Received: by 10.68.211.233 with SMTP id nf9mr13639705pbc.85.1382921361844;
        Sun, 27 Oct 2013 17:49:21 -0700 (PDT)
Received: from gadabout.dyndns.org (pool-71-165-61-200.lsanca.dsl-w.verizon.net. [71.165.61.200])
        by mx.google.com with ESMTPSA id fk4sm30600783pab.23.2013.10.27.17.49.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Oct 2013 17:49:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20131027013402.GA7146@leaf>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236815>

On 10/26/13 18:34, Josh Triplett wrote:
> Linux Kernel ... "Fixes:" line ... containing an abbreviated commit hash

<!-- -->
> This helps people (or automated tools) determine how far to backport

I beg pardon if I'm rehearsing an old debate, but it seems to me it 
would be better and worthwhile to bring more of git to bear by adding 
`reference` links as follows from considering this proposed sequence:

     #  ...G---B---...    history-with-bug-at-B

     Gprime=`git commit-tree --reference G`
     Bprime=`git commit-tree --reference B -p $Gprime`

     #   ...G---B---...   history-with-bug-at-B
     #      :   :         # <-- `:`'s are `reference` links
     #      G'--B'        $Bprime is a mergeable cherry-pick for B

`reference` links have no enforced semantics. Teach all current logic to 
ignore them (fetch doesn't fetch through them, fsck doesn't care, etc.). 
  Elaborating some of the good parts:

* If the author and committer data are left untouched when 
`commit-tree`'s tree and message arguments are defaulted, as above, to 
the referenced commit's tree and message, the resulting commit is unique.

* Bullet-proof cherry-pick creation becomes easy and idempotent:

         git-make-cherry-pick() {
             local picked=$1
             set -- `git rev-list --parents $picked^!`
             shift
             local parents
             local parent
             local p2
             for parent; do
                     p2="$p2 -p `git commit-tree --reference $parent`"
             done
             git commit-tree --reference $picked $parents`
         }

* Which makes the created commit id a fully-implemented _change-id_ for 
the referenced commit:

         git merge $(git-make-cherry-pick $B)

     can be done from anywhere, merge won't have to rely on patch-id's 
to detect cherry-picks done this way.

* A bugged commit gets fixed by fixing its reference commit and merging 
normally, worry-free:

         ...G---B ... -F   Merge fix X for a bug in B
            :   :     /
            G'--B'---X     X's commit message is the `Fixes:` equivalent

    Bugfix commit X can be safely merged anywhere.  Worst case, `git 
merge -s ours --no-commit X` and do whatever you would have done otherwise.

`merge` might usefully be updated to warn about merging from a commit 
with only a reference parent, I think merging from `G'` would probably 
be a mistake.

---
So, this is as far as I've gotten with this, is there reason to think it 
should or shouldn't be pursued?
