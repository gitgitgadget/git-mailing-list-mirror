From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] am: handle stray $dotest directory case
Date: Thu, 13 Jun 2013 23:03:56 +0530
Message-ID: <CALkWK0mUnNTfJQuGQAoMtnsOXvXU+z+W6D_MMuio1sq4vkucjA@mail.gmail.com>
References: <1371133031-28049-1-git-send-email-artagnon@gmail.com> <7v61xivsxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:34:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBQ4-0007Ns-MR
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758676Ab3FMRej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 13:34:39 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:54208 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756046Ab3FMReh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 13:34:37 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so12326035iec.13
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S9VzDhADi6EvK72p1FTw0S/RN+t1UIDIeAdNgh+zyEQ=;
        b=Sk2ztAF75S2WX3zHbCebfU+1iaJJMu5tdl4KUVvmMnEazu31VUYhfXpAi/VR4FSbKY
         eH/fp/ZfY6PPg92kLexulYA5Pip2POz1/oyhZUzsJSu1yW0s8J2p6Y3KoFjcnJK4eVvv
         Z5YOnFjdTahfxJL0y2xM/qh9LrAgE+gBuoq4Nr4ey9tXDQhk5Hq8baUbV9Pu0+OfMypO
         wRhMyyBSyCEUIaI/SbQVh6tjC+edrPGIi3UH0pxtfwmYOjQHIoAl2LomjybbHE3D47EO
         9xBnEYNBCuobsYebch9pVotLd+YZQqk2L9rMn3Qhwodze0XtE1Vg2jGoW80ZIJhpvXST
         kttw==
X-Received: by 10.50.98.104 with SMTP id eh8mr6028699igb.111.1371144876740;
 Thu, 13 Jun 2013 10:34:36 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 13 Jun 2013 10:33:56 -0700 (PDT)
In-Reply-To: <7v61xivsxh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227752>

Junio C Hamano wrote:
> Perhaps _that_ guarding condition is what needs
> to be fixed, by reverting it back to just "does $dotest exist?"
>
> Adding a single case workaround smells like a band-aid to me.

Like I pointed out earlier, the original codepath is not equipped to
handle this case.  A "normal" git am --abort runs:

  git read-tree --reset -u HEAD ORIG_HEAD
  git reset ORIG_HEAD

blowing away the top commit in the scenario you outlined.

This happens because that codepath incorrectly believes that an am is
"in progress".  What this means is that it believes that some of the
am code actually got executed in the previous run, setting ORIG_HEAD
etc.  In your scenario

  % git am
  ^C

nothing is executed, and a stray directory is left behind.

If anything, I think the check for $dotest/{next,last} has made the
code more robust by correctly verifying that some code did get
executed, and that an am is indeed in progress.  The bug you have
outlined is equivalent to:

  % mkdir .git/rebase-apply
  % git am --abort

Therefore, the fix is to treat it as exactly that: a stray directory
that needs to be cleaned up in the codepath that treats it as a "fresh
run"; not going through the "normal" am --abort logic and blowing away
the top commit.

Makes sense?
