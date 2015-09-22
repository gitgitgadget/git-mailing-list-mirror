From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/2] notes: don't expand qualified refs in expand_notes_ref
Date: Tue, 22 Sep 2015 08:26:42 -0700
Message-ID: <CA+P7+xr_rXtxpuV0SpyB0ysXz0zi=ZWTRHt+TANzOqVN5g=n-g@mail.gmail.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
 <1442441194-5506-2-git-send-email-jacob.e.keller@intel.com>
 <xmqqzj0mkn7r.fsf@gitster.mtv.corp.google.com> <CA+P7+xpv_0Sf94FqMKJa0v0pSSEWXPRD2KQ0kmNBKC=2hrunhw@mail.gmail.com>
 <xmqqsi665yjm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 17:27:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZePTJ-00050m-7q
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 17:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbbIVP1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 11:27:04 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34304 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbbIVP1D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 11:27:03 -0400
Received: by iofb144 with SMTP id b144so18113749iof.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MqDnMOvNefuVkPkXbIoXJblXr7u49jSPHdlLcgZoXCk=;
        b=pxzoZeVMAXYD2lx3Sc7EGldYtdrduhIFDkpQDjU7EuWW+goyHzSSzq9NPBmsXU3ntj
         0nhm97b+AVaz4L1HpMvGIxP/eOkXll7OJ5ZlA5XBWPzmDjDy7IEb4zAkS3m8Qd7LZF2p
         4w4aGroJNThLvuq4NlAblOCNtu6kUMlkpfNMZ3XVXBYjjYsOr2/Je8LgjT9/TEIgXy5B
         6spJRaaXKQXMuLyxAHxiYwEeTy03Z0iJ56Fb2EWNdADEJuT+OFgJagMIL+ARkm3s1QBj
         1C7p9IlFaGtAr6bf48C4oNuPwgiUEkso8DEE6oFYlYljtQ0GXWw3fV/HUziV5zOxjY+s
         fMTQ==
X-Received: by 10.107.133.151 with SMTP id p23mr39689313ioi.71.1442935621466;
 Tue, 22 Sep 2015 08:27:01 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Tue, 22 Sep 2015 08:26:42 -0700 (PDT)
In-Reply-To: <xmqqsi665yjm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278393>

On Tue, Sep 22, 2015 at 7:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The current code before your patch limits the allowed pair of notes
> trees by insisting that both appear as the tips of refs somewhere in
> refs/notes/*.  For allowing to merge from outside refs/notes/, you
> need to loosen the location the latter notes tree, the one to update
> your local notes tree with, can come from.  But that does not mean
> you would want to loosen the location where the resulting notes tree
> can go.

I do not loosen where the written location can go. My patch series
sort of does the opposite of where you suggest. I change
expand_notes_ref to be more "loose" but not still keep the current
checks in place which ensure that refs outside of refs/notes don't
write to them.

>
> I think the proposed patch conflates them, and that conflation does
> not help anything.  The rule of that function used to be "It must
> come from refs/notes/ and nowhere else".  That made sense in the old
> world order where both must be from refs/notes/, and the rule still
> makes sense in the new world order for the destination of the merge.
>

Yes, I don't change the destination rule, though I do change how we
can "DWIM" so that "attempting" to merge into "refs/balagrg/foo" does
not actually merge into "refs/notes/refs/balagrg/foo". I think this is
sane.

The actual "init_notes_check" code prevents merging into refs outside
of refs/notes/*

I think it's incredibly confusing that other DWIM's do not expand
"refs/*" into "refs/something/refs/*"

> The new rule of that function after the proposed patch says "It must
> come from either refs/notes or refs/ somewhere".  This does not make
> sense for the destination because it is too loose (and we didn't see
> any justification why loosening it is a good idea), and it does not
> make sense for the source because it still is too tight.  It should
> be able to take anything get_sha1() understands (including $THEIRS
> in the above example).

Agreed, we should use something more expansive for the non-write
operations. I still think the proposed change to expand_notes_refs
would be good... but that's because I find it incredibly confusing.
Apparently we disagree on that.

>
> In addition you might also want to allow additional DWIMs from X to
> refs/remote-notes/*/X as well as from X to refs/notes/X, but that is
> secondary and should be done as a follow-up "nice to have" change,
> because both "notes/remote-notes/origin/commits" and "notes/commits"
> would be understood by get_sha1() already, and it is questinable if
> it is a good idea to introduce special DWIMs that kick in only when
> the commands are talking about notes in the first place (an equally
> questionable alternative is to teach get_sha1() about refs/notes/*
> and refs/remote-notes/*/*, which will make the disambiguation noisy
> in the normal non-notes codepath---my knee-jerk reaction is to
> suggest not to go there, either).

The DWIM's I suggest are "foo" -> "refs/notes/foo", "notes/foo" ->
"refs/notes/foo", as these already work, in addition to "<origin>/foo"
-> "refs/remote-notes/<origin>/foo" and "<origin>/notes/foo" ->
"refs/remote-notes/<origin>/foo" Obviously only kicking in for notes
references.

>
> In any case, to get us closer to that endgame, change in the
> proposed patch does not help.  It tries to cover two different cases
> with a logic that is not a good match to either.  You need to have
> two separate helpers to interpret the source and the destination.
>

My patch does the opposite of your suggestion: Loosen expand_notes_ref
while keeping the same overall restrictions, which has the same result
if being considered a little backward.

> Calls expand_notes_ref() made on a command line argument that
> specifies the source (which I think is similar to what the other
> recent topic calls "read-only") should be made to calls to a more
> lenient version (and you can start with get_sha1() for that purpose
> without introducing your own DWIMs in the first step), while leaving
> calls to expand_notes_ref() for destination and the implementation
> of expand_notes_ref() itself unmolested, so that we can keep the
> safety in expands_notes_ref() that makes sure that the destination
> of a local operation is under refs/notes/*.

expand_notes_ref doesn't actually provide the safety net. You can
bypass this entirely by using the command line, at least for the
non-write operations. In addition, documentation says "non qualified
refs will be expanded" which usually means "refs/*" will be left
alone, but in this case "refs/*" outside of refs/notes will be
expanded.

Even with just this patch the only difference is an attempt to use
refs/foo/bad *won't* expand into "refs/notes/refs/foo/bar" which is an
expansion I find incredibly confusing to begin with.

Regards,
Jake
