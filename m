From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG 1.7.9: git branch fails to create new branch when
 --edit-description is used
Date: Fri, 27 Jan 2012 23:27:29 -0800
Message-ID: <7vbopoxp5q.fsf@alter.siamese.dyndns.org>
References: <2443.1327701165@plover.com>
 <7vr4ykybnl.fsf@alter.siamese.dyndns.org> <4F2399B6.8020507@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Jason Dominus <mjd@plover.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jan 28 08:27:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rr2hF-0001qg-MY
	for gcvg-git-2@lo.gmane.org; Sat, 28 Jan 2012 08:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab2A1H1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 02:27:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab2A1H1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 02:27:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5917760F;
	Sat, 28 Jan 2012 02:27:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BILkezPtZWso0kh6/b2jFXKwIIY=; b=f0gQLd
	Zjx3Jhv0C6F26Wjn8YEMjJ8hX/ZSvxKnlkaO1eLm5GObLU1FFMdAAVyYkmBSOJhZ
	VSbsIpgGRO0BROKkF+81Ad1ETj+TU/IZHu2pbIj9bmI6kHScMP1gnjrY2V/JW9Lp
	ikewIzSvYQ8nRYqkiDiZyRZNRHlq/K1SrsQ+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lH8V2d4KASWbXqvCSQPIpMuIrknm9GS/
	huouw7VKwPSEI4TuKOaibwAn2Hsmh3UZ+6+7UP58bJC7EyNB6HyDZUvK8GxnRkJa
	SIWWC7ns2xMP28jcIhD4ymctdR2H1st8wtEkI9Z8pCd+8nB/pTyslvBPOI+AEbaU
	x73KszU64gw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92C75760D;
	Sat, 28 Jan 2012 02:27:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC2E8760C; Sat, 28 Jan 2012
 02:27:30 -0500 (EST)
In-Reply-To: <4F2399B6.8020507@alum.mit.edu> (Michael Haggerty's message of
 "Sat, 28 Jan 2012 07:46:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89C9A202-4981-11E1-8BB8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189252>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>>> Where is branch blarf?
>> 
>> You haven't created one in that sequence yet.
>> 
>> This is more of a documentation bug. 
>> 
>> As the SYNOPSIS section makes it clear, the '--edit-description' is a
>> separate mode from showing (the first group), creating or repointing (the
>> second), or renaming (the third).
>> 
>> After that you should be able to say "git branch blarf" and view its
>> description.
>
> Given this design, shouldn't "git branch --edit-description" fail if the
> branch doesn't already exist?


The only use scenario in the original design was to have a way to store
the description given a branch name, and giving a description to a branch
that does not yet exist is outside the scope of the design. So it all
boils down to what is the most convenient and the simplest to explain.

We could error it out (i.e. you cannot name a thing that does not yet
exist), or we could consider it is a convenience feature that you can
prepare a description even before you create one, or we could even tweak
it more like "-t $name" that tries to work both on existing one (without
changing any base) or non-existing one, creating it while at it. The last
approach historically is the most error prone (we had numerous bugs in the
create_branch() helper after it started allowing an existing branch when
updating the "track" information) and I would rather not go that route if
we can avoid it.

Honestly speaking, I haven't formed an opinion.

> Shouldn't it also resolve ambiguous reference names?

As this mode, just like other modes of "git branch" _always_ takes a
branch name, I do not think there is any "ambiguous reference name".

You give $name to it, and it should always mean refs/heads/$name, and
there shouldn't be any DWIMming to something like refs/heads/mh/$name

Or do you have other kinds of ambiguity in mind?
