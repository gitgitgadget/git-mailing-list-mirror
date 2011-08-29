From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Un-pessimize "diff-index $commit -- $pathspec"
Date: Mon, 29 Aug 2011 15:05:56 -0700
Message-ID: <7v1uw36fgb.fsf@alter.siamese.dyndns.org>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <CA+55aFzk+hn9wMAp3H92SHAGO8CQVBpTsmR41FgCy32T7muUzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 00:06:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9y0-0003fA-4A
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 00:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab1H2WF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 18:05:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab1H2WF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 18:05:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 105B64D0C;
	Mon, 29 Aug 2011 18:05:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OClonsgBMjVfK3rktTjYDMosGIw=; b=O5qKwq
	Di1zmhn7i09PvZCJ4GIsJMdccd9IZ/8yb8xnEogZeXAMsenyWp3mhos3ooKSB9yg
	2iE4eYgNFLQiFXmYkcLWy3J+gX9EBPCtJOQxWkN4B5IwyWRndI0XUYkv0LHjBqzi
	2U0JP8p7H2EiRlJvKi166+LMMv3nKknvp6nC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kgpCXn2kHpbbFR6okJDk1SS0poHhDdF7
	6FZZhA+W43xWkqaqfUKneauRB2wnu3y75kegNK8vAwa3UJf39wEKNZPP2A0vhvDT
	w92qpN7T1OvgHbD5L3gpq/DTCuLxAEnNuKR0uQqCvVGqlIqtRmbPn6cR0L0hqJQH
	leW10a+hwJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07E204D0B;
	Mon, 29 Aug 2011 18:05:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ABDA4D0A; Mon, 29 Aug 2011
 18:05:57 -0400 (EDT)
In-Reply-To: <CA+55aFzk+hn9wMAp3H92SHAGO8CQVBpTsmR41FgCy32T7muUzA@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 29 Aug 2011 14:56:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 129EAB9A-D28B-11E0-9C29-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180366>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Aug 29, 2011 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Before and after applying this series, looking for changes in the kernel
>> repository with a fairly narrow pathspec gets a moderate speeds up.
>
> "moderate speeds up"?
>
> Looks like a big win to me. Admittedly it's already a pretty fast
> operation, but script it and repeat it a million times, and that will
> matter a lot more.
>
> I guess the "--raw" diff part means that you are hiding the time to
> make a real diff, which would otherwise swamp everything else. Even
> so, this looks like a good improvement.

The topic started by Marat Radchenko in

    http://thread.gmane.org/gmane.comp.version-control.git/179926

who was trying to pick a single path (we do not know how deep it is), and
was comparing between these two:

  $ time git show branch:file | diff -u - file > /dev/null 
  real    0m0.003s
  user    0m0.000s
  sys     0m0.000s
  $ time git diff branch -- file > /dev/null 
  real    0m31.442s
  user    0m31.040s
  sys     0m0.380s

Replacing "diff -u" with "git diff --no-index" in the former didn't make
much of a difference. It turned out that Marat had 603k paths in the index
and the most of the time was spent in the unpack machinery.
