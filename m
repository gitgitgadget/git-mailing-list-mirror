From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/17] revert: Propogate errors upwards from
 do_pick_commit
Date: Sun, 17 Jul 2011 11:59:04 -0500
Message-ID: <20110717165904.GA27787@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-6-git-send-email-artagnon@gmail.com>
 <20110712173220.GA14120@elie>
 <CALkWK0=6A=2z5BShsiHeMCS2Movn+L3V4P1WJTTQ-HexTasAhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 18:59:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiUgb-0007sr-C2
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 18:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778Ab1GQQ7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 12:59:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44098 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab1GQQ7O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 12:59:14 -0400
Received: by iwn6 with SMTP id 6so2476625iwn.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CK5mqKKMrFcANdZUjRInjfvJTd0qrPn6kkVCWZ56G6o=;
        b=WanjIaSkesai87NrmPqpypwTKzZ6oJ/xtUy5kiTQd6AxRBYp+ngj2BpHMcmO4coEqr
         q8kUrU7mJyrW+X92Kt596d9xIn6rxJ5OPCXtIVtbEEaEhn6pmuEwWeVmLLJg1rszvUWV
         7jZQOhxCxsp3uG7F2j/RqE93X6D0siEzcpKaM=
Received: by 10.231.179.208 with SMTP id br16mr5137711ibb.87.1310921953847;
        Sun, 17 Jul 2011 09:59:13 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id f13sm2321682ibe.27.2011.07.17.09.59.11
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Jul 2011 09:59:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=6A=2z5BShsiHeMCS2Movn+L3V4P1WJTTQ-HexTasAhg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177306>

Hi,

Ramkumar Ramachandra wrote:

> revert: Propogate errors upwards from do_pick_commit
>
> Currently, revert_or_cherry_pick can fail in two ways.  If it
> encounters a conflict, it returns a positive number indicating the
> intended exit status for the git wrapper to pass on; for all other
> errors, it calls die().  The latter behavior is inconsiderate towards
> callers, as it denies them the opportunity to do some post-processing
> or cleanup before exiting.  For instance, later in the series, caller=
s
> will want to save some data about the current operation before
> exiting.

Thanks for explaining.  Why can't callers use set_die_routine() or
atexit()?  Is the last sentence true?

> Change this by replacing some of the calls to "die" with calls to
> "error", so that revert_or_cherry_pick can return negative values too=
=2E
> While postive return values indicate conflicts as before, negative
> ones indicate other errors.  This return status is propogated updward=
s
> from do_pick_commit, to be finally handled in cmd_cherry_pick and
> cmd_revert.
>
> In the same spirit, also introduce a new function error_dirty_index,
> based on die_dirty_index, which prints some hints and returns an erro=
r
> to its caller do_pick_commit.
>
> While the full benefits of this patch will only be seen once all the
> "die" calls are replaced with calls to "error", its immediate impact
> is to change some of the "fatal:" messages to "error:" messages and
> print a new "fatal: cherry-pick failed" message when the operation
> fails.

Starting to get long.  It's not immediately obvious to me why
error_dirty_index is a detail that needs to be singled out.  Maybe
these three paragraphs could be summarized by saying:

 After this patch, revert_or_cherry_pick will still return a positive
 return value to indicate an exit status for conflicts as before,
 while for other (fatal) errors it will print an error message and
 return -1 instead of die()-ing.  The cmd_revert and cmd_cherry_pick
 are adjusted to handle the fatal errors by die()-ing themselves.

 Thus for now, the only user-visible impact would be to change some
 "fatal:" messages to say "error:" and to add a new "fatal:
 cherry-pick failed" message at the end when the operation fails.

 Since no callers take advantage of the ability to recover from
 errors yet, it is possible and even likely that these functions do
 not completely clean up after themselves on (fatal) error but leave
 some state to be cleared away by exit().  Callers beware!

That last paragraph summarizes my worry.  Since this API change does
not seem to be used by the other patches, I would prefer not to
leave such a trap for unwary new callers, at least until the intended
legitimate use is a little clearer.

[...]
>> write_cache_as_tree() locks the index and does not always commit or
>> roll it back except on success. =C2=A0Current callers aren't likely =
to try
>> to lock the index again (since they just die()), but presumably the
>> goal of returning error() here is to allow for callers that want to
>> stay alive and do something more. =C2=A0How should they recover (i.e=
=2E, what
>> is the intended API)?
>
> Hm, there was supposed to be a discard_cache() before this error as I
> recall -- fixed now.  Thanks for catching.

discard_index() does not unlock the index.

I had wondered what the discard_cache() stuff was about before; thanks
for explaining.

>> Similar questions probably apply to calls to other APIs that return =
-1
>> to mean "I failed; please print an appropriate message about that an=
d
>> exit". =C2=A0I haven't checked carefully, since the answer to this e=
xample
>> could help in knowing what to look for in the others.
>
> I think the others are fairly clear actually.

Roughly speaking, there are two kinds of functions that return error()
instead of die()-ing in the git codebase:

 1. Those that recover from their errors, leaving the process in a
    sane state that allows the caller (e.g., a long-lived interactive
    porcelain) to go on to do other things

 2. Those that do not have enough information to give a useful error
    message themselves, so delegate to the caller the responsibility
    to die() with an error message about where in the program the
    failure occured.

The commit message suggests that you are introducing a new category:

 3. Those that could die() without trouble, _except_ that some callers
    want to do cleanup of private state on exit and atexit() is not
    working for them for some reason

But from this description of it you can see that the category seems
questionable and unlikely to be necessary to me.

How do callers know which of the three categories a function being
called falls into?  That question is relevant because the caller must
respond accordingly:

 a. In case (1), the caller can go on with its work.
 b. In case (2), the caller writes a good error message and die()s ASAP=
=2E
 c. In the new case (3), the caller needs to exit() or die() ASAP,
    but there is no message that especially needs to be written.

I had thought the idea was to put pick_commits() in case (1) (usable
by long-lived porcelain like cgit that don't want to exit).  To
accomplish that, when you call a function of type (2), you would need
to audit its implementation to see what changes it needs to move to
type (1), if any.  (FWIW, I am not convinced you've tried to do this,
hence the comment above about it.)

It clearly is not part of case (2).  All the useful context has
already been written to stderr when pick_commits() returns.

If it is case (3), the reader is going to wonder why you didn't just
use atexit() or set_die_handler() and why it is worth the
complication.

Does that make sense?
Jonathan
