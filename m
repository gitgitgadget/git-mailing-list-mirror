From: Junio C Hamano <gitster@pobox.com>
Subject: Re: orthogonal cases of log --date option
Date: Fri, 06 Mar 2009 00:02:10 -0800
Message-ID: <7v1vtbw03h.fsf@gitster.siamese.dyndns.org>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
 <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
 <20090305104304.GA17760@coredump.intra.peff.net>
 <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com>
 <20090305211120.GB20157@coredump.intra.peff.net>
 <7vy6vjy5js.fsf@gitster.siamese.dyndns.org>
 <20090306052318.GB3426@sigill.intra.peff.net>
 <7vmybzw3el.fsf@gitster.siamese.dyndns.org>
 <76718490903052258j277fa8e9g963deae1c3264a22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:03:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfV27-00060c-9z
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 09:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbZCFICY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 03:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbZCFICX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 03:02:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbZCFICX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 03:02:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C0D19F96D;
	Fri,  6 Mar 2009 03:02:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8B5099F96C; Fri,
  6 Mar 2009 03:02:13 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1D82A204-0A25-11DE-A9EB-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112400>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Fri, Mar 6, 2009 at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> Because from the user's perspective --foo={bar,baz,bleep} is about
>>> selecting exactly one of {bar,baz,bleep}.
>>
>> I do not feel very strongly about this either way, and without any prior
>> end user "Huh?" input, I would probably have argued like you myself, but
>> I saw the original message from Miles about giving more than one --date
>> and getting perplexed to see that it did not work, so...
>>
>> I am not likely to use --tz=Indian/Christmas myself; GMT and local might
>> however be useful in some situations, though.
>
> So I don't mind picking this up, but I'd like some guidance. There are
> two issues:
>
> 1) The CLI. You and Jeff don't seem to have an agreement here, but
> frankly, this is the easy part.
>
> 2) The internal implementation. Your implementation (enum -> bitfield)
> is clever, but Jeff seems to prefer what I suggested (going to a
> struct). The latter is quite a bit more work.

Is it?  Isn't it just the matter of doing something like this?

	struct date_mode {
        	enum {
                DATE_NORMAL = 0,
                DATE_RELATIVE,
                ...
                DATE_RAW
                } format;
                enum {
                DATE_ORIGINAL = 0,
                DATE_LOCAL
                /* perhaps ",DATE_GMT" later... */
                } tz_offset;
	};

	/* In revision.c::handle_revision_opt() */
        ...
	} else if (!strcmp(arg, "--date=local")) {
		revs->date_mode.format = DATE_NORMAL;
        	revs->date_mode.tz_offset = DATE_LOCAL;
	} else if (!prefixcmp(arg, "--date=")) {
        	revs->date_mode.format = parse_date_format(arg + 7);
	} else if (!strcmp(arg, "--tz=local")) {
        	revs->date_mode.tz_offset = DATE_LOCAL;
	}
	...

        /* In date.c::show_date() */
	...
        const char *show_date(unsigned long time, int tz, struct date_mode *mode_)
	{
        	int mode = mode_->format;

		if (mode_->tz_offset == DATE_LOCAL)
			tz = local_tzoffset(time);

		...
		/* and remove the existing
                if (mode == DATE_LOCAL)
                	tz = local_tzoffset(time);
		   that appears later in the code
		*/
	...
