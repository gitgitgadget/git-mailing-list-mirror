From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Sun, 24 Jul 2011 16:17:23 -0700
Message-ID: <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
 <7vy5znscst.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 01:17:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql7vQ-0006bs-I0
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 01:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab1GXXR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 19:17:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771Ab1GXXR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 19:17:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8955A42E8;
	Sun, 24 Jul 2011 19:17:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3d9TIecwWOReivvjpXwVEPCzTN4=; b=PByTiJ
	GRxePGkWxSyRzqBAjh8xxkkf9mSdDelIoQ0iAevL67oQncPvSCFHZF0nsEhm5GQm
	6hbURUIHdDiiiCiXp/qdlsJ5UkcRx+le9ClZpL/7VNiZIQ8S+tJiwsCE4MchFm6k
	jqkZcFWx9IBsyM4w2we2qs/edAfyww8hTnNgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QkwAtap7AnEyPAfy1M/rzKqoLAQs0nNz
	MQ4BicD+oeCv6W/dJUs1G1ajaQfwR5BHvZERsepJRPyBIBFny3j7jLsdWMheycoC
	3rUsu4Pp9aNLHhdVbAkK2+bHhVfk+pH7hHoGh3PtoU+0/UBEi2/MfAeY4ghJvpEG
	LZsgqugmpe8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8013142E6;
	Sun, 24 Jul 2011 19:17:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0890F42E5; Sun, 24 Jul 2011
 19:17:24 -0400 (EDT)
In-Reply-To: <7vy5znscst.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 24 Jul 2011 12:23:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1747485C-B64B-11E0-B22F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177779>

Junio C Hamano <gitster@pobox.com> writes:

> Questionable.  Did the user mean to say Z is positive when he said
>
> 	$ git rev-list A B ^C ... --not G H ... ^Z

Having said all that, I think you wanted a way to reconstruct various
different command lines that ends up in the same set of "pending objects",
and I do think that is something we need to address, as our command line
parsing heavily depend on the preprocessing phase of the revision
traversal machinery, and some commands do want to act differently between
the case when they are given "master" vs "master^0" for example (i.e. does
the user mean the branch as a whole or the commit at the tip?  If the
former the command may want to do something to the refs/heads/master while
the latter the command may work only on the commit or outright reject the
request saying "I only work on a branch").

In other words, I am not opposed to an effort to give the callers to the
"pending objects" machinery a better way to discover what the user told us
from the command line, giving them more than just "at the end of the
UNINTERESTING marking here are the objects listed on the command line and
you can look at their flags".  For example, some commands may want to tell
"a..b" and "^a b" apart, and other commands may want to tell what "a" was
when the user asked for exotic things like "a^@" or "a^!".

It may make sense to change the new "flag" field that can express only one
bit in your implementation to something more descriptive to express "what
command line option did this come from".  For example,

	git cmd a...b

that calls setup_revisions() may put "a" (positive), "b" (positive), and
zero or more commits that are their merge bases (negative) in pending
objects queue. Right now, these pending object entries may have some part
of the string being parsed as their name, but we may want to annotate all
the object array entries that result from "a...b" with the same "a...b"
(or a structure that represents its parsed form), so that the caller can
notice things like (1) they came from the single command line argument,
(2) the user didn't list random negative commits but they are meant as
merge bases between a and b, (3) a and b were written as such, not as
their abbreviated object names, etc.

Then "git fast-export master..master" can notice that there are two object
array entries in the pending object queue, they came from the same command
line argument, whose parse tree is a "unsymmetric difference between
string 'master' and string 'master'", and take the last piece to convince
itself that the user is talking about the master branch, even though as
the set arithmetic the result is an empty set, and do something
intelligent about the master branch.
