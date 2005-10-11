From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Tue, 11 Oct 2005 11:03:59 -0700
Message-ID: <87ek6s0w34.fsf@penguin.cs.ucla.edu>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
	<7v64s7svya.fsf@assigned-by-dhcp.cox.net>
	<7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
	<87mzlgh8xa.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Tue Oct 11 20:06:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPOUA-0000mM-Ev
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 20:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVJKSET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 14:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVJKSET
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 14:04:19 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:27613 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S932247AbVJKSET (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 14:04:19 -0400
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
	by kiwi.cs.ucla.edu (8.11.7p1+Sun/8.11.7/UCLACS-5.2) with ESMTP id j9BI3v404213;
	Tue, 11 Oct 2005 11:03:57 -0700 (PDT)
Received: from eggert by penguin.cs.ucla.edu with local (Exim 4.50)
	id 1EPOTn-000151-Ly; Tue, 11 Oct 2005 11:03:59 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 11 Oct 2005 08:17:25 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9977>

Linus Torvalds <torvalds@osdl.org> writes:

> Personally, I'd like the normal C quoting the best.

That would be fine with me too.  How about if we use the equivalent of
--quoting-style="c" for file names that contain funny bytes, and no
quoting for other file names?  So, for example, something like this:

    diff --git "space tab\tnewline\nquote\"backslash\\" b/dee/pqr
    similarity index 72%
    rename from "space tab\tnewline\nquote\"backslash\\"
    rename to dee/pqr
    index 9ee055c..243fbbc 100644
    --- "space tab\tnewline\nquote\"backslash\\"
    +++ b/dee/pqr
    @@ -1 +1,3 @@
     Fri Oct  7 23:19:04 PDT 2005
    +foo
    +foo

The surrounding double-quotes are an extra indication to the human
reader that there is something weird about the quoted file name.

> Use filenames as if they are just binary blobs of data, 
> that's the only thing that has a high chance of success.

Thanks for thinking those things through.  I agree mostly, but there's
still a technical problem, in that we have to decide what a "funny
byte" is if we are using C-style quoting.  For example, the simplest
approach is to say a byte is funny if it is space, backslash, quote,
an ASCII control character, or is non-ASCII.  But this will cause
perfectly-reasonable UTF-8 file names to be presented in git format
using unreadable strings like "a\293\203\257b" or whatever.

Perhaps it would be better to say that a byte is "funny" if it is
space, backslash, quote, an ASCII control character, or a byte that is
not part of a valid UTF-8 encoding.  This will let UTF-8 file names
through unscathed, while still warning the reader when funny business
is going on.  File names with other encodings (e.g., Shift-JIS) will
contain lots of backslashes, but that's OK: we don't mind making
nonstandard encodings hard-to-read, so long as we preserve the bytes
correctly.

We could implement in other GNU applications by having a new quoting
style that supports this quoting behavior.  I can arrange for that.


> If somebody wants to use names with tabs and newlines, is he really
> going to work with diffs? Or is it just a driver error?

The current-supported scheme with 'diff' and 'patch' should work for
everything but newlines.  I like the idea of getting it to work even
with newlines, and I am willing to sacrifice old patches with file
names starting with '"' (extremely rare, if any) to get newlines to
work.  Among other things I worry about people submitting
purposely-malformed patches in non-git environments.
