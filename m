From: Junio C Hamano <junkio@cox.net>
Subject: Re: resolve (merge) problems
Date: Thu, 01 Dec 2005 15:58:32 -0800
Message-ID: <7v3blccqtz.fsf@assigned-by-dhcp.cox.net>
References: <20051201231844.59450.qmail@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 00:59:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhyJz-0000yQ-1D
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 00:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVLAX6g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 18:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVLAX6g
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 18:58:36 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:60033 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932560AbVLAX6f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 18:58:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201235801.COKB15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 18:58:01 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20051201231844.59450.qmail@web31801.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 1 Dec 2005 15:18:44 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13088>

Luben Tuikov <ltuikov@yahoo.com> writes:

> $ git resolve HEAD master "merge linus' tree"
> Trying to merge 5666c0947ede0432ba5148570aa66ffb9febff5b into
> 32df3299405fb7054b76346899f3db2fa29150fb using 458af5439fe7ae7d95ca14106844e61f0795166c.
> Simple merge failed, trying Automatic merge
> Removing arch/arm/configs/poodle_defconfig
> Removing drivers/atm/atmdev_init.c
> fatal: merge program failed
> Automatic merge failed, fix up by hand
>
> How do I proceed from here?
>
> The output from git-diff-index is:
>
> $git-diff-index --name-status HEAD
> M       Documentation/usb/error-codes.txt
> M       Makefile
> M       arch/arm/configs/corgi_defconfig
> U       arch/arm/configs/poodle_defconfig
> M       arch/arm/configs/spitz_defconfig

Easier to read is:

	$ git-diff-files --name-status

which would tell you that there two files have conflicting
changes:

U       arch/arm/configs/poodle_defconfig
U       drivers/atm/atmdev_init.c

and you would hopefully not see anything else (you saw tons of
paths only because you compared against HEAD, which shows not
just conflicts but everything the merge brought in).

	$ git diff arch/arm/configs/poodle_defconfig drivers/atm/atmdev_init.c

would give you the diff between your version (before merging)
and the half-merged file with conflict markers.  Resolve them
just like you would resolve conflicting changes.  I would
usually just open these files in an editor, and pick one of the
sections between <<< == >>> these markers.

One nifty tool I saw suggested on the list recently was xxdiff:

	$ xxdiff -U arch/arm/configs/poodle_defconfig

No matter how you would resolve, the first goal of yours is to
get these files in your working tree into a good shape, which
may involve compiling and testing.  Once you have these files in
a good enough shape, you tell git that you are done with them:

	$ git update-index \
        	arch/arm/configs/poodle_defconfig drivers/atm/atmdev_init.c

and commit.

	$ git commit

The commit message editor would loudly warn you that you are
committing a merge, but that is OK because that is what you are
doing.  You might want to describe how you resolved (which side
you picked) the conflicting changes in the log, in addition to
the standard boilerplate "merged that branch" message.
