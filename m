From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC PATCH] add t3420-rebase-topology
Date: Fri, 28 Sep 2012 11:03:19 -0700
Message-ID: <CANiSa6hvs2253yb4s0PpaAfG=hoBK2psP896GMFWT-UjiPZDwA@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<50582873.603@viscovery.net>
	<CANiSa6i+A6fkWpkPMXiBRdT48LaSfPe2yki+AmWFAKYg02p=+g@mail.gmail.com>
	<20120927122035.GL16059@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 20:03:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THeuQ-0007U0-Fg
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 20:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758673Ab2I1SDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 14:03:21 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:57192 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2I1SDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 14:03:20 -0400
Received: by qchd3 with SMTP id d3so2143725qch.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sMgOCeUcW08ctS9aeX6gCxRfAjKNE/KCYcZOXj2j+HI=;
        b=XYKz1iyBEIb4VPf7ML+QslMhYjuf3UkEku0ym/LfbSlJ2/hqtvtTV7c9jGZfqyyBhp
         S+IPUmHPOMI+jm30NNB8WPSMteBSn9oj5ADggCdsRY78hsSLtRSTeS2HHcmfC8Ndq7EC
         vhBS4lZ8VFzg0NEKdGu5zrOlAsPMCC2z/n4LYGbfP2LNKSHEnRhRJsIcOAaoILCUAVVA
         m/uOxy4R5wS5f7+1jP0rdJ8b6Zj+yHJlzwROTgoaladJoKmMH+4I1aRUAmwPg/XotupF
         vQXeuEOJ0PfFaXSK1pGAYF8kv0TuHCCw+H4xelxIvO3opR2kD+1RJj0fjfvxr3TOgwpE
         VAaQ==
Received: by 10.224.52.139 with SMTP id i11mr18837012qag.11.1348855400069;
 Fri, 28 Sep 2012 11:03:20 -0700 (PDT)
Received: by 10.49.1.44 with HTTP; Fri, 28 Sep 2012 11:03:19 -0700 (PDT)
In-Reply-To: <20120927122035.GL16059@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206591>

On Thu, Sep 27, 2012 at 5:20 AM, Chris Webb <chris@arachsys.com> wrote:
> You're right that rebase --root without --onto always creates a brand new
> root as a result of the implementation using a sentinel commit. Clearly this
> is what's wanted with --interactive

That's not as clear as one might first think. "git rebase -i" actually
honors --force; if one marks a commit for "edit", but then --continue
without making any changes, the next commit(s) will be fast-forwarded.
See the first few lines of pick_one (or pick_one_preserving_merges).

> but rebase --root with neither --onto
> nor --interactive is a slightly odd combination for which I struggle to
> imagine a natural use. Perhaps you're right that for consistency it should
> be a no-op unless --force-rebase is given?
>
> If we did this, this combination would be a no-op unconditionally as by
> definition we're always descended from the root of our current commit.

For consistency, it seems like "git rebase -p --root" should always be
a no-op, while "git rebase [-i/-m] --root" should be no-op if the
history has no merges. Also, since "git rebase -i" tries to
fast-forward through existing commits, it seems like "git rebase -i
--root" should ideally not create a sentinel commit, but instead stop
at the first commit marked for editing.

If, OTOH, --force-rebase is given, we should rewrite history from the
first commit, which in the case of --root would mean creating a
sentinel commit.

So, in short, I have a feeling that the sentinel commit should be
created if and only if both --root and --force-rebase (but not --onto)
are given.

> However, given the not-very-useful behaviour, I suspect that rebase --root
> is much more likely to be a mistyped version of rebase -i --root than rebase
> --root --force-rebase. (Unless I'm missing a reasonable use for this?
> History linearisation perhaps?)

Yes, the "not-very-useful"-ness of this is the clear argument against
making them no-ops. But I have to say I was slightly surprised when I
tried "git rebase --root" for the first time and it created completely
new history for me. As you say, "git rebase --root" is probably often
a mistyped "git rebase -i --root", and if that is the case, it seems
nicer (in addition to being more consistent) if we don't do anything
rather than rewriting the history. The history rewriting might even go
unnoticed and come as an unpleasant surprise later.

When working on a new project, "git rebase -i --root" might even be a
convenient replacement for "git rebase -i <initial commit>" even when
one does not want to rewrite the initial commit itself, and in such a
case, the user would clearly not want a sentinel commit either.

So I'm getting more and more convinced that the sentinel commit should
only be created if --force-rebase was given. Let me know if I'm
missing something.

Martin
