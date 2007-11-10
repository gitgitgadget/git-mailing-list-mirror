From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sat, 10 Nov 2007 13:14:16 -0800
Message-ID: <7vabpliz13.fsf@gitster.siamese.dyndns.org>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 22:14:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqxf7-0005l3-RH
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 22:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbXKJVO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 16:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754266AbXKJVOZ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 16:14:25 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51622 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbXKJVOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 16:14:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B0D7F2F2;
	Sat, 10 Nov 2007 16:14:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D04889405D;
	Sat, 10 Nov 2007 16:14:40 -0500 (EST)
In-Reply-To: <1194722863-14741-1-git-send-email-pkufranky@gmail.com> (Ping
	Yin's message of "Sun, 11 Nov 2007 03:27:43 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64378>

Ping Yin <pkufranky@gmail.com> writes:

> 	# submodule modifiled: sm1 sm2
> 	#
> 	# * sm1 354cd45...3f751e5:
> 	#   <<<
> 	#   	one line message for C
> 	#   	one line message for B
> 	#   >>>
> 	#   	one line message for D
> 	#   	one line message for E
> 	#
> 	# * sm2 5c8bfb5...ac46d84:
> 	#   <<<
> 	#   	msg
> 	#
> 	# On branch master
> 	# Changes to be committed:
> 	#   (use "git reset HEAD <file>..." to unstage)
> 	#
> 	#	modified:   sm1
> 	#	modified:   sm2

I think this presentation order is horrible.

 * I think everbody preferes to have "On branch master" at the
   very beginning, to avoid committing to a wrong branch by
   mistake.

 * As I understand it, in the real life use, there will be quite
   many commits from the submodule updates when a new commit is
   bound to a submodule in the superproject, as _the_ point of
   having a submodule is to bind a more or less independent
   project that progresses at quite a different pace as a
   submodule to the superproject.  In other words, by design,
   the superproject can stay behind from the tip of subproject
   and rebind it to a different commit only when there are
   significant changes of the subproject that need to be there
   to allow the other parts of the superproject (either
   superproject itself or another submodule) to use the features
   and/or fixes the submodule updates provides.

   Which means it will not be uncommon have hundreds of "one
   line message" for the submodules at the very beginning of the
   commit log message buffer, and your prsentation order will
   make that part overwhelm the overview of what changed _in_
   the supermodule itself (the "Changes to be committed:"
   lines), which gives the birds-eye view.

   And I think it is more important to give the birds-eye view
   of the supermodule itself first, when you are helping to
   prepare a commit message for the supermodule.  The user would
   start the commit log for the superproject with "This updates
   the new frotz feature.  It uses the updated API from the
   submodules A and B so we now use updated versions of them."
   and then continue "Notable changes in submodule A are ...".
   And the new part you are adding would help the user to write
   the latter description.

I also find "<<< lines then >>> other lines" format very hard to
read.  Maybe formatting it like this would make it a bit more
readable and more space efficient?

 	# * sm1 354cd45...3f751e5:
 	#   - one line message for C
 	#   - one line message for B
 	#   + one line message for D
 	#   + one line message for E
 	# * sm2 5c8bfb5...ac46d84:
 	#   - msg

Note that if you swap the order and move this at the tail
(perhaps before "Untracked files:" section, if you do not have a
decent .gitignore set up), you can also lose the "submodules
modified: sm1 sm2" line and the blank line before it, which
would make the output even shorter without losing any useful
information.
