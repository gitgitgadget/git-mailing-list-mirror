From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP] completion: complete git diff with only changed
 files.
Date: Thu, 19 May 2011 10:07:18 -0700
Message-ID: <7vipt68vqx.fsf@alter.siamese.dyndns.org>
References: <4DD30F87.2000807@gmx.de>
 <7v8vu4efvj.fsf@alter.siamese.dyndns.org> <4DD3C814.8000100@gmx.de>
 <7voc2zbwz8.fsf@alter.siamese.dyndns.org> <4DD50DA9.8010305@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Paul Ebermann <Paul-Ebermann@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 19 19:07:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN6hM-0005ec-JY
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933622Ab1ESRHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:07:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933619Ab1ESRH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 13:07:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB73A5401;
	Thu, 19 May 2011 13:09:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xg2UeUDaP5UzD7r7dB6+9JQmBJw=; b=JSjYvZ
	466F5wvNlYLmtOZDybmeCTRWPzk0h2E1o5S+HtDtbKA+vqk50FFEpyEUIg/B6swL
	g6leRwVoPTzEfqdb8NoA8Jsr7piR23pEOzxnNvsQPgV2cAl/iApysTbgfdtjOk8g
	SozQUMFNfnwlYv4LZNz8iJvwt0ht297rBKSvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sKLwxVEYF6QePbmJ7r52jtKpNDWmqJmC
	IjSJxjW6oltLiXiwXC2vJdBM/WrZyxl3XH5sU6xkTADBx/aPZ3StL+qa3DTrj3BG
	l1Bz/P8Uk4vYTI9jCC552hqcNYLIdlrqo2ntQkQmrrBnDR+Vu53zYV+TqmmTktMA
	8k2u/2tzOqk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A21A5400;
	Thu, 19 May 2011 13:09:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 436BC53FF; Thu, 19 May 2011
 13:09:26 -0400 (EDT)
In-Reply-To: <4DD50DA9.8010305@gmx.de> (Paul Ebermann's message of "Thu, 19
 May 2011 14:31:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C283327A-823A-11E0-BD10-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173969>

Paul Ebermann <Paul-Ebermann@gmx.de> writes:

> For me, it is not so much about saving CPU cycles (I have enough of
> these) but about not seeing things I don't want to see, and helping me
> decide what to type. This might be against the Git philosophy, I'm
> starting to realize.

I would say Git UI philosophy is it is justified to spend CPU cycles in
order to reduce brain cycles (of course it does not justify spending extra
CPU cycles for no gain), but your change cuts both ways. In the use case I
presented, it _wasted_ a dozen or so seconds of my brain cycle before I
get what I wanted to see. In your use case, it will reduce the need to
waste your brain cycle skiping the completion you would not want to see to
get to what you want. So I am not fundamentally opposed to the change, but
the trade-off will largely depend on what your workflow is and what system
you are on.

One thing that I am worried about is the latency before getting the list
of completion. I've heard enough horror stories on a filesystem with slow
lstat(3) even "diff-files --name-only" introduces a noticeable lag, so I
am not sure limiting this new codepath only to the case where you know the
comparison is made between the index and the working tree would save those
folks.

There already are existing knobs in the completion script to tweak how
much extra cycles the user is willing to spend to generate PS1. Perhaps
the new codepath can be made to trigger only to people who want it (or the
other way around, to allow people to disable)?
