From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] mergetools: Simplify how we handle "vim" and
 "defaults"
Date: Sat, 26 Jan 2013 20:25:38 -0800
Message-ID: <7vd2wrz1z1.fsf@alter.siamese.dyndns.org>
References: <1359247573-75825-1-git-send-email-davvid@gmail.com>
 <7vobgbz58a.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7E1NkMV0_G+6oY9O3iCS9OCEzR1HYssKpwh77swDUcig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 05:37:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzJzS-00088P-Sn
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 05:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab3A0EZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 23:25:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574Ab3A0EZl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 23:25:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF018CD6C;
	Sat, 26 Jan 2013 23:25:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m8elPYY6M1RslaLInfRhZ6EBWQk=; b=pq3bXD
	RysbN+Rau+3FQFTOcFzghQzOdPAhJip5jDxr06JC6etw6nMYhO4TWS06J4JII+9l
	yjMnjA2EmPE4KPo+3t6fcuwU1r5imkOFU2b3BCYpJu70WZ20tRAHGcJr5qbOXG/y
	GxW7fjHC10EDdMoP7cD8LlHsubQTGCQel1BxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ef9ZLOYSwr3jHIhAEWyKG392WyZfsZfa
	svQl6/33ZA7BfGXmDRg0woRvAwImCfmWLSFdfdRixYvM+8kXsSSwowZOzQ94VmgA
	aTJ5AgoaOIyFV/fmbajrftI+SDbWWBlorBMhRDAww0fkHHuau12mcmBCwsnGM3Cz
	0sc82nKgaYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4430CD6B;
	Sat, 26 Jan 2013 23:25:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EA98CD67; Sat, 26 Jan 2013
 23:25:40 -0500 (EST)
In-Reply-To: <CAJDDKr7E1NkMV0_G+6oY9O3iCS9OCEzR1HYssKpwh77swDUcig@mail.gmail.com> (David
 Aguilar's message of "Sat, 26 Jan 2013 19:56:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B458ED8-6839-11E2-9916-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214674>

David Aguilar <davvid@gmail.com> writes:

> I have a question. John mentioned that we can replace the use of
> "$(..)" with $(..) in shell.

I think it isn't so much about $(...) but more about quoting the RHS
of assignment.

Consider these:

	var="$another_var"
	var="$(command)"
	var="$one_var$two_var"
	var="$another_var$(command)"

all of which _can_ be done without dq around the RHS, because the
result of variable substitution and command substitution will not be
subject to further word splitting.

I however find it easier to read with dq around the latter two, i.e.
substitution and then concatenation of the result of substitution.
The extra dq makes the intent of the author clearer, especially
while reviewing a script written by other people whose understanding
of the syntax I am not sure about ;-).  Between var=$another and
var="$another", the latter is slightly preferrable for the same
reason.

One questionable case is:

	var=$(command "with quoted parameter")

It makes it a bit harder to scan if there is an extra set of dq
around RHS, i.e.

	var="$(command "with quoted parameter")"

That case is easier to read without dq around it, or you could cheat
by doing this:

	var="$(command 'with quoted parameter')"

In any case, as long as the result is correct, I do not have very
strong preference either way.
