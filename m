From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] notes: handle multiple worktrees
Date: Fri, 31 Jul 2015 11:46:30 -0700
Message-ID: <xmqq8u9w5fnd.fsf@gitster.dls.corp.google.com>
References: <1438364697-6647-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 20:46:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLFKI-0006Rn-5d
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 20:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbbGaSqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 14:46:33 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34188 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbbGaSqd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 14:46:33 -0400
Received: by pdbbh15 with SMTP id bh15so46627938pdb.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lHtw0Tj7UYTExtyQEAAaRwKA4kn8CDgK0/MJbH3oS0U=;
        b=vNaP8uXVmOLCm8i3jQWbpPxZz0ZSnXYiCpJI4cTBAeybgyO6gFTfAJgiR6nVvdLYK9
         xajKEdI82+dEouN0Z3UHIknFXop7DMtZOAOjM1znMfDSizvgTpc5pBgCVxckHo/dbDmI
         TGdsFQk78I7otDNYMBPZnctlqJGJRv8YEYFpYW8DnjAwvpobQJG4XiA2sgL36QXuQv9T
         USf8FAM6nl+GnR7MAy4E1Muq5AEs279FovMi6jzCI6Tn/YdSUazm3C5UAnl7/I8WJR50
         ezrD7YIXSVEBale9KI3hi3vDvcAWQNT1/wsjH5aE3G+OX0MvZFh4AtFB37fMZtf2aLEG
         cX4Q==
X-Received: by 10.70.55.1 with SMTP id n1mr9690183pdp.21.1438368392672;
        Fri, 31 Jul 2015 11:46:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id cl15sm9023917pdb.27.2015.07.31.11.46.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 11:46:31 -0700 (PDT)
In-Reply-To: <1438364697-6647-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 31 Jul 2015 13:44:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275062>

David Turner <dturner@twopensource.com> writes:

> Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using
> die_if_shared_symref.  This prevents simultaneous merges to the same
> notes branch from different worktrees.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>
> This version addresses Eric Sunshine's critiques of v1.  It breaks out
> the symref-checking functionality into die_if_shared_symref, leaving
> die_if_checked_out to handle HEAD.

>
> ---
>  builtin/notes.c                  |  2 ++
>  t/t3320-notes-merge-worktrees.sh | 71 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100755 t/t3320-notes-merge-worktrees.sh

Hmm, is this the whole thing?

Or is a prerequisite patch to add that "symref check" infrastructure
missing on the receiving end?

This is a tangent, but there is a bigger spanner in "bisect".  It
uses refs/bisect/* to keep track of the current bisection state, but
that state is tied to a particular worktree, and it should not be
shared across other worktrees.

We need to reserve a part of refs/* hierarchy (e.g. refs/private/*)
for per worktree private stuff and handle them just like we do
per-worktree pseudorefs, or something like that.
