From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 4/6] git-check-attr: Normalize paths
Date: Thu, 04 Aug 2011 10:05:52 -0700
Message-ID: <7vliv95cpb.fsf@alter.siamese.dyndns.org>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
 <1311849425-9057-5-git-send-email-mhagger@alum.mit.edu>
 <7v4o1zg20r.fsf@alter.siamese.dyndns.org> <4E3A12B9.1010800@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 04 19:06:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp1Mw-0000rJ-Ag
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 19:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab1HDRF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 13:05:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378Ab1HDRF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 13:05:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E236A4AA1;
	Thu,  4 Aug 2011 13:05:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1a0w40Y9gEjwbmEeZJG3M5M6uJo=; b=UE6avh
	K/skn7l62mwNbkXetIiOA0KVe+pfJgPU8JL31lg1OWtkQRRaywJoar90pJQNbrXK
	V7FD0rMmzbqqyfr8N6rNERkEUYpr6+IeffHkWaowwq/eOooMNXweJhONfm5NKjky
	aDOrV4f3VLZr2PjKC+qJmouPAymbAK7QFBJtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bokS8podMqk9vpgUfoqVz5LRI2h1aJei
	CzJsL5+bgLvnRCLDv6hI08Mds3UKkgWj4Wejej4UluZMYXqxHF4eT+PWWu+LFlJl
	C4Fojid9j5FjCUpT3x6uTZKjsJc/N+1Z6z0vY4pgPgZwdRtmJbFdVlc8gXIl0rPr
	SHG4nkAAlnU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D95A24AA0;
	Thu,  4 Aug 2011 13:05:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 358D24A9F; Thu,  4 Aug 2011
 13:05:54 -0400 (EDT)
In-Reply-To: <4E3A12B9.1010800@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 04 Aug 2011 05:32:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0375E3A0-BEBC-11E0-ADF1-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178751>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> I think passing down "prefix" (i.e. where your $(cwd) was relative to the
>> root level of the working tree) and the user-supplied "pathspec" (which
>> typically is relative to that original $(cwd)) is the canonical approach.
>> The very original git worked only at the root level of the working tree,
>> with paths specified relative to the root level of the tree, so many code
>> do:
>> 
>> 	- find out the root of the working tree;
>>         - note where the $(cwd) was in "prefix";
>>         - chdir to the root of the working tree;
>> 	- prepend the "prefix" to user supplied pathspec;
>>         - forget all the complexity and work on the whole tree.
>> 
>> Then the "prefix" gets stripped away from the beginning of the paths when
>> reporting.
>> 
>> Your patch from a cursory look seems to follow that pattern, which is
>> good.
>
> Thanks for the explanation.
>
> Yes, my code follows the pattern, except that in this case it is
> unnecessary to chdir to the root of the working tree.

Just to make sure there is no misunderstanding. The chdir() should not be
in the core part of the system that you may want to libify.

The above pattern was developed primarily so that older utility functions
in the system that were written back when nobody ran git from anywhere
other than the top level of the working tree can be easily adapted to main
programs that can be launched from a subdirectory. The initial set-up part
of the program is responsible for figuring out "prefix", turning relative
paths given by the user into paths relative to the top of the working
tree, and then chdir'ing to the top.

After all that happens, the library-ish parts of the system only have to
deal with full paths relative to the root of the working tree. "prefix"
comes into play when reporting the results (i.e. showing paths relative to
user's $(cwd) in the output or in the error messages).
