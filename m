From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-daemon: logging done right
Date: Wed, 13 Aug 2008 16:13:32 -0700
Message-ID: <7vmyjgjyoz.fsf@gitster.siamese.dyndns.org>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Aug 14 01:14:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTPYD-0004Ar-1E
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 01:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbYHMXNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 19:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbYHMXNl
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 19:13:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206AbYHMXNl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 19:13:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F1D9458436;
	Wed, 13 Aug 2008 19:13:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 23B7158434; Wed, 13 Aug 2008 19:13:34 -0400 (EDT)
In-Reply-To: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl> (Stephen
 R. van den Berg's message of "Wed, 13 Aug 2008 10:43:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75DE9400-698D-11DD-8F7E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92291>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> Make git-daemon a proper syslogging citizen with PID-info.

In general, please try to avoid using the wording like that in the commit
log message, _without_ defining what you think is the proper way and why
you think the current behaviour is improper.

Do you mean "if we use syslog(), we can ask it to add pid information to
the output and we do not have to prepend pid information ourselves"?

For the same reason, "logging done right" is somewhat a suboptimal title
for the patch.  If the title describes concisely the reason why the new
way was chosen by you over the old way, and the readers can judge for
themselves if they agree with your reasoning and if the new way is better.
For example, you could have said "git-daemon: let syslog() to add our pid
to the messages".

Yes, it is _not_ the only change you are making with this patch, and the
example message won't describe what you did fully.  It may be an
indication that you are doing too many things in one patch, unless other
changes are "well, they are not a big deal but while we are at it why not
fix them" kind of changes.

> Simplify the overzealous double buffering in the logroutine.

Is there any overzealous double buffering involved?  I thought it just
does s*printf() twice into the single buf[]?  Are you referring to the
trick of setting stderr to line-buffered output?  It does remove the need
for these two s*printf(), and is an improvement.

I am however not as sure as you seem to be that these two changes make the
difference between "done right" and "done wrong" --- at most I'd say that
these fall into "improve the way the log is done" category.

> Call logerror() instead of error().

Calls to die() are covered by setting die-routine to daemon_die(), but the
error() calls are lost to bitbucket.  This is a real fix to keep otherwise
lost error message to the log stream.

Don't you want to also send the "poll failed" error to the log stream as
well?

Thanks.
