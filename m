From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Fri, 13 May 2005 17:33:11 -0700
Message-ID: <7voebe63zs.fsf@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<20050513224529.GF32232@pasky.ji.cz>
	<7vhdh691gs.fsf@assigned-by-dhcp.cox.net>
	<20050513233354.GK32232@pasky.ji.cz>
	<7vmzqy7k47.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 02:34:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWkbC-00053U-K3
	for gcvg-git@gmane.org; Sat, 14 May 2005 02:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVENAdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 20:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVENAdd
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 20:33:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11444 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262641AbVENAdS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 20:33:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514003312.HYDE7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 May 2005 20:33:12 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <7vmzqy7k47.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 13 May 2005 16:59:36 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Another possibility.  How about generating the following _only_
when mode changes (including create and delete), even for human
consumption?  There will be _no_ such line when mode or type
does not change.

# mode: 100644 100755 path/to/a/file/that/changed/mode
# mode: 100644 120000 path/to/a/file/that/changed/to/symlink
# mode: 100644 100644 path/to/a/file/with/no/mode/change
# mode: . 100644 path/to/a/new/file
# mode: 100644 . path/to/a/deleted/file

This is not "something like this", but a proposal for the exact
output format specification (I am going to code immediately).
Each token above is separated with exactly one ' ' (ASCII 0x20)
each, and such a line comes immediately before the patch for the
file.  Showing both mode bits is to prepare for the case you
would want to apply the patch in reverse.

This is for machine consumption and there is no need to force
them to parse out -> and (), so I dropped them.  And mode or
type change happens so rarely, it would be OK for human
consumption if we show these garbage (from human point of view)
only when things change.  Can you parse this, or do you always
want to have them even if nothing changes?

Let's see how this would look like to humans.

    # mode: 100644 100755 path0
    --- a/path0
    +++ b/path0
    @@ -1,3 +1,3 @@
     Line 1
     Line 2
    -line 3
    +Line 3
    # mode: 100644 . path1
    --- a/path1
    +++ /dev/null
    @@ -1,3 +0,0 @@
    -Line 1
    -Line 2
    -line 3
    --- a/path2
    +++ b/path2
    @@ -1,3 +1,3 @@
     Line 1
     Line 2
    -line 3
    +Line 3
    # mode: . 100755 t/t2000-diff.sh
    --- /dev/null
    +++ b/t/t2000-diff.sh
    @@ -0,0 +1,41 @@
    ...

Doesn't look too bad, does it?

