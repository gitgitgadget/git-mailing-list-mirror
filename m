From: Junio C Hamano <gitster@pobox.com>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Mon, 14 Dec 2009 15:22:50 -0800
Message-ID: <7vhbrtdtth.fsf@alter.siamese.dyndns.org>
References: <20091214183337.GA25462@atjola.homenet>
 <7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
 <tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	jk@silentcow.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:23:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKKGD-0005Vm-Gz
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 00:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932AbZLNXXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 18:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932858AbZLNXXQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 18:23:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846AbZLNXXO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 18:23:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E87AA88994;
	Mon, 14 Dec 2009 18:23:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Re7g7e5mN5ya6RNIj8WUZ47etTw=; b=i05Hvk
	fn5gBOiN2q71dHm45x0nQKhr4dfabEqZeOPTIUiryvc/zN1GOAGhj3OcC/ZXLk4m
	OiD2MfXMe9yfW6VDnM8HRwkeko65cR0DH8pN2sS7Vk03ut7bWyJcZuIkVTLb98OC
	IeqYzsTTQpco4De160jjksl3nqBYZEwFcmpu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dNdVB66q9eC8h5UV/UM4lvM2+Cw/IwmN
	gzwtN2FmYH+Pz6emdMd5vcmi3rf+ciu7WCBx8WUEvDcK+N7O+2C7y5qkyy18SQiH
	glAGNcX3Hjj95A7ZcdqsyvlOkIUD3zXg7Fg9ZZFc84Izn1tQLRitoXS7jxME0ts4
	Sv7o7R6AxR4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D789B88990;
	Mon, 14 Dec 2009 18:23:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF4A08898C; Mon, 14 Dec
 2009 18:22:51 -0500 (EST)
In-Reply-To: <tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon\, 14 Dec 2009 16\:56\:58 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9F89AB1E-E907-11DE-BD40-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135253>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> My understanding of the problem is that rfc2822 dictates that...

I think the fundamental problem is that what MUA uses as the internal
storage format doesn't necessarily have to even be RFC-2822, which only
specifies what should be on-the-wire.  The blamed commit took things too
far.

It actually is the norm to use LF as the line terminator in the body text
in saved messages (and trailing CR as a true part of the payload), and
"am" traditionally used that definition.  It is meant to read from "mbox"
format to begin with.

Before the blamed commit, "am" took what was given literally, and it
treated the trailing CR as part of the payload in a text file, each of
whose line is LF terminated.  This meant that if you sent and your MUA
didn't corrupt, or more importantly if you ran format-patch yourself to
produce a patch on content with CRLF line endings and fed it to am without
any e-mail involved, your CRLF would have been preserved.  So in that
sense, unlike what you said in your message, the blamed commit didn't
decide that the line termination must be LF.  It decided that the line
termination does not matter, which is a lot worse.

As long as the use of CR is an internal storage matter and "Save As..."
doesn't add extra CR that wasn't in the original contents, I wouldn't say
that such a MUA is broken.  In the use case that led to the blamed commit,
the user is choosing to read directly from the internal storage of MUA,
bypassing its "Save As..." interface meant to be used to externalize the
messages, and the user is responsible for dealing with the fallout, hence
my "dos2unix" suggestion in the original thread.

Probably we should revert that commit, unless somebody comes up with a
better solution _or_ somebody convincingly argues that there shouldn't be
CRLF in your committed history.
