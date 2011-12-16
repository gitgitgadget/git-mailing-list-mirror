From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to commit incomplete changes?
Date: Thu, 15 Dec 2011 16:21:15 -0800
Message-ID: <7v8vmdl62s.fsf@alter.siamese.dyndns.org>
References: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
 <4EEA79E0.4070700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 01:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbLYB-0002uq-Ch
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 01:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759883Ab1LPAVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 19:21:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759671Ab1LPAVS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 19:21:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7C1B6CE5;
	Thu, 15 Dec 2011 19:21:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HXMmNDZUMkE2Cirz+aEf3X+qhEk=; b=pyByWF
	bD02AnG+kkNWrAXdE4q2HePLI5QSpczyvpC9UHL9LcCzRSbbcw3stkgEZ0U6AhV3
	YKEcARux4Y3hclxL2srTaSYvB+qke+8BwAKoJn+Ngygf8UsTPavejeMFygoJp13R
	g6reY9BJCrd5xk1gbxWnPN1NZ+8ySm6vn9h20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d7G6hf4a40l/IfUweno9Dranb9u5hgCL
	LkcEEtLfL2ZS/mV21OxdB+1qyX/HZqhMFUvkzHTSkl+g6LrZK222KY93b+wbLTLg
	cOvjS7RsDp5drdBTrgsVxvgqi0lvFecQQCudhCgfjZWc9MBNF60vd9Kxv/48lS7c
	bmBe4eYkbQY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFFBF6CE4;
	Thu, 15 Dec 2011 19:21:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4457C6CE3; Thu, 15 Dec 2011
 19:21:17 -0500 (EST)
In-Reply-To: <4EEA79E0.4070700@gmail.com> (Neal Kreitzinger's message of
 "Thu, 15 Dec 2011 16:51:12 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEF57760-277B-11E1-AF03-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187260>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> A main purpose for the squash and fixup options is ...
> "To make it look like you
> did it all perfectly without making any mistakes" (or a reasonable
> facsimile thereof).  You insights on the cherry-picking of fixes is
> interesting, but makes no sense in the context of unpublished work.
> Why would you need to cherry-pick fixes to mistakes that have not yet
> been propagated (published)?
> ...
> I assume by 'generated changes' you mean the automerge in git...

My reading of the "need to split" example was not "bulk of work plus fixes
to mistakes". Imagine you are working on somebody else's code and for some
reason you want to do

	s/setenv/xsetenv/g

all over the code, and also add a wrapper to implement xsetenv() function.

You _could_ do it in one single commit, but what happens when you try to
adjust to the updated upstream code, which may have added new callsites to
setenv()?

If you keep it as two patches, one is mechanical (i.e. s/setenv/xsetenv/g)
and the other is manual (i.e. implementation of xsetenv()), then you can
discard the text of the "mechanical" one from the old series and instead
run the substitution on the updated code, and then cherry-pick the
"manual" one.

If you did the mechanical one first, the resulting code would not compile
(lacks xsetenv() implementation), and then the second "manual" one would
"fix" it. In this simplified example, it is easy to flip the orders and
keep things work, but then you would get a complaint from clever compiler
or linker that xsetenv() implementation is defined but nobody uses it,
which is another kind of breakage. So it _is_ possible that you cannot
avoid breaking the system inside two patches, making them "all-or-none"
series.
