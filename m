From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/cygwin.c - Use cygwin's stat if core.filemode ==
 true
Date: Sun, 12 Oct 2008 16:39:13 -0700
Message-ID: <7vd4i5fkny.fsf@gitster.siamese.dyndns.org>
References: <20081012133934.GB21650@dpotapov.dyndns.org>
 <1223837086-2864-1-git-send-email-mlevedahl@gmail.com>
 <7vskr1fvys.fsf@gitster.siamese.dyndns.org> <48F25CB6.10702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, dpotapov@gmail.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 01:40:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpAY8-00035K-Tf
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 01:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbYJLXjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 19:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbYJLXjY
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 19:39:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbYJLXjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 19:39:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FE3B6EC71;
	Sun, 12 Oct 2008 19:39:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B7FD86EC6D; Sun, 12 Oct 2008 19:39:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF5820CC-98B6-11DD-A036-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98066>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Before you do that, can you explain why git_cygwin_config() should
>> duplicate the setting of that variable instead of using the existing
>> parser for that variable by calling git_default_config()?
>
> I don't like traversing the same list of configuration variables /
> files twice, each time looking for a different variable just so that
> one of those traversals can use a standard function, rather than just
> traversing once and getting exactly what this routine needs; this
> seems wasteful to me. However, I am (obviously) not the maintainer of
> this code so I will do this however it is desired.

I am not sure what you meant by "traversing twice"; when the first call to
stat or lstat is made, you call init_stat() and read the config file,
feeding each and every variable definition to the callback functions.  And
then whenever the command implementations call git_config() to getting the
configuration necessary for their own use, they read the config, again
feeding each and every variable definition to the callback functions.
This is "traversing twice" which is unfortunate, but that is not something
you can control from this codepath.

But in any case, I was worried about something different.

If you call git_default_config() as a fallback from git_cygwin_config(),
which is what all the other standard configuration callback functions do,
and/or set trust_executable_bit, command implementations that do not call
git_default_config() on their own would see different trust_executable_bit
value when running on non-Cygwin platform and on Cygwin.

I was wondering if git_cygwin_config() was originally written not to call
git_default_config() because some command implementations do not to want
to call git_default_core_config() (and/or read trust_executable_bit
variable from the configuration) for some reason (which would be just
hiding bugs in other parts of the system, I suspect).

If that is the case, we would have to fix such broken parts of the system,
but until that happens your original patch to use a separate variable and
keeping trust_executable_bit untouched would be much safer than this
latest patch.  Hence the question.
