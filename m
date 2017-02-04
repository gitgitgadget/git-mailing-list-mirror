Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D7A1FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 07:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbdBDH1K (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 02:27:10 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35631 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753740AbdBDH1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 02:27:09 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so3093336pfa.2
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 23:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=XRQZeh2RX9Wdrgev45ObjT1kxezlNt4+IOUew9SARss=;
        b=hXDlSFt9kVQEn1CUXWBJSa16/kylap0XHfd4GwH6Uc/lA3LuPlpuragIFwGHyEZyel
         PWwNBNH9ikvneHzs/cdRjF568YXrpDlDqkL0jxnRDm5fWrj/edaaSH9/hMsOkxujVhCY
         ns3137OCJ5E9mXRJKOk4Gfx2Np4B7PxfJIx+QZ6uZ1jsvIfJxI0OeXvUV/osdrDd2W7h
         B2hl63YiP9on8GXIyLtnE4N0jrs07pBfZ9QGCr8c3EiRC1o1yZejdwrazhCE1s7amqXb
         fS76xjtglaMtAJfLbERx07cprBoM6oeliG7hwIGQ+uZ5WtumzX3Zqs4AFpxZhzpF8WjQ
         4ROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=XRQZeh2RX9Wdrgev45ObjT1kxezlNt4+IOUew9SARss=;
        b=s6A0Q81x58wbMu46zCDtiWGodydIu41dlsReQ+uifyBqVIXuHcMOp6FgmXImwK7TKk
         DARtLejTBR77tz8rzi8+8yTKZjh4PG1QoaR5JSFL5n6Spw/LBKMmBWigUpNJGlrmZXsi
         rQTIzgI8A0YdBuGr1TjaRS4NkhxvqGtQS/TxdHMYLwVcjRtJ8AyC/0xrFiMMg2dKHXQd
         YonEV6QOHPEfivMNH2bIJMzHh4kFN5vFSBNHT6KQrXuGP/dz99SOzA6n6rfopT+2uDoz
         3HrMWlXT0Uv4YC5cmEChlaAoLq9D26+JwwB6m6A4E+g79iNpISgmoxbJjM0tOrW/FOKV
         d5UA==
X-Gm-Message-State: AIkVDXKciXC84ernQgSiwH/GBfloFNluE1DS7r3j73KHzchG3lEJzLxu5H3K4q6wx/4kRw==
X-Received: by 10.99.156.2 with SMTP id f2mr1176745pge.189.1486193228786;
        Fri, 03 Feb 2017 23:27:08 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id c11sm72295951pfk.14.2017.02.03.23.27.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 23:27:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: How I review patches
Date:   Fri, 03 Feb 2017 23:27:07 -0800
Message-ID: <xmqq37fu5sc4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a write-up on how I review patches posted on the list, in
the hope that knowing what to expect may help contributors [*0*].

But before going into exactly how I do my reviews, here is a short
list of the goals of doing reviews.  I review a patch (or a set of
patches) to ensure that including it to our codebase will NOT:

 * hurt users of existing versions of Git. [*1*]

 * hurt users of the version of Git the change appears in. [*2*]

 * make life harder for developers [*3*] of Git in the future. [*4*]

The remaining paragraphs of this message are not to be taken as me
telling other reviewers how they must conduct their reviews.  I will
queue, and I have queued, patches reviewed by other reviewers
without doing detailed reviews myself, as long as I trust that the
reviewers share the same goals in their reviews, and as long as I
trust their competence and taste.  How they exactly review may be
different from how I would have reviewed the patches, and that is
perfectly fine.

1. Description of the problem being solved.

When I see a patch (or a set of patches), I first read the proposed
log message, documentation update and new in-code comments.

These are places where the contributor can (and is expected to)
explain the motivation behind the change.  I read them to make sure
that they clearly state what problem is being solved, why a
particular solution was chosen, what exactly that solution is, and
what other solutions were considered but discarded.

Just like "X is broken" in a bug report is not clear enough, "Fix X"
is often not enough in the proposed log message, as it is not clear
which part of what X does is wrong in the contributor's mind, and
why the contributor thinks it is broken.  Saying "X currently does Y
but it should do Z instead to help such and such use case." would
help reviewers (and future developers who will read it) understand
the motivation behind the change.

A new feature or enhancement that is worth adding by default needs
to be explained how that new thing works and why it is there to the
end users, so a lack of documentation update is noticed at this
stage as well.

When I find that the explanation is lacking after reading the cover
letter, proposed log message, and documentation updates, I often ask
the contributor to elaborate, before going into the actual diff.  I
often suggest "perhaps you meant this?", and I end up reading the
actual diff to base my best guess on in order to do so.  This is
also where I notice a tricky code whose "why" is under-explained in
in-code comments [*5*].

To such review comments, I do not want the contributor to just say
"yes, you now understand what I wanted to do with this change".  I
want to see the log message, in-code comments and documentation
updated so that other reviewers and future developers will not have
to ask the same question as I asked again.

2. Design of the solution.

After clarifying the original motivation of the contributor, it
sometimes becomes apparent that the patch aims too low and attempts
to solve too narrow an issue.  I would point out that, within the
context of the patches, they can and should solve a wider range of
problems of the same class [*6*].  Or the patch may hurt users in
use cases that the contributor did not consider, and the solution
may need to be designed to cover these cases [*7*].  This design
review may cause us to iterate until we have a good description of
the problem and design of the solution.


3. "Code" review.

Once we made sure that the motivation is made clear, the scope of
the change is refined, and the design of the solution described
clearly, I dive into the code changes.  What I look for primarily
during this phase is to see what the code does matches the desired
behaviour we established before this phase for correctness.  This is
what many people think of as "code review", and it ranges from
spotting style issues and typoes, finding and fixing stupid
off-by-one errors, to noticing future maintainance issues caused by
using a wrong abstration or a misdesigned API.

During the review of the actual code change, I may discover that
some common corner cases are not handled properly, which I would
point out.  Or the contributor may have thought about tricky corner
cases and handled them correctly in the patches, but did not explain
the "what" and "why" in the log message.  Recording what cases were
considered and decided based on what reasoning in the log message is
important to help future developers and sets the course of evolution
of the codebase, and this may result in updates in the "explanation
of the changes" reviewed early in the cycle.

It is not like I never look at the code until log message and
explanation is perfect; to reduce the number of back-and-forth, I do
comment on the code even before it becomes clear if the design is
sound and clearly described.  But at the conceptual level, because
the motivation guides the design and the design guides the
implementation, I tend to review the patches in this order.

Hope the above helps current and future contributors when they are
preparing and reviewing their patch series before submitting.


[Footnotes]

*0* If disclosing this to contributors turns out to be a good idea,
    we may want to add a polished version of this to somewhere in
    Documentation/ next to SubmittingPatches.

*1* For example, we need to be very careful when changing the
    on-disk or on-wire data.  We as developers may always run the
    bleeding-edge version of Git, but how well do users with older
    version of Git interact with our new shiny toys?  Backward
    compatibility issues can hurt users of existing versions Git
    that do not have the change the patch introduces.

*2* That's called a "bug" in general, but can take different forms
    (i.e. implementation bug, documentation bug, design bug, etc.).
    Maybe the documentation promises to (or it can be misread to
    promise to) do A when the actual code does B instead.  Maybe the
    code does A most of the time but silently does something else in
    a corner case, without documenting it.  Maybe the problem the
    patches wanted to solve have two different ways to solve,
    and the patches chose one way to solve and implemented it
    correctly as it documented the feature, but the approach taken
    may be a way that forces users to use Git in an awkward way or
    encourages them to employ a bad workflow, when there is another
    way that helps users better.

*3* Future users of Git cannot be hurt more than the patches
    themselves hurts them immediately.  Patches may make a design
    mistake that makes it hard or impossible to extend a part of the
    system further, and users can be robbed their opportunity to use
    even better Git in the future---but the "even better Git" does
    not exist yet when the patches are accepted anyway, and their
    user experience at least does not get worse, at least.  The
    developers will find a way to work it around and transition
    existing users to allow such an extension into existence and
    their work may be made harder by such a design mistake, though.

*4* A set of patches may add a helper function that is useful for any
    NUL-terminated string, but may make the helper take a pointer to
    a strbuf because the callers to it in the patches happen to all
    have the string in a strbuf.  That forces future developers who
    want to call the helper to either wrap their string in a strbuf
    or to fix the misdesigned API to the helper function to take a
    simple "char *".

    A set of patches may introduce a new helper function to split
    fields in a string whose format is well known throughout the
    system, for which there already exists a helper function to do
    the splitting.  This doubles the amount of work required when
    the format of the string needs to be extended in the future.

    A set of patches may conflate two semantically distinct sets of
    things and try to parse elements of both set with a single
    helper function, only because the elements in these two sets
    happen to be the same in the version immediately after applying
    the patches. This forces future developers who need to add
    more elements to one set without affecting others to split the
    helper into two.

    All of the above make it harder for developers that need to
    enhance the system in the future, but they will NOT hurt users
    of existing version or the version immediately after the patches
    land.  Such a patch series may happen to work correctly
    at that version, and no amount of tests or field trials will
    reveal these maintainance issues.

*5* In-code comments that do not explain why the code does things in
    a particular way but just translates what it does from C to
    English add to maintenance burden of having to keep it in sync
    with the code, without adding much value to the readers of the
    code.  They instead should explain why the code does what it
    does.

*6* For example, a contributor may originally wants to solve
    something only for tags, but it is not uncommon that the issue
    that exists for tags are shared by other kinds of refs, and it
    may be better to solve it uniformly across tags, branches, etc.

*7* "cover"ing other uses cases does not necessarily have to be done
    perfectly.  In less likely situations, it may be OK to punt and
    say "my code cannot handle it" and die() with a message, and
    that is much much better than not considering these situations
    and doing wrong things.
    
