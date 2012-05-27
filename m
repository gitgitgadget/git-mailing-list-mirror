From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Sun, 27 May 2012 02:27:56 -0700
Message-ID: <7vbolaotwj.fsf@alter.siamese.dyndns.org>
References: <20120523122135.GA58204@tgummerer.unibz.it>
 <CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
 <20120525201547.GB86874@tgummerer>
 <CACsJy8BRWmqz+2_A5_=1S9_sxOQa9GXnPQ7J1Y6id0_vh2-=+Q@mail.gmail.com>
 <20120527090407.GD86874@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 11:28:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYZle-0001Bb-Mj
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 11:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957Ab2E0J2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 05:28:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab2E0J17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 05:27:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62DAE57E0;
	Sun, 27 May 2012 05:27:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6iqsPsvNIlOJ2X4LlQ63ZnBqcHE=; b=VMXWEQ
	FOh2/rZrFJW9q/u1cdN9G2KW94wleyqvuMihzjzZ64gXf53ETMVqUPbECwL2s7LT
	tlRraQm6VtRQu1pT0l84i1CaKrT4mGn5xflRgxZ4yqJGa9fCgE0BKY1U3SHyW3kl
	6UKxKz/lMQl2AeNC7J7a4fF10yoSMS9Kk4rUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W3jYZ+OxU+3PEcw8FzDqkZC3O4UoEcxJ
	WNYF4+iuxwkvq1ZcfdW6ZbeqvjSlKyEQroo2Y8BjWj8rBWVjYY1/QsdrxOGFjtD5
	48Ja4cn3a/asttkSLyUQ1DyEaSsTzJBN4UfgXu+mhJkVIhSQDlpL12iGE41cqoi2
	Ia6nAxhK2Xg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58EED57DF;
	Sun, 27 May 2012 05:27:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E431B57DE; Sun, 27 May 2012
 05:27:57 -0400 (EDT)
In-Reply-To: <20120527090407.GD86874@tgummerer> (Thomas Gummerer's message of
 "Sun, 27 May 2012 11:04:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F015C36-A7DE-11E1-B048-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198584>

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> No, read_index_from would go through the normal tree->list conversion.
>> What I'd like to see is what it looks like when a command accesses
>> index v5 directly in tree form, taking all advantages that tree-form
>> provides, and how we should deal with old index versions while still
>> supporting index v5 (without losing tree advantages)
>
> Ah ok, thanks for the clarification, I understand what you meant now.
> I think however, that it's not very beneficial to do this conversion
> now. git ls-files needs the whole index file anyway, so it's probably
> not a very good test.

Think about "git ls-files t/" and "git ls-files -u".  

The former obviously does *not* have to look at the whole thing, even
though the current code assumes the in-core data structure that has the
whole thing in a flat array.  IIRC, you had unmerged entries tucked at the
end outside the main index data, so the latter is also an interesting
demonstration of how wonderful the new data format could be.

Unlike other commands like status and diff that may need to look at things
other than the index, the core functionalitly of ls-files is purely about
the index.  I do not understand why you think it is not a good test case.
If an updated index structure cannot even improve ls-files, there is no
hope it can improve other more complex commands that need to walk the
index and something else in parallel.
