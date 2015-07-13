From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] worktree: use "git reset --hard" to populate worktree
Date: Mon, 13 Jul 2015 11:36:11 -0700
Message-ID: <xmqqsi8rzyzo.fsf@gitster.dls.corp.google.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 20:38:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEicQ-0003Vi-IK
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 20:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbbGMSgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 14:36:14 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33670 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbbGMSgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 14:36:13 -0400
Received: by iggp10 with SMTP id p10so82168223igg.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GtzFgYnlavheuZm+sTOHzdCZlHneJ+yJr0rmtb1kPOs=;
        b=LuyUIxDWtls++2rJsU2R3AFwwLYdK4kYWdvGTvKb3fGbhmOypochPkL/GHCcORIkFs
         PLhz6E3C78tJZjciLPD1K75elG70vDeLD6l0QCqRgTkLGAy3HdhCItLOxDc22lVYnHP6
         zlg+Fd/wYRF5130fL/hz6WhsoARQtIjVdagRkXPZ+qv4NckRsLi1OA/8QGHqF/NvYBNw
         KRX33JQccoi2qYgfAnPCNey7/JcDHB/exiaCWtrYMy8OE2ZZM0v52HnN/Xs2kGr7A1QK
         wMs9eNiZk82ttS1zyXOElT6F9rzscRRqLDPKz1KJ0tspWJBv2Xn2i1YFSknvNQYfMIUy
         RzHA==
X-Received: by 10.50.72.41 with SMTP id a9mr13081622igv.51.1436812573153;
        Mon, 13 Jul 2015 11:36:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4d10:ec6a:e89:91cb])
        by smtp.gmail.com with ESMTPSA id t29sm8411210ioi.24.2015.07.13.11.36.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Jul 2015 11:36:12 -0700 (PDT)
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Fri, 10 Jul 2015 20:05:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273921>

Eric Sunshine <sunshine@sunshineco.com> writes:

> This is a follow-on series to [1], which migrated "git checkout --to"
> functionality to "git worktree add". That series continued using "git
> checkout" for the initial population of the new worktree, which required
> git-checkout to have too intimate knowledge that it was operating in a
> newly created worktree.
>
> This series eliminates git-checkout from the picture by instead
> employing "git reset --hard"[2] to populate the new worktree initially.
>
> It is built atop 1eb07d8 (worktree: add: auto-vivify new branch when
> <branch> is omitted, 2015-07-06), currently in 'next', which is
> es/worktree-add except for the final patch (which retires
> --ignore-other-worktrees) since the intention[3] was to drop that patch.

A few comments on things I noticed while reading (mostly coming from
the original before this patch series):

 - What does this comment apply to?

        /*
         * $GIT_COMMON_DIR/HEAD is practically outside
         * $GIT_DIR so resolve_ref_unsafe() won't work (it
         * uses git_path). Parse the ref ourselves.
         */

   It appears in front of a call to check-linked-checkout, but I
   think the comment attempts to explain why it manually decides
   what the path should be in that function, so perhaps move it to
   the callee from the caller?

 - check_linked_checkout() when trying to decide what branch is
   checked out assumes HEAD is always a regular file, but I do not
   think we have dropped the support of SYMLINK_HEAD yet.  It needs
   to check st_mode and readlink(2), like resolve_ref_unsafe() does.

 - After a new skelton worktree is set up, the code runs a few
   commands to finish populating it, under a different pair of
   GIT_DIR/GIT_WORK_TREE, but the function does so with setenv(); it
   may be cleaner to use cp.env[] for it, as the process we care
   about using the updated environment is not "worktree add" command
   we are running ourselves, but "update-ref/symbolic-ref" and
   "reset" commands that run in the new worktree.

Other than that, looks nicely done.

I however have to wonder if the stress on "reset --hard" on log
messages of various commits (and in the endgame) is somewhat
misplaced.

The primary thing we wanted to see, which this series nicely brings
us, is to remove "new-worktree-mode" hack from "checkout" (in other
words, instead of "reset --hard", "checkout -f" would also have been
a satisfactory endgame).

Thanks.
