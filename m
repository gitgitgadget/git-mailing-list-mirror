From: Junio C Hamano <junkio@cox.net>
Subject: Re: Use a *real* built-in diff generator
Date: Fri, 24 Mar 2006 23:39:08 -0800
Message-ID: <7vu09nvuqr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
	<7vk6ajxbe5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 08:39:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN3Mj-0007QX-Jq
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 08:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWCYHjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 02:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCYHjM
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 02:39:12 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10715 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751101AbWCYHjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 02:39:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325073910.YGLZ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 02:39:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17961>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> This uses a simplified libxdiff setup to generate unified diffs _without_ 
>> doing  fork/execve of GNU "diff".
>
> Good stuff.

The reason I like this is because I was thinking about doing
in-core diffs for different purpose when I was driving to work
this morning [*1*]  --- to make pickaxe a more useful building
block.

Currently, pickaxe tries to do an exact match to find the case
where a given substring S appears in the version C of the file
but not in the its parent C^n (1 <= n), and then it tells the
diffcore to emit the differences.  The user (probably only me on
this list?)  is expected to look at the change, make an
intelligent decision to feed a matching substring S' found in
C^n and restart from that commit.

To be a useful "content movement tracker", the process of
finding matching 'old shape' in the previous version and
re-feeding it to pickaxe should be automated if possible, and
in-core diff machinery would be one component to help that.

For example, if I wanted to find when I stole 'ls-files -t'
feature from Cogito, I would first run less ls-files.c; I see
these and am reasonably sure these relate to what I am looking
for:

	...
        static const char *tag_cached = "";
        static const char *tag_unmerged = "";
        static const char *tag_removed = "";
        static const char *tag_other = "";
        static const char *tag_killed = "";
        static const char *tag_modified = "";
	...

So I run:

	$ git whatchanged -S'static const char *tag_other = "";
        static const char *tag_killed = "";
	static const char *tag_modified' -p master -- ls-files.c

which finds:

        Author: Junio C Hamano <junkio@cox.net>
        Date:   Mon Sep 19 15:11:15 2005 -0700

            Show modified files in git-ls-files
	...
        @@ -28,6 +29,7 @@ static const char *tag_unmerged = "";
         static const char *tag_removed = "";
         static const char *tag_other = "";
         static const char *tag_killed = "";
        +static const char *tag_modified = "";

but that is not what I am interested in; the matching "old
shape" is the version before the tag_modified was added (and it
already had other tag_xxx in there).  So with the current
pickaxe, I manually re-run whatchanged starting from the found
commit with modified string like this:

	$ git whatchanged -S'static const char *tag_removed = "";
        static const char *tag_other = "";
        static const char *tag_killed = "";' -p $that_commit -- ls-files.c

in order to further drill down.

A truly useful pickaxe should take two line numbers and a
filename (to name the range of lines I am interested in) from
the starting version, notice when that range changes shape, and
after showing the found commit, replace the range with the one
matching from the older commit and continue.

[Footnote]

*1* When you are bogged down in a boring day-job, your brain
tends to try to compensate by spending as much your waking time
as possible on thinking about more interesting and more useful
stuff -- like git ;-).
