From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid broken Solaris tr
Date: Tue, 18 Jun 2013 15:31:30 -0700
Message-ID: <7vli672gql.fsf@alter.siamese.dyndns.org>
References: <1371590247-13436-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 00:31:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up4R8-0005yj-4p
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 00:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282Ab3FRWbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 18:31:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322Ab3FRWbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 18:31:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B227B29DBF;
	Tue, 18 Jun 2013 22:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LGSNo2eCIwWXd4mCsqES/PvrM04=; b=KPOyvl
	a384f8DIuYtrhWNjkl8kVliNrN0syeIMc5sUwvzUw/8etjugA0jhQ8y/zkjFFqYm
	2CxPCXRebkYem+DdVNr2PcyiYbKBZ2NqFb/mQnxL7E+xQIQH66HQTo68jl/nhfOk
	9L0etYxILAp/5rDVSkmLHln8ytQjf/wI5m2/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vEFEtD1Rjudifh06QFpkez0AdqJu3WyT
	d2IkkP/dPESnjX6e1TWVkPTL+L2R+i0CMw7JtpMpgGxrSHTd5mIoqlsmcOw3KYt5
	niip//OxVh/glErZuRMq2oOkPltF8nzM4a2ZpLXDzUsZfVkK5iAlPN9V6aijiIez
	Kodd87b82lE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A609329DBE;
	Tue, 18 Jun 2013 22:31:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BFC929DB9;
	Tue, 18 Jun 2013 22:31:31 +0000 (UTC)
In-Reply-To: <1371590247-13436-1-git-send-email-bdwalton@gmail.com> (Ben
	Walton's message of "Tue, 18 Jun 2013 22:17:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D376EA70-D866-11E2-AF7C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228320>

Ben Walton <bdwalton@gmail.com> writes:

> Solaris' tr (both /usr/bin/ and /usr/xpg4/bin) fail to handle the case
> where the first argument is a multi-character set and the second is a
> single null character.

Almost all the tr invocations look like converting LF to NUL, except
for two that squash a colon ':', HT and LF all to NUL.  Is Solaris's
tr fine with the former but not the latter?

> We make this change globally in t0008-ignores instead of just for the
> cases where it matters in order to maintain consistency.

I am not suggesting to keep 'tr "\n" "\0"', but just wanted to make
sure I am reading the first paragraph correctly.  If we are
rewriting, we should do so consistently.

> +perl -pne 's/^"//; s/\\//; s/"$//; s/\n/\0/g' stdin >stdin0

What is -pne?  Is it the same as -pe?

tr/\n/\0/ (or y/\n/\0/) may be more faithful to the original.


> +perl -pne 's/^"//; s/\\//; s/"$//; s/\n/\0/g' expected-default > \
> +    expected-default0

Ditto.  We may want to give the same script used in the above two
(and twice again in the later hunk) more descriptive name, e.g.

	broken_c_unquote () {
		perl -pe '... that script ...' "$@"
	}

	broken_c_quote stdin >stdin0

Side note: the script is broken as a generic C-unquote function in
multiple ways.  It does not work if it has more than one backslash
quoted characters, it does not understand \t, \b, \015, \\, etc. to
name two.

But the breakage does not matter for the strings used in the test
vector.
