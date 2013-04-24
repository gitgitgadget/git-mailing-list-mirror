From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Wed, 24 Apr 2013 13:57:44 +0530
Message-ID: <CALkWK0=JsR9txrrnWZKyrTpv-s+ZgVz-cL6ZsMn2R+wz6rE4FA@mail.gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
 <1366725724-1016-8-git-send-email-artagnon@gmail.com> <CABURp0onypkDFiovYP4s0UuBV+oFp3rPv1Jq8dGbxZhKU_sgsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 10:28:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUv44-0008QD-Bz
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 10:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757743Ab3DXI20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 04:28:26 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:42123 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638Ab3DXI2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 04:28:24 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so1372387iaf.18
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6Q/tLN6/6oQWjzgkKVhkBtjurG4M4y1E2tY0vQFzoHE=;
        b=QL16QFD+1z9Q7GC4/QB2kmvKzWRwHqq1JdiaQV4XAp/9LolH9ZqmJf73a9SaKHtDhN
         kEkaz5SxE6eJtBYqaOQY82g7N1TlnWpAOvigObRvJg2L3J0M8I4+Y6orAd6n+hYCESGR
         xXOuNIoRQ1DAP0WkykcBuFvcPAPWFkuL67X7alpHsNdJNxo33eZ+fG88oJ5VvSGtvU5k
         NtxBld1ISRZmtdqGxIasexC2/FDCiowSsEfvZ2/Hsar+wccgJOXxIyC1Qmms5No9/BOd
         5OkPSIOB8LHH1I+Arpv0WKYy9gECFbiT5y59Y1OK8qaa2kUvGq655beh4N+Sshj2alD9
         ANMQ==
X-Received: by 10.50.73.65 with SMTP id j1mr14226030igv.49.1366792104290; Wed,
 24 Apr 2013 01:28:24 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 01:27:44 -0700 (PDT)
In-Reply-To: <CABURp0onypkDFiovYP4s0UuBV+oFp3rPv1Jq8dGbxZhKU_sgsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222238>

Phil Hord wrote:
> Because I am in a git-rebase which has apparently failed, I would
> expect 'git rebase --abort' would save me here.  But it does not and
> you have given me some unique instructions to try to recover.  I
> suppose rebase--abort cannot be made to recover in this case because
> this is a rebase-wrapper and all of my rebase-state is already
> discarded.  But I would much prefer to have the normal "undo"-ability
> of git-rebase here, once I realize I have made a mistake or
> encountered conflicts I am not prepared to handle right now.

You're asking for a hammer solution, when I'm advocating a solution
that offers more flexibility and control.  Commits and worktree
changes are fundamentally two different things, and I treat them
differently.

rebase.autostash is simply a shortcut for:

    $ git stash && git rebase ... && git stash pop

Except that your stash is not blocked during the rebase process: we
use a special stash.  If the last 'git stash pop' fails, do you do
this?

    $ git reset --hard HEAD@{1}
    $ git stash pop
    # snip, snip ...
    # redo the entire rebase

I _never_ find myself doing this; in your hammer solution, you're
advocating that we always do this.

The stash is a powerful tool when used properly: a stash isn't
attached to any branch, and therefore perfectly designed to keep small
temporary worktree changes for a short period of time.
rebase.autostash is _not_ a way to take away power from the user, or
save the user from learning how to use stash.

That said, the current implementation is very rough and I will improve
it in the next iterations.  If the apply fails, I will push the
changes onto stash@{0}, and let the user do a 'git stash pop' instead
of having to remember (or copy out) a SHA-1 displayed in the terminal
output.  Essentially, this leaves the user in the exact same state as
if she had done a 'git stash && git rebase ... && git stash pop'.
