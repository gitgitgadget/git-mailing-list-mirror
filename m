From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Sun, 21 Jun 2015 10:15:18 -0700
Message-ID: <xmqqioahj849.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
	<xmqq1th77829.fsf@gitster.dls.corp.google.com>
	<95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
	<xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
	<558643CA.6000303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, peff@peff.net
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jun 21 19:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6iq7-00045b-En
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 19:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbbFURPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 13:15:22 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37243 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbFURPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 13:15:22 -0400
Received: by igblr2 with SMTP id lr2so40328029igb.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7gPn8QYFkJB22H7dTG8hrsn554Bgn3OC4Tz6zgWsapU=;
        b=q03bw+pcFAtxDluMD7NygGZM3tsx3aM9SPsjwx93fhOdvCRkcwy1ZiTSQQFvMd30d4
         HfRNaO/8vVkGHkPv3tHYjVraTPOh2tMCarJ++DJ67wQQm0Ck8yIi0Q/5i0yEOqzmgOWt
         vT0KL3VOfaQSg3b+udg/815LiX6vVPDWO8GeIqLvIWFJP5/0A10IyRK7X27AXFkMpwVQ
         55wON3eSA9E9QDjKqnAMbD8l+YTWg3FdimE78OFmwqU2rV73BgNyjzR/1z/xoN3qXd9Z
         jhDigJ3YAP6H10CDA1VQM8pkw0ivJ3/G9AliNvrwRN2lidoAfBVzQX9LC8ARbznxlXmr
         1m9w==
X-Received: by 10.107.168.72 with SMTP id r69mr22359878ioe.4.1434906921463;
        Sun, 21 Jun 2015 10:15:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:990b:778:aa29:b388])
        by mx.google.com with ESMTPSA id s28sm9908656ioi.31.2015.06.21.10.15.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jun 2015 10:15:19 -0700 (PDT)
In-Reply-To: <558643CA.6000303@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 21 Jun 2015 06:55:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272271>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> But now that I'm writing this, a silly question occurs to me: Do we need
> an overall option like this at all? If I demote all blob-integrity
> checks to "ignore" via the mechanism that you have added, then shouldn't
> fsck automatically detect that it doesn't have to open the blobs at all
> and enable this speedup automatically?

That's brilliant.

Just to make sure I am reading you correctly, you mean the current
overall structure:

	if (! "is the blob loadable and well-formed?") {
		report("BAD BLOB");
                ... which is equivalent to ...
                if ("is bad_blob ignored?")
			; /* no-op */
		else {
			output "BAD BLOB";
                        if ("is bad_blob an error?")
				return 1; /* error */
		}
	}
        ... other checks ...

can be turned into this structure:

        if ("is bad_blob ignored?")
		;
	else if (! "is the blob loadable and well-formed?") {
		report("BAD BLOB");
                ... which would be equivalent to ...
		output "BAD BLOB";
                if ("is bad_blob an error?")
			return 1; /* error */
	}
        ... other checks ...

I think that makes tons of sense.  With one minor caveat.  In the
above "rewrite" I deliberately described report() in the updated
flow to always output, but that would force all checkers to adopt
"do not unconditionally check; if we do not report, do not even
bother checking", which (1) would be a large change to what Dscho
currently have, and (2) might not apply to certain kinds of error
conditions.

But that minor caveat is easily addressed by keeping the "if we are
set to ignore this error, just return 0" in report().  Some codepaths
(like the "BAD BLOB" above) may not exercise it by bypassing the
call to report() upfront and that is perfectly fine.

I like that idea.

> So maybe
> `--(no-)?check-blob-integrity` is actually a shorthand for turning a few
> more specific checks on/off at once.
>
> As for thinking of a shorter name for the option: assuming the blob
> integrity checks can be turned on and off independently as described
> above, then I think it is reasonable to *also* add a `--quick` option
> defined as
>
> --quick: Skip some expensive checks, dramatically reducing the
>     runtime of `git fsck`. Currently this is equivalent to
>     `--no-check-blob-integrity`.
>
> In the future if we invent other expensive checks we might also add them
> to the list of things that are skipped by `--quick`.

Yes, that is doubly brilliant. Taken together with the auto-skipping
of the checks based on the report settings, it makes it unnecessary
to even introduce --[no-]check-blob-integrity or any other new
knobs.

Very well analysed.  I am happy with the "--quick" with that
definition.

Thanks.
