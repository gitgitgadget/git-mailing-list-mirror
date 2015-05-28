From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pre-commit hook not run on conflict resolution during rebase
Date: Thu, 28 May 2015 13:03:07 -0700
Message-ID: <xmqqy4k8fp1g.fsf@gitster.dls.corp.google.com>
References: <1m55i3m.1fum4zo1fpnhncM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Thu May 28 22:03:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy41M-0002JF-83
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbbE1UDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 16:03:11 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34550 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbbE1UDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:03:09 -0400
Received: by igbhj9 with SMTP id hj9so1723432igb.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=h5yRBNQOGAIE5cpDOqZLcW/l3PF27dxFz75skQr37x4=;
        b=o1A6X+8c2pNYTIKSoVkSOPdYbaOzc19dUUUK56j5RcQSmICqI8zzn1sW0r5ddjEHLJ
         Mr6BFlpYfFhKGkGZn/2LTIgbHUH8OI3uzmGFXfG87u37+l1JHawbF+0iNK/j4t+X04c4
         z5aD+1OH02tzk24DH7iObVKLZ5n9ijqdfGC3zC0KYLrRyq++5nbxbumZtTMrK3y2ZjOW
         /VxxwxZglxpgD2CB37ClrrTkPMPSKsdszYAdst5MRRvG28uAfY7j73z9mxn2TX6dYgiG
         aatX4IfD0vJdxrPPDdXq2tKL/gdNljlzJ4TLma84SbFjAHuzBI+LwyIgmomRodnWf4fA
         /WxA==
X-Received: by 10.107.128.30 with SMTP id b30mr5595677iod.84.1432843388518;
        Thu, 28 May 2015 13:03:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id k186sm2501894ioe.37.2015.05.28.13.03.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 13:03:08 -0700 (PDT)
In-Reply-To: <1m55i3m.1fum4zo1fpnhncM%lists@haller-berlin.de> (Stefan Haller's
	message of "Thu, 28 May 2015 21:38:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270188>

lists@haller-berlin.de (Stefan Haller) writes:

> When a rebase stops because of a conflict, and I edit the file to
> resolve the conflict and say "git rebase --continue", then the
> pre-commit hook doesn't run at that point,...
> From glancing through the githooks manpage, I couldn't see any other
> hook that would help in this situation. Am I missing something?

I do not think so.  There may be some fallouts, like negatively
affecting folks who have been relying on the current behaviour, but
I do not see a fundamental reason why that hook should not trigger
there (it may not trigger in the current implementation, but I view
it as lack of need so far, not a deliberate omission).

> I guess the next best solution would be to also have a pre-push hook
> that performs the same checks again, just in case the bad code managed
> to get past the pre-commit hook for some reason or other. This feels
> very redundant, but I guess it would work well.

I'd say pre-receive would be the most sensible place to check things
like this.  Some of your developers may not have pre-commit hook or
even run "commit --no-verify" to bypass the local check, and if you
have a central meeting place for the efforts by all your folks, that
is where you want to enforce the policy.

Checks done anywhere else are what are redundant, including the
pre-commit hook in individual developers.  You can view them as a
way for individual developers to save their time---by choosing to
check locally, they make sure their commits do not trigger the
pre-receive hook at the central place.
