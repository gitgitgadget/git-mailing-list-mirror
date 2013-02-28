From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/5] Implement line-history search (git log -L)
Date: Thu, 28 Feb 2013 12:37:32 -0800
Message-ID: <7v38wgi38z.fsf@alter.siamese.dyndns.org>
References: <cover.1362069310.git.trast@student.ethz.ch>
 <9af548b2a7e4a4da9eb30e99b0223f20788b4fc1.1362069310.git.trast@student.ethz.ch> <7vbob4iaxh.fsf@alter.siamese.dyndns.org> <87fw0g6xp4.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 28 21:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBAEr-0000Je-K0
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 21:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760232Ab3B1Uhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 15:37:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755944Ab3B1Uhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 15:37:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EC3EACB4;
	Thu, 28 Feb 2013 15:37:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hKqDHEpgPBRLxw51W1IX0t+kkOw=; b=tz9Bxx
	wy8Up1cQaXY35QYHw2bbGXfZyRfsuwQwjqaUNYJTrmTWrvb1ZKSHlnEsz4BeuEw0
	CLPnWQ372f32VSV8q/gygw6Yy2EY1vqtucp3EghsJKee9fC3Z1JeUz/FqlE6x0qE
	wI8PwZkAUB7YE4EEWM7MnSFU3bj29JnYLWGeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OVbTzuSczVKd6ctoA0c+2XtPi9UIvAtx
	u4lqUhMi74aL4rYLLJ0hmpxM7gr3oyqXYFBgpH/c7ZuL1p1mymLGU5TZX7Etn80q
	u+XMTDh7f16GQobvomSqqO4bq8SYtr6mNbLGJpfpwGO5kNLWDjW0BmyGcaFMzeCz
	r6I0MPr5rBw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93A6DACB2;
	Thu, 28 Feb 2013 15:37:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C246ACB0; Thu, 28 Feb 2013
 15:37:34 -0500 (EST)
In-Reply-To: <87fw0g6xp4.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 28 Feb 2013 20:32:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE508C0A-81E6-11E2-A095-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217254>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +/*
>>> + * NEEDSWORK: manually building a diff here is not the Right
>>> + * Thing(tm).  log -L should be built into the diff pipeline.
>>
>> I am not sure about this design, and do not necessarily agree that
>> wedging this to the diff pipeline is the right future direction.
>>
>> I have a feeling that "log -L" should actually be built around
>> "blame".  You let blame to hit the first parent to take the blame,
>> and then turn around to show a single "diff-tree" between the child
>> and the parent with whatever other diff pipeline gizmo the user can
>> give you from the command line.  The blame also tells you what the
>> "interesting" line range were at the first parent commit you found,
>> so you can re-run the same thing with an updated range.
>
> Hrm, now that you mention it, this is actually a brilliant idea.

I don't know.  That is just me handwaving without giving a serious
end-to-end thought.
