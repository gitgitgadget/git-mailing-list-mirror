From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make !pattern in .gitattributes non-fatal
Date: Fri, 01 Mar 2013 13:53:39 -0800
Message-ID: <7vbob2g524.fsf@alter.siamese.dyndns.org>
References: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch> <7vfw0eg90e.fsf@alter.siamese.dyndns.org> <87mwumx36m.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 01 22:54:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBXu3-00089P-O6
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 22:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab3CAVxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 16:53:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973Ab3CAVxm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 16:53:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 349FFA3A4;
	Fri,  1 Mar 2013 16:53:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a3CtBeEQhP1QZguyKR2SsBtD3zI=; b=x4oesj
	pcWlmojoo57ofDB/Jq8Ar+SS0XG04svTPVFGBgbOC+YcaylqHqZcHrFUY075+5XB
	EfTJFR+CISdkny/UhLg+sYa3sdYOT+PfaQ7+gYvWAV396XrszsTlSCtFu07mqGYH
	UIcoiJLscFrTz7W1uZOXCCCeiPl7J+gGGPSqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=blGT4OcXPENH/ZimUf1eWBpyiP58PCiW
	ZMHVIMeCZdR4IqykR0vPZUvwS/ER3s6YIpP1+yMu4hCv0YY3xlrnzIDERxhGVskV
	kTPrfyEmhFZ8e73usYx9SWyeh9wqz8tVzmlEJ1y+nOjIlYzbPmSPS9oDql/NyXde
	sU9cIVcHc8E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28D8CA3A3;
	Fri,  1 Mar 2013 16:53:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8102DA3A1; Fri,  1 Mar 2013
 16:53:40 -0500 (EST)
In-Reply-To: <87mwumx36m.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 1 Mar 2013 21:42:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A815E5C-82BA-11E2-85C7-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217295>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> Before 82dce99 (attr: more matching optimizations from .gitignore,
>>> 2012-10-15), .gitattributes did not have any special treatment of a
>>> leading '!'.  The docs, however, always said
>>>
>>>   The rules how the pattern matches paths are the same as in
>>>   `.gitignore` files; see linkgit:gitignore[5].
>>>
>>> By those rules, leading '!' means pattern negation.  So 82dce99
>>> correctly determined that this kind of line makes no sense and should
>>> be disallowed.
>>>
>>> However, users who actually had a rule for files starting with a '!'
>>> are in a bad position: before 82dce99 '!' matched that literal
>>> character, so it is conceivable that users have .gitattributes with
>>> such lines in them.  After 82dce99 the unescaped version was
>>> disallowed in such a way that git outright refuses to run(!) most
>>> commands in the presence of such a .gitattributes.  It therefore
>>> becomes very hard to fix, let alone work with, such repositories.
>>
>> Fixing the working tree is easy, but when we read from a history
>> that already records such an entry in an attribute file, it would
>> become somewhat cumbersome.  I wouldn't use "very hard to fix" to
>> describe such a case.
>
> Well, I'm sorry if I hurt any feelings there, but...
>
>   ~/tmp/badattr(master)$ git show bad:.gitattributes
>   !bad text
>   ~/tmp/badattr(master)$ ~/g/git-checkout bad  # a git without my patch
>   fatal: Negative patterns are forbidden in git attributes
>   Use '\!' for literal leading exclamation.
>   ~/tmp/badattr(master)$ git status
>   # On branch master
>   nothing to commit (use -u to show untracked files)
>
> Notice how it remains on master.  I suppose with enough knowledge of the
> internals I could manage,...

That would have been nicer to have in the log message.

In any case, 1.8.1.5 will go out with this fix (this is v1.8.1
regression IIUC) this afternoon.  Thanks for a fix.
