From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] notes: don't expand qualified refs in expand_notes_ref
Date: Tue, 22 Sep 2015 07:17:01 -0700
Message-ID: <xmqqsi665yjm.fsf@gitster.mtv.corp.google.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
	<1442441194-5506-2-git-send-email-jacob.e.keller@intel.com>
	<xmqqzj0mkn7r.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xpv_0Sf94FqMKJa0v0pSSEWXPRD2KQ0kmNBKC=2hrunhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 16:17:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeONd-0005Hz-J8
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 16:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758060AbbIVORI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 10:17:08 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35588 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbbIVORF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 10:17:05 -0400
Received: by pacfv12 with SMTP id fv12so10767511pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZvuR3HKoEGKkZ2q9Y4QMffRQNbsXLUh9lJtmcXzGSsY=;
        b=HNrQt0/0tSBPbe5Zjb6CzTntjmSDl10Dm+Shjm/AK1IHwynzoVgQEJRPasaPAU8El0
         B4r8cVjZH1G2xM8X07ovGPKt05XxrPJanxJT7PwWq4bIiTqAR0lEBUANdtP3FRs7jAqv
         mRvjTW+SlAROCofpsr5YbmwU0R8wlELacOKWCPxL/o5/pH2CEfKiUJZBwV/yMkTAsVTO
         v7I5d3qGy1Pt9hHfU5+WqvaaFGVIXyPd7jg4/ffskWLxd/T5wpcKVRgZ9ew/pDoTP7GN
         4geRddZgMxCO6cvMwA3kMQCH18EA9BeChof12eHw98Us9eaywaovDo+IPC5T6HBoFNir
         SXnQ==
X-Received: by 10.68.215.73 with SMTP id og9mr31369913pbc.122.1442931424922;
        Tue, 22 Sep 2015 07:17:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id bh5sm2698707pbc.5.2015.09.22.07.17.02
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 07:17:03 -0700 (PDT)
In-Reply-To: <CA+P7+xpv_0Sf94FqMKJa0v0pSSEWXPRD2KQ0kmNBKC=2hrunhw@mail.gmail.com>
	(Jacob Keller's message of "Mon, 21 Sep 2015 23:50:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278391>

Jacob Keller <jacob.keller@gmail.com> writes:

> I never got any better suggestion on how to allow the behavior
> desired, which is to enable merging from a non-notes location, in
> order to provide a standard location for remote notes, ie:
> refs/remote-notes/<remote>/<ref>

Step back a bit and think again.  I think you are blinded by your
refs/remote-notes/*.

It is fine to wish that

    $ notes merge refs/notes/commits refs/remote-notes/origin/commits

to work, but you shouldn't force your users to use remote-tracking
refs in the first place.  Your users should be allowed to do this as
well:

    $ fetch origin refs/notes/commits
    $ THEIRS=$(git rev-parse FETCH_HEAD)
    $ notes merge refs/notes/commits $THEIRS

We need to realize that "notes merge" involves two notes trees and
they are of different nature.  The notes tree you are merging into
and recording the result (the destination), which will be a local
note, and the other notes tree you obtained from elsewhere and
update that local note with (the source).

The current code before your patch limits the allowed pair of notes
trees by insisting that both appear as the tips of refs somewhere in
refs/notes/*.  For allowing to merge from outside refs/notes/, you
need to loosen the location the latter notes tree, the one to update
your local notes tree with, can come from.  But that does not mean
you would want to loosen the location where the resulting notes tree
can go.

I think the proposed patch conflates them, and that conflation does
not help anything.  The rule of that function used to be "It must
come from refs/notes/ and nowhere else".  That made sense in the old
world order where both must be from refs/notes/, and the rule still
makes sense in the new world order for the destination of the merge.

The new rule of that function after the proposed patch says "It must
come from either refs/notes or refs/ somewhere".  This does not make
sense for the destination because it is too loose (and we didn't see
any justification why loosening it is a good idea), and it does not
make sense for the source because it still is too tight.  It should
be able to take anything get_sha1() understands (including $THEIRS
in the above example).

In addition you might also want to allow additional DWIMs from X to
refs/remote-notes/*/X as well as from X to refs/notes/X, but that is
secondary and should be done as a follow-up "nice to have" change,
because both "notes/remote-notes/origin/commits" and "notes/commits"
would be understood by get_sha1() already, and it is questinable if
it is a good idea to introduce special DWIMs that kick in only when
the commands are talking about notes in the first place (an equally
questionable alternative is to teach get_sha1() about refs/notes/*
and refs/remote-notes/*/*, which will make the disambiguation noisy
in the normal non-notes codepath---my knee-jerk reaction is to
suggest not to go there, either).

In any case, to get us closer to that endgame, change in the
proposed patch does not help.  It tries to cover two different cases
with a logic that is not a good match to either.  You need to have
two separate helpers to interpret the source and the destination.

Calls expand_notes_ref() made on a command line argument that
specifies the source (which I think is similar to what the other
recent topic calls "read-only") should be made to calls to a more
lenient version (and you can start with get_sha1() for that purpose
without introducing your own DWIMs in the first step), while leaving
calls to expand_notes_ref() for destination and the implementation
of expand_notes_ref() itself unmolested, so that we can keep the
safety in expands_notes_ref() that makes sure that the destination
of a local operation is under refs/notes/*.
