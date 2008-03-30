From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
 non-ascii characters
Date: Sun, 30 Mar 2008 16:47:16 -0700
Message-ID: <7vwsnjwz97.fsf@gitster.siamese.dyndns.org>
References: <20080328212700.GA9529@coredump.intra.peff.net>
 <200803290819.07280.robin.rosenberg.lists@dewire.com>
 <20080329072203.GA17625@coredump.intra.peff.net>
 <200803290941.54091.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7G0-0005sD-Gu
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbYC3Xr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 19:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754739AbYC3Xr3
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:47:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbYC3Xr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 19:47:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CD2514D8;
	Sun, 30 Mar 2008 19:47:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7FDE714D6; Sun, 30 Mar 2008 19:47:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78530>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> Den Saturday 29 March 2008 08.22.03 skrev Jeff King:
>> On Sat, Mar 29, 2008 at 08:19:07AM +0100, Robin Rosenberg wrote:
>> > Den Friday 28 March 2008 22.29.01 skrev Jeff King:
>> > > We always use 'utf-8' as the encoding, since we currently
>> > > have no way of getting the information from the user.
>> >
>> > Don't set encoding to UTF-8 unless it actually looks like UTF-8.
>>
>> OK. Do you have an example function that guesses with high probability
>> whether a string is utf-8? If there are non-ascii characters but we
>> _don't_ guess utf-8, what should we do?
>
> Any test for valid UTF-8 will do that with a very high probability. The
> perl UTF-8 "api" is a mess. I couldn't find such a routine!?. Calling 
> decode/encode and see if you get the original string works, but that is too
> clumsy, IMHO.

The sequence to decode followed by encode will test if you have a valid
one and if it is canonically encoded, which is testing too much.  You only
want to check if it is valid, and do not care about normalization.

I see this in perluniintro.pod:

    =item *

    How Do I Detect Data That's Not Valid In a Particular Encoding?

    Use the C<Encode> package to try converting it.
    For example,

        use Encode 'decode_utf8';
        if (decode_utf8($string_of_bytes_that_I_think_is_utf8)) {
            # valid
        } else {
            # invalid
        }

For commit log messages, we traditionally use similar idea to guess by
checking if it looks like an UTF-8 encoded string and otherwise assume
Latin-1 (and I think we still do if the user does not tell us).

If this issue is only about the --compose part of send-email, perhaps you
can interactively ask instead of "otherwise assume Latin-1"?
