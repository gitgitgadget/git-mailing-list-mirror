From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: No advice to commit if --no-commit
Date: Tue, 21 Feb 2012 14:31:56 -0800
Message-ID: <7v1upng6n7.fsf@alter.siamese.dyndns.org>
References: <1329858317-3066-1-git-send-email-hordp@cisco.com>
 <20120221222049.GA31934@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>, Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 23:32:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzyFg-0001KB-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 23:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab2BUWb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 17:31:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581Ab2BUWb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 17:31:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 818DC618B;
	Tue, 21 Feb 2012 17:31:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lY0f9P8CqSnrdVaptAanmlBJFwQ=; b=u9InA6
	9ZQkYpZLdRJm4InVwYGgYqmuj5igMYo7VBdlTzfJ7pQ9sGMxXnZrTqfNtX2GxNsL
	h7KvOYvxZCllzfxLn5e4CbeYXVFBkewZebJI/dRlKxfrVc4oXm6bmSWiHYGktRUn
	7QquJ1e5GNmP22pQoA/S6FK16hBSNrloXcGFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OSSjQ3XokuxcKLnHH6A25kslnJMz1XuV
	dUBSdkSLl6GiSmcpIS3VOpnd3F/Nn9zjcNC8qscS5cNVTK+jmYGZE/PCcix9s4/b
	cUIRqfqotInfrVMcnC5LdvBrrsUViH8gjUzNAaWJAnw9U/PVp4McmB4lhTCEF8gj
	0w7rZJZasgw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77C85618A;
	Tue, 21 Feb 2012 17:31:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E79F76187; Tue, 21 Feb 2012
 17:31:57 -0500 (EST)
In-Reply-To: <20120221222049.GA31934@burratino> (Jonathan Nieder's message of
 "Tue, 21 Feb 2012 16:23:22 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD65C950-5CDB-11E1-BAF0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191192>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +	if (show_hint) {
>>  		advise(_("after resolving the conflicts, mark the corrected paths\n"
>> +			 "with 'git add <paths>' or 'git rm <paths>'"));
>> +		if (!opts->no_commit)
>> +			advise(_( "and commit the result with 'git commit'"));
>
> "cherry-pick --no-commit" was not about to commit, but the user might
> have been.  I think the hint is intended to convey that authorship
> will be correctly preserved if the user continues with "git commit"
> and no special -c option is necessary.

Actually, an often used but perhaps neglected use case of "cherry-pick --no-commit"
is to use it as a substitute for

	git show $that_commit | git apply [--index]

to lift the change from $that_commit and incorporate it into your
unrelated (from the point of view of the author of $that_commit) work.
The user would be doing "edit $this_file" and "edit $that_file" before or
after the "show | apply" aka "cherry-pick --no-commit", and it is merely
a type-saver, not having to re-type the change $that_commit introduced
relative to its parent.

So in that context, I can understand the suggestion to commit is at best
annoying ("I am still working on the current change. Why do you talk about
committing?") and at worst alarming and misleading ("Oh, am I to lose some
change if I do not commit right now?").

> A smaller detail: splitting the message into two like this gives
> translators less control over how to phrase the message and where to
> wrap lines.  Luckily that is easy to fix with
>
> 	if (opts->no_commit)
> 		advise(...);
> 	else
> 		advise(...);

Yes, this pattern must be followed in the reroll.

Thanks for a review and comment.
