From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: Allow treeish expressions as notes ref
Date: Mon, 13 Jul 2015 09:35:40 -0700
Message-ID: <xmqqzj30yq03.fsf@gitster.dls.corp.google.com>
References: <CALKQrgdGJy6vtBRL413bbSHSi+=KTh4Q98hpbgg29j4J191=bA@mail.gmail.com>
	<1436517551-12172-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 18:35:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEgho-00008G-Bw
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 18:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbbGMQfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 12:35:44 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35370 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbGMQfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 12:35:43 -0400
Received: by igcqs7 with SMTP id qs7so61550232igc.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=P7DkWCklb4AMgz1g1zCaQIeWGEHwdA1XA5uXF3O4b9I=;
        b=ZFb0QRlpM+hroqtNWw1REMMbVx2GnVf8RnGhW0JqGORS15QhnK/uegHUgV5B67uumD
         6Pw1arE+QYdHk5/YV8MQp1/MNQFfLDOMJkGUds+J4QwR+huI9x+6zx7EtUjvCbm6wb2H
         8tIPy5XlPFx6+cXJM0VI9bCCJLdnN7OuThPRyGg8iDond7PnNE2X7AkEE5tkHPXcwQ9e
         ys/ovFwhG7uONTudZC8tmBE1KM9HN0tvNP8FBAHxtBHFHi1L+hxuQTSVmOoUaLRMlH7p
         bS1K1vTBAH/GGCp1XkdZ0d6SDxsXt4ephOhLnXyCcZwQYnMte3eSILyBSEypTBUvBmlD
         BYnw==
X-Received: by 10.107.26.203 with SMTP id a194mr44585996ioa.62.1436805342572;
        Mon, 13 Jul 2015 09:35:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4d10:ec6a:e89:91cb])
        by smtp.gmail.com with ESMTPSA id g12sm12857422ioe.28.2015.07.13.09.35.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Jul 2015 09:35:41 -0700 (PDT)
In-Reply-To: <1436517551-12172-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Fri, 10 Jul 2015 17:39:11 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273920>

Mike Hommey <mh@glandium.org> writes:

> init_notes() is the main point of entry to the notes API. It is an arbitrary
> restriction that all it allows as input is a strict ref name, when callers
> may want to give an arbitrary treeish.
>
> However, some operations that require updating the notes tree require a
> strict ref name, because they wouldn't be able to update e.g. foo@{1}.
>
> So we allow treeish expressions to be used in the case the notes tree is
> going to be used without write "permissions", and to distinguish whether
> the notes tree is intended to be used for reads only, or will be updated,
> a flag is added.

It is unfair to call the current check arbitrary, though.  From the
point of view of the person who views notes as a database, it is
entirely a sensible thing to treat it as an read/write data store.

> This has the side effect of enabling the use of treeish as notes refs in
> commands allowing them, e.g. git log --notes=foo@{1}.

I do not think it is a "side effect".  It's the primary benefit this
change brings in.

I'd flip the attitude around and sell this as "an enhancement",
perhaps like this:

    notes: allow treeish expressions as notes ref
    
    init_notes() is the main point of entry to the notes API. It ensures
    that the input can be used as ref, because it needs a ref to update
    to store notes tree after modifying it.
    
    There however are many use cases where notes tree is only read, e.g.
    "git log --notes=...".  Any notes-shaped treeish could be used for
    such purpose, but it is not allowed due to existing restriction.
    
    Allow treeish expressions to be used in the case the notes tree is
    going to be used without write "permissions".  Add a flag to
    distinguish whether the notes tree is intended to be used read-only,
    or will be updated.
    
    With this change, operations that use notes read-only can be fed any
    notes-shaped tree-ish can be used, e.g. git log --notes=notes@{1}.
    
    Signed-off-by: Mike Hommey <mh@glandium.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


One thing I found puzzling is that the "arbitrary restriction" does
not seem to do anything visibly "restricting".

I taught my copy of "git am" to add the message-ID of the original
patch to the resulting commit, and that is kept in "amlog" notes.

Without this patch, I am getting this:

    $ git log --notes=amlog -1 --pretty=short
    commit 7a3744f95d4d21b27470e5bacaed8c434150ecac
    Author: Mike Hommey <mh@glandium.org>

        notes: allow treeish expressions as notes ref

    Notes (amlog):
        Message-Id: <1436517551-12172-1-git-send-email-mh@glandium.org>

The above is very much expected.  Now without your patch, I get
this:

    $ git log --notes='amlog@{1}' -1 --pretty=short
    commit 7a3744f95d4d21b27470e5bacaed8c434150ecac
    Author: Mike Hommey <mh@glandium.org>

        notes: allow treeish expressions as notes ref

It seems to be ignoring what is not a refname without complaining.
However, that does not seem to be the whole story.  Look:

    $ git log --notes='amlog@{1' -1 --pretty=short
    warning: notes ref refs/notes/amlog@{1 is invalid
    commit 7a3744f95d4d21b27470e5bacaed8c434150ecac
    Author: Mike Hommey <mh@glandium.org>

        notes: allow treeish expressions as notes ref

    $ git log --notes='amlog@{5000}' -1 --pretty=short
    fatal: Log for 'refs/notes/amlog' only has 3072 entries.

So sometimes we silently ignore, sometimes we warn, and sometimes
we refuse to work.  The above are all without your patch applied.

With your patch, the only change I see is this:

    $ git log --notes=amlog@{0} -1 --pretty=short
    commit 7a3744f95d4d21b27470e5bacaed8c434150ecac
    Author: Mike Hommey <mh@glandium.org>

        notes: allow treeish expressions as notes ref

    Notes (amlog@{0}):
        Message-Id: <1436517551-12172-1-git-send-email-mh@glandium.org>

We read from a tree-ish ;-) Whee!

What is interesting is to think what should happen when amlog@{1}
is given.  The version with your patch gives the same output as we
saw earlier, because amlog@{1} tree exists, but does not know about
your patch (yet), so does not add "Notes" section, which makes sense
by itself.

But we cannot tell if amlog@{1} was somehow malformed or it was OK
and there was no notes on the commit.

We probably should do a few more things:

 - Make sure that we show "there is no such tree-ish, no way to look
   up any note to any commit from there" and "I understood the tree
   you gave me, but there is no note for that commit" differently.

 - Decide if we want to "fail" the operation when the notes tree
   given by the user is not even a tree-ish or just "warn" and keep
   going.  And do so consistently.

Thanks.
