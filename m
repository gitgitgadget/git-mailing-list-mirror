From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rev-list | git cherry-pick --stdin is leaky
Date: Tue, 30 Apr 2013 11:31:26 -0700
Message-ID: <7vsj27dg5d.fsf@alter.siamese.dyndns.org>
References: <517F0C18.8060703@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Stephen Boyd <sboyd@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:31:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFKw-0003Qh-8z
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760849Ab3D3Sba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:31:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760877Ab3D3Sb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:31:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41BFE1AE91;
	Tue, 30 Apr 2013 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VRpP3QFp2BEwNzCtk0q75M+r+Rg=; b=o6GP8s
	M51r/mwd7m8fkDRe2dLk5O9M1Baw7NzdmIAVCXwnXk17iVQYlCb7GtuL2z9EvAVP
	QZ0wtnI605/6sdvc3g+0LLs8y9Zii1SxGXesipGJ7fGIK7Vc5z9u4DyKZ1ggoVlK
	5WkzscnvBClpNXZiQ5y/yZdMvFbHcTXr2ohvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V/z7TkqAU52+U8MNP2nwEf3SBoqKgNOY
	SCxUb0TSCbSou3529180JcOsM6mqfE7KbWEaUP8LKgeonArFd28ZCkBuLEckphJk
	x1yDnFi6g3JCSQjpQXA4bAj46whvx13n3Qqj3T9aAZJ36AZ4TRrzCBojCKPfphgb
	grLKWpXzhFY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 397841AE90;
	Tue, 30 Apr 2013 18:31:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAF811AE8F;
	Tue, 30 Apr 2013 18:31:27 +0000 (UTC)
In-Reply-To: <517F0C18.8060703@codeaurora.org> (Stephen Boyd's message of
	"Mon, 29 Apr 2013 17:11:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B9011B0-B1C4-11E2-AF30-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222984>

Stephen Boyd <sboyd@codeaurora.org> writes:

> (resending since the attachment seems to make vger sad)
>
> Hi,
>
> I'm running git rev-list | git cherry-pick --stdin on a range of about
> 300 commits. Eventually the chery-pick dies with:
>
>     error: cannot fork() for commit: Cannot allocate memory

Unfortunately, I am not very surprised.

The merge-recursive machinery was designed in the "run once and let
exit() clean up after ourselves" manner, which lets it not even
having to worry about keeping track of what needs to be cleaned up.
Reusing it inside cherry-pick and revert without updating it was OK,
but extending cherry-pick and revert to take more than one change
without addressing its resource management was a large mistake.

I vaguely recall suggesting to fork and perform a three-way merge in
a separate process when operating on more than one commit when this
feature was first discussed.  We may have to do something like that.
