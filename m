From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Display change history as a diff between two dirs
Date: Mon, 31 Oct 2011 20:49:51 -0700
Message-ID: <7v39e8o61s.fsf@alter.siamese.dyndns.org>
References: <4EAC6765.4030003@gmail.com>
 <7vty6rrow8.fsf@alter.siamese.dyndns.org> <4EAE688C.8010502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roland Kaufmann <rlndkfmn+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 04:50:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL5MN-0003Ww-WA
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 04:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab1KADtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 23:49:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942Ab1KADty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 23:49:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA9BE6BC9;
	Mon, 31 Oct 2011 23:49:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UmPCkbz1jZOQFpNLCppuC0Xl634=; b=wWTyqD
	83NVmQyoZ8WeAxjNyLLR1YTtXtuho+lmwc+camuSJ+ER+S+Ru5K8sGwTfQbFw18i
	eJAr5XW8kXA/Y7lwcuduj0pMZGnKQfsQydntMGYd6iscV0ol0fCwUZIQMNPftcvR
	aFYVT9w0uRdvrdH9y7rohymAeLNxfp1A9kiC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SB3/0qp48aDSp7TK+htpnkbMHsZu8og0
	OjT67ugYPy6tmhjYLNxKoGnCtJz5VrUHkGJDpgR7OG63xTyoLSMvwjhaunYFRvKV
	jRZhSUZ3ISdAGpB/t19276kD7gih4oVYHRjrQVQehtPTW2jRbigBJrUcbvLEiu1a
	btGEvzww7eE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A16786BC1;
	Mon, 31 Oct 2011 23:49:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34C1A6BC0; Mon, 31 Oct 2011
 23:49:53 -0400 (EDT)
In-Reply-To: <4EAE688C.8010502@gmail.com> (Roland Kaufmann's message of "Mon,
 31 Oct 2011 10:21:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E733532-043C-11E1-B233-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184554>

Roland Kaufmann <rlndkfmn+git@gmail.com> writes:

>> "git diff" (and possibly even things like "git log -p") populating
>> two temporary directories (your old/ and new/) and running a custom
>> program specified by GIT_EXTERNAL_TREEDIFF environment variable,
>> instead of doing
>
> Would it be better to have yet another configuration available for
> this option instead of reusing the existing infrastructure for `git
> difftool`?

GIT_EXTERNAL_DIFF is designed to drive tools that can take a single pair
of files and compare, so it is entirely possible for people to have such
tool that would _not_ grok (as a tool named by the variable does not have
to) two directories specified by it. So yes, it is essential that the
variable not be reused.

It probably is OK for "git diff --dirdiff" to use GIT_EXTERNAL_TREEDIFF if
and only if GIT_EXTERNAL_DIFF is not defined, and use GIT_EXTERNAL_DIFF
otherwise. People who have GIT_EXTERNAL_DIFF set to a tool capable of
handing directory pair can just add "--dirdiff" to the command line, and
others can find such a tool and set it to GIT_EXTERNAL_TREEDIFF when they
do so.

>> It also is not clear what could be used in "$@". Obviously you would
>>  not want things like "-U20" and "--stat" fed to the first "list of
>> paths" phase, but there may be some options you may want to give to
>> the inner "external diff" thing.
>
> Ideally, it should work the same way as `git difftool`.

I am not so sure about that; difftool is another way to drive a tool one
filepair at a time. You want to drive a tool that takes them as two _sets_
of files, one in each directory.
