From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] textconv: don't convert for every operation
Date: Sat, 25 Oct 2008 11:32:20 -0700
Message-ID: <7v3aika5l7.fsf@gitster.siamese.dyndns.org>
References: <20081025004815.GA23851@coredump.intra.peff.net>
 <20081025005256.GD23903@coredump.intra.peff.net>
 <7vhc71b5ai.fsf@gitster.siamese.dyndns.org>
 <20081025071912.GA24287@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 20:33:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtnxN-0006sS-9t
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 20:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbYJYSch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 14:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbYJYSch
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 14:32:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbYJYScg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 14:32:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 130DA730DF;
	Sat, 25 Oct 2008 14:32:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 92F7C730DE; Sat, 25 Oct 2008 14:32:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4AF17504-A2C3-11DD-A5DE-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99117>

Jeff King <peff@peff.net> writes:

>> I am also somewhat worried about the performance impact of running
>> get_textconv() to the same filespec many times when no textconv is
>> defined, which is the normal case we should optimize for.  It appears that
>> diff_filespec_load_driver() is optimized for a wrong case (i.e. "we
>> already know this needs a custom driver and we know which one").
>
> No, it is the same as before. We always end up with a driver at the end
> of the function, so further calls will be no-ops. So we do exactly one
> attribute lookup per filespec, caching the result.

Ah, I missed that driver named "default".  Sorry for the noise.

> I think it makes sense to figure out _what_ needs fixed first, because
> it might be somewhat minor. So far I see:
>
>   - leak from fill_mmfile; this definitely needs fixed. The quick fix is
>     minor (free if we did a textconv). A more involved fix is to pull it
>     out of fill_mmfile entirely and put the code directly into
>     builtin_diff, which would be part of a re-roll of this latest
>     series.  But see below.
>
>   - Keep fill_mmfile allocation semantics clear.  I was trying to keep
>     it simple for other fill_mmfile callers to opt-in to textconv, even
>     if they chose to do it by some user-controlled mechanism instead of
>     by default (e.g., diff.TextconvDiffstat or something). But maybe
>     that is not of value to us. Again, that is a re-roll of this series.

It would be either:

 (1) non-textconv users call fill_mmfile(&mf, ..., 0), use mf and return
     without clean-up as before, while textconv users do:

 	fill_mmfile(&mf, ..., 1);
        use mf;
        if (mf->ptr != one->data)
		clean up mf->ptr;
        return;

or

 (2) non-textconv users are unchanged from v1.6.0, while textconv users
     do:

	const char *textconv = get_textconv(...);
	fill_mmfile(&mf, ...); /* no change to fill_mmfile() */
	if (textconv)
        	munge_mmfile(&mf);
	use mf;
        if (textconv)
        	cleanup_mmfile(&mf);

The end result may not be that much different, but I find the latter
easier to follow for three reasons:

 * we expect that majority of the users of fill_mmfile() are non textconv
   users.  I'd feel safer to keep their codepath the same as v1.6.0;

 * fill_mmfile() semantics is the same as long before -- it just gives it
   a borrowed pointer;

 * the code that makes a change to mmfile that requires clean-up does so
   explicitly, and that is followed by an explicit clean-up, both
   contained in the same function;

>   - performance considerations with driver loading. I believe this is a
>     non-issue. So either you are reading the code wrong,...

Yes I was.  Thanks and sorry.
