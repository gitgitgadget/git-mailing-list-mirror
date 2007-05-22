From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add ability to specify environment extension to run_command
Date: Mon, 21 May 2007 23:33:44 -0700
Message-ID: <7v646l9xkn.fsf@assigned-by-dhcp.cox.net>
References: <20070520153908.GF5412@admingilde.org>
	<20070520181433.GA19668@steel.home>
	<20070521090339.GH942MdfPADPa@greensroom.kotnet.org>
	<20070521224828.GA10890@steel.home>
	<7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net>
	<20070522060302.GH5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Sven Verdoolaege <skimo@kotnet.org>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue May 22 08:33:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqNwN-0006CQ-IG
	for gcvg-git@gmane.org; Tue, 22 May 2007 08:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbXEVGdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 02:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756392AbXEVGdq
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 02:33:46 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51975 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787AbXEVGdp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 02:33:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070522063345.HPYS15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 22 May 2007 02:33:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 26Zk1X00H1kojtg0000000; Tue, 22 May 2007 02:33:45 -0400
In-Reply-To: <20070522060302.GH5412@admingilde.org> (Martin Waitz's message of
	"Tue, 22 May 2007 08:03:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48077>

Martin Waitz <tali@admingilde.org> writes:

> On Mon, May 21, 2007 at 04:02:42PM -0700, Junio C Hamano wrote:
>> I had a feeling that some callers needed to be able to unsetenv
>> some.  How would this patch help them, or are they outside of
>> the scope?
>
> At first I had the same objection but the putenv documentation
> told me that at least in glibc you can unsetenv by providing
> the variable name without a "=".

I recall SysV putenv() does not remove "ENVNAME" without '=', and
http://www.opengroup.org/onlinepubs/000095399/functions/putenv.html
seems to say that as well.

> But perhaps we should check for other systems?

Probably.

At least we have setenv/unsetenv calls already (with emulation
where they aren't available), we could do something like this:

	struct child_process {
        	...
                const struct {
                        const char *name;
                        const char *value; /* NULL to unsetenv */
                } *env;
		...
	};

and in start_command():

	if (cmd->env) {
		int i;
                for (i = 0; cmd->env[i].name; i++) {
			if (cmd->env[i].value)
				setenv(cmd->env[i].name, cmd->env[i].value, 1);
			else
				unsetenv(cmd->env[i].name);
                }
        }
