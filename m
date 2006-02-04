From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] daemon: Support a --user-path option.
Date: Sat, 04 Feb 2006 04:40:13 -0800
Message-ID: <7v8xsrz49e.fsf@assigned-by-dhcp.cox.net>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
	<20060203202706.1895.70864.stgit@metalzone.distorted.org.uk>
	<7vr76kcggx.fsf@assigned-by-dhcp.cox.net>
	<slrndu8utr.2i8.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 13:40:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5MiO-0006vb-Ds
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 13:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945925AbWBDMkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 07:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945944AbWBDMkS
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 07:40:18 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14575 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1945925AbWBDMkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 07:40:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204123756.DPUH17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 07:37:56 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrndu8utr.2i8.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Sat, 4 Feb 2006 10:02:35 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15592>

Mark Wooding <mdw@distorted.org.uk> writes:

> This is what I'm after, yes.  The above can be achieved
> straightforwardly with --user-path=. if that's what you actually wanted.
> (Indeed, --user-path= works too, but this is harder to explain.)
>
> I think I'd probably either run with --user-path=public-git or
> --user-path=public_html/git -- I've not made my mind up.

I made that conditional to --strict, but come to think of it, an
independent option like --user-path makes more sense, whether
that option does the public_html-like path munging or not.

I think for personal repositories public_html-like limiting may
be simpler to manage than the current approach of using
git-daemon-export-ok flag file (the latter is more flexible but
most people probably do not need that flexibility).

In my simplistic view, --base-path serves something like /pub
hierarchy of an ftp server or /var/www of an http server.  It
goes hand-in-hand with the whitelist and everything under it are
exported without having to mark individual directories with
git-daemon-export-ok (or having a name like public_html to mark
it exportable).  For ~user/ based paths, it is natural to wish
to limit the parts of home directories but there currently is
not a good way to do so.  We could probably extend the whitelist
to take path glob patterns and say "~*/public-git/" or something
silly like that, but that still means the request must be in the
form "git://host/~alice/public-git/frotz.git/" (which may not be
such a bad thing); "git://host/~alice/frotz.git/" might look
nicer.  Your path munging idea is one way to do so.  Another
would be for alice to have $HOME/frotz.git/git-daemon-export-ok.
Personally I do not think either would make too much of a
difference from usability point of view.

So I am not dismissing what you are trying to achieve here.
However, I am not happy about having <pwd.h> there and majorly
duplicating what enter_repo() does in that part of the code.
