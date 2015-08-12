From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Thu, 13 Aug 2015 00:04:36 +0200
Message-ID: <CALKQrgfyxRG0dMBKUcsfV5ybu16nVhWPwa9rCBjT=ba93p+aEQ@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
	<1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
	<CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
	<xmqqy4hhmedb.fsf@gitster.dls.corp.google.com>
	<CA+P7+xrSAo43=-3q-7SPxerYPKU3+T75dG5dTE=H8odicRDxSg@mail.gmail.com>
	<xmqqa8twl3x9.fsf@gitster.dls.corp.google.com>
	<CA+P7+xournf+1Cqnr-AAO+EzUee3KfEevFQLhXkqyfQGBvPRpQ@mail.gmail.com>
	<CA+P7+xpsjX=4j=7w7DJ+EnO-uBfq53_Bmwk8AZ4frAy=iTQ7ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 00:04:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPe8f-0007mO-DT
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 00:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbbHLWEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 18:04:45 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:64661 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbHLWEp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 18:04:45 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZPe8Y-000M90-J3
	for git@vger.kernel.org; Thu, 13 Aug 2015 00:04:42 +0200
Received: by ykdz80 with SMTP id z80so26439570ykd.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 15:04:36 -0700 (PDT)
X-Received: by 10.13.223.204 with SMTP id i195mr23371803ywe.91.1439417076626;
 Wed, 12 Aug 2015 15:04:36 -0700 (PDT)
Received: by 10.37.201.134 with HTTP; Wed, 12 Aug 2015 15:04:36 -0700 (PDT)
In-Reply-To: <CA+P7+xpsjX=4j=7w7DJ+EnO-uBfq53_Bmwk8AZ4frAy=iTQ7ZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275822>

On Wed, Aug 12, 2015 at 11:43 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Aug 12, 2015 at 12:16 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Oh interesting. I did a test. If you provide a fully qualified ref not
>> inside refs/notes, then it assumes you meant refs/notes/refs/foo/y
>> rather than refs/foo/y
>>
>> I need to do some more digging on this to determine the exact thing going on...
>>
>> Regards,
>> Jake
>
> I did some more digging. If you pass a notes ref to "--refs" option,

You're referring to the --ref option to 'git notes'?

> that requires all notes to be bound to refs/notes/* and does not allow
> passing of arbitrary refs. However, you can set the environment
> variable GIT_NOTES_REF or core.notesRef to a fully qualified
> reference.
>
> That seems very arbitrary that --ref works by expanding notes and the
> environment variable and configuration option do not... [1]

I believe the intention here was to provide the DWIM-ing at the most
end-user-facing interface (leaving the two other interfaces as possible
"loopholes" for e.g. scripts that "known what they're doing" and don't
want the DWIM-ery to get in their way). Looking back at it now, that
approach was probably misguided.

> I think this inconsistency is very weird, because *most* people will
> not use refs/notes/* etc. This makes it so that --refs forces you to
> use refs/notes/* or it will prefix it for you... ie: you can use
> notes/x, refs/notes/x, x, but if you use refs/tags/x it will DWIM into
> refs/notes/refs/tags/x
>
> I think this is very confusing that --refs doesn't behave the same as
> other sections... either we should enforce this on all refs or we
> should fix the DWIM-ery to be consistent.
>
> that is, we should fix DWIM-ery to be:
>
> (1) if it starts with refs/* leave it alone
>
> (2) if it starts with notes/*, prefix it with refs/
>
> (3) otherwise prefix it with refs/notes/
>
> But that way, refs/some-other-notes/ will work fine instead of
> becoming something else.

Yes, that is probably a better way to do the DWIM-ery.

However, we then need to provide an additional layer of safety/checks
that prevent notes operations from manipulating non-notes refs. First:

 - As mentioned elsewhere in the thread, git notes merge should certainly
   refuse to merge into anything not under refs/notes/*.

 - Preferably, all notes _manipulation_ should be limited to only operating
   under refs/notes/* (although I haven't fully thought through all of the
   ramifications of that).

 - Notes _querying_ (as opposed to manipulation) should be allowed both
   within and outside refs/notes/*

I think this should cover the use cases where you fetch notes from a remote
and put them in e.g. refs/remote-notes/* (or refs/remotes/origin/notes/*).
After all, you should not manipulate those notes directly (just as you
don't manipulate your remote-tracking branches directly), but you should
definitely be able to query them, and merge them into a _local_ notes ref
(living under refs/notes/*).

Does that make sense?

> We should also fix reads of environment variable etc such taht we
> enforce these values always are fully qualified and begin with refs.
> Otherwise, use of --refs and the environment variable don't allow the
> same formats.

Agreed.


...Johan

> Regards,
> Jake
>
> [1] 8ef313e1ec3b ("builtin/notes.c: Split notes ref DWIMmery into a
> separate function")
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Johan Herland, <johan@herland.net>
www.herland.net
