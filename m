From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 13:50:40 -0700
Message-ID: <20140801205040.GT12427@google.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
 <20140801200201.GS12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:50:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDJmq-0007jC-G3
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 22:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbaHAUuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 16:50:44 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:60962 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178AbaHAUuo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 16:50:44 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so6165279pdj.36
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AQ1sQNdgioA52zCv0TxiyxALzdR309iAMPtMR0/SrrI=;
        b=T5Hq+8mqL6rcJWEYrDF7wXB/YbHa6XFfgjaTidLBimiynjnILFFeudQ2axWdwa77GZ
         U39tkdJyRV+a7U7oypfLArl7UnuDqtRtc7QioOTz6iQ5aP3ggsvK2OqjU2Q/tOFarXVf
         urirDcUb8tn2lxsQJ+OdWr2ysFWqpfGcrq7nOMlLo2M/Fq6ZS4+kmMpL8qhd1RsHWDLi
         a/bbr92I2WVl8U35tXA1nlWVPDs+8WhlaGXcW4g1ZN0oQlK9/AHTyFI+CIBgI34Yk5bC
         X+c+2Kxyk4NNQe6vVing7+zjA3ErljOv7Iu95/b0x9H01j8/DklfqQJtBma6eB2Su6in
         mKGg==
X-Received: by 10.68.220.170 with SMTP id px10mr8992215pbc.33.1406926243570;
        Fri, 01 Aug 2014 13:50:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:303c:6b98:896:51f2])
        by mx.google.com with ESMTPSA id v8sm14512032pdr.45.2014.08.01.13.50.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 13:50:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140801200201.GS12427@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254663>

Jonathan Nieder wrote:

> Do you mean that "git merge" should be aware of what changes you have
> already cherry-picked?
>
> It isn't, and that's deliberate

That said, when today's "git merge" fails to resolve conflicts, it's
easily possible that we could do better at resolving the merge by
walking through both sides and understanding what happened.

The detailed history lets you

   i) Present conflicts in an easier to resolve way.

      "Patch #1 which tries to do X conflicted with patch #2 which
      tries to do Y; please reconcile them" can be less painful to
      deal with than "Something in this pile conflicted with something
      in that pile".

  ii) Break a seeming conflict into pieces that can be automatically
      resolved more easily.

      X vs X'+Y may conflict where X' is a cherry-pick of X, if X and
      Y touch the same code.  Meanwhile if we're lucky then X vs X'
      will not conflict because they make the same change, and Y can
      apply on top.

 iii) Handle cherry-picked changes in a *different* way.  For example,
      if patch X was applied on one side and applied and then reverted
      on the other side, this could show up as a conflict.  After all,
      the two sides don't agree on whether patch X is a good change or
      not.

These features have corresponding downsides:

   i') (Speaking from experience of using git-imerge) Too many tiny
       conflicts can sometimes be more painful to resolve than all the
       conflicts at once.  When X, Y, Z, and W had various conflicts,
       how to reconcile X and Y alone or Z and W alone are academic
       questions that don't actually need to be answered to produce
       the merge result.

  ii') This kind of clean, broken-down merge can produce a "clean"
       but wrong result.

       For example, if the following sequence of events occured:

         1. Build fancy new feature X on "master".

	 2. Cherry-pick X to the bugfixes-only branch "maint".
	    Whoops.
	 3. Correct the mistake: revert X on "maint".  Now "maint"
	    is bugfixes-only again!

	 4. Merge "maint" to "master".

       Then a naive, 3-way merge will notice there is no change
       on "maint" since it was last merged to master and the
       merge will bring in no change (good).

       And on the other hand a one-patch-at-a-time merge would
       try to apply X (with no effect, since it's already applied)
       and then try to apply the revert of X.  The net effect would
       be to revert X from "master" (bad)!

 iii') See (ii').

git-imerge from https://github.com/mhagger/git-imerge can help with
(i) and (ii) but not (iii).

Hoping that clarifies,
Jonathan
