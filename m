From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] Introduce a performance test for git-rebase
Date: Mon, 12 Mar 2012 12:45:33 -0700
Message-ID: <7v399dsiw2.fsf@alter.siamese.dyndns.org>
References: <cover.1331561353.git.trast@student.ethz.ch>
 <e6a6af53264368a25e71719901f3227042e21f5c.1331561353.git.trast@student.ethz.ch> <87ipi9yaws.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:45:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7BBe-0002Z1-2A
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 20:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441Ab2CLTph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 15:45:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756343Ab2CLTpg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 15:45:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A019609D;
	Mon, 12 Mar 2012 15:45:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kO7zHGHGfUSL43vBcorgnjJ2PQY=; b=OdZx7r
	wL6+6jL6hUOa4+06M7JlP6lT2k9UStwj9AeKKR6eQfgCyp1IjtTwFdTI8CpPn92o
	/H5F6UkD23itbYwKPgjtJxCxiQNadgFW9He44xOoeQZZxBeFa0rbA8op/o7o8R8k
	GDq9ORXXfCXbcV4ni+tb+2ufkmXEM+Tv75hFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WTlssS9Riw0ycP3I06uIyMOWCK+XiIxp
	lclWYbJo/NwxpQiSz9bijQuioIKN96vaujfxikkebtZF1AJaghYDAxsU8ctdhF6x
	xi4bX7o7YAeS3IggD3/kspsc81IEDojXQNeKEzaioQg5NLHaZsP+Qsda1PLPS1LU
	MdwzcTyJcYw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80013609C;
	Mon, 12 Mar 2012 15:45:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B2CB609B; Mon, 12 Mar 2012
 15:45:34 -0400 (EDT)
In-Reply-To: <87ipi9yaws.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 12 Mar 2012 18:41:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF5EC92C-6C7B-11E1-97F9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192932>

Thomas Rast <trast@inf.ethz.ch> writes:

> However, it's pretty obvious that 'rebase -f' is slow compared to
> 'rebase -m'.  So slow in fact that the user would be better off running
> an *interactive* rebase.

The mention of "-f" got me off track, but does "-m" avoid creating
new commits when it does not have to?  A side effect "-f" has is to
replay _all_ the commits, if I recall correctly.

> This comes from the i18n support added in adc3b2b27..a9f578685, and from
> 43c2325 (am: use get_author_ident_from_commit instead of mailinfo when
> rebasing, 2010-06-16).

> Now I'm not really keen on hacking on git-am until it gets back its
> performance, as for most uses it's probably still fast enough.  But I
> think one important question is: can we get rid of the
> git-format-patch|git-am mode of git-rebase, which has historically been
> a source of pain (see, e.g., the aforementioned 43c2325)?

In the longer term, the right way forward is to try doing less in
the patch mode in rebase.  For example, the command could make the
list of commits to be replayed exactly the same way as it does for
flattening cherry-pick rebase, and instead of running "am", run
"format-patch --stdout | apply --3way --whitespace=fix --index" and
commit the result using "commit -C".  That way it can depend on
"commit -C" and does not have to worry about stupid things like
43c2325.
