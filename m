From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] finding the fork point from reflog entries
Date: Thu, 24 Oct 2013 14:20:29 -0700
Message-ID: <xmqqa9hymkma.fsf@gitster.dls.corp.google.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<20131024205434.GC10779@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Oct 24 23:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZSKb-0003x7-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 23:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab3JXVUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 17:20:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889Ab3JXVUd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 17:20:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E127C4D562;
	Thu, 24 Oct 2013 21:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HkcxsEtgHJD3AKvy9BiNQ9SCfYA=; b=ujzwXE
	QezqTrPpTxyQ8ehlcdrY5BSBYbcKuqwPxnS497y/Ta7Od1ICwSlPz6J9jp24LuLm
	/cbHTOc9c/kb9NW9CehX2q648g70VGmSSgcW5SLZITEm0VtoKaVlLSm8gzXW63ZB
	ByS35thjfk16EWnS4XwimLv5qXh9IkABiGGi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hVfXXk3IWQaeD4GV9qDZdvxa1o1NkN0q
	LBj6NWkEnOlmzgapXhqq+E5g4XOF5LH64XZJyDif1cqSO+Edk/TYHSC4EqPYrm+J
	DLXp2bICobYjx+VJLAh8Y5XA3JMPUvgojkFG2mg7BRD4rCOQFZon8S5WSobj8NE3
	3MEK82UvZ2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D695D4D561;
	Thu, 24 Oct 2013 21:20:32 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B71E4D55C;
	Thu, 24 Oct 2013 21:20:32 +0000 (UTC)
In-Reply-To: <20131024205434.GC10779@serenity.lan> (John Keeping's message of
	"Thu, 24 Oct 2013 21:54:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D4C0708-3CF2-11E3-A43A-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236625>

John Keeping <john@keeping.me.uk> writes:

> On Thu, Oct 24, 2013 at 12:11:22PM -0700, Junio C Hamano wrote:
>> The first one is a clean-up of the code to parse command line
>> options to "git merge-base".  Options such as "--independent",
>> "--is-ancestor" and "--octopus" are mutually exclusive and it is
>> better expressed in terms of the recently introduced OPT_CMDMODE.
>> 
>> The second one implements the entire logic of the for loop we see in
>> "git pull --rebase" directly using get_merge_bases_many() and
>> postprocessing the result.
>
> Nice!  I tried this in the case where the target commit happens to be
> the 63rd reflog entry:
>
> $ time sh -c 'for rev in $(git rev-list -g origin/master 2>/dev/null)
> do
>     git merge-base --is-ancestor $rev b2edae0 && break
> done
> '
>
> real    0m3.772s
> user    0m3.338s
> sys     0m0.440s
>
> $ time git merge-base --reflog origin/master b2edae0
>
> real    0m0.156s
> user    0m0.138s
> sys     0m0.018s

The real question is if the C code computes the same as the shell
loop.
