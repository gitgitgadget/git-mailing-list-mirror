From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Wed, 05 Oct 2011 16:03:05 -0700
Message-ID: <7v62k359ee.fsf@alter.siamese.dyndns.org>
References: <4E8C6F2F.1070306@6wind.com>
 <7v8voz8hgq.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dyn3kk7SfNZzxjoD-hK9jBQr2igmOqJojeYNHLubtSY=w@mail.gmail.com>
 <7vpqib5ciw.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dysix9fOCuvm5+aU7-AC4wmsxH4-MOX+yhaHEqzeN1cPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 01:03:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBaUd-0008Lb-8X
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 01:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935523Ab1JEXDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 19:03:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935493Ab1JEXDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 19:03:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0157C5608;
	Wed,  5 Oct 2011 19:03:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H/sI3txH8ZjMkR2jyCkX04DPWJM=; b=djpgMU
	I6fApZaaW5z/qK0+cPBl+o17JY1MU2Z+Jknbzh2/V1lXEH3El4dSyZ7hE0OC2vvv
	a3qpOKhtp4hWYMPjIg0Th5VrQM5PY3zxh3EtEzHCUDXwx86IbsJu7UH2HLl7e6G4
	XD7O/m0h2oJGgwO+p2KOabVvqpFvDtZaNwxkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vnsefau6uJtkSzRkwJJ72V3P58C4S8gk
	hsDCZHjw36uvgV91f0+ICVGih+sqrZMG6u342kZ97zLBKCRvA8u7hAp9aXfBIp9m
	03H4gaeqaQMDTVyBY05I1Zy/w3sFcsbdk6iYRHeMenpT0sRwYiFsgspRKgYSo2iP
	Ck97q71r6Ls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEEDC5607;
	Wed,  5 Oct 2011 19:03:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A0565606; Wed,  5 Oct 2011
 19:03:07 -0400 (EDT)
In-Reply-To: <CAG+J_Dysix9fOCuvm5+aU7-AC4wmsxH4-MOX+yhaHEqzeN1cPg@mail.gmail.com> (Jay
 Soffian's message of "Wed, 5 Oct 2011 18:23:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3039AFF0-EFA6-11E0-9B27-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182901>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Oct 5, 2011 at 5:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think the sequencer state needs to be removed when the command aborts.
>
> Or written later in do_pick_commit().

As a general direction, I think it makes tons of sense ot delay writing
out these state files before you really commit that the user will be in
the cherry-pick (or revert) sequence.

I am not sure if do_pick_commit() is the best place to do so. Wouldn't it
be necessary to special case the first round at least? The pick can fail
in one of two ways:

 - It does not even start. This is the case I illustrated in the earlier
   message, and we do not want to leave sequencer state.

 - It stops with conflict. At this point, it probably is OK to say that
   the user is committed to go with the sequencer flow and the next step
   would be to help Git resolve conflicts and proceed, and in this case we
   do want the sequencer state.

And once we picked/reverted at least one commit, if there are more, the
user knows the sequencer flow is in progress, and it is perfectly fine to
see the error message from "commit --amend".

It's just the "commit --amend" message that says I cannot amend felt
utterly out of place, immediately after seeing "cherry-pick" that tried to
pick only one commit did _not_ even start.
