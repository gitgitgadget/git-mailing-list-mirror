From: Petr Baudis <pasky@ucw.cz>
Subject: Test suite
Date: Thu, 12 May 2005 00:40:44 +0200
Message-ID: <20050511224044.GI22686@pasky.ji.cz>
References: <118833cc05050911255e601fc@mail.gmail.com> <7vr7gewuxt.fsf@assigned-by-dhcp.cox.net> <20050510230357.GF26384@pasky.ji.cz> <7vsm0us5p5.fsf@assigned-by-dhcp.cox.net> <118833cc050511113122e2d17d@mail.gmail.com> <7vpsvxqwab.fsf@assigned-by-dhcp.cox.net> <7vd5rxquo5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 00:34:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzlq-0001Tb-MN
	for gcvg-git@gmane.org; Thu, 12 May 2005 00:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVEKWlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVEKWlJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:41:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32707 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261283AbVEKWkq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 18:40:46 -0400
Received: (qmail 11376 invoked by uid 2001); 11 May 2005 22:40:44 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5rxquo5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 12:12:10AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I've added test subdirectory and two tests to check the above
> problems are fixed.

I'd prefer introduction of the infrastructure for this in a separate
commit. I'll focus on it here; I will have a look at the checkout-cache
stuff tomorrow.

> Created: t/t0000.sh (mode:100755)
> --- /dev/null
> +++ b/t/t0000.sh

I'd prefer some better name for this. What about testlib.sh?

> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2005 Junio C Hamano
> +#

A short description here would be nice.

> +case "${verbose+set}" in
> +set)	say= ;;
> +*)	say=: ;;
> +esac

Perhaps set $verbose if -v was passed or something.

Looking at how you use it, I wouldn't run the command at all if not
verbose.

> Created: t/t1000-checkout-cache.sh (mode:100755)
> --- /dev/null
> +++ b/t/t1000-checkout-cache.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2005 Junio C Hamano
> +#

I think each test in the suite should have a short summary of its focus
in the top comment.

> +. ./t0000.sh
> +git-init-db 2>/dev/null || exit

I'd do this in testlib.sh (you might well blast it away and redo it when
testing init-db).

> +echo >&2 "* checkout-cache sans -f"
> +git-checkout-cache -a
> +case "$?" in
> +0)	echo >&2 "*** bug: should not have succeeded." ;;
> +*)	echo >&2 "*** ok: failed as expected." ;;
> +esac

And this essentially repeats all over and over.

What about something like

cmdtest "sans -f" git-checkout-cache -a

> +if test -f path0 && test -d path1 && test -f path1/file1
> +then
> +	echo >&2 "*** ok: checked out correctly."
> +else
> +	echo >&2 "*** bug: checkout failed."
> +	exit 1
> +fi

We might get a good function for this later too, for now I'd propose

if test -f path0 && test -d path1 && test -f path1/file1; then
	testok "checkout"
else
	testfail "checkout" # non-fatal test failure
	testfatal "checkout" # fatal test failure, die right away
fi


And at the end the script, you should do

exit $teststatus

which is set to non-zero anytime testfail was invoked.

> Created: t/t1001-checkout-cache.sh (mode:100755)
> --- /dev/null
> +++ b/t/t1001-checkout-cache.sh
> @@ -0,0 +1,64 @@
> +show_files() {
> +	find path? -ls |
> +	sed -e 's/^[0-9]* * [0-9]* * \([-bcdl]\)[^ ]* *[0-9]* *[^ ]* *[^ ]* *[0-9]* [A-Z][a-z][a-z] [0-9][0-9] [^ ]* /fs: \1 /'
> +	git-ls-files --stage |
> +	sed -e 's/^\([0-9]*\) [0-9a-f]* [0-3] /ca: \1 /'
> +	git-ls-tree -r "$1" |
> +	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
> +}

Ugh. I think a comment would be suitable here. ;-)

> +mkdir path0
> +date >path0/file0
> +git-update-cache --add path0/file0
> +echo >&2 "* initial state: one file under one directory"
> +tree1=$(git-write-tree)

cmdtest --capture-stdout "one file under one directory" git-write-tree
tree1=$(cat $teststdout)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
