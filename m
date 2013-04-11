From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Locating merge that dropped a change
Date: Thu, 11 Apr 2013 12:21:25 -0700
Message-ID: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org>
References: <51645749.8090402@bracey.fi> <5166F2C5.4020803@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Apr 11 21:21:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQN3u-0001Lm-9E
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 21:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab3DKTVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 15:21:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38157 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab3DKTV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 15:21:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E179214F67;
	Thu, 11 Apr 2013 19:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2BRiM5dZtQgNh1zhIVUMLB55T0c=; b=KEtstF
	Tp5WfwJWWndsgmhignDryYgtcxNr4Y3Peaag8grOmB3gMRurS5aGJqaJQjX6bUlM
	oTsl8gOCPo93rlGPBztsH/+pvtVgv+GAMGGqcw4A7+98nHyhpuFgDN4cTD2ez+lT
	J+dKd//6Di8NjgHXvODKHIIFSWWAMBmL4a51w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OezyJBqf2qWm+xaGCKKaoha+8zgUD0md
	mZZgULQ6+kc/omwpoGUCCepzAAfvyYtaKxWPS6Zu8vLy4TebDHaHLRqLdeHC6ZkQ
	lm2ktAGsZKSq8JpteyqnfuhZBGkz3zF4LNIuSXhf52GWiP92MArvL3QM0gAQsCdG
	anzalRfztsY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6F7214F66;
	Thu, 11 Apr 2013 19:21:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F34F14F65; Thu, 11 Apr
 2013 19:21:27 +0000 (UTC)
In-Reply-To: <5166F2C5.4020803@bracey.fi> (Kevin Bracey's message of "Thu, 11
 Apr 2013 20:28:37 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0196E032-A2DD-11E2-9987-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220919>

Kevin Bracey <kevin@bracey.fi> writes:

> I think I've found the problem. It only doesn't work _if you specify
> the file_.
>
> Specifically, if I was missing an addition, my first attempt to find
> it would be
>
>   git log -p -m -S<addition> <file>
>
> If the addition was lost in a merge, that doesn't even show the
> addition, which is surprising, but intentional. The addition isn't
> part of the HEAD version of <file>, so no point going down that path
> of the merge. Fine. However, I expected this to work:
>
>   git log --full-history -p -m -S<addition> <file>
>
> But it doesn't. It finds the addition, but _not_ the loss in the merge
> commit.
>
> But this does work:
>
>   git log -p -m -S<addition>
>
> That really feels like a bug to me. By specifying a file, I've made it
> miss the change, and I can see no way to get the change without making
> it a full-tree operation.
> ... But I'd like some way to find merges
> that drop code in a specified file, and surely "--full-history" is it?

Yeah, I think that is a bug.

    $ echo first >file
    $ git add file && git commit -m initial
    $ git checkout -b side
    $ echo second >file && git commit -a -m side
    $ git checkout - && >file && git add file && git commit -m lose
    $ git merge -s ours -m lost side
    $ git log -p -m --full-history -Ssecond -1 file

does not seem to find the commit that lost the line.
