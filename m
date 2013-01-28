From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] sequencer.c: teach append_signoff how to detect
 duplicate s-o-b
Date: Sun, 27 Jan 2013 18:06:30 -0800
Message-ID: <7v7gmy12op.fsf@alter.siamese.dyndns.org>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-7-git-send-email-drafnel@gmail.com>
 <20130122083825.GG6085@elie.Belkin>
 <CA+sFfMcyupLGPt8-3PWMzwgGR3zrm4ZfA-7KwBh5VkMXmhuTKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:07:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tze7k-0004LJ-3L
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab3A1CGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:06:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757180Ab3A1CGe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:06:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E51CC8F7;
	Sun, 27 Jan 2013 21:06:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3N0+yt8nMbrDMYxonzmUOwVhnUQ=; b=bL7KE5
	alnUz54rqVNBMpXbv5HqVaov3jyFuQFh1GEvL3xgx2Sg/mJOmEoRNZFMZt/e6Fwx
	HOTs4VFelMi+yEqf0muKPFVtRtuuJqWcutBBC/+Y7rTFEOdiJiAHYJFZWQ5h2Bn/
	U+yavTW6haOhavj5B/GlENVpDmgkc6moS68II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NtliYp/C019XZ8wsiUdyDP9V4DdirHqi
	a2Tv1Pyh2RZRq8TTTU96ggngKRZWDLzjeCuaiO83Z+XhmHP/hA2q/JGvlZ9cLIzj
	hvUxBgojUhmEYwC9aZRjY42djfjwwXUM4OptQAtAndzFJ2D4KnEup22AMf5PjQuv
	az2dYm7/4bQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83B64C8F6;
	Sun, 27 Jan 2013 21:06:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FF06C8F4; Sun, 27 Jan 2013
 21:06:32 -0500 (EST)
In-Reply-To: <CA+sFfMcyupLGPt8-3PWMzwgGR3zrm4ZfA-7KwBh5VkMXmhuTKQ@mail.gmail.com> (Brandon
 Casey's message of "Sun, 27 Jan 2013 16:36:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56692D04-68EF-11E2-A3D3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214783>

Brandon Casey <drafnel@gmail.com> writes:

> On Tue, Jan 22, 2013 at 12:38 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Brandon Casey wrote:
>>
>>> Teach append_signoff how to detect a duplicate s-o-b in the commit footer.
>>> This is in preparation to unify the append_signoff implementations in
>>> log-tree.c and sequencer.c.
>> [...]
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -1082,9 +1101,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>>>       return pick_commits(todo_list, opts);
>>>  }
>>>
>>> -void append_signoff(struct strbuf *msgbuf, int ignore_footer)
>>> +void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob)
>>
>> Isn't the behavior of passing '1' here just a bug in "format-patch -s"?
>
> I think that is an open question.

Yes. as I said in a previous review round, I think it was a mistake
that format-patch chose to pay attention to any S-o-b in the patch
trail, not only the last one, and we may want to correcct it once
this series solidifies as a separate "bugfix" change on top.
