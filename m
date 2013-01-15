From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: store converted URL
Date: Tue, 15 Jan 2013 08:51:48 -0800
Message-ID: <7vr4lm4cez.fsf@alter.siamese.dyndns.org>
References: <1357760618-81222-1-git-send-email-max@quendi.de>
 <7vmwwbd43o.fsf@alter.siamese.dyndns.org>
 <64C81CD0-960A-47F2-89FC-8D3126B1F4D5@quendi.de>
 <7vzk0a4ekj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:52:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv9kF-0007WW-Qa
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 17:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab3AOQvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 11:51:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61388 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755805Ab3AOQvw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 11:51:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6707CBA94;
	Tue, 15 Jan 2013 11:51:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=stHHWSAxVbsbVJmHYiw7V3fJtfc=; b=xj975g
	UVG+GT3JNERMUt2LZG678I6xGPM822ZGqvE6YrIcTtdRb7BQdUjNqi8eHvaN+4/V
	0Bcf55hFwWGcP0udOPATahSRR6I1n7nBXrCzdiKUcGWXMbboe08JswAaOoVA4sk/
	ReO6ne9XSAYK5b9r1f+kcTMWtKRKQKxpTGyj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LCSk5aBcRkH13AysWPsJRTVKG9Uxykf/
	ZBWMMh0Iav1/BT1NtI40ggBZEb9sbPs3tAujcH8LvWbh15+m1pfHxQcNiFbMgAib
	N8k/TGrdzFGF7pXHg5D0aQqvisqVOm1YtcmxN3ltdxcueEowL15POmClDDFR2YLl
	XfFmw/G0Scs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C035BA93;
	Tue, 15 Jan 2013 11:51:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B485EBA91; Tue, 15 Jan 2013
 11:51:50 -0500 (EST)
In-Reply-To: <7vzk0a4ekj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 15 Jan 2013 08:05:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBA461DE-5F33-11E2-88EF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213648>

Junio C Hamano <gitster@pobox.com> writes:

> Max Horn <max@quendi.de> writes:
> ...
>> See also the discussion (yeah, this time a real one ;-) leading to this:
>>   https://github.com/felipec/git/issues/2
>> ...

If I understand correctly, the $backend::$opaqueToken is a contract
between the remote-helper and the remote-$backend that says "When
user wants to interact with the same (foreign) repository, we agreed
to let her use 'origin' nickname.  The remote-helper looks up this
opaque token that corresponds to 'origin' and gives it to the
remote-$backend, and whatever is in the opaque token should be
sufficient for the remote-$backend to figure out how to proceed from
there".

But in this hg::../over/there case, it seems that string is not
sufficient for remote-hg to do so and the contract is broken.

When "git clone $backend::$opaqueToken repo" is run in /dir/ecto/ry,
and then subsequent "git fetch origin" will be run in (a
subdirectory of) /dir/ecto/ry/repo, but anything relative to
/dir/ecto/ry will not work once you go inside /dir/ecto/ry/repo.
The "create a new repository here" argument could even be an
absolute path to a totally different place, so if the
remote-$backend wants to use $opaqueToken as anything relative to
the $(cwd) when "git clone" was invoked, that original location
needs to be available somehow.

Would a new helper protocol message be necessary, so that the
backend can rewrite the $opaqueToken at "clone" time and tell the
helper what to store as URL instead of the original?  I do not think
that is much different from remote-$backend updating the value of the
remote.origin.URL using "git config".

An alternative approach may be for somebody (either the "git clone"
or the remote-$backend) to store a "base directory" when "git clone"
was invoked in remote.origin.dirAtCloneTime variable, so that the
next time remote-$backend runs, it can read that directory and
interpret the $opaqueToken as a relative path to that directory if
it wants to.  That way, nobody needs to rewrite $opaqueToken.

How do other remote helpers solve this, I have to wonder, though.
By not allowing relative paths to a directory?
