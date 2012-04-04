From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick
 failed
Date: Wed, 4 Apr 2012 15:16:10 -0500
Message-ID: <20120404201610.GB17544@burratino>
References: <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com>
 <20120403144505.GE15589@burratino>
 <4F7B650C.9060800@sohovfx.com>
 <20120403210815.GB19858@burratino>
 <20120403211219.GC19858@burratino>
 <4F7B69FE.9010600@sohovfx.com>
 <20120403212650.GD19858@burratino>
 <4F7B839D.2020808@sohovfx.com>
 <20120404181148.GB16993@burratino>
 <4F7C9FAE.5050806@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 22:16:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWcw-0003Uj-GB
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 22:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab2DDUQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 16:16:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab2DDUQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 16:16:17 -0400
Received: by iagz16 with SMTP id z16so754103iag.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ut5fdtCTC9+G53HuswfE/hTwzxOySasR9raTSXGBQx0=;
        b=gdtbOilftZjdLwZMWxwlwSEbRq+4rxSYTnsWiV2cKAIc7DTBOVbayuK1o7qWk71QRc
         wqxMg0aTVHxZv6Z3KdbKJrKxw7FBIyCGoFx9JMArAeagcUi35GFrvSNzflq+qxywJfW+
         lhw93mmlf7HdDbYIgdduNJTh9o+AY8GFc16LunRfDbV/vc5+IyuGEsLAgSaNlnezoAjx
         rdgpxprPD4sljuEp8Nhq7xNwMmnlH5p3wi5ENP0PvXKT9cs41VoSryCVUdsUaQjg6TTR
         3N69C4ZHkSZX9oiuXGJbCn81K7AXq1eZGhCspVBDkqTXg9iBizQYKrHDmL1dk4iGbvui
         Kk9g==
Received: by 10.50.222.233 with SMTP id qp9mr3212282igc.58.1333570576891;
        Wed, 04 Apr 2012 13:16:16 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id cg9sm4384019igb.17.2012.04.04.13.16.15
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 13:16:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7C9FAE.5050806@sohovfx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194734>

Andrew Wong wrote:

>                            Since there could be other scenarios where
> "commit" could fail

As far as I can tell, there just aren't any such other scenarios,
unless you mean like running out of memory or disk space.  "git
cherry-pick" disables hooks when running "git commit" so the
pre-commit hook can't block the commit.

So the scenarios fall into three or so categories.

 - when "git cherry-pick" performs a merge and encounters conflicts,
   it prints a message and exits, writing CHERRY_PICK_HEAD to tell
   the operator what command to use (instead of "git commit" or
   "git cherry-pick --continue") when the problem is resolved.

   If my script sets GIT_CHERRY_PICK_HELP, it will print a different
   message and does not write CHERRY_PICK_HEAD because the operator
   is going to run "myscript --resume" and not "git commit" or "git
   cherry-pick --continue" when the problem is resolved.

 - when "git cherry-pick" performs a clean merge that produces no
   change, "git commit" prints a message about a missing --allow-empty
   argument and exits.

   My GIT_CHERRY_PICK_HELP setting is not respected, so the user is
   likely to run "git commit" or "git cherry-pick --continue" instead
   of the command I wanted.

 - when "git cherry-pick" performs a clean merge that produces a
   change but "git commit" fails to record it due to a stray signal or
   running out of disk space, git does not print any advice for the
   operator.

   In particular, my GIT_CHERRY_PICK_HELP setting is not respected.
   Also, CHERRY_PICK_HEAD is written even though my wrapper script
   that sets GIT_CHERRY_PICK_HELP didn't expect that.

   The operator can return to a familar state with "git reset --hard"
   followed by "git checkout" of some familiar branch, except that my
   script may be keeping some state of its own that lingers until the
   operator tries to use it again...

I was focusing on the second category.  Using a stock message instead
of the custom message from GIT_CHERRY_PICK_HELP certainly seems to me
like a bug or incomplete feature.

When you say that there are other ways for "git commit" to fail and
Junio says that in some cases "git cherry-pick" should not write
CHERRY_PICK_HEAD at all, you are probably thinking of the third
category.

Hope that helps,
Jonathan
