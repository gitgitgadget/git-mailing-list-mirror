From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cache_tree_find(): remove redundant checks
Date: Tue, 04 Mar 2014 15:18:34 -0800
Message-ID: <xmqqr46himd1.fsf@gitster.dls.corp.google.com>
References: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq8uspk72g.fsf@gitster.dls.corp.google.com>
	<531652B9.4000001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 05 00:18:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKybk-0004Zt-EN
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 00:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbaCDXSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 18:18:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797AbaCDXSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 18:18:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71B7071A09;
	Tue,  4 Mar 2014 18:18:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M1sW2VTnb3okMiikULlVTaWmnvw=; b=m3qVyP
	qGI5hWbGCw71nN55TALH6X6FHmaMBfQd3XSr54kGc3S/Ei9B62jv4V5eDLrlxhHo
	9pZaWG8gR2E4+oICy4CoCpLgx9QRcxa8C2SSSrT6cn/8rf7L8wIFt8ff6a8aKRnQ
	TFpPtR5tO/NM0+FgR0HjcJ7T1dzP66750DZxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KslRFUp8GcnbpaJtELk6cTQI/AG7Eqf3
	NiKX2KAcQ+XzbYYJs4Gjq6kn6on8K6h2f1hC+7cQopfwLTkv55watt9uC/Fa83JX
	wKLgxgFQfaG7q1i8KJngWP6j71GoK6ggSDNucBiJwAMXyu4+pMb53xT0kQ/yamxR
	msJX79w0IjI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FEF571A08;
	Tue,  4 Mar 2014 18:18:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A339471A07;
	Tue,  4 Mar 2014 18:18:37 -0500 (EST)
In-Reply-To: <531652B9.4000001@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 04 Mar 2014 23:24:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 50A77700-A3F3-11E3-9B22-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243404>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> Isn't the above a strchrnul()?
>
> Oh, cool, I never realized that this GNU extension was blessed for use
> in Git.  Will change.

We do have our own fallbacks for non-glibc platforms, so it should
be safe.

>> Combining a freestanding decl with intializer assignment to lose one
>> line is sort of cheating on the line count, but replacing the three
>> lines with a single strchrnul() would be a real code reduction ;-)
>
> I suppose you are just teasing me, but for the record I consider line
> count only a secondary metric.  The reason for combining initialization
> with declaration is to reduce by one the number of times that the reader
> has to think about that variable when analyzing the code.
> ...
> I really wish we could mix declarations with statements because I think
> it is a big help to readability.

Unfortunately, I think we are in violent disagreement.

A variable declaration block with initializations on only some but
not all variables is extremely annoying.  If none of the variable
declaration has initialization (or initialization to trivial values
that do not depend on the logic flow), and the first statement is
separated from the decl block, then I do not have to read the decl
part when reading the code/logic *at all* (the compiler will find
missing variables, variables declared as a wrong type, etc.).

In other words, a trivial initialization at the beginning of the
block, if the logic flow only sometimes makes assignment to the
variable, is perfectly fine, e.g.

	const char *string = NULL;

	if (...) {
        	string = ...
	}                

But I would wish people stop doing this:

	const char *string = strchrnul(name, ':');

	... the real logic of the block that uses string follows ...

and instead say

	const char *string;

	string = strchrnul(name, ':');
	... the real logic of the block that uses string follows ...
