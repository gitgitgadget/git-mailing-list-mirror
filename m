From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: do not ignore --no-hardlinks
Date: Thu, 26 Feb 2009 23:59:14 -0800
Message-ID: <7vr61kmht9.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de>
 <da2c9173f403c4fb509609fb823b6be0728d94f3.1235690903u.git.johannes.schindelin@gmx.de> <20090227025829.GA22060@coredump.intra.peff.net> <7vy6vsmjeo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 09:00:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcxeQ-0008Ai-R0
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 09:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444AbZB0H71 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 02:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbZB0H71
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 02:59:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbZB0H70 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 02:59:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D35B4243C;
	Fri, 27 Feb 2009 02:59:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CFA53243B; Fri,
 27 Feb 2009 02:59:16 -0500 (EST)
In-Reply-To: <7vy6vsmjeo.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Feb 2009 23:24:47 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8B75508A-04A4-11DE-A7B7-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111643>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
> So across filesystems:
>
>  - "git clone /p/a/t/h" falls back to copying;
>
>  - "git clone --local /p/a/t/h" should fail without falling back to
>    copying; and
>
>  - "git clone --no-local /p/a/t/h" should work as if file:///p/a/t/h
>    was given.
>
> That is much more sensible than making "git clone --no-hardlinks /p/a=
/t/h"
> imply more than what the option really means: we are making a local c=
opy
> but do not cheat with hardlinking.

I liked it so much that I wrote a commit message for it:

    commit c255d7bbf4dd567ca60a8991c3ac052c9b2d1593
    Author: Jeff King <peff@peff.net>
    Date:   Thu Feb 26 23:31:49 2009 -0800

        clone: do not ignore --no-local option

        With a variable initialized to false, we couldn't tell if the u=
ser didn't
        give --local or if the user explicitly told us --no-local after=
 we get control
        back from parse_options().

        This fixes and makes "git clone --no-local /p/a/t/h" always use=
 non-local
        transport (aka "git native protocol over pipe").

        Signed-off-by: Junio C Hamano <gitster@pobox.com>

Except that it does not work.

Initializing option_local to -1 and then feeding it to parse_options() =
via
OPT_BOOLEAN() is a cute idea, but when parse_options() sees a command l=
ine
like this:

	$ git clone -l /p/a/t/h

It triggers this codepath in get_value():

	case OPTION_BOOLEAN:
		*(int *)opt->value =3D unset ? 0 : *(int *)opt->value + 1;
		return 0;

and ends up incrementing it to zero.

I wonder what would break if we simply change this to:

	case OPTION_BOOLEAN:
		*(int *)opt->value =3D !unset;
		return 0;

Damn it, it is called BOOLEAN, and na=C3=AFvely I would think --option =
would
set it to 1, --no-option would set it to 0, and not having --option nor
--no-option would leave the associated variable alone, but apparently t=
hat
is not what is happening.

Pierre, do you remember why this code is implemented this way?  The
"increment if we have --option" semantics seems to date back to 4a59fd1
(Add a simple option parser., 2007-10-15) which is the day one of the
history of parse-options.
