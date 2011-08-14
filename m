From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Sun, 14 Aug 2011 14:13:12 -0700
Message-ID: <7vei0nn1cn.fsf@alter.siamese.dyndns.org>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com>
 <20110814160440.GK18466@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 23:13:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qshzm-0002Q3-Fi
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 23:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab1HNVNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 17:13:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753730Ab1HNVNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 17:13:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 394694A48;
	Sun, 14 Aug 2011 17:13:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xbDeTbxcByGtBsR32WJ4ysYPF54=; b=Bc7NPo
	uLTg6QWzVqK2KfaK5sfU0nsxteZUHHE3RCI+Y99khnxW2YNZRcp1P4ZPkSzHCnIE
	t+8cu8S9sXz5+xwN+imf3/hWija7c2iUK0/D3XzKVu4n9LfKBxw8+VNuAGcoO2ec
	T5rJGhaKqbvacsRWQzz/OEaA7lKNwz+nV0i4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PeCb5rUcliZhc7l6cLDvcA8KzMwEtEbT
	pZ7jblMuWR+rYDloEo8EdTFVOPIJ7KRXbZGuFfihtiN7D3sQFGSNrVBSysFG9DPr
	VxHvNuCfT3ZudZ2nZvTbn1q+6BEadAMioI2AgvmWptyGm54LgO4G0MCyM1hLg0M7
	c2PGhFlfqS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3056C4A47;
	Sun, 14 Aug 2011 17:13:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB8584A46; Sun, 14 Aug 2011
 17:13:14 -0400 (EDT)
In-Reply-To: <20110814160440.GK18466@elie.gateway.2wire.net> (Jonathan
 Nieder's message of "Sun, 14 Aug 2011 11:04:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 393CA0CC-C6BA-11E0-9DAD-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179347>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> Since d3f4628e (revert: Remove sequencer state when no commits are
>> pending, 2011-07-06), the sequencer removes the sequencer state before
>> the final commit is actually completed.  This design is inherently
>> flawed, as it will not allow the user to abort the sequencer operation
>> at that stage.  Instead, make 'git commit' notify the sequencer after
>> every successful commit; the sequencer then removes the state if no
>> more instructions are pending.
>
> Sorry, I'm getting lost in all the words.  I suspect you are saying
> “d3f4628e was trying to solve such-and-such problem, but its fix was
> problematic because it removes the data that a hypothetical "git
> cherry-pick --abort" command would need to work.  Back out that
> change and adopt the following instead.”

It still is unclear why "removing the sequencer state when no more insns
are pending" is so necessary that the codebase needs to bend backwards to
support that in the first place. What problem is d3f4628e really trying to
solve?

If "who is responsible for removing a stale state" is the issue it tries
to address, Wouldn't it be much cleaner to make "sequencer continue"
notice that state and silently succeed, saying "I am done"?
