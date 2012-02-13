From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Sun, 12 Feb 2012 22:37:46 -0800
Message-ID: <7vsjifgrwl.fsf@alter.siamese.dyndns.org>
References: <20120210185516.GA4903@tgrennan-laptop>
 <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <7vaa4qnk4u.fsf@alter.siamese.dyndns.org> <4F361DD4.9020108@alum.mit.edu>
 <7vlio9n5ym.fsf@alter.siamese.dyndns.org> <4F389FB1.2070706@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 13 07:38:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwpYB-0005dE-JH
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 07:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab2BMGiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 01:38:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab2BMGhs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 01:37:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22F234A04;
	Mon, 13 Feb 2012 01:37:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QYNxrKezHBw+8hFPcy1GVlKUDTM=; b=Y8wguR
	j2uc53LGN13HURR+cUCziac7QnrpoYabF7ULUqDj8u0+vtDwYefXVIlw88f7ReoW
	phQnZqOJ09aU4WA0Y8oQrRdHMOr0gQTe5TIeCwP9ixD1rb49gdsjL5vPsdRMfpB6
	/hDQUTSnnYbCMoDEaiM75CK+T801REUfWTL5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gFSRG6MqPI9Bhk3XOZPv0JF4j1FWAgk5
	EUTsoxS3ilmaewdUcIVpkCMT8QoFBlqP3q+dF7ntZVFWHPdSRqcVFXnlj7GEXuTN
	q29xHZ+VYPBDhtqnCbghfENtFDHc7Err4E3dtmd+pkfCe5KdsH8/T6RAUlwlv30T
	3KJzc1ioNdQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 165D84A03;
	Mon, 13 Feb 2012 01:37:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AFA84A02; Mon, 13 Feb 2012
 01:37:47 -0500 (EST)
In-Reply-To: <4F389FB1.2070706@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 13 Feb 2012 06:29:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E315FA4-560D-11E1-80EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190610>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Of *course* they operate on different namespaces.  But part of the way
> that revisions are selected using rev-list is by *selecting or excluding
> refnames* from which it should crawl.

I am appalled if that is truly the understanding of yours, after having
taken more than a few patches from you to fairly core parts of Git.

"rev-list A ^B" does not say "include A and exclude B from which rev-list
should crawl" AT ALL.  We _actively_ crawl from both A and B.  It is that
what are reachable from B is painted in a color different from the color
in which we paint what are reachable from A.

A better pair you could have mentioned would be for-each-ref vs rev-parse
(not rev-list).  What Tom wanted with "do not show the refs that match the
pattern" he originally wanted to give to "tag --list" would be

	for-each-ref A ^B

that is "show ref that matches A but do not show if it also matches B",
while what you want to say is "I want to paint A in positive color and
paint B in negative color, and I want to get a canonical notation to do
so", it is spelled with rev-parse, not for-each-ref, like this:

	rev-parse A ^B

In other words,

	git rev-list $(git rev-parse A ^B)

would be the equivalent to "git rev-list A ^B".

Maybe you are troubled that there are multiple concepts of negation, which
ultimately comes from the undeniable fact that for-each-ref and rev-parse
operate on entities in different concept domain (refnames and objects)?
And if we decide to use "^", then these two different concepts of negation
are both expressed with the same operator "prefix ^", leading to
confusion?

I am kind of sympathetic to that argument, and it might be a better idea
to avoid using "^" as the negation for matching operator, in order to make
it more apparent to the users that for-each-ref and rev-parse operate on
different concepts. But at the same time, if you know these are distinct
concepts, using the same "^" operator as a consistent way to express the
"negation" that is applicable in each concept domain does make it easier
for users as they gain experience. I tend to avoid making things too hard
for experienced users for the sake of flattening the very early learning
curve when possible, because nobody will stay novice forever.
