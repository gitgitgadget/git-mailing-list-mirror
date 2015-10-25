From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] t5516 "75 - deny fetch unreachable SHA1, allowtipsha1inwant=true" flaky?
Date: Sun, 25 Oct 2015 10:38:01 -0700
Message-ID: <xmqq8u6qluh2.fsf@gitster.mtv.corp.google.com>
References: <9A3BCDA2-5915-4287-A385-95A3ACCBB850@gmail.com>
	<CABA5-z=1N5=8huSr=BLmjj_KHLbMMiXdo0qok7Mc_ZOeB=J9jA@mail.gmail.com>
	<CFEB6E3F-48A0-41D8-A8FD-D48B806461DB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fredrik Medley <fredrik.medley@gmail.com>, peff@peff.net,
	patrick.reynolds@github.com, Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 18:38:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqPFD-0000hp-0a
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 18:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbbJYRiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 13:38:06 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751085AbbJYRiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 13:38:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B02D231B9;
	Sun, 25 Oct 2015 13:38:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xef01RX3Q1x98jQRKAp0mkxbGXs=; b=h1Z6pa
	vnuKQ73upJJw86e0eDBNmv1neP1vbDwMsb3DmG+YcDvU2CxaxRhokRYk1FJwz3lb
	hilvCN6ruqBo+AbfP9myXs7yI+OuADv2C7siz2+xtRdLDHQDZ2KhvMCvZ/GiSffj
	akmA16fsYC9zYTQyfUCjV0z/OMKkllikcDTDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7+4c9lCjdqpv2a4a/9RZX7Zh9yJ1wfZ
	xIqnj9C2dAs5piSpMCP+JllP1C7c08NmQ+B5bKEZEDbWeaV5r8BXejydF+JuC88Q
	JV+3tSBdbBpQRbIwbLexA4W2gRf+n638/whTxuzK0qAQxdBfBaxvyessuhqCV+6m
	FVL1LN+uik8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12CE6231B6;
	Sun, 25 Oct 2015 13:38:03 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A890231B5;
	Sun, 25 Oct 2015 13:38:02 -0400 (EDT)
In-Reply-To: <CFEB6E3F-48A0-41D8-A8FD-D48B806461DB@gmail.com> (Lars
	Schneider's message of "Sun, 25 Oct 2015 14:47:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 243D5CAA-7B3F-11E5-AEB4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280161>

Lars Schneider <larsxschneider@gmail.com> writes:

> (1) Make upload-pack wait for a response (with timeout) before it
> closes the pipe. However, I believe this would not be in line with
> the general Git philosophy stated in "git.c" (added in 7559a1be):
> "Many parts of Git have subprograms communicate via pipe, expect
> the upstream of a pipe to die with SIGPIPE when the downstream of
> a pipe does not need to read all that is written."

While I think "waiting" with "timeout" is undesirable for the
upload-pack / fetch-pack communication, you are rejecting it for a
wrong reason.

What you quoted is not even a Git philosophy.  Yes, many parts do
want to behave like that, and the "restore" needs to make sure that
such a behaviour happens by fixing the environment given to us by
the process spawning us.

That does not mean some parts of the system, if they want to run
SIGPIPE ignored, must not do so because it goes "against the
philosophy".  

It only means that these parts of the system, if they choose to,
must arrange to do so themselves.  That "restore" thing is merely to
give us a known good state to start from.

> (2) Ignore SIGPIPE errors when "fetch-pack" sends a "done" using
> "sigchain_push(SIGPIPE, SIG_IGN)" /
> "sigchain_pop(SIGPIPE)". However, then the check_pipe function
> (added in 756e676c) kicks in and we would need to work around that
> as well.

I am not sure if we are looking at the issue the right way once we
start saying 'do this _when_ fetch sends ...'.

The communication between fetch and upload goes bidirectionally in
an overlapping fashion, and at any point in the communication, not
limited to "after fetch sends 'done'", the other side can decide to
disconnect while one side is sending.  If you are lucky, you will
finish sending the current batch and try to read from the other side
and notice "the remote end hung up unexpectedly", and if you are
unlucky, you find your write cannot go through due to broken pipe.

Dying with SIGPIPE would not give us a chance to clean things up
(i.e. react to the "not our ref" error in a more application
specific way), so the current behaviour has a room for improvement,
but I suspect that changes required for "dying more nicely" would be
rather large [*1*]; I am not convinced if it is worth the effort.

That leaves us to something along this line...

> (3) Add a method "test_must_fail_or_die" to
> "test-lib-functions.sh". This method accepts exit codes 129<x<192,
> too. Use the new method in t5516.

... but I have to wonder if 129<x<192 is loosening too much, given
that the only error we expect, other than the orderly shutdown, is
reception of sigpipe.


[Footnote]

*1* We'd need to update fetch-pack.c:send_request() so that it and
    its helpers use a variant of write() that does not die with
    SIGPIPE and instead returns an error status to the caller, and
    update all the callers to react to an error, which may involve
    jumping to the receive codepath with the hope that some early
    response is already waiting for us to read and gives us an error
    message from the remote side, or something along that line.  And
    we'd probably need to update the other direction, i.e. push and
    receive, for symmetry.
