From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form ^{/message}
Date: Wed, 17 Apr 2013 14:01:06 +0530
Message-ID: <CALkWK0kJOSBN8XTJKBLOqi4tUjjm9unr=No65TtW9V0qvKmV-A@mail.gmail.com>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
 <CA+sFfMfkoBcoPvJSYBGUe46EbMfiC7q6tVZs6db2NHrEb2gb7Q@mail.gmail.com>
 <CALkWK0=L4mqVBqDMWgzN+BT5bnEF0L6d=GPXvrNhPL_Asvdq8Q@mail.gmail.com> <CA+sFfMd-pfmPXNCoAfH59om1cdYh1=bJ7yb-BGZHjkra5Gm_uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 10:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USNmU-0007Fn-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 10:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965879Ab3DQIbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 04:31:49 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:53416 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965758Ab3DQIbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 04:31:46 -0400
Received: by mail-ia0-f174.google.com with SMTP id o25so1177262iad.19
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DUedjuxVIseB/P/xfKPK4dq6yeoqxZxc4KWc7SE0j0I=;
        b=SROVaIKn32tmiHe3nuJndCiZdCsvOXiR3LwfmZImtQdDPbuV+cQcXrGu8JCTVM3Kez
         M0q3JJcAFCHbuAmeEAMznyOaW+QFRqslAXeXfzIDcg8Jmg+4rrhj2Qsyk7/tPWNy4RE2
         B05Jw9aq8NgbkqfqEvSog6EBFU2cxc5QGi1nwT4U6NINJFexxrE5492lwedc2YBvNROk
         A1CUp1mWpn6LjskH7EYTLzB4YswG8Vt3PGFRZ3W8l4s8erjw7KRl2CyEpjqHhTaOgnVx
         NgUe64G/lmb8oB89Lyr1MM+ETZHNMPMyUGstTLLZkcXq6kyqp3rWjcVDnHUgOWAMh6ha
         b3rw==
X-Received: by 10.50.17.166 with SMTP id p6mr10009700igd.12.1366187506260;
 Wed, 17 Apr 2013 01:31:46 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 17 Apr 2013 01:31:06 -0700 (PDT)
In-Reply-To: <CA+sFfMd-pfmPXNCoAfH59om1cdYh1=bJ7yb-BGZHjkra5Gm_uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221520>

So, I read through git-stash.sh a little more, and found the following:

1. Any stash that can be shown can be applied, but not necessarily
popped or dropped (as the documentation indicates).  The reason for
this is simple: a pop/drop attempts to clear the entry in the stash
reflog as well, but all stashes need to have a corresponding reflog
entry (for instance, those created with 'stash create').

2. IS_STASH_LIKE is a misnomer: all it checks is that the given <rev>
is a merge commit.  As a result, you can 'stash show' and 'stash
apply' any merge commit.  Should we attempt to tighten this somehow,
or are we okay with the stash being just another merge commit?  Check
for a special commit message perhaps?

Brandon Casey wrote:
> You can create a stash without modifying the refs/stash reflog using
> 'sha1=`git stash create`' and then later apply it using 'git stash
> apply --index $sha1'.  You'll have to reset the work directory
> yourself though since 'git stash create' does not do so.  The stash
> created this way is just a dangling commit so it will have a lifetime
> according to the gc.pruneexpire (default 2 weeks currently).

Thanks, but I was worried more about reachability of the commit: if I
create a ref to it in refs/stashes/* like I suggested, it wouldn't
expire until that ref was gone.  Then again, I suppose a ref is
unnecessary for a temporary stash.  Yeah, I can store the SHA-1 hex of
the dangling commit in my caller's $state_dir, and apply it from there
later.
