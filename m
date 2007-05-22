From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add ability to specify environment extension to run_command
Date: Tue, 22 May 2007 15:19:47 -0700
Message-ID: <7v1wh88prw.fsf@assigned-by-dhcp.cox.net>
References: <20070520153908.GF5412@admingilde.org>
	<20070520181433.GA19668@steel.home>
	<20070521090339.GH942MdfPADPa@greensroom.kotnet.org>
	<20070521224828.GA10890@steel.home>
	<7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net>
	<20070522214754.GD30871@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 00:19:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqchw-0000kD-QD
	for gcvg-git@gmane.org; Wed, 23 May 2007 00:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbXEVWTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 18:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758755AbXEVWTu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 18:19:50 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56195 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbXEVWTt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 18:19:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070522221948.UNKU12190.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 22 May 2007 18:19:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2NKo1X0021kojtg0000000; Tue, 22 May 2007 18:19:48 -0400
In-Reply-To: <20070522214754.GD30871@steel.home> (Alex Riesen's message of
	"Tue, 22 May 2007 23:47:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48127>

Alex Riesen <raa.lkml@gmail.com> writes:

> Others already discussed the issue. Just to be sure, I reimplemented
> that comfortable putenv with unsetenv: if an environment entry ends
> with a "=" it will be unset.

Although combination of putenv and unsetenv gives a somewhat
queasy feeling for obvious reasons, I'll let it pass.  As we
are coming up with an interface that uses only one string per
environment element, that is probably a sensible thing to do,
rather than trying to do the "historically correct" pairing of
setenv/unsetenv.

However, I do not think "VAR=" to unset it is a good interface.
Having an environment variable whose value happens to be an
empty string and not having the variable at all are two
different things.

Because you _scan_ the whole string in your patch to see if it
ends with = anyway, a trivial improvement would be to do:

	if (strchr(cmd->env, '='))
                putenv(cmd->env);
	else
        	unsetenv(cmd->env);

If you do not mind such a special syntax (e.g. "VAR="), I would
suggest doing that as a prefix (e.g. "!VAR") and do:

	if (cmd->env[0] != '!')
        	putenv(cmd->env);
	else
		unsetenv(cmd->env + 1);

The former look cleaner but less efficient; we are going to exec
so I do not think micro-optimization would matter at all, so my
suggestion would be to do the strchr().
