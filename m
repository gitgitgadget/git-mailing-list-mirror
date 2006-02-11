From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.1.6.g4d44 make test FAILURE report
Date: Fri, 10 Feb 2006 20:43:21 -0800
Message-ID: <7vwtg2pkt2.fsf@assigned-by-dhcp.cox.net>
References: <43ED0368.7020204@gmail.com>
	<7vhd76vqrg.fsf@assigned-by-dhcp.cox.net> <43ED3FD3.7020005@gmail.com>
	<7vvevmtza4.fsf@assigned-by-dhcp.cox.net> <43ED5F60.1010408@gmail.com>
	<7v1wyasfam.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 05:43:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7mbW-0006Sm-P5
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 05:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWBKEnX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 23:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWBKEnX
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 23:43:23 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33014 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932240AbWBKEnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 23:43:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211044028.IRWR17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 23:40:28 -0500
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <7v1wyasfam.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 10 Feb 2006 20:14:09 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15925>

Junio C Hamano <junkio@cox.net> writes:

> git-sh-setup one is easy to fix.  We could say something equally
> silly like this instead:

BTW, the reason I initially did this one and git-pull with
git-var was there was no way to extract values from the config
file easily from the command line back then. git-repo-config was
initially called git-config-set and was about setting values.

IMHO the configuration mechanism, and git-var in particular, is
quite broken, and nobody bothered to fix it.

 (1) git-var -l can show all defined variables in the config
     file, but you cannot ask about specific variable it does
     not know about.  You have to use git-repo-config for that:

	$ git var -l | head -n 4
        core.filemode=true
        core.gitproxy=none for kernel.org
        pull.twohead=resolve
        pull.octopus=octopus
	$ git var core.filemode ;# it does not know
        usage: git-var [-l | <variable>]
	$ git repo-config core.filemode
	true

 (2) git-repo-config does not have a way to list all the
     configuration items like "git-var -l".

 (3) neither of these commands know list of all the possible
     configuration items, nor types of them, so core.filename
     can be spelled as "1" or "true" to mean the same thing to
     our C code, but repo-config faithfully returns how the
     value is literally spelled in the configuration file.  The
     following two means the same thing to the C layer, so the
     calling script needs to further interpret the output from
     git-repo-config:

	$ git repo-config core.filemode ;# [core] filemode=1
	1
	$ git repo-config core.filemode ;# [core] filemode=true
	true

 (4) worse, boolean 'true' can be specified by just having the
     configuration item in the file, but repo-config dumps core
     on that:

	$ git repo-config core.filemode ;# [core] filemode
        segmentation fault

Above problems are not the only problems with git-var and
git-repo-config, but these are not entirely these programs'
faults.  They come from the way the configuration file mechanism
works.  To allow different classes of configuration items to be
defined by commands that know about them, there is no central
registry of all the supported configuration items in the code.
For example, "diff.*" configuration items can be interpreted only
by C level programs that call git_config(git_diff_config).

With the current structure, it is very hard for these commands
to sensibly list all the configuration values (e.g. lack of
"[core] filemode" in the configuration file ought to mean that
the executable bit is unreliable i.e. core.filemode=false, but
they cannot report it), or report the values taking into account
their types.  I do not think they even attempt to do so.
