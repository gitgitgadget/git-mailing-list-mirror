From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: do not ignore --no-hardlinks
Date: Fri, 27 Feb 2009 00:13:41 -0800
Message-ID: <7vmyc8mh56.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de>
 <da2c9173f403c4fb509609fb823b6be0728d94f3.1235690903u.git.johannes.schindelin@gmx.de> <20090227025829.GA22060@coredump.intra.peff.net> <7vy6vsmjeo.fsf@gitster.siamese.dyndns.org> <7vr61kmht9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 09:15:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcxsV-0003gg-PV
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 09:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbZB0IN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 03:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbZB0IN7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 03:13:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444AbZB0IN6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 03:13:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D8DF9DCBA;
	Fri, 27 Feb 2009 03:13:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C43AB9DCB9; Fri,
 27 Feb 2009 03:13:48 -0500 (EST)
In-Reply-To: <7vr61kmht9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Feb 2009 23:59:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 941B3806-04A6-11DE-A22E-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111644>

Junio C Hamano <gitster@pobox.com> writes:

> It triggers this codepath in get_value():
>
> 	case OPTION_BOOLEAN:
> 		*(int *)opt->value =3D unset ? 0 : *(int *)opt->value + 1;
> 		return 0;
>
> and ends up incrementing it to zero.
>
> I wonder what would break if we simply change this to:
>
> 	case OPTION_BOOLEAN:
> 		*(int *)opt->value =3D !unset;
> 		return 0;
>
> Damn it, it is called BOOLEAN, and na=C3=AFvely I would think --optio=
n would
> set it to 1, --no-option would set it to 0, and not having --option n=
or
> --no-option would leave the associated variable alone, but apparently=
 that
> is not what is happening.
>
> Pierre, do you remember why this code is implemented this way?  The
> "increment if we have --option" semantics seems to date back to 4a59f=
d1
> (Add a simple option parser., 2007-10-15) which is the day one of the
> history of parse-options.

I think that this came from a misguided attempt to do:

	-v
        -v -v
        -v -v -v

to cumulatively record the desired verbosity levels.

Originally we did not have OPT__VERBOSITY() nor OPT_VERBOSE() so it is
understandable that OPT_VERBOSE() was implemented in terms of this
OPT_BOOLEAN() construct.

I think all parse_options() users that do support the verbosity level i=
s
either using OPT__VERBOSE() or OPT_VERBOSITY() these days, and we could
probably fix this by doing something like:

 (1) Introduce OPTION_CUMULATIVE_LEVEL whose behaviour is "--no-option =
to
     reset to zero, --option to raise by one", and fix OPTION_BOOLEAN t=
o
     "--no-option to zero, --option to one":

	case OPTION_BOOLEAN:
 		*(int *)opt->value =3D !unset;
		return 0;
	case OPTION_CUMULATIVE_LEVEL:
 		*(int *)opt->value =3D unset ? 0 : *(int *)opt->value + 1;
 		return 0;

 (2) Use OPT_CUMULATIVE_LEVEL() instead of OPT_BOOLEAN() to implement
     OPT__VERBOSE() and OPT__QUIET().

But I am inclined to postpone such a change til after 1.6.2.
