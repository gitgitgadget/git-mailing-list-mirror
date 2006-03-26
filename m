From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why would merge fail on a one-line addition?
Date: Sat, 25 Mar 2006 17:32:30 -0800
Message-ID: <7vfyl6t2hd.fsf@assigned-by-dhcp.cox.net>
References: <20060325222601.GA1500@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 03:32:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNK7S-00056R-J5
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 03:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWCZBcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 20:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWCZBcd
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 20:32:33 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:9118 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751261AbWCZBcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 20:32:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060326013231.RLLY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 20:32:31 -0500
To: Marc Singer <elf@buici.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18017>

Marc Singer <elf@buici.com> writes:

> One of the unmerged files leaves this trail.
>
>   elf@florence ~...git/linux-2.6 > git-ls-files --unmerged
>   100644 6262d449120cdcde5db1b079806dcc0d9b5e6b7c 1       arch/arm/mach-lh7a40x/irq-lpd7a40x.c
>   100644 dcb4e17b941990eabe8992680c9aa9b67afb6fd4 3       arch/arm/mach-lh7a40x/irq-lpd7a40x.c

> Why would git have a problem with this?

Your change and the change in the other branch are conflicting
and git is helping you notice that.

The index has different #1 and #3 with #2 missing.  This means
the common ancestor (#1) had it, you (#2) _removed_ it, while
the other branch (#3) modified it.  Should it carry forward the
modification (one line addition) made by the other branch and
then remove the file to match yours, or should it remove it to
match yours and ignore what the other branch did?

If you do not want to have that file in the result, record the
path as such and make a commit.  Since there is no #2, your
working tree probably do not have that path, so:

        $ git update-index --remove arch/arm/mach-lh7a40x/irq-lpa7a40x.c

to resolve the path, resolve other conflicts if you have any and
then commit the result.

However, this _might_ be a case where your line of development
somewhere between the common ancestor and your tip moved that
file somewhere else in which case you may want to do three-way
merge between 6262d4 blob, your tip and dcb4e1 blob _and_ commit
the result at the path you have.  I do not know if that is the
case and even if so I do not know where you have the
corresponding file in your tree, but just as an example if you
have it in arch/arm/mach-foo/irq-lpd7a40x.c, you would:

	$ cd arch/arm/mach-foo/
	$ common=$(git unpack-file 6262d4)
        $ his=$(git unpack-file dcb4e1)
        $ merge irq-lpd7a40x.c $common $his
        $ rm -f $common $his

And then eyeball the result of the merge, fix it up as
necessary, and then:

	$ git update-index --remove arch/arm/mach-lh7a40x/irq-lpa7a40x.c
        $ git update-index arch/arm/mach-foo/irq-lpd7a40x.c

before committing.
