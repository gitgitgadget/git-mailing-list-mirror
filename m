From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Wed, 06 Nov 2013 12:42:28 -0800
Message-ID: <xmqq7gcl8dor.fsf@gitster.dls.corp.google.com>
References: <20131106.074355.225932577498673677.chriscool@tuxfamily.org>
	<CAP8UFD0STna++2StV1RcT2bB83Lh_hFQU94A0y4ziovs61Z==A@mail.gmail.com>
	<xmqq4n7pa1pn.fsf@gitster.dls.corp.google.com>
	<20131106.211659.1008913569403460043.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: christian.couder@gmail.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	dan.carpenter@oracle.com, greg@kroah.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 06 21:42:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve9vw-0007Ay-CU
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 21:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab3KFUmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 15:42:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756039Ab3KFUmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 15:42:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCF234F0B4;
	Wed,  6 Nov 2013 15:42:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=64QJfPzBhNpHSDsskJ55XNkAPho=; b=Jap15B
	lDViubtdxXViH/n/PeIh3dCbVQ3A23U9Xf5scRGWiXmcuC84ZB/X9/N6C+Ugd4J8
	/pLnE4mSF2GO+23UaZO4xmFWUcx6JvbyiyiWtLp2DaEXskwFdp8pYU10lE05aRvl
	61UQypjm4bzXwftjhIC76CqZgs7K2o9xV/gzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eXbJXiHg8myCJBLkEfmWK/kvRjDq602X
	11WftjilKZLxh/sC20tM2qPhvJPf4tIpU0dCzcfpyuoFqTgVn5IyVqPQy8EevJq2
	7cqy4CzHKizlyfDFeMmRjKtGLttETVXu+EI2akuBNnKIbBaxNMbvwVSZdFzk2bLX
	kVdRvB81lz8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE5C14F0B3;
	Wed,  6 Nov 2013 15:42:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 148224F0B0;
	Wed,  6 Nov 2013 15:42:30 -0500 (EST)
In-Reply-To: <20131106.211659.1008913569403460043.chriscool@tuxfamily.org>
	(Christian Couder's message of "Wed, 06 Nov 2013 21:16:59 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F4709DF8-4723-11E3-94EB-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237368>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
>> Christian Couder <christian.couder@gmail.com> writes:
>> 
>>> To append a s-o-b only if there is no s-o-b already, one would need to use:
>>>
>>> [trailer "signoff"]
>>>          key = "Signed-off-by:"
>>>          if_exist = dont_append
>>>          if_missing = append
>>>          command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'
>> 
>> But that is insufficient to emulate what we do, no?  I.e. append
>> unless the last one is from the same person we are about to add.
>
> Yeah, but, with DONT_REPEAT_PREVIOUS, it would be possible using:
>
> [trailer "signoff"]
>          key = "Signed-off-by:"
>          if_exist = dont_repeat_previous
>          if_missing = append
>          command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'

Anything is possible, but "possible" does not justify "it is better
way than other possible ways".

What are the plausible values for if_missing?  If if_missing needs
"prepend", for example, in addition to "append", does it mean
if_exist also needs corresponding "prepend" variant for the value
"dont_repeat_previous" you would give to if_exist?

Having two that are seemingly independent configuration does not
seem to be helping in reducing complexity (by keeping settings that
can be independently set orthogonal, by saying "if the other rule
decides to add, do we append, prepend, insert at the middle?", for
example).

How would one differentiate between "there is a field with that key"
and "there is a field with that <key, value> combination" with a
single if_exist?  Add another variable if_exist_exact?
