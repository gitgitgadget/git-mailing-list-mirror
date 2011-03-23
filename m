From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] git cherry vs. git rev-list --cherry, or: Why does "..."
 suck?
Date: Wed, 23 Mar 2011 11:20:54 -0700
Message-ID: <7vfwqdem0p.fsf@alter.siamese.dyndns.org>
References: <4D889119.3020009@drmicha.warpmail.net>
 <4D8A23CD.9030203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:21:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Sg9-0006es-Cv
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 19:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098Ab1CWSVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 14:21:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab1CWSVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 14:21:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BDBBB4E3A;
	Wed, 23 Mar 2011 14:22:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zdyq186kTr88F+fnyVYsAQkiAq8=; b=ky1Q5P
	Nm3Slydwz3aDq597YDGspyPIFexMDS3yKhWpYguot9xroaH5VO9dlDSBsjTlJuVq
	VcSAgWsfEtT7ALfF1VMVCHcxWIxH9PQdKlqEWn5ocXjLH6SEM3fXWbxFJnutaEcZ
	7zar0eW4ixM2x0jtLJv6zMY65gaZrSYj78RXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DcrBXh6aVCVtLzlG0jqjvlL6CX5o33Ei
	K1rWxqaqnqiyCAVMYy0YJNqdwGct3/LdeMVAVqv3gF7XJdt5BUy9Ccz+C/V3Vo+F
	FJbyFgNHz1eblO5A5r6jweql8gVpZoPxRHc0u46o7ZfF1cfkrGrqJcRKnFFLxItu
	QOSSIK/DIKY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B9214E2D;
	Wed, 23 Mar 2011 14:22:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CA064E2C; Wed, 23 Mar 2011
 14:22:36 -0400 (EDT)
In-Reply-To: <4D8A23CD.9030203@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 23 Mar 2011 17:46:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89176A70-557A-11E0-9107-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169867>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Adding some recent insight:
>
> Michael J Gruber venit, vidit, dixit 22.03.2011 13:07:
>> Performance
>> ===========
>> 
>> I don't get this:
>> 
>> git cherry A B: 0.4s
>> git rev-list --cherry A...B: 1.7s
>> (more details below)
>
> I can get the latter down to 0.95s and this
>
>> merge-base A B: 0.95s
>> merge-base --all A B: 0.95s
>> rev-parse A...B: 0.95s
>
> to 0.16s each. The downside is that merge-base may give a few
> unneccessary candidates (commits which are ancestors of other commits it
> returns), but this does not change the results for rev-list, of course.
>
> I get this dramatic speedup by removing the check for duplicates from
> get_merge_bases_many() in commit.c. After a first merge_bases_many()
> run, returning N commits, that check calls merge_bases_many() again for
> each pair (N choose 2) to check whether one is contained in the other.
> Quite a bottleneck. Removing it works great. But can we live with a few
> additional merge bases?

When we run merge-base as the top-level command (this includes
reduce_heads() that is used by "git merge"), we have to cull unnecessary
phantom bases that can be reached by other bases, so you are not allowed
to make such a change unconditionally.

Passing down a parameter from a caller that is prepared to handle phantom
merge bases correctly is probably the right approach.  Existing callers
can make "safer" calls for now; you can later examine them and turn them
into "faster" calls if they operate correctly given a result that contain
phantom bases.
