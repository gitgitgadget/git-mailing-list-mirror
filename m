From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] sequencer.c: teach append_signoff how to detect
 duplicate s-o-b
Date: Sat, 09 Feb 2013 15:06:05 -0800
Message-ID: <7v7gmhulya.fsf@alter.siamese.dyndns.org>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-7-git-send-email-drafnel@gmail.com>
 <20130122083825.GG6085@elie.Belkin>
 <CA+sFfMcyupLGPt8-3PWMzwgGR3zrm4ZfA-7KwBh5VkMXmhuTKQ@mail.gmail.com>
 <7v7gmy12op.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:06:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4JVB-0007kp-Ci
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 00:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543Ab3BIXGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 18:06:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756349Ab3BIXGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 18:06:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02E99C9E0;
	Sat,  9 Feb 2013 18:06:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pp2SW0BGxKRv9bl1jNq+stXbHv8=; b=uYn6TF
	nrSlJcUvjzLQSV6fO8XVupNYHpXbaLWylbtV0uHdR09khl2KC1DX+7EpSwcfcqPx
	5+qa87l8zowAqA0WHQEyDGXA2y8rO1z756eJI3uXpjRtYz6sjX/73QErUzTZGqnJ
	j+u4wEi7xgOg0UW0RE+yh+tkGwaKUtCpaHk1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qx8ctp4cIiBf/qnh1mS1KL6TPpfXOhQT
	J455Xy46OmV5oYTLSDhmxjqHERA4+cMM8PG4t5cD0/QWpp0GNqfgLW4LQhXw9Gik
	LMU3FBWfVPesHgB06B4s0IfPi9RR50gb1XJjC040J2lVInDkOrcPjXfLtSlmeHHe
	aAe8De2fjJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA31BC9DF;
	Sat,  9 Feb 2013 18:06:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65BF5C9DE; Sat,  9 Feb 2013
 18:06:07 -0500 (EST)
In-Reply-To: <7v7gmy12op.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jan 2013 18:06:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49310788-730D-11E2-B60A-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215881>

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Casey <drafnel@gmail.com> writes:
>
>> On Tue, Jan 22, 2013 at 12:38 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Brandon Casey wrote:
>>>
>>>> Teach append_signoff how to detect a duplicate s-o-b in the commit footer.
>>>> This is in preparation to unify the append_signoff implementations in
>>>> log-tree.c and sequencer.c.
>>> [...]
>>>> --- a/sequencer.c
>>>> +++ b/sequencer.c
>>>> @@ -1082,9 +1101,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>>>>       return pick_commits(todo_list, opts);
>>>>  }
>>>>
>>>> -void append_signoff(struct strbuf *msgbuf, int ignore_footer)
>>>> +void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob)
>>>
>>> Isn't the behavior of passing '1' here just a bug in "format-patch -s"?
>>
>> I think that is an open question.
>
> Yes. as I said in a previous review round, I think it was a mistake
> that format-patch chose to pay attention to any S-o-b in the patch
> trail, not only the last one, and we may want to correcct it once
> this series solidifies as a separate "bugfix" change on top.

This is a tangent, but I _think_ (didn't check, though) "git am -s"
implements this incorrrectly.  Just another LHF somebody may want to
take a look.
