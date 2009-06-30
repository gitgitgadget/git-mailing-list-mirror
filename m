From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Don't clean any untracked submodule's .git dir by default in git-clean
Date: Tue, 30 Jun 2009 00:34:12 -0700
Message-ID: <7vljna9nuz.fsf@alter.siamese.dyndns.org>
References: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com>
	<1246327845-22718-2-git-send-email-jason.k.holden@gmail.com>
	<1246327845-22718-3-git-send-email-jason.k.holden@gmail.com>
	<4A49B36D.2080103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Holden <jason.k.holden@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 09:34:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLXrS-00074z-2I
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 09:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbZF3HeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 03:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbZF3HeL
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 03:34:11 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:51808 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbZF3HeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 03:34:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090630073414.QIYP18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jun 2009 03:34:14 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id A7aC1c0044aMwMQ037aC9r; Tue, 30 Jun 2009 03:34:13 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=9cvXoET4qPUA:10 a=fv-XvKvnAAAA:8
 a=Az0r0qbcK0tzIolqf60A:9 a=dV5pPrDZ3MJZNgRuWQgA:7
 a=piTAWHBTJrw0537beYTiDNjsDzoA:4 a=koyV10BnNV0A:10 a=l9rlz7MJbUIA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122495>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jason Holden schrieb:
> ...
>>  If
>> we run git-clean on the mainline branch, when we have a submodule that only
>> exists on a local branch, the entire .git directory of the untracked
>> submodule will get deleted, possibly losing any un-pushed local changes to
>> the submodule.
>
> This is not about "mainline" and "local branch"; it is about switching
> from one branch that tracks the submodule to another one that doesn't
> track it.

I do not think it is even about that.

If you have an old-style nested git work tree, i.e. you have an
independent git repository in some subdirectory of a work tree of a git
work tree, you will have exactly the same issue.  There is no need for any
submodule to get involved.

For example, I have a clone of git.git repository at Meta/ and have the
'todo' branch checked out, so that I can say "Meta/Make", "Meta/Dothem",
etc.  In such a set-up, if you do not have Meta/ in .gitignore (or even if
you do, if you said "git clean -f -x -d"), you will lose that directory
(and arguably that is by design).

I think protecting users from mistakes is a very good idea, but I see at
least two small problems with the patch.  For brevity I'll name the "not a
submodule in the HEAD commit of the superproject" directory "Meta/" in the
following.

 (1) Protecting Meta/.git is not goot enough. If it were, and if this is
     only about submodules, then you can use the "gitdir:" facility to
     relocate Meta/.git directory to somewhere under superproject's .git
     and be done with it.

     You _must_ protect the checked out files, their uncommitted contents
     and untracked but unignored files.  After all, Meta/ is a valid git
     repository in its own right.  Noticing that "rm -r" is about to
     remove Meta/.git after it has already touched many other files in
     Meta/ is one recursion level too late.

 (2) Naming the option to force removal "-m" is wrong; this is not about
     submodule at all.  Can we use double-force "-f -f", perhaps?
