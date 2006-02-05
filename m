From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] do not open editor in dumb terminal
Date: Sat, 04 Feb 2006 18:54:59 -0800
Message-ID: <7voe1msef0.fsf@assigned-by-dhcp.cox.net>
References: <20060203114133.GA11499@kvasir.watson.ibm.com>
	<7vu0bgdxmh.fsf@assigned-by-dhcp.cox.net>
	<20060205003741.GB29021@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, boutcher@cs.umn.edu
X-From: git-owner@vger.kernel.org Sun Feb 05 03:55:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5a3Z-00082C-0F
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 03:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWBECzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 21:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWBECzH
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 21:55:07 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:54993 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932290AbWBECzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 21:55:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060205025336.TEIH6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 21:53:36 -0500
To: Amos Waterland <apw@us.ibm.com>
In-Reply-To: <20060205003741.GB29021@kvasir.watson.ibm.com> (Amos Waterland's
	message of "Sat, 4 Feb 2006 19:37:41 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15616>

Amos Waterland <apw@us.ibm.com> writes:

> If your TERM is set to `emacs' then that is fine.  If it is set to
> `dumb' however, that seems a bit strange.  A dumb terminal is usually
> understood to be one that does not have the ability to interpret control
> sequences.

I am not talking about M-x terminal that uses TERM=emacs-*.  I
am talking about M-x shell and M-x compile.  In those modes, the
default TERM is "dumb".

I could live with something like this (untested) patch, though.
Instead of falling back on ed (or ex), you could error out and
give the error message if you want.

I know of an editor that works fine even when invoked with
TERM=dumb, and I explicitly told programs to use it by exporting
EDITOR environment variable with the name of that editor.  I am
entitled to expect that programs honor that wish, instead of
insulting me by saying "Hey dummy, you cannot run any editor on
a dumb terminal".  Be the editor "emacsclient" or "ed", they
both work fine for me, thank you ;-).

The user, at least the ones who understand what your program
does, always knows a lot better about his enviornment and his
needs than your program will ever do.  You can try to be helpful
(e.g. refuse to spawn the editor when you feel it is not
appropriate), but you can never be perfect.  Just in case your
helpfulness turns out to be misguided inconvenience, you should
leave a way for the user to override it.  I was unhappy about
your patch because it errored out only after checking TERM
without checking EDITOR or VISUAL.

Although you did not bring this up, there is a same issue for
${PAGER:-less} elsewhere.  Inside Emacs I usually set it to
"cat".  I do not want the program to be helpful by just checking
TERM=dumb to error that out, either.

> The reason I sent the patch is that people get a rather
> unpleasant introduction to git when vi splatters control
> characters all over their emacs session when they do their
> first commit.

It's been quite a while since I used the real "vi" the last
time, but I think the real vi was not _that_ dumb as you
described.  If the termcap said that the $TERM cannot do a
reasonable visual mode, it sensibly fell back to a line editor
mode ex, if I recall correctly.  Maybe popular vi clones these
days are poorly emulated in that respect.  I dunno.

---
diff --git a/git-commit.sh b/git-commit.sh
index 193feeb..c4a9dc3 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -207,6 +207,10 @@ then
 fi
 case "$no_edit" in
 '')
+	case "$VISUAL$EDITOR,$TERM" in
+	',dumb')
+		EDITOR=ed ;;
+	esac
 	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
 	;;
 esac
