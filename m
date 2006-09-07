From: Junio C Hamano <junkio@cox.net>
Subject: Re: file rename causes history to disappear
Date: Wed, 06 Sep 2006 17:52:54 -0700
Message-ID: <7vbqps5wgp.fsf@assigned-by-dhcp.cox.net>
References: <44FEE0BB.2060601@garzik.org>
	<Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
	<44FEED4B.30909@garzik.org>
	<Pine.LNX.4.64.0609060858050.27779@g5.osdl.org>
	<Pine.LNX.4.64.0609060922110.27779@g5.osdl.org>
	<7vmz9c7pzm.fsf@assigned-by-dhcp.cox.net>
	<86bqpsvfd3.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 02:52:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL88P-0003In-Cn
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 02:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWIGAwq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 20:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWIGAwq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 20:52:46 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33155 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161036AbWIGAwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 20:52:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907005245.FMTB26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Sep 2006 20:52:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KCsl1V00p1kojtg0000000
	Wed, 06 Sep 2006 20:52:46 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86bqpsvfd3.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "06 Sep 2006 14:45:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26582>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
> Junio> The only people who will get burnt by this change are the ones
> Junio> with metacharacters in their pathnames, so it is relative safe
> Junio> change.
>
> But does that mean you'll provide the equivalent to "fgrep" for "grep",
> as in a switch that turns this off, or a seperate command?
>
> I can think of times when I might be trying to track a file with a square
> bracket in the name.

If your path is "foo.c[1]" then "foo.c[1]" as fnmatch() pattern
would not obviously match it, which is sad.

However, we do try to match the path literally before falling
back to fnmatch() so in practice I do not think  it is so bad.

$ git ls-files -s ;# everybody has "hello world".
100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0	foo.c
100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0	foo/bar[1]/baz/boa.c
100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0	foo/bar[2].c
$ git grep hello -- 'foo/bar[1]'
foo/bar[1]/baz/boa.c:hello world
$ git grep hello -- 'foo/bar[[]*[]]*'
foo/bar[1]/baz/boa.c:hello world
foo/bar[2].c:hello world
$ git grep hello -- 'fo*'
foo.c:hello world
foo/bar[1]/baz/boa.c:hello world
foo/bar[2].c:hello world
$ exit
