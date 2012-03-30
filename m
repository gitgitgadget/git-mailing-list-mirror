From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git push performance problems with ~100K refs
Date: Thu, 29 Mar 2012 19:12:21 -0700
Message-ID: <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
References: <201203291818.49933.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 04:12:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDRKH-0004C2-8q
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 04:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759857Ab2C3CMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 22:12:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759768Ab2C3CMY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 22:12:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8850D734C;
	Thu, 29 Mar 2012 22:12:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mP2FBz1fe3APbR/MQEnVnkQup10=; b=RcNugE
	94FSmkjiMWI8neEvBAPL+mQJdtIzspfY2RjoK+nfL4K4bztcg+LBInzpJ3fMXx5o
	4KXhQ0tUrjGCB1T/j5v/p5QC594obShRkf6PcsWhzbYYHdktrHeSCXNudoYTNXqG
	5P4VHZ4ACSHaxauyLHqqzLDFFiPA4VpWvRpAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O9POOVwH16hQhYcR7g2UfIT4ixq3kdmA
	MvEFt1pgY66G/7juv2CvU/ZzgyXQ1brHKCWrKJML1EgdoB7QJtMtAgZqm0soOiPm
	iTGP8uuk0gsy8tOydCPbLyHGTHK/nmmaQjroabXci4n8z377EbwKOeya4p5csYQr
	eSaXO5FCZHo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80B29734A;
	Thu, 29 Mar 2012 22:12:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12B887349; Thu, 29 Mar 2012
 22:12:22 -0400 (EDT)
In-Reply-To: <201203291818.49933.mfick@codeaurora.org> (Martin Fick's message
 of "Thu, 29 Mar 2012 18:18:49 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C974FCAA-7A0D-11E1-8903-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194313>

Martin Fick <mfick@codeaurora.org> writes:

> Does anyone have any hints as to what might be wrong with 
> the receiving end algorithm that would cause a small change 
> to use so much CPU?  Is there anything that can be done 
> about it?  I noticed that the --all option will effectively 
> feed all the 100K refs to rev-list, is this really 
> necessary?

It is trying to minimize the transfer cost.  By showing a ref to the
sending side, you prove you have chains of commits leading to that commit
and the sender knows that it does not have to send objects that are
reachable from that ref. One thing you could immediately do is de-dup the
100k refs but we may already do that in the current code.

> Are there any tests that I can perform to help 
> debug this?

You do not need to "help debug" it.  It's cause is already known: the
receiver exposes too many refs to the sending side.

We've talked about possible solutions but no concrete design nor code is
there yet.
