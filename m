From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does 'git branch -d' act differntly after clone?
Date: Thu, 20 Aug 2015 08:49:24 -0700
Message-ID: <xmqqa8tm7yez.fsf@gitster.dls.corp.google.com>
References: <CALwJaCzYgDKdcT7H7=5x0fnNRv4MsrtjJoHJcB9rJyh3dU--xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Konstantin Hollerith <khollerith@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 17:49:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSS5s-0006pV-Px
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 17:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbbHTPt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 11:49:28 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34886 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbbHTPt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 11:49:27 -0400
Received: by pdob1 with SMTP id b1so15603604pdo.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=L2VI/9rIYWr93XCIqNddxIPW/kgSB2HYW7x/gHWwM0I=;
        b=AhfGPiiI66M5Oge0ch3PeJ5cnmuAJVAwn72w00xKrGZasyQPve35zZXJ06GimAuQFN
         JpBYJDHCQAq+dA83QEWHt9/L1bHEkyKiCuyaiR+mNQOlp6qi4lgAxxsSuzlvzRquclKy
         l4qAWIHJ81aDUeL8LWCW8QKPLtvMQ1Wz4ZlUqiqzaTcSNngHJKvBTlYQEC25XHTxJQoC
         M/pTz+LHtmiWVNdCK2FSoYXk1eCyjR04aSGbTLRleRszDRTYCLD8ynLr6rmsWCZAeYtH
         Izuh9lwWZJvXrZVEXK9sesEFinyq9pUek2WY0z3naN75k+5TCZny3Yort/t2QdJ160zb
         g3RA==
X-Received: by 10.70.91.73 with SMTP id cc9mr7564362pdb.59.1440085766697;
        Thu, 20 Aug 2015 08:49:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id qw2sm4812498pbc.5.2015.08.20.08.49.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 08:49:25 -0700 (PDT)
In-Reply-To: <CALwJaCzYgDKdcT7H7=5x0fnNRv4MsrtjJoHJcB9rJyh3dU--xQ@mail.gmail.com>
	(Konstantin Hollerith's message of "Thu, 20 Aug 2015 14:10:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276247>

Konstantin Hollerith <khollerith@gmail.com> writes:

> Why does git branch -d acts differently after a clone?

In the former case, that branch is the only thing that knows about
the commits near the tip of it.  Immediately after you clone that
repository, you have a copy of that branch as a remote-tracking
branch for origin/neuerTestBranch.  You didn't say how you got a
local copy of it in there, but I'd imagine that in the clone you did
something like:

    $ git checkout neuerTestBranch

which is a short-hand for

    $ git checkout -b neuerTestBranch origin/neuerTestBranch

and then went back to a branch other than that branch when you asked
the branch to be removed, e.g.

    $ git checkout master
    $ git branch -d neuerTestBranch

without building any further history on neuerTestBranch.

Now, your local neuerTestBranch is a mere unmodified copy of the
remote-tracking branch origin/neuerTestBranch; the commits on the
former will not become unreachable if you remove neuerTestBranch,
because they are all reachable via origin/neuerTestBranch.  And that
is why the deletion of it has less severe potential of information
lossage, compared to the original case where you attempt to remove
the only copy.
