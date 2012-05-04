From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: reflog for deleted branches
Date: Fri, 04 May 2012 09:24:51 -0700
Message-ID: <7vmx5nc3sc.fsf@alter.siamese.dyndns.org>
References: <4FA2F7DA.6020108@tu-clausthal.de>
 <7vaa1pdjz8.fsf@alter.siamese.dyndns.org> <4FA30270.6000806@tu-clausthal.de>
 <7vwr4sdfw7.fsf@alter.siamese.dyndns.org> <4FA376B5.50804@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri May 04 18:24:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQLJT-0004TT-7D
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 18:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab2EDQYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 12:24:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57564 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875Ab2EDQYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 12:24:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BBF86E09;
	Fri,  4 May 2012 12:24:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ivXUxVUucOz7mBG8+cPsmucCwn0=; b=JwE95m
	P9QdGKdX1oh/9ZrO2ZvKsFkDbkrqaX5ePf6zx2/HqEqRJOBdsqmig17wCfZh/Jq1
	ab0rvKAS4kvj2kqGJfiebrUMBHk5j/zCkQkfbF4rwWAvj2iZOSS+wESOYwUmr6MQ
	heN58MicNScnl049f72N1KH2wrgEpVqK34m0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cGV5qc0R9O4dH8Ni/uXwzQ3SiOitwBT3
	6MACgAgppJH6/C06iYlKJ/ygE6Z5Ieanv/UW3eoal9rTD3lMrNjLWKrp/yufpCqI
	7Bo57x3smQfekyzLP/4K32KWL5HiOvbTj8gU59AfPsjXZfk6Z0JOsL5pcYmIPGBl
	ppVrM7Zjdp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 528306E08;
	Fri,  4 May 2012 12:24:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D911A6E07; Fri,  4 May 2012
 12:24:52 -0400 (EDT)
In-Reply-To: <4FA376B5.50804@dewire.com> (Robin Rosenberg's message of "Fri,
 04 May 2012 08:27:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD9429DE-9605-11E1-B06D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197035>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Junio C Hamano skrev 2012-05-04 01.05:
>> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
>>
>>> The "normal" reflog cannot be used if you just create and then delete a
>>> branch - the reflog is empty in this case.
>>
>> I somehow thought we discussed about the lack of "creation" event.
>> Perhaps it is sufficient to create a reflog entry for such then?
>
> We have the create event (oldd=0000...), if we just don't delete the log and add
> a destroy event (newid=000000).
>
> A bit trickier with the current reflog design is the case where you
> delete branch foo and then create the branch foo/bar.

That is not worth worrying about from the behavioral point of view, as end
users, even on Macs and Windows, have long learned that in a hierarchical
name space, you cannot have foo and foo/bar at the same time.  But from
the implementation point of view, that implies in this sequence:

	create foo/bar, creating refs/heads/foo/bar and logs/foo/bar
        delete foo/bar, removing refs/heads/foo/bar but keeping logs/foo/bar
	create foo

the third step needs to "rm -fr logs/foo && >logs/foo".  We have refs/heads/foo
under lock, so presumably nobody can create a baz branch that adds logs/foo/baz
to race with us while we do so, but I didn't check.  Our lock taking code
may need to be tweaked so that if you take lock on refs/heads/foo, nobody
else can take lock on refs/heads/foo/anything, and vice versa.
