From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick and 'log --no-walk' and ordering
Date: Fri, 10 Aug 2012 14:38:32 -0700
Message-ID: <7vfw7uig13.fsf@alter.siamese.dyndns.org>
References: <CAOeW2eE=VcUs1YcWqqEUc6vM6jW9JaXzE-_tVWy48VtPzm_+wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:38:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szwun-0004T7-Pi
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758646Ab2HJVig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 17:38:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab2HJVif (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:38:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCF6D8EBC;
	Fri, 10 Aug 2012 17:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1sFq23bVFLM1VK6PPlw9mcBOb4E=; b=m5QXnX
	lHMSmWEUdY86tNJ3QvoSZ32TCFPFX9401c+SuLRI37jV7LWur8/305DZYrY14ZDz
	vusVPsmU+KYVE/Q78QNk5yj49hfIte8RI7ggE4xj7HvuLXUqn1qnvZIblpB0Yfdt
	mbAIPSxZ1QDDZDyilJdg8j4vppzSI9sYa/hUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wCfU5oR2QE/+8dKrGdSm+nrqxjb04vKz
	Sj3o5PFtVfXz66Wy7r3MoHLVfed640XhvlVLBJzABrXk7rMCALY7egsVniWPgbdm
	QIgE+IYMeAOPqWsqLD5LPY1F9A9LRslb97K+A3eUJoZUAXJgd7tGWZ7Imn4mx1zd
	78EzZIqJJCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC26A8EBB;
	Fri, 10 Aug 2012 17:38:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B66D8EBA; Fri, 10 Aug 2012
 17:38:34 -0400 (EDT)
In-Reply-To: <CAOeW2eE=VcUs1YcWqqEUc6vM6jW9JaXzE-_tVWy48VtPzm_+wA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Fri, 10 Aug 2012 13:41:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC7601AE-E333-11E1-88D0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203267>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> There is also cherry-pick/revert, which I _think_ does not really want
> the revisions sorted.

Yes, I think sequencer.c::prepare_revs() is wrong to unconditoinally
call prepare_revision_walk().

It instead should first check the revs->pending.objects list to see
if what was given by the caller is a mere collection of individual
objects or a range expression (i.e. check if any of them is marked
with UNINTERESTING), and refrain from going into the body of the
preparation steps, which has to involve sorting.

I think we had to fix a bug in "git show" coming from a similar root
cause, but the bug manifested in the opposite direction.
