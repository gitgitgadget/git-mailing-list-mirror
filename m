From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: --ancestry-path
Date: Wed, 21 Apr 2010 01:49:08 -0700
Message-ID: <7v8w8hchrv.fsf@alter.siamese.dyndns.org>
References: <201004201649.31084.johan@herland.net>
 <7viq7lg8f2.fsf@alter.siamese.dyndns.org>
 <7v39ypg4gm.fsf_-_@alter.siamese.dyndns.org>
 <201004210934.30226.johan@herland.net> <4BCEADA3.7090504@viscovery.net>
 <7vochdcjz5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Johannes Sixt <j.sixt@viscovery.net>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 10:49:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Vcx-00019e-Pu
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 10:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab0DUItW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 04:49:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab0DUItU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 04:49:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6594A9D7D;
	Wed, 21 Apr 2010 04:49:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xSGdtNTnf8pv+LwaIup127dMYLk=; b=UOplUT
	stMuwyCdTltrdDK2M/kUSB5SA8ZvVAMXk/jSFmw4zXXETHdyyONdUevYXxj9E2Ey
	IDcCdgJoXkqa1aLIK7ni2yTZp2nBNhLocTo20O3Ao56lXmzWb7r/mmm1mMT/+EsP
	S6k3tYHxjq5S5rduXb5LI95y7ngkWETs1ymPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AWHemkKmeW5G8e1Aeb75eLdydYWrezsD
	5+8xHbyjIo0afuv1kxlt3bGrIbQZkQQE8EhLhKsAsaPhFfQXy7oFcKvhmRw4C+Hf
	pA9NVAp0Mwx7Ldxsa2AXdJcXnBqlvu0a0mT5fn5WxKlCUTPm5rJGw40Ae4IHNb3K
	VYgfOtgEqK0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 649F2A9D78;
	Wed, 21 Apr 2010 04:49:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 989C2A9D73; Wed, 21 Apr
 2010 04:49:09 -0400 (EDT)
In-Reply-To: <7vochdcjz5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 21 Apr 2010 01\:01\:34 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C337A80C-4D22-11DF-A503-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145420>

Junio C Hamano <gitster@pobox.com> writes:

> I am reasonably sure that parents (specifically, "rewrite_parents") is
> broken.  The new function should cull parents that do not appear on the
> ancestry path from merges (that is what "NEEDSWORK" is about).  It may or
> may not break gitk, though---these off-path parents are shown as parents
> of an on-path merge but will be marked as UNINTERESTING.

Thinking about it a bit more, I think this is Ok, as all the ancestors on
a side branch that is off-path are marked uninteresting, and we do show
uninteresting parents in the output of an interesting commit.  In fact, if
you do "rev-list --parents HEAD^..HEAD -- .", on a non-merge non-empty
commit, you will see uninteresting HEAD^ shown as the parent of HEAD.

> This is not a new problem, but I strongly suspect that cherry-pick is
> broken the same way wrt "rewrite_parents".

This is a different and a real issue.  By marking ones that are duplicate
of commits from the other side as SHOWN, we will spit out a disconnected
history.  It should rewrite the parent list so that children of a commit
that is removed due to being a duplicate from the other side point at an
ancestor of that removed commit to keep the history connected.
