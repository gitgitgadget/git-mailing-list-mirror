From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rename conflicts in the index
Date: Wed, 27 Mar 2013 10:34:15 -0700
Message-ID: <7vk3osn3vs.fsf@alter.siamese.dyndns.org>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com> <7va9q72n1u.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com> <7vboa6t14w.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0BA54@TK5EX14MBXC253.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Edward Thomson <ethomson@microsoft.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:34:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKuFL-0005LN-QB
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab3C0ReT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:34:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55631 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab3C0ReS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:34:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 000E79B5A;
	Wed, 27 Mar 2013 13:34:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hO26TAlAas1Mu/7Yf+FXenY7tFc=; b=GJXlnI
	ULKByhl6TH7N5mEkAuIZOPArpFbLFpFOVxJb/iA8dqHk4YG1Z7PLgu5vFeXCmiXc
	EdFgSwralv3NFavi3eIrrNjk1H9p9uV9EnfnHmvTvsQnkRnnzqngeOOCtlHTyoIh
	bgbShjrRLhM92dZS21qWDQOWPDfTCZIcW5uR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ENGtnVIcYWI7lES46VvDk+58gPcWrJf5
	sF8mA36PqCkwEgU+ePYVOGJt04ayHlQ18ew/UtLvnFSwJCWWb+S8V2C7NjegT4B5
	x7kIo1U1YiKhyRly/h2JKg3p85GCQSOSPl4zYeO4DDWlTBgwsi/1KQQ8QNkirvtC
	hZp46UTGFO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E82209B59;
	Wed, 27 Mar 2013 13:34:17 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C29A9B58; Wed, 27 Mar 2013
 13:34:17 -0400 (EDT)
In-Reply-To: <A54CE3E330039942B33B670D971F857403A0BA54@TK5EX14MBXC253.redmond.corp.microsoft.com> (Edward Thomson's message of "Wed, 27 Mar 2013 17:03:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CE2A688-9704-11E2-8ECE-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219289>

Edward Thomson <ethomson@microsoft.com> writes:

> Junio C Hamano [mailto:gitster@pobox.com] wrote:
>> Edward Thomson <ethomson@microsoft.com> writes:
>> > I would propose that this not simply track rename conflicts, but all
>> > conflicts.
>> 
>> That is a no starter.
>
> So.  Can you explain to me why this would be a non starter?

At least two, IIRC.  One is the consequence of the other.

We do not gratuitously break existing implementations.  If no
conflict is stored as higher-stage index entries in an index that
has your index extension, no existing implementation can read a
conflicted index written by your implementation and have users
resolve conflicts.

When a path originally at A is moved to B on only one branch, and
there are content-level conflicts between the changes made by one
branch (while going from A to B) and by the other branch (while
keeping it at A), we would end up having three stages for path B
without any trace of path A.  I do not offhand know how much it
helps to learn A in such a situation in the real life, but we are
indeed losing information, and I do not have any problem with an
extension that records in the index the fact that in the two (of the
three) commits involved in the merge, the path was at A.

But people have been successfully using existing versions of Git
without that information to merge branches with renames, and
resolving the content-level conflicts.  Your tool that
_additionally_ records "This path that currently has three stages
for B was at A in the common ancestor (i.e. stage #1) and that
branch (either stage #2 or stage #3)" does not _have_ _to_ break
these users by removing the three stages for B from the main index.

Also we do not duplicate information unnecessarily.  Nowhere in the
above "we have been losing the fact that two of the three had the
contents we have at path B in the resulting unmerged index at path
A, and that information might be useful as well", there is a reason
to write another copy of mode or SHA-1 for any of the three variants.

As I said, you do not live in the world where you are writing
something like Git from scratch.  Perhaps you do, but then the
result will not be Git and we wouldn't be discussing that system on
this mailing list.
