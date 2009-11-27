From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: don't ignore --keep (-k) option
Date: Fri, 27 Nov 2009 13:11:31 -0800
Message-ID: <7vfx7zk70c.fsf@alter.siamese.dyndns.org>
References: <874ookp4u8.fsf@meyering.net>
 <7vmy2b76ji.fsf@alter.siamese.dyndns.org> <87638zm38r.fsf_-_@meyering.net>
 <7vy6lrka69.fsf@alter.siamese.dyndns.org> <87y6lr203s.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 22:11:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE86T-0007ja-W3
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 22:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbZK0VLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 16:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbZK0VLe
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 16:11:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbZK0VLe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 16:11:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D02F883E5D;
	Fri, 27 Nov 2009 16:11:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B8WQiptOBRVLqPBCAeWn5M2Gu7M=; b=hXwQVi
	LDptUvuZnhnNRXKPp/UXDXmEXSUJTVleY2BbNlIzu6Vl5d07uGfhJuFxd/bvda/p
	LnUoKBwfK1QYYbJ0vEK4KCe2+LxnjYIM85DrURFIQxTXKGYzAw7BawM1agCCE3AU
	+ilJTdofbN6RGkL/0SToT0PzOIZCqLfNIu9dA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k8yqE571pZyqsEo3rCtkG8I0xgzyA80x
	76CX1qheI7mg+1K4nS/qcLlEN8tSpWbhHbt/v6dN5o/CTtdpCF1d1F4PyCyK3diG
	7g85s8n7078YaQ+LzH0jnDDc5TRwf3cSdj7tsJqwgbNDvHqKigT9vgqAHxDWMofC
	ShY2EatAkkI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD94383E5C;
	Fri, 27 Nov 2009 16:11:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 007B583E5B; Fri, 27 Nov
 2009 16:11:32 -0500 (EST)
In-Reply-To: <87y6lr203s.fsf@meyering.net> (Jim Meyering's message of "Fri\,
 27 Nov 2009 21\:17\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 729874E4-DB99-11DE-A253-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133939>

Jim Meyering <jim@meyering.net> writes:

>> At the level of "what does each line of the code do", this is a fix, but
>> as we do a lot more than just stripping "[PATCH] " from the beginning of
>> the Subject: line these days, I think we are better off declaring defeat
>> in this particular codepath and not doing anything here.
>
> Sounds fine to me.
> Glad you're keeping everything in perspective.

What the case statement tries to do is _wrong_; "mailinfo -k" keeps the
original prefix and all the case statement does is to add an extra [PATCH]
that did not exist anywhere in the original on top of that.

What is funny is that the case statement has been trying to do a wrong
thing from day-one, ever since the script was introduced in d1c5f2a (Add
git-am, applymbox replacement., 2005-10-07).  That version uses $keep to
hold -k or empty, gives that to mailinfo for producing $dotest/info, and
it has the same case statement that switches on $keep_subject nobody sets
to add an extra "[PATCH]" in front.  Luckily, due to the typo you found,
nobody was bitten by the bug, and your patch will break things for people
by enabling it ;-).

Thanks for noticing this one.  It began an innocent bug nobody noticed,
but it is embarrassing that we carefully _maintained_ that code nobody
triggers for four years.
