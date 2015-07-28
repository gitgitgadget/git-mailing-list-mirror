From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 12:44:28 -0700
Message-ID: <xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org, Johan Herland <johan@herland.net>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:44:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKAnj-0001wS-V0
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbbG1Toc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:44:32 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35803 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbG1Tob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:44:31 -0400
Received: by pabkd10 with SMTP id kd10so74679255pab.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gP3P3tnFmPy0HLMNtXzvLaV3FhXscoGvT1AoKsSXyOg=;
        b=Kz7JqlC0ylXBoe0FEiOqFUy79ckPiSavB6Bv4KEBEduachrCzqdZGnMKJ5lglGNTU2
         mBytmcHEIJRzCamKYXzkfzs689WPFWo+YLcAvofKNQB1yfVR19JCgZPojqkrLv7dGZoc
         RPggojilcgbyIX5iTmivEtVIjC0ASRZk/gHmyKS30mjihfbG4bWS6mqb5PEC9hZFKqbH
         n2rJ4d1wXGWxk1dhFVO3J3iAORYPamJCZBMoKA2yoh+bHWu7x3oRy/GT0fTDfuDZ5EE3
         TSTIzEimAPk95UMg15kLQ/Ze9kuFlDp1ab0uO4Awi1/2/jPFvF6NOH/4o9HsXDH/ZUIC
         KTJA==
X-Received: by 10.66.119.136 with SMTP id ku8mr82813437pab.26.1438112670794;
        Tue, 28 Jul 2015 12:44:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id yd8sm26474365pab.46.2015.07.28.12.44.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 12:44:29 -0700 (PDT)
In-Reply-To: <xmqqpp3cds44.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 28 Jul 2015 12:00:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274820>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> All-caps files like NOTES_MERGE_REF are pseudorefs, and thus are
>> per-worktree.  We don't want multiple notes merges happening at once
>> (in different worktrees), so we want to make these refs true refs.
>> ...
> The two "rev-parse --verify" looks semi-sensible [*1*];
> notes_merge_partial is all lowercase and it refers to
> $GIT_DIR/notes_merge_partial, because they are shared across working
> tree. 
>
> But then why are $GIT_DIR/notes_merge_worktree/* still checked with
> "test -f"?  If they are not refs or ref-like things, why should they
> be downcased?  If they are, why not "rev-parse --verify"?
>
> [Footnote]
>
> *1* I say "semi-" sensible, because it looks ugly.  All ref-like
>     things immediately below $GIT_DIR/ are all-caps by convention.
>     Perhaps it is a better idea to move it under refs/; "everything
>     under refs/ is shared across working trees" is probably a much
>     better rule than "all caps but HEAD is special".

I am not sure if "we don't want multiple notes merges at once" is a
valid cause for this inconsistency in the first place.  When you try
to start merging a notes tree in one place (leaving NOTES_MERGE_REF
and friends in the ref storage shared across worktrees), should you
be prevented from merging a different notes tree in another?  Isn't
the whole point of having refs/notes/ hierarchy to allow different
notes to hang underneath there, and isn't NOTES_MERGE_REF symref
about keeping track of which one of them is being worked on in this
working tree?

We don't want multiple usual merges at once in different worktrees,
either; rather, we don't want conflicting updates to the same branch,
be it done by a merge or a single-parent commit, from different
worktrees.  And the way we protect ourselves is by forbidding two
checkout of the same branch by controlling what HEAD can point at.

Making NOTES_MERGE_REF shared across working trees feels like
solving that "no multiple checkouts" problem by making HEAD shared
across working trees, ensuring that only one of them can have usable
HEAD.  Instead, shouldn't we be solving the issue by allowing
NOTES_MERGE_REF in multiple working trees point at different refs
but ensuring that there is at most one working tree that updates one
particular ref in refs/notes/ hierarchy?  Can't we learn from (and
even better, reuse) the logic that controls HEAD for this purpose?

I think it is OK for us to admit that the "notes" subsystem is not
quite ready to work well with multiple working tree world yet [*1*],
and move this series forward without worrying about them.


[Footnote]

*1* I am not saying that the notes subsystem can forever stay to be
    second class citizen that does not know about multiple worktrees
    or pluggable ref backends.  But my brief scan of builtin/notes.c
    seems to indicate that there are quite a lot of work to be done
    to prepare it for these two big changes.  My gut feeling is
    that:

    - NOTES_MERGE_REF symref is like HEAD, that is per working tree
      but is controlled across working trees---no two working trees
      can "checkout" the same refs/notes/* tree for conflict
      resolution at the same time.  It should be all-caps and live
      directly under $GIT_DIR/.

    - NOTES_MERGE_PARTIAL is like MERGE_HEAD or the index in that it
      is merely a state of in-progress merge that is private to a
      single working tree.  $GIT_DIR/NOTES_MERGE_PARTIAL is just
      fine, and we do not have to change it.

    - NOTES_MERGE_WORKTREE is a temporary area in the filesystem
      that houses bunch of blob files (i.e. notes contents).  It
      should be per-working tree but it is not even refs.
      $GIT_DIR/NOTES_MERGE_WORKTREE is just fine, and we do not have
      to change it.

    And as to adjusting to the "ref backend with pseudo ref" world,
    I think the code is more-or-less ready, especially because your
    recent round of this series teaches the "pseudorefs private to
    working tree" to update_ref() and delete_ref(), relieving the
    ref API users like notes subsystem from having to worry about
    them.

    So the only potential issue in the notes subsystem is to ensure
    NOTES_MERGE_REF from multiple working trees do not point at the
    same thing at the same time, with a similar protection we have
    for HEAD, I think.
