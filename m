From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 10:41:29 -0800
Message-ID: <7v62gg3grq.fsf@alter.siamese.dyndns.org>
References: <20120111173101.GQ30469@goldbirke>
 <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
 <20120112165329.GA17173@sigill.intra.peff.net>
 <20120112174731.GA6038@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 19:41:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlPaj-0000d9-5n
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 19:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777Ab2ALSlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 13:41:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049Ab2ALSlc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 13:41:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74ACA6923;
	Thu, 12 Jan 2012 13:41:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i6HjJgTj0ClCoVgVOO52b1/+8S4=; b=E10Bkl
	0gqawApDPP4Yafvo3Sdx4h0dNscXOWWcHm36kQeOlXj3+CwY2akiesaBkebmt9Mw
	DwM7+wkngMOzdkWWIXndy2Ag9VDtFkVy3UYMtG7n3rQb5wU3opaqJTW4fHNaksHY
	OlMEQcA/UXHBM5strMiSivcuGnw+HY0MGk+t0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lulMP2UeTP+vofQ0TIPsd8iiCKlQ/HBA
	oYnB/j+QOjW1MehLV1Ulbmk3eMKo5pwraH9VFha03MMUOdBlnKfQtQ5js+/3IgRg
	WL/Osdv7aYgYHFJrjd2MXH4EtXDqUJd/P9o+QcE5NL1KggIvUfl5d7NC2F8n5FEG
	bFrQrfR9DNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A9B36922;
	Thu, 12 Jan 2012 13:41:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D51916921; Thu, 12 Jan 2012
 13:41:30 -0500 (EST)
In-Reply-To: <20120112174731.GA6038@burratino> (Jonathan Nieder's message of
 "Thu, 12 Jan 2012 11:47:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B54ED72-3D4D-11E1-9FF5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188468>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Yes, exactly.  Another question: what should
>
> 	git cherry-pick master..next maint..master
>
> do?

Revision ranges are not defined as a union of sets, but a single set as a
range between zero or more bottom (UNINTERESTING) commits and zero or more
top commits, the ones reachable from the top but not from the bottom, so
the above will work as if you said "^master ^maint master next", which is
the same as "master..next" (if you assume all of "maint" is contained in
"master" all of which is contained in "next", of course).

And it is not likely to change soon.

In the longer term (or in an alternate universe where we were inventing
Git from scratch today without any existing users), we may want to revamp
the revision machinery, taking advantage of the recent addition of the
"cmdline" facility to it, so that we would walk ranges "master..next" and
"maint..master" independently, clearing the object flags as needed between
the separate traversals as needed, and then take a union of these ranges,
before returning results from get_revision() calls.
