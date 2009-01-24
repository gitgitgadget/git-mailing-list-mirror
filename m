From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Sat, 24 Jan 2009 12:26:50 -0800
Message-ID: <7vvds4movp.fsf@gitster.siamese.dyndns.org>
References: <20090117153846.GB27071@coredump.intra.peff.net>
 <200901220113.32711.markus.heidelberg@web.de>
 <7vmydi4kiz.fsf@gitster.siamese.dyndns.org>
 <200901241228.33690.markus.heidelberg@web.de>
 <7vk58ko8k7.fsf@gitster.siamese.dyndns.org>
 <20090124191700.GA17935@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 24 21:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQp7H-0002QS-78
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 21:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbZAXU1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 15:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbZAXU1D
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 15:27:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbZAXU1B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 15:27:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A21041D33E;
	Sat, 24 Jan 2009 15:26:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 39AC71D21C; Sat,
 24 Jan 2009 15:26:52 -0500 (EST)
In-Reply-To: <20090124191700.GA17935@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 24 Jan 2009 14:17:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58F44B70-EA55-11DD-BCD6-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107002>

Jeff King <peff@peff.net> writes:

> On Sat, Jan 24, 2009 at 10:36:24AM -0800, Junio C Hamano wrote:
> ...
>> You did not find the breakage in format-patch either to begin with; so
>> your not finding does not give us much confidence that there is no other
>> breakage, does it?
>> 
>> Grumble...
>
> Sadly, this is an area that is not covered very well in the tests
> (partially, I think, because it is "just" output which we tend to
> neglect, and partially because the isatty() stuff is hard to test with
> our harness). So I don't think it's _entirely_ Markus' fault.

Oh, don't get me wrong.  I am not interested in finding whose fault it
was.  I was just stating the fact that one person not finding a breakage
does not mean much as an assurance.

It is actually not trivial to test this breakage in our test suite.
Before committing 9383af1 (Revert previous two commits, 2009-01-23), I
spent about 20 minutes trying to come up with a test to expose the
breakage in an acceptable way.  A test that assumes that it is run with a
controlling terminal is relatively easy to write, but I couldn't come up
with a test that would have triggered even when the tests were run without
a tty (for gory details, see git_config_colorbool() and how stdout_is_tty
is used).

Here is the "relatively easy" but an unacceptable one.

diff --git c/t/t4014-format-patch.sh w/t/t4014-format-patch.sh
index 9d99dc2..609946a 100755
--- c/t/t4014-format-patch.sh
+++ w/t/t4014-format-patch.sh
@@ -255,4 +255,10 @@ test_expect_success 'format-patch respects -U' '
 
 '
 
+test_expect_success 'format-patch is colorless even with color.ui = auto' '
+	git config color.ui auto &&
+	TERM=ansi git format-patch -1 >/dev/tty &&
+	grep "^+5$" 0001-foo.patch
+'
+
 test_done

Points that makes the above patch unacceptable are:

 (1) It hardcodes 0001-foo.patch.  You could try doing these:

     (1.1) patchname=$( ... git format-patch -1) && grep ... <"$patchname"
     (1.2) git format-patch -1 --stdout >patchfile && grep ... <patchfile

     but they won't work, because "color.ui = auto" will not color unless
     the standard output is a tty, and TERM is better than "dumb".

 (2) It would not trigger if /dev/tty cannot be opened for writing.

     
