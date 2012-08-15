From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request - discard hunk in add --patch mode
Date: Wed, 15 Aug 2012 11:11:09 -0700
Message-ID: <7vvcgk58le.fsf@alter.siamese.dyndns.org>
References: <BLU0-SMTP37070ADBEC060E1EA15944693B60@phx.gbl>
 <87txw41okl.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mina Almasry <almasry.mina@hotmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:11:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1i3s-0005YB-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 20:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab2HOSLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 14:11:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab2HOSLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 14:11:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57386922D;
	Wed, 15 Aug 2012 14:11:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=35ismgXjdIEEeAJKH9Lh+a49n+E=; b=ULh0d6
	885hcSGL8IIxoKP4LsJuqsTbnyNf6ZophDD9SS1CNeywerqHECZ5ID6wVlC8ql+J
	H7icb+DIcHYgg/cxr5W+/3s25PC1oFugYCh9tfidyexQ3fgLLOfknWpSE71YGQmN
	71jPR9NQqrDmOwD1MTUrVmCHDJRmPiFLvcqeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oJb4yG3Fk0GTIBa7DKGp7L6GDfbCEa0d
	Actqq/ohuPkzywrrJapIZWPpjSpPjbPeQty+tTdmbNVLuqrR1TSDwjFv5e0Knm6i
	Qcqu3sAJ0LIt7D9xt/8AbIBO/j9Aode3nqc8o4aqCNLyG+BhrHHaUtLU3MqVzjcx
	DryS4mIahYw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 442C5922C;
	Wed, 15 Aug 2012 14:11:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57A6E922B; Wed, 15 Aug 2012
 14:11:12 -0400 (EDT)
In-Reply-To: <87txw41okl.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 15 Aug 2012 11:39:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9895DBCC-E704-11E1-B484-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203479>

Thomas Rast <trast@student.ethz.ch> writes:

> Mina Almasry <almasry.mina@hotmail.com> writes:
>
>> I frequently stage files using git add --patch command and I almost 
>> always come across debug code I want to discard, but there is no option 
>> for that in the prompt. The result is that I have to run an extra 
>> command after the dialogue ends.
>>
>> I would like to add a feature to allow users to discard hunks using a 
>> command like r! or d!
>
> This has come up before, and actually led to the introduction of
> 'checkout -p' and 'reset -p':
>
>   http://thread.gmane.org/gmane.comp.version-control.git/123854

That is a blast from the past.

Why is saying "git checkout ." too much work, after "add -p" that
you excluded the debugging cruft?

I actually do this for extra safety, though:

	git add -p ;# add everything but exclude debug cruft
	git diff ;# make really sure that this shows only garbage
	git diff | git apply -R ;# and get rid of that garbage

primarily because I can take the "git diff" output in the second
step to a file, remove the hunk that I accidentally forgot to add
in the "add -p" stage, and "apply -R" to remove only the cruft.
After doing so, "git diff" will show the important-but-forgotten
bit, and I can choose to add it to the next commit, or I can choose
to leave it in the working tree for a future commit after the
current index is committed.

But the above is a tangent side-note to show possibly a better way
to work, not about adding new operations to "add -p".
