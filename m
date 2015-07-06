From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 18/23] checkout: retire --to option
Date: Mon, 06 Jul 2015 12:41:13 -0700
Message-ID: <xmqqh9physyu.fsf@gitster.dls.corp.google.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
	<1436203860-846-19-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 21:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCCGX-00009H-2b
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 21:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbbGFTlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 15:41:16 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33641 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750AbbGFTlP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 15:41:15 -0400
Received: by igh16 with SMTP id 16so34060245igh.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ng+itd1Rge0kbpfNOyCdH7Tn7/vU/uj27uMrqJW/GK0=;
        b=H+tvyudw/oAHfHM1jBBjM19Vnunz4Bd9UMLRfmNL7lhKYTi5X1dFxhQ7NrHRyaT1HQ
         L/SmrCnFU+bYtLu9LfxuaLQGHVtoKmjxseDuXj8yfQxa3TchFwf47Zo+DmvM0uRwaWcM
         agEusYxLn2PEvN6eSWmkiR0Z2c1ibhwPdVLVJdmzNYkaLLiVbr/H+HGFvXu5hpFm+t6C
         5tkru31ErM1bqE3Z0wCo0hxQpgBna/Hy1CH1ee7RlG4kZsuckSY9dwz+kAQXzwrNIDkI
         KYtz+vyvvvJhvS7mhdfAe9sfdThisVnonPwRjPglD51Bh+S8vRKAr5K5H2frm8KYPaph
         hIAQ==
X-Received: by 10.50.43.227 with SMTP id z3mr43354546igl.12.1436211675369;
        Mon, 06 Jul 2015 12:41:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by smtp.gmail.com with ESMTPSA id fv2sm10283936igb.22.2015.07.06.12.41.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 12:41:14 -0700 (PDT)
In-Reply-To: <1436203860-846-19-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Mon, 6 Jul 2015 13:30:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273454>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Now that "git worktree add" has achieved user-facing feature-parity with
> "git checkout --to", retire the latter.
>
> Move the actual linked worktree creation functionality,
> prepare_linked_checkout() and its helpers, verbatim from checkout.c to
> worktree.c.
>
> This effectively reverts changes to checkout.c by 529fef2 (checkout:
> support checking out into a new working directory, 2014-11-30) with the
> exception of merge_working_tree() and switch_branches() which still
> require specialized knowledge that a the checkout is occurring in a
> newly-created linked worktree (signaled to them by the private
> GIT_CHECKOUT_NEW_WORKTREE environment variable).


I do not quite understand why we still need the hidden environment
variable.  Is this a sign that the implementation is shared too much
between unrelated codepaths (or to put it another way, perhaps API
functions that are not best fit are being used)?

Stepping back a bit, with or without the new "linked worktree"
feature, when you came across a repository whose working tree does
not have any file (i.e. somebody ran "git ls-files | xargs rm"), you
do not know and care what is in .git/index right now, you do not
know and care what branch its .git/HEAD points at, but you *do* know
what branch you want to be on (or where you want its HEAD detached
at), what would be the command you would use?

The state immediately after a new worktree is constructed by
populating /path/main/.git/worktrees/test-next/ and pointing it from
/path/other/test-next/.git but before the index or the files under
/path/other/test-next/ are populated is exactly that situation, no?
Wouldn't "symbolic-ref HEAD the-branch-i-want" (or "update-ref HEAD
the-commit-i-want" in the detached case) followed by "reset --hard"
the more natural thing to use, instead of merge-working-tree and
switch-branches that are implementation details of "checkout"?
