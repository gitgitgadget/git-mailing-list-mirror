From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Fri, 05 Feb 2010 15:31:06 -0800
Message-ID: <7vsk9fs1j9.fsf@alter.siamese.dyndns.org>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:31:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXdw-0003Gm-Fd
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933380Ab0BEXbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:31:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933046Ab0BEXbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:31:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56298978EB;
	Fri,  5 Feb 2010 18:31:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ZFmhmRWz+sHX0Nwlhv73kK/MCE=; b=Ec7/E9
	2SzrHuXNQm4J1mTHfkRxLM0eWxZZmwpNtbmQyMiDFOpT6wLCr8UNqxJiNCxqYpqW
	YYJaAicj2zUd49PX0AyTMpaZEiOEq7bL9d81XWCd4+ZxxFNia8t5DqZqnt93fP9l
	lvDPUf+QCHRNKQAlUvF1agP8dnEmzwboTMUbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IFwbpn5SNG/cWO9kW0ATbu/5FYl/CKhp
	8NazoYD0NnnfL66Bigv6AZo+jzltUN0nTV7gkPnfEySOi7DBrgDd6NTpSA6OP7Kr
	LYnDuNoXYXsZw7y1ZgofIwtn4TSVDgYiWkhh3Zy7iDMbSZKVDHmC/K3voSiETiCX
	0fsyWHwMcoQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 332E6978E9;
	Fri,  5 Feb 2010 18:31:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C067978E5; Fri,  5 Feb
 2010 18:31:08 -0500 (EST)
In-Reply-To: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr> (Jan
 Engelhardt's message of "Sat\, 6 Feb 2010 00\:09\:11 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B1AFF2C-12AE-11DF-83F5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139121>

Jan Engelhardt <jengelh@medozas.de> writes:

> Just about now I wanted to grep for accesses of a particular struct 
> member. Needless to say that it was not a very amusing experience.
> I would expect that (1) probably fails:
>
> (1)	$ git grep '->cnt' net/ipv4/netfilter/
> 	error: unknown switch `>'
>
> So far so good, seems reasonable and matches what I would expect from 
> most other userspace tools. So let's add -- to terminate the option 
> list:

Also you can say "grep -e '->cnt'".  Not just "git grep" but regular grep
understands this, too.

> (2)	$ git grep -- '->cnt' net/ipv4/netfilter/
> 	fatal: bad flag '->cnt' used after filename
>
> *bzzt*.

This indeed is bzzt, especially if you had a file called "./->cnt" in the
work tree.  That would mean that you cannot tell the command to look for a
pattern in the work tree.

But because you are not giving anything before "--", that "git grep" is
not looking for anything.  Indeed, (2) is a user error.  If you try this:

        $ git grep a -- '->cnt' net/ipv4/netfilter/

does do what the command line specifies:  Look for a pattern "a" in files
whose names match given pathspecs ('->cnt' or 'net/ipv4/netfilter/').

> What works is (3).
>
> (3)	$ git grep -- -- '->cnt' net/ipv4/netfilter/

Huh?  Now I am lost.  Weren't you looking for a pattern "->cnt"?

And if this command looks for and finds the string '->cnt' in files whose
path match net/ipv4/netfilter/ pathspec, I would say it _is_ a bug.

The command line looks for "--" (the first one) as a pattern, and
interprets the second "--" as your attempt to tell git that '->cnt' is not
an option but is a pathspec.  So it looks for a pattern "--" in files
whose names match given pathspecs( again '->cnt' or 'net/ipv4/netfilter/').

> But it almost looks like Morse code.

Indeed.  But did (3) really work?  I tried it myself in a copy of the
kernel repository, and it found lines that contain '--' in files whose
names match net/ipv4/netfilter/ pathspec, as my copy of the kernel source
does not have a file '->cnt' at all.
