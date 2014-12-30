From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] receive-pack.c: add protocol support to negotiate atomic-push
Date: Tue, 30 Dec 2014 08:47:05 -0800
Message-ID: <xmqqvbktrsom.fsf@gitster.dls.corp.google.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
	<1419017941-7090-2-git-send-email-sbeller@google.com>
	<549A6C4C.8000905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, ronniesahlberg@gmail.com,
	jrnieder@gmail.com, sunshine@sunshineco.com, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 30 17:47:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5zx2-0003bt-9N
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 17:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbaL3QrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 11:47:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751287AbaL3QrP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 11:47:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 730092917B;
	Tue, 30 Dec 2014 11:47:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6vV2uMfB1hCRq7szxogTxsJ8qkw=; b=My+m/4
	S13R4okXgrCiKDFXEJxSe4zqEo0zdYHYIMgaWM9abnTwsOIHD7jeAQawHAL215y0
	tzwxN2jwYP4zagbRD+nEwEwYXZTHrM2JOeHvzsC9Xg6DcFfoPq/tSVQMg8d0ULSS
	9SEQAI7jvVmIDSgsBoN9z6w2qs0g5r8S2fwss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LRt4ibXnwS9PSDcypXIOXfXMkjsAP2io
	0XP44wEqh2jstfQNVp1UClQj1r9izbC+wd0zGRlKF9wGW31zeoJZZJxOeQulIUUy
	W/DCTtJiOKNP4WtKO5H406SsUEf84+NRxpnc89oF68H/mgYwWpCAOlmATk9jiVpr
	2IpK5Q3uuq4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 689DB29179;
	Tue, 30 Dec 2014 11:47:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12AA529178;
	Tue, 30 Dec 2014 11:47:12 -0500 (EST)
In-Reply-To: <549A6C4C.8000905@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 24 Dec 2014 08:33:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 808B8000-9043-11E4-8914-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261926>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If I understand correctly, after this patch the server advertises the
> "atomic" capability even though it doesn't actually have that ability
> until a later patch. It seems to me that the order of the patches should
> be reversed: don't advertise the capability before it is actually
> implemented. Why? Bisection. Between the two patches the server is buggy.

That is a valid point.  It also reminds us of another thing.

We would need a way to test interoperability among the three new
combinations (i.e. new and old receive-pack talking to new and old
"git push").  We can control what the sender talks on the wire by
giving or not giving "--atomic" option on the command line, but
there should be a way for us to control what the receiver talks on
the wire, i.e. "receivepack.pushAtomic = false" that tells us not to
advertise the "atomic push" capability over the wire, even if you
are running the updated "receive-pack" binary.

This will not only for testing.  When we discover that "atomic"
support is undesirable for whatever reason (e.g. the transaction
machinery may consume too many file descriptors without a good
reason), we would need a way for users to disable it until the
problem is fixed.

And of course the tests should make sure that

 (1) "git push --atomic" that talks with the receiving end that has
     receivepack.pushAtomic set to false behaves as we desire (error
     out? degrade to non-atomic? --- whichever way we decide).

 (2) "git push" that talks with the receiving end with "atomic" enabled
     does not do an atomic push, i.e. try to push two refs, one that
     fast forwards and the other that does not, and see one ref is
     updated while the other ref remains intact and "git push"
     itself reports failured.;

 (3) "git push --atomic" that talks with the receiving end with
     "atomic" enabled does the atomic thing.

among other things.
